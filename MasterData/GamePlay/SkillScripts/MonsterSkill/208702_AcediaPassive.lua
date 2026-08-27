local bs_208702 = class("bs_208702", LuaSkillBase)
local base = LuaSkillBase
bs_208702.config = {}

function bs_208702:ctor()
end

function bs_208702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["208701_Roll"] = self.arglist[1]
  self.caster.recordTable["208701_arg2"] = self.arglist[2]
end

function bs_208702:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208702
