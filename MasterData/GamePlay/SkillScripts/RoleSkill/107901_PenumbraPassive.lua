local bs_107901 = class("bs_107901", LuaSkillBase)
local base = LuaSkillBase
bs_107901.config = {
  buffId = 107901,
  buffId_heal = 107902,
  buffId_02 = 107903,
  buffId_03 = 107904,
  actionId_02 = 1023,
  HurtConfigID = 2,
  heal_config = 2,
  effectId_hide = 107903
}

function bs_107901:ctor()
end

function bs_107901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddHurtResultStartTrigger("bs_107901_1", 1, self.OnHurtResultStart, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, nil, false)
  self:AddAfterHurtTrigger("bs_107901_2", 1, self.OnAfterHurt, nil, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_107901_3", 1, self.OnAfterPlaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107901_4", 1, self.OnAfterBattleStart)
  self.passiveCd = 0
end

function bs_107901:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[6], BindCallback(self, self.OnPreparation), nil, -1, 0)
end

function bs_107901:OnPreparation()
  if self.caster:GetBuffTier(self.config.buffId_03) > 0 then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_03, 1, nil, true)
end

function bs_107901:OnRoleSplash(role)
  if role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_107901:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_107901:OnHurtResultStart(skill, context)
  if skill.skillType == eBattleSkillLogicType.Original and context.sender:GetBuffTier(self.config.buffId) > 0 and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.hurt_type ~= 2 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[9]
    }, true)
    skillResult:EndResult()
  end
end

function bs_107901:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local battleCtrl = LuaSkillCtrl.battleCtrl
  local curFrame = battleCtrl.frame
  if curFrame < self.passiveCd then
    return
  end
  local hprate = self.caster._curHp * 1000 // self.caster.maxHp
  if hprate <= self.arglist[2] then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_hide, self)
    LuaSkillCtrl:CallBuffRepeated(self, self.caster, self.config.buffId_heal, 1, self.arglist[3], false, self.OnBuffExecute)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_02, 1, self.arglist[3], true)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_02, 1)
    self.passiveCd = curFrame + self.arglist[5] + self.arglist[3]
  end
end

function bs_107901:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_config, {
    self.arglist[4]
  }, true, true)
  skillResult:EndResult()
end

function bs_107901:OnAfterPlaySkill(skill, role)
  if role == self.caster and (skill.isNormalSkill or skill.isCommonAttack) then
    local movSelectTarget = skill.moveSelectTarget
    if movSelectTarget ~= nil and movSelectTarget.targetRole ~= nil and movSelectTarget.belongNum == 2 then
      self.timer.left = self.timer.delay
    end
  end
end

function bs_107901:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_107901
