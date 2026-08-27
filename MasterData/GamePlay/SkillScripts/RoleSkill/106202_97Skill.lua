local bs_106202 = class("bs_106202", LuaSkillBase)
local base = LuaSkillBase
bs_106202.config = {
  effectId_skill = 106211,
  effectId_hit = 106208,
  hurtConfig = 25,
  hurtConfig2 = 24,
  skill_time = 23,
  skill_time2 = 27,
  start_time = 7,
  start_time2 = 5,
  actionId = 1105,
  actionId2 = 1056,
  action_speed = 1,
  skill_selectId = 1001,
  audioId1 = 234,
  audioId2 = 235,
  buffId1 = 106201,
  buffId2 = 106203,
  buffId_170 = 170,
  weaponLv = 0
}

function bs_106202:ctor()
end

function bs_106202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106202:PlaySkill(data)
  self.caster.recordTable.IsInSkill1 = true
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local moveTarget = self:GetMoveSelectTarget()
    if moveTarget ~= nil then
      target = moveTarget.targetRole
    end
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId2, self.config.action_speed, self.config.start_time2, attackTrigger)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self)
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
    LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_hit, self)
    LuaSkillCtrl:StartTimer(self, self.config.start_time2 - 2, function()
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId2, 1, 1)
    end)
    LuaSkillCtrl:StartTimer(self, self.config.start_time2 - 1, function()
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId2, 1, 1)
    end)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnJiangyuSkill, target)
  end
end

function bs_106202:OnAttackTrigger(target)
  if target:GetBuffTier(self.config.buffId1) >= 4 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[3]
    })
    skillResult:EndResult()
  else
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
  self:OnSkillDamageEnd()
  self.caster.recordTable.IsInSkill1 = false
end

function bs_106202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106202
