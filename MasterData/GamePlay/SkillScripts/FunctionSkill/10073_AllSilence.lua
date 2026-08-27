local bs_10073 = class("bs_10073", LuaSkillBase)
local base = LuaSkillBase
bs_10073.config = {buffId = 26, buffTier = 1}

function bs_10073:ctor()
end

function bs_10073:InitSkill(isMidwaySkill)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[1])
end

function bs_10073:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10073
