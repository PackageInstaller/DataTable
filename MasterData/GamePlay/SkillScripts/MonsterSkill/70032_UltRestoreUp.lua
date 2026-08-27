local bs_70032 = class("bs_70032", LuaSkillBase)
local base = LuaSkillBase
bs_70032.config = {}

function bs_70032:ctor()
end

function bs_70032:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70032_1", 1, self.OnAfterBattleStart)
end

function bs_70032:OnAfterBattleStart()
  LuaSkillCtrl:CallAddRoleProperty(self.caster, 15, 10000000, eHeroAttrType.Extra)
end

function bs_70032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70032
