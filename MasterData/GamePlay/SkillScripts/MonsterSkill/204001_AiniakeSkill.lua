local bs_204001 = class("bs_204001", LuaSkillBase)
local base = LuaSkillBase
bs_204001.config = {
  effectId = 10909,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10118,
    crit_formula = 0
  }
}

function bs_204001:ctor()
end

function bs_204001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_204001_2", 10, self.OnAfterBattleStart)
  self.pasika = nil
end

function bs_204001:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList == nil or targetList.Count < 1 then
    return
  end
  for i = 0, targetList.Count - 1 do
    if targetList[i].targetRole.roleDataId == 1001 and targetList[i].targetRole.belongNum == 1 then
      self.pasika = targetList[i].targetRole
    end
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 5, 10)
  if targetList == nil or targetList.Count < 1 then
    return
  end
  for i = 0, targetList.Count - 1 do
    local targetRole = targetList[i].targetRole
    if targetRole ~= nil and targetRole ~= self.caster and targetRole.roleDataId ~= 104 and targetRole.roleDataId ~= 1001 then
      LuaSkillCtrl:CallBuff(self, targetRole, 1025, 1, nil, true, self.pasika)
    end
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.OnShout, self, -1)
end

function bs_204001:OnShout()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc, nil, 1)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 5, 10)
  if targetList == nil or 1 > targetList.Count then
    return
  end
  for i = 0, targetList.Count - 1 do
    local targetRole = targetList[i].targetRole
    if targetRole ~= nil and targetRole.roleDataId == 104 then
      local emptyGrid = LuaSkillCtrl:FindEmptyGridWithinRange(self.caster, 1)
      if emptyGrid ~= nil then
        targetList[i].targetRole:ResetRoleState()
        LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, targetList[i].targetRole, emptyGrid.x, emptyGrid.y, 5)
    end
    else
      if targetRole ~= nil and targetRole ~= self.caster and targetRole.roleDataId ~= 104 and targetRole.roleDataId ~= 1001 then
        local emptyGrid = LuaSkillCtrl:CallFindEmptyGridClosedToTargetInRange(self.caster.x, self.caster.y, targetRole)
        if emptyGrid ~= nil then
          LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, targetList[i].targetRole, emptyGrid.x, emptyGrid.y, 5)
        end
      end
      if targetRole ~= nil and targetRole.roleDataId == 1001 and targetRole.belongNum == 1 then
        local emptyGrid = LuaSkillCtrl:FindRoleRightEmptyGrid(targetRole, 1)
        if emptyGrid ~= nil then
          LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, targetRole, emptyGrid.x, emptyGrid.y, 5)
        elseif targetRole.x < 6 then
          local targetGrid_role = LuaSkillCtrl:GetRoleWithPos(targetRole.x + 1, targetRole.y)
          if targetGrid_role ~= nil and targetGrid_role.roleDataId == 1001 then
            local hurt = targetGrid_role.maxHp // 4
            LuaSkillCtrl:RemoveLife(hurt, self, targetGrid_role, true, nil, true, true)
          end
        end
      end
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_204001:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_204001
