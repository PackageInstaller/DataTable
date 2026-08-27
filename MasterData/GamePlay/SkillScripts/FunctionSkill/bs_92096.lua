local bs_92096 = class("bs_92096", LuaSkillBase)
local base = LuaSkillBase
bs_92096.config = {}

function bs_92096:ctor()
end

function bs_92096:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_92096:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92096
