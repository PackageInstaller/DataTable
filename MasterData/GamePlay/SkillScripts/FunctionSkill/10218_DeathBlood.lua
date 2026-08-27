local bs_10218 = class("bs_10218", LuaSkillBase)
local base = LuaSkillBase
bs_10218.config = {baseheal_formula = 10011, effectId = 1008}

function bs_10218:ctor()
end

function bs_10218:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10218_10", 1, self.OnRoleDie)
end

function bs_10218:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    local sheildNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.baseheal_formula, self.caster, role, self)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheildNum)
    self:PlayChipEffect()
  end
end

function bs_10218:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10218
