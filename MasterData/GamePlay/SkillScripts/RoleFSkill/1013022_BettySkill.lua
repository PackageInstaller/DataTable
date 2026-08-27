local bs_1013022 = class("bs_1013022", LuaSkillBase)
local base = LuaSkillBase
bs_1013022.config = {buffId_Wild = 10130101, buffId_170 = 170}

function bs_1013022:ctor()
end

function bs_1013022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1013022:PlaySkill(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Wild, 1, self.arglist[1], true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
end

function bs_1013022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1013022
