local bs_10341 = class("bs_10341", LuaSkillBase)
local base = LuaSkillBase
bs_10341.config = {buffId = 2069, buffId2 = 1291}

function bs_10341:ctor()
end

function bs_10341:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10341:OnAfterBattleStart()
end

function bs_10341:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10341
