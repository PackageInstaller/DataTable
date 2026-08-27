local bs_30033 = class("bs_30033", LuaSkillBase)
local base = LuaSkillBase
bs_30033.config = {}

function bs_30033:ctor()
end

function bs_30033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["30033_Flag"] = true
end

function bs_30033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30033
