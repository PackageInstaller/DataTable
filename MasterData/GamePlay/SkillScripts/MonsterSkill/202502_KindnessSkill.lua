local bs_202502 = class("bs_202502", LuaSkillBase)
local base = LuaSkillBase
bs_202502.config = {
  buffId_194 = 194,
  skill_time = 30,
  startAnimId = 1002,
  audio_loop = 316
}

function bs_202502:ctor()
end

function bs_202502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_202502:PlaySkill(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_194, 1, self.arglist[1] + self.config.skill_time)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.startAnimId)
end

function bs_202502:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202502
