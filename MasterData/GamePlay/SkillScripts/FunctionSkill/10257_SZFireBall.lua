local bs_10257 = class("bs_10257", LuaSkillBase)
local base = LuaSkillBase
bs_10257.config = {}

function bs_10257:ctor()
end

function bs_10257:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10257:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10257
