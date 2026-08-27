local bs_212400 = class("bs_212400", LuaSkillBase)
local base = LuaSkillBase
bs_212400.config = {
  buffId1 = 175,
  buffId2 = 1033,
  buffId3 = 198,
  heal_config = {baseheal_formula = 3022},
  effectId = 212400,
  buffId4 = 212400,
  grid_id = 33
}

function bs_212400:ctor()
end

function bs_212400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_212400", 1, self.OnAfterBattleStart)
end

function bs_212400:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
end

function bs_212400:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 5, 10)
  for i = targets.Count - 1, 0, -1 do
    local role = targets[i].targetRole
    if LuaSkillCtrl:IsObstacle(role) then
      targets:RemoveAt(i)
    end
  end
  if targets.Count > 0 then
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if role ~= nil and 0 < role.hp and role.camp == 2 and role.belongNum == eBattleRoleBelong.enemy then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
          self.arglist[1]
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId4, 1, nil, true)
      end
    end
  end
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid ~= nil then
    LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, self.config.grid_id)
  end
end

return bs_212400
