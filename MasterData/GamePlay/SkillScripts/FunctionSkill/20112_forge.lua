local bs_20112 = class("bs_20112", LuaSkillBase)
local base = LuaSkillBase
bs_20112.config = {}

function bs_20112:ctor()
end

function bs_20112:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20112_1", 1, self.OnAfterBattleStart)
end

function bs_20112:OnAfterBattleStart()
  local atk_range = self.caster.attackRange
  if 2 < atk_range then
    local change_range = math.min(math.max(2 - atk_range, -2), 0)
    self.caster:AddRoleProperty(eHeroAttr.attackRange, change_range, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.damage_increase, -change_range * self.arglist[1], eHeroAttrType.Extra)
  end
end

function bs_20112:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20112
