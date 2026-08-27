local bs_214302 = class("bs_214302", LuaSkillBase)
local base = LuaSkillBase
bs_214302.config = {}

function bs_214302:ctor()
end

function bs_214302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.bs_214302 = true
end

function bs_214302:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_214302:LuaDispose()
  base.LuaDispose(self)
end

return bs_214302
