local bs_20180 = class("bs_20180", LuaSkillBase)
local base = LuaSkillBase
bs_20180.config = {}

function bs_20180:ctor()
end

function bs_20180:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.RootGroupCurse = true
end

function bs_20180:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20180
