local bs_20119 = class("bs_20119", LuaSkillBase)
local base = LuaSkillBase
bs_20119.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId = 10923
}

function bs_20119:ctor()
end

function bs_20119:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_20119_1", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_20119:OnAfterMove()
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  local targetList = LuaSkillCtrl:FindRolesAroundGrid(grid, eBattleRoleBelong.enemy)
  if targetList ~= nil and targetList.Count > 0 and self:IsReadyToTake() then
    self:DoDamage()
  end
end

function bs_20119:OnRoleSplash(role, grid)
  if role == self.caster and role.curCoord == grid.coord and self:IsReadyToTake() then
    local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    local targetList = LuaSkillCtrl:FindRolesAroundGrid(grid, eBattleRoleBelong.enemy)
    if targetList ~= nil and targetList.Count > 0 then
      self:DoDamage()
    end
  end
end

function bs_20119:DoDamage()
  self:OnSkillTake()
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_config)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_20119:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20119
