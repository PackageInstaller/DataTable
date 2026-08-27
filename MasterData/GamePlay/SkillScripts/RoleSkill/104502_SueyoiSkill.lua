local bs_104502 = class("bs_104502", LuaSkillBase)
local base = LuaSkillBase
bs_104502.config = {
  actionId_start = 1002,
  skill_time = 11,
  start_time = 4,
  effectId_start = 1045022,
  effectId_target = 1045021,
  effectId_boom = 1045023,
  buffId_skillTarget = 1045021,
  buffId_loopAction = 1045002,
  buffId_UltloopAction = 1045032,
  buffId_sniperGrid = 1032,
  buffId_FindTarget = 1045022,
  buffId_ChargeTier = 1045001,
  buffId_taunt = 3002,
  buffId_taunt2 = 67,
  HurtConfig_aoe = {
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  }
}

function bs_104502:ctor()
end

function bs_104502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.skillTargetRatio = self.arglist[1]
  self.caster.recordTable.skillTarget = nil
  self:AddAfterHurtTrigger("bs_104502_2", 1, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_104502_3", 1, self.OnBeforePlaySkill)
  self:AddSetHurtTrigger("bs_104502_1", 999, self.OnSetHurt, self.caster)
end

function bs_104502:OnBeforePlaySkill(role, context)
  if context.skill ~= self.cskill or self.caster ~= role then
    return
  end
  context.active = false
  local moveTarget = self.cskill.moveSelectTarget
  if moveTarget ~= nil and moveTarget.targetRole.intensity == 0 and moveTarget.targetRole.belongNum == eBattleRoleBelong.neutral then
    moveTarget = nil
  end
  if moveTarget == nil then
    self.cskill:ResetCDTimeRatio(80)
    return
  end
  local target = moveTarget.targetRole
  if target == nil or 0 >= target.hp then
    return
  end
  if moveTarget.belongNum == self.caster.belongNum then
    self.cskill:ResetCDTimeRatio(80)
    return
  end
  local alreadyTarget = target:GetBuffTier(self.config.buffId_skillTarget)
  if 0 < alreadyTarget then
    self.cskill:ResetCDTimeRatio(80)
    return
  end
  context.active = true
end

function bs_104502:PlaySkill(data)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget ~= nil and moveTarget.targetRole.intensity == 0 and moveTarget.targetRole.belongNum == eBattleRoleBelong.neutral then
    moveTarget = nil
  end
  local target = moveTarget.targetRole
  if target == nil or 0 >= target.hp then
    return
  end
  local isOnSniperGrid = self.caster:GetBuffTier(self.config.buffId_sniperGrid)
  if 0 < isOnSniperGrid then
    target = self:SniperGridTarget()
  end
  local setTarget = BindCallback(self, self.setTarget, target)
  self.caster:LookAtTarget(target)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, 2.5, self.config.start_time, setTarget)
end

function bs_104502:SniperGridTarget()
  local targetlist = LuaSkillCtrl:CallTargetSelectWithCskill(self.cskill, 21, 10, self.caster)
  if targetlist.Count < 1 then
    return
  end
  return targetlist[0].targetRole
end

function bs_104502:setTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_start, self, self.SkillEventFunc)
  local enermylist = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 10, false)
  if enermylist.Count > 0 then
    for i = 0, enermylist.Count - 1 do
      if enermylist[i].belongNum ~= self.caster.belongNum then
        local skillTarget = enermylist[i]:GetBuffTier(self.config.buffId_skillTarget)
        if 0 < skillTarget then
          LuaSkillCtrl:DispelBuff(enermylist[i], self.config.buffId_skillTarget, 0, true)
        end
      end
    end
  end
end

function bs_104502:SkillEventFunc(effect, eventId, target)
  self.caster.recordTable.skillTarget = target.targetRole
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_skillTarget, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_FindTarget, 1, nil, true, target.targetRole)
  end
end

function bs_104502:OnSetHurt(context)
  local isSkillTarget = context.target:GetBuffTier(self.config.buffId_skillTarget)
  if isSkillTarget < 1 then
    return
  end
  if context.sender ~= self.caster then
    return
  end
  if context.extra_arg == ConfigData.buildinConfig.HurtIgnoreKey or context.isTriggerSet then
    return
  end
  if not context.skill.isCommonAttack and not context.skill.isUltSkill then
    return
  end
  local buffs = LuaSkillCtrl:GetRoleBuffs(context.target)
  if buffs ~= nil and buffs.Count > 0 then
    for i = 0, buffs.Count - 1 do
      if buffs[i].buffType == 2 then
      end
    end
  end
  self:DebuffSpread(context.target, buffs)
  self:TargetBomb(context.target, context.hurt)
  LuaSkillCtrl:DispelBuff(context.target, self.config.buffId_skillTarget, 0, true)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_FindTarget, 0, true)
  self.caster.recordTable.skillTarget = nil
end

function bs_104502:DebuffSpread(target, buffs)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
  local addBuff = buffs
  if skillResult == nil or skillResult.roleList.Count < 1 then
    return
  end
  for i = 0, skillResult.roleList.Count - 1 do
    if skillResult.roleList[i].recordTable.equipSummoner then
      break
    end
    self:AddDebuff(skillResult.roleList[i], addBuff)
  end
  skillResult:EndResult()
end

function bs_104502:AddDebuff(target, buffs)
  if target == nil or target.hp <= 0 then
    return
  end
  if buffs == nil or buffs.Count < 1 then
    return
  end
  for i = 0, buffs.Count - 1 do
    if buffs[i].buffType == 2 then
      local skill = buffs[i].battleSkill
      local sender = buffs[i].maker
      local buffID = buffs[i].dataId
      local tier = buffs[i].tier
      local decade = buffs[i].totalTime
      if buffID == self.config.buffId_taunt2 or buffID == self.config.buffId_taunt then
        local setBuff = LuaSkillCtrl:CallBuff(self, target, buffID, tier, decade, false, sender)
      else
        local setBuff = LuaSkillCtrl:CallBuffWithOriginSkill(skill, target, buffID, tier, decade, false, self.caster)
      end
    end
  end
end

function bs_104502:TargetBomb(target, hurt)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_boom, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
  local baseHurt = hurt
  local realHurt = baseHurt * self.arglist[2] // 1000
  for i = 0, skillResult.roleList.Count - 1 do
    if not skillResult.roleList[i].recordTable.equipSummoner then
      local role = skillResult.roleList[i]
      LuaSkillCtrl:CallRealDamage(self, role, nil, self.config.HurtConfig_aoe, {realHurt}, true)
    end
  end
  skillResult:EndResult()
  self:OnSkillDamageEnd()
  if 0 >= self.caster.hp then
    base.OnCasterDie(self)
  end
end

function bs_104502:OnCasterDie()
  local enermylist = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 10, false)
  if enermylist.Count > 0 then
    for i = 0, enermylist.Count - 1 do
      if enermylist[i].belongNum ~= self.caster.belongNum then
        local skillTarget = enermylist[i]:GetBuffTier(self.config.buffId_skillTarget)
        if 0 < skillTarget then
          local normalAttackCharge = self.caster:GetBuffTier(self.config.buffId_ChargeTier)
          local ultCharge = self.caster:GetBuffTier(self.config.buffId_UltloopAction)
          if normalAttackCharge + ultCharge <= 0 then
            LuaSkillCtrl:DispelBuff(enermylist[i], self.config.buffId_skillTarget, 0, true)
            base.OnCasterDie(self)
          end
        end
      end
    end
  end
end

function bs_104502:LuaDispose()
  base.LuaDispose(self)
end

return bs_104502
