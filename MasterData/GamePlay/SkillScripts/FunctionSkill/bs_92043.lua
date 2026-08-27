local bs_92043 = class("bs_92043", LuaSkillBase)
local base = LuaSkillBase
bs_92043.config = {baseheal_formula = 10011, effectId = 1008}

function bs_92043:ctor()
end

function bs_92043:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_102506_2", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_92043:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.player then
    local sheildNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.baseheal_formula, self.caster, role, self)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheildNum)
    self:PlayChipEffect()
  end
end

function bs_92043:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92043
