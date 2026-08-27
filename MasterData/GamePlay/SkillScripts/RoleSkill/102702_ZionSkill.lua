local bs_102702 = class("bs_102702", LuaSkillBase)
local base = LuaSkillBase
bs_102702.config = {
  effectId1 = 10383,
  speed = 1,
  actionId = 1002,
  action_speed = 1,
  skill_time = 15,
  start_time = 16,
  audioId1 = 264,
  audio_loop = 265
}

function bs_102702:ctor()
end

function bs_102702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102702:PlaySkill(data)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:StartTimer(self, 6, function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, self.config.speed, true)
  end)
end

function bs_102702:TakeActionTrigger()
  self.isSkillUncompleted = false
  if self.actionTrigger ~= nil then
    if not self.isCommonAttack then
      LuaSkillCtrl:StopShowSkillDurationTime(self)
    end
    self.actionTrigger()
  end
end

function bs_102702:OnAttackTrigger()
  local base = self.caster.skill_intensity * self.arglist[1] // 1000
  local num = (self.caster.maxHp - self.caster.hp) * 1000 // self.caster.maxHp * self.arglist[3] // self.arglist[2]
  local shieldValue = base * (1000 + num) // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
end

function bs_102702:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102702
