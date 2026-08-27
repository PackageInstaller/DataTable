local bs_104902 = class("bs_104902", LuaSkillBase)
local base = LuaSkillBase
bs_104902.config = {
  effectId_attack = 104903,
  effectId_hit1 = 104904,
  effectId_hit2 = 104905,
  effectId_hit3 = 104906,
  buffId_passive = 104901,
  buffId_skill = 104902,
  buffId_stun = 3006,
  shieldFormula = 3022,
  skill_time = 27,
  actionId = 1021,
  action_speed = 1,
  start_time = 6,
  start_time2 = 4,
  start_time3 = 7,
  hurtConfigId = 2
}

function bs_104902:ctor()
end

function bs_104902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeAddBuff, "bs_104902_7", 1, self.OnBeforeAddBuff)
end

function bs_104902:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_attack, self, nil, nil, nil, true)
  end
end

function bs_104902:OnAttackTrigger(target)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skill, 1)
  self.Mask = LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_passive, 1)
  if self.caster:GetBuffTier(self.config.buffId_passive) == 1 then
    self.MaskEffect = self.Mask.listBattleEffect[0]
  end
  local MaskEffectNum = self.caster:GetBuffTier(self.config.buffId_passive) - 1
  LuaSkillCtrl:EffectSetCountActive(self.MaskEffect, MaskEffectNum, true)
  if target == nil or 0 >= target.hp then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit1, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {
    self.arglist[1]
  })
  skillResult:EndResult()
  LuaSkillCtrl:StartTimer(self, self.config.start_time2, function()
    if target == nil or target.hp <= 0 then
      return
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {
      self.arglist[2]
    })
    skillResult:EndResult()
    LuaSkillCtrl:StartTimer(self, self.config.start_time3, function()
      if target == nil or target.hp <= 0 then
        return
      end
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hit3, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {
        self.arglist[3]
      })
      skillResult:EndResult()
      self:OnSkillDamageEnd()
    end)
  end)
end

function bs_104902:OnBeforeAddBuff(target, context)
  if target == self.caster and context.buff.buffCfg.IsControl == true and self.caster:GetBuffTier(self.config.buffId_skill) > 0 and (context.buff.maker.belongNum ~= self.caster.belongNum or context.buff.battleSkill.dataId == 20118) then
    context.active = false
    self.Mask = LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_passive, 1)
    if self.caster:GetBuffTier(self.config.buffId_passive) == 1 then
      self.MaskEffect = self.Mask.listBattleEffect[0]
    end
    local MaskEffectNum = self.caster:GetBuffTier(self.config.buffId_passive) - 1
    LuaSkillCtrl:EffectSetCountActive(self.MaskEffect, MaskEffectNum, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_skill, 0)
  end
end

function bs_104902:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104902:LuaDispose()
  base.LuaDispose(self)
  self.Mask = nil
  self.MaskEffect = nil
end

return bs_104902
