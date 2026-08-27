local bs_10039 = class("bs_10039", LuaSkillBase)
local base = LuaSkillBase
bs_10039.config = {buffId = 26, buffTier = 1}

function bs_10039:ctor()
end

function bs_10039:InitSkill(isMidwaySkill)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[1])
end

function bs_10039:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10039
