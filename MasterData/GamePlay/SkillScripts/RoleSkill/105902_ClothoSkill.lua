local bs_105902 = class("bs_105902", LuaSkillBase)
local base = LuaSkillBase
bs_105902.config = {
  HurtConfigID = 20,
  HurtConfigID1 = 19,
  buffId = 105903,
  buffId_focusOnFiring = 105904,
  skill_time = 27,
  actionId = 1002,
  action_speed = 1,
  start_time = 6,
  effectId_cast = 105907,
  effectId_hit = 105908,
  effectId_cast_hit = 105910,
  weaponLv = 0
}

function bs_105902:ctor()
end

function bs_105902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_105902_01", 1, self.OnAfterPlaySkill)
end

function bs_105902:PlaySkill(data)
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
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
  end
end

function bs_105902:OnAttackTrigger(target)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_focusOnFiring, 1, self.arglist[3], false, target)
    end
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arglist[1],
    self.arglist[2]
  })
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[3])
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
  if 2 <= self.config.weaponLv then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_blind, 1, self.arglist[6])
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_damageup, 1, self.arglist[6])
  end
  self:OnSkillDamageEnd()
end

function bs_105902:OnAfterPlaySkill(skill, role)
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  if skill.isCommonAttack and skill.maker.belongNum == self.caster.belongNum and target:GetBuffTier(self.config.buffId) > 0 then
    LuaSkillCtrl:StartTimer(nil, 8, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID1, {
        self.arglist[4]
      }, true)
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(target, self.config.effectId_cast_hit, self)
    end, nil)
  end
end

function bs_105902:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105902
