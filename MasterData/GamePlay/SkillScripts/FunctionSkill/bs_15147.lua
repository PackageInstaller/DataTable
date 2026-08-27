local bs_15147 = class("bs_15147", LuaSkillBase)
local base = LuaSkillBase
bs_15147.config = {
  heal_config = {
    baseheal_formula = 501,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_15147:ctor()
end

function bs_15147:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_15147", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum, nil, eBattleRoleType.character)
end

function bs_15147:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    local healNum = role.maxHp * self.arglist[1] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {healNum}, true, true)
    skillResult:EndResult()
  end
end

function bs_15147:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15147
