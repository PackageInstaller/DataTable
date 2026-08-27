local bs_105003 = class("bs_105003", LuaSkillBase)
local base = LuaSkillBase
bs_105003.config = {
  actionId_start = 1005,
  actionId_end = 1006,
  buffId_Super = 3003,
  buff_hitfly = 3019,
  shieldFormula = 105001,
  configId = 3,
  effectId1 = 105008,
  effectId2 = 105009,
  effectId3 = 105010,
  audioIdStart = 105011,
  audioIdMovie = 105012,
  audioIdEnd = 105013,
  buffId_shield = 105004
}

function bs_105003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_105003_1", 1, self.OnBreakShield)
end

function bs_105003:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 and 0 < target:GetBuffTier(self.config.buffId_shield) then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_shield, 0)
  end
end

function bs_105003:PlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(30)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute), selectRolesType)
end

function bs_105003:CallSelectExecute(role)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  if role == self.caster and not self.caster.recordTable["105001_summoner_alive"] and self.caster.recordTable.ult_tip == true then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.PuzzleSummonerTimerAcc, -1)
    LuaSkillCtrl:StartTimer(nil, 2, function()
      local role_ex = self.caster
      if self.caster.recordTable["105001_summoner_alive"] then
        role_ex = self.caster.recordTable["105001_summoner"]
      end
      if role_ex == self.caster then
        local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, nil, self)
        if 0 < shieldValue then
          LuaSkillCtrl:AddRoleShield(role_ex, eShieldType.Normal, shieldValue)
          self:shieldBuff(role_ex)
        end
      end
      LuaSkillCtrl:CallEffect(role_ex, self.config.effectId1, self)
      local grid_ex = LuaSkillCtrl:GetGridWithRole(role_ex)
      local roles_ex = LuaSkillCtrl:FindRolesAroundGrid(grid_ex, LuaSkillCtrl:GetRelationBelong(self.caster.belongNum, eBattleRoleBelong.enemy))
      if roles_ex == nil or 0 >= roles_ex.Count then
        return
      end
      for i = 0, roles_ex.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles_ex[i])
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
          self.arglist[3]
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(roles_ex[i], self.config.effectId3, self)
        LuaSkillCtrl:CallBuff(self, roles_ex[i], self.config.buff_hitfly, 1, self.arglist[4])
      end
    end)
    return
  end
  if role ~= nil then
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, nil, self)
    if 0 < shieldValue then
      LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
      self:shieldBuff(role)
    end
    LuaSkillCtrl:CallEffect(role, self.config.effectId1, self)
    local grid = LuaSkillCtrl:GetGridWithRole(role)
    local roles = LuaSkillCtrl:FindRolesAroundGrid(grid, LuaSkillCtrl:GetRelationBelong(self.caster.belongNum, eBattleRoleBelong.enemy))
    if roles == nil or 0 >= roles.Count then
      return
    end
    for i = 0, roles.Count - 1 do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles[i])
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
        self.arglist[3]
      })
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(roles[i], self.config.effectId3, self)
      LuaSkillCtrl:CallBuff(self, roles[i], self.config.buff_hitfly, 1, self.arglist[4])
    end
  end
end

function bs_105003:shieldBuff(role)
  LuaSkillCtrl:StartTimer(self, 1, function()
    local shield_num = LuaSkillCtrl:GetShield(role, eShieldType.Normal)
    if 0 < shield_num then
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_shield, 1, nil)
    end
  end)
end

function bs_105003:PlayUltEffect(data, selectTargetCoord, selectRoles)
  if not self:Check(selectRoles) then
    return true
  end
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  if selectRoles ~= nil and selectRoles.Count > 0 then
    self.target = selectRoles[0]
  end
  if self.target ~= nil then
    self.caster:LookAtInstantly(self.target)
  end
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_105003:Check(selectRoles)
  if selectRoles == nil or selectRoles.Count <= 0 then
    return false
  end
  return self:CheckManualSkillTakeAvailable(selectRoles[0])
end

function bs_105003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_105003:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_105003:LuaDispose()
  self.target = nil
  base.LuaDispose(self)
end

return bs_105003
