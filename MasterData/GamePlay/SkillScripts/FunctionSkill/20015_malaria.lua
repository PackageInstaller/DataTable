local bs_20015 = class("bs_20015", LuaSkillBase)
local base = LuaSkillBase
bs_20015.config = {}

function bs_20015:ctor()
end

function bs_20015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20015_1", 1, self.OnAfterBattleStart)
end

function bs_20015:OnAfterBattleStart()
  local attr = self.caster.battleEnd_hp_regen
  LuaSkillCtrl:CallAddRoleProperty(self.caster, eHeroAttr.battleEnd_hp_regen, -attr, eHeroAttrType.Extra)
  LuaSkillCtrl:CallAddRoleProperty(self.caster, eHeroAttr.battleEnd_hp_regen, 1, eHeroAttrType.Extra)
end

function bs_20015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20015
