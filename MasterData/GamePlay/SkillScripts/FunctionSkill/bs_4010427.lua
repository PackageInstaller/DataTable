local bs_4010427 = class("bs_4010427", LuaSkillBase)
local base = LuaSkillBase
bs_4010427.config = {}

function bs_4010427:ctor()
end

function bs_4010427:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_4010427:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010427
