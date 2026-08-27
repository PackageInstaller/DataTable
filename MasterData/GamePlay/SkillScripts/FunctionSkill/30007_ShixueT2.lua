local bs_30007 = class("bs_30007", LuaSkillBase)
local base = LuaSkillBase
bs_30007.config = {}

function bs_30007:ctor()
end

function bs_30007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["30007_arg"] = true
end

function bs_30007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30007
