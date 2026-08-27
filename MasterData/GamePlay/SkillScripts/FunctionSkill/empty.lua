local empty = class("empty", LuaSkillBase)
local base = LuaSkillBase
empty.config = {}

function empty:ctor()
end

function empty:InitSkill(isMidwaySkill)
end

function empty:PlaySkill()
end

function empty:OnCasterDie()
  base.OnCasterDie(self)
end

return empty
