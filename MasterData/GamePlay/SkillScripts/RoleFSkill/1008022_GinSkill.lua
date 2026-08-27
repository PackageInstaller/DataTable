local bs_1008022 = class("bs_1008022", LuaSkillBase)
local base = LuaSkillBase
bs_1008022.config = {
  buffId_160 = 10080101,
  skill_time = 15,
  buffId_170 = 3008
}

function bs_1008022:ctor()
end

function bs_1008022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1008022:PlaySkill(data)
  local buff_time = self.config.skill_time + self.arglist[1]
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_160, 1, buff_time, true)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, buff_time, true)
  LuaSkillCtrl:CallRoleAction(self.caster, 1002)
  LuaSkillCtrl:StartShowSkillDurationTime(self, buff_time)
end

function bs_1008022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1008022
