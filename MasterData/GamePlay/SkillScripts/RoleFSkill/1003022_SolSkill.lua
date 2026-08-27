local bs_1003022 = class("bs_1003022", LuaSkillBase)
local base = LuaSkillBase
bs_1003022.config = {
  buffId_lz1 = 10030101,
  buffId_lz2 = 10060101,
  buffId_fire = 301101,
  effectId_fire = 100304,
  effectId_lz = 100307,
  effectId_firehit = 100305,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  HurtConfig2 = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0,
    hurt_type = 2
  },
  skill_time = 33,
  start_time = 9,
  actionId = 1004,
  action_speed = 1
}

function bs_1003022:ctor()
end

function bs_1003022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_1003022_8", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_lz1)
  self:AddBeforeBuffDispelTrigger("bs_1003022_10", 1, self.OnBeforBuffDispel, nil, nil, self.config.buffId_lz1)
end

function bs_1003022:PlaySkill(data)
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
    LuaSkillCtrl:CallEffect(target, self.config.effectId_fire, self, nil, nil, nil, true)
  end
end

function bs_1003022:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_firehit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
    self.arglist[1]
  })
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_lz1, 1)
  LuaSkillCtrl:StartTimer(self, 10, function()
    LuaSkillCtrl:CallEffect(target, self.config.effectId_firehit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_lz1, 1)
  end)
end

function bs_1003022:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_lz1 and target ~= nil and target.hp > 0 and target:GetBuffTier(self.config.buffId_lz1) + target:GetBuffTier(self.config.buffId_lz2) >= 4 then
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if 0 >= buffs.Count then
      return
    end
    local _1tier = target:GetBuffTier(self.config.buffId_lz1)
    local _2tier = 0
    for i = 0, buffs.Count - 1 do
      if buffs[i].dataId == self.config.buffId_lz2 and buffs[i].maker ~= nil and 0 < buffs[i].maker.hp then
        _2tier = target:GetBuffTier(self.config.buffId_lz2)
      end
    end
    if _2tier == 0 then
      _1tier = 4
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = self.arglist[2] * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig2, {hurt_arg})
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effectId_lz, self)
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_lz1, 0, true)
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_lz2, 0)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fire, 1)
  end
end

function bs_1003022:OnBeforBuffDispel(target, context)
  if context.buffId == self.config.buffId_lz1 then
    local _1tier = target:GetBuffTier(self.config.buffId_lz1)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = self.arglist[2] * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig2, {hurt_arg})
    skillResult:EndResult()
  end
end

function bs_1003022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1003022
