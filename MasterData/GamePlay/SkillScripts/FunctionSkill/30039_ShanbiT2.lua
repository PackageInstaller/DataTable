local bs_30039 = class("bs_30039", LuaSkillBase)
local base = LuaSkillBase
bs_30039.config = {}

function bs_30039:ctor()
end

function bs_30039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["30039_Flag"] = true
end

function bs_30039:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30039
