local bs_30009 = class("bs_30009", LuaSkillBase)
local base = LuaSkillBase
bs_30009.config = {}

function bs_30009:ctor()
end

function bs_30009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["30009_arg"] = true
end

function bs_30009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30009
