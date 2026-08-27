local bs_21242 = class("bs_21242", LuaSkillBase)
local base = LuaSkillBase
bs_21242.config = {}

function bs_21242:ctor()
end

function bs_21242:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_21242:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21242
