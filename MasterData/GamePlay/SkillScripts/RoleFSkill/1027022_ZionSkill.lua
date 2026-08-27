local bs_1027022 = class("bs_1027022", LuaSkillBase)
local base = LuaSkillBase
bs_1027022.config = {
  effectId1 = 10383,
  speed = 1,
  actionId = 1002,
  action_speed = 1,
  skill_time = 15,
  start_time = 16,
  audioId1 = 264,
  audio_loop = 265
}

function bs_1027022:ctor()
end

function bs_1027022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1027022:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:StartTimer(self, 6, function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, self.config.speed, true)
  end)
end

function bs_1027022:OnAttackTrigger()
  local base = self.caster.skill_intensity * self.arglist[1] // 1000
  local num = (self.caster.maxHp - self.caster.hp) * 1000 // self.caster.maxHp * self.arglist[3] // self.arglist[2]
  local shieldValue = base * (1000 + num) // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
end

function bs_1027022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1027022
