local bs_30021 = class("bs_30021", LuaSkillBase)
local base = LuaSkillBase
bs_30021.config = {}

function bs_30021:ctor()
end

function bs_30021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["30021_Flag"] = true
end

function bs_30021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30021
