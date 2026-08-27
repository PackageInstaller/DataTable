local gs_31 = class("gs_31", LuaGridBase)
gs_31.config = {
  effectId = 10962,
  heal_config = {baseheal_formula = 501}
}

function gs_31:ctor()
end

function gs_31:OnGridBattleStart(role)
end

function gs_31:OnGridEnterRole(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  local healNum = role.maxHp * 50 // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.config.aoe_config)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {healNum}, true, true)
end

function gs_31:OnGridExitRole(role)
end

function gs_31:OnGridRoleDead(role)
end

return gs_31
