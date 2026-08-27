local bs_15151 = class("bs_15151", LuaSkillBase)
local base = LuaSkillBase
bs_15151.config = {}

function bs_15151:ctor()
end

function bs_15151:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15151_4", 1, self.OnAfterBattleStart)
end

function bs_15151:OnAfterBattleStart()
  local originalRebornTime = 150
  if self.caster.recordTable.RebornTime ~= nil then
    originalRebornTime = self.caster.recordTable.RebornTime
  end
  self.caster.recordTable.RebornTime = originalRebornTime - originalRebornTime * self.arglist[1] // 1000
end

function bs_15151:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15151
