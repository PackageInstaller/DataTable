local bs_40021 = class("bs_40021", LuaSkillBase)
local base = LuaSkillBase
bs_40021.config = {}

function bs_40021:ctor()
end

function bs_40021:InitSkill(isMidwaySkill)
  self.caster.recordTable.life_num = self.arglist[1]
end

function bs_40021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_40021
