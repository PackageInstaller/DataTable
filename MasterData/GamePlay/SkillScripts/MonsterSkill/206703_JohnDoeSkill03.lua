local bs_206703 = class("bs_206703", LuaSkillBase)
local base = LuaSkillBase
bs_206703.config = {
  effectIdGrid = 2067031,
  effectIdGo = 2067032,
  effectIdUp = 2067033,
  effectIdStart = 2067034,
  effectIdAttack = 2067035,
  effectIdHurt = 2067036,
  effectIdHit = 2067037,
  selectId = 40,
  actionId = 1105,
  skill_time = 30,
  start_time = 7,
  buffId_hurt = 2067031,
  buffId_skillTip = 2067032,
  buffId_Stun = 3006,
  Aoe = {
    effect_shape = eSkillResultShapeType.Target,
    aoe_select_code = 4,
    aoe_range = 1
  },
  configId = 3
}

function bs_206703:ctor()
end

function bs_206703:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.grid = {}
  self.gridEffect = nil
  self.caster.recordTable.attackUp = self.arglist[4]
end

function bs_206703:PlaySkill(data)
  self:AbandonSkillCdAutoReset(true)
  local target = LuaSkillCtrl:GetRoleWithPos(5, 2)
  if target ~= nil and target.hp > 0 and target ~= self.caster then
    local grid1 = LuaSkillCtrl:CallFindEmptyGridNearest(target)
    LuaSkillCtrl:CallPhaseMove(self, target, grid1.x, grid1.y, 3, 69, 1, true)
  end
  local grid = LuaSkillCtrl:GetTargetWithGrid(5, 2)
  local gridrole = LuaSkillCtrl:GetGridWithPos(5, 2)
  self:ReadyPlaySkill(data, gridrole)
end

function bs_206703:ReadyPlaySkill(data, grid)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectIdGo, self)
  LuaSkillCtrl:SetRolePos(grid, self.caster)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectIdUp, self)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  local lookGrid = LuaSkillCtrl:GetTargetWithGrid(0, 2)
  self.caster:LookAtTarget(lookGrid)
  LuaSkillCtrl:PlayAuSource(self.caster, 465)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 1, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skillTip, 1, self.arglist[5] + self.config.skill_time)
  self.gridEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectIdAttack, self)
  LuaSkillCtrl:StartTimer(nil, self.config.skill_time, function()
    self:EndSkillAndCallNext()
  end)
end

function bs_206703:EndSkillAndCallNext()
  if self.caster == nil then
    return
  end
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CallNextBossSkill()
end

function bs_206703:OnAttackTrigger()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
  LuaSkillCtrl:PlayAuSource(self.caster, 466)
  self:InspectGridTarget(targetList)
  LuaSkillCtrl:StartTimer(nil, self.arglist[3], BindCallback(self, self.KillAllGridEffect))
  self:CallHurt()
end

function bs_206703:KillAllGridEffect()
  if self.gridEffect ~= nil then
    self.gridEffect:Die()
    self.gridEffect = nil
  end
end

function bs_206703:CallHurt()
  if self.grid == nil or table.count(self.grid) <= 0 then
    self:CancleCasterWait()
    return
  end
  local time = self.arglist[3] // 15
  LuaSkillCtrl:StartTimer(nil, 15, function()
    for i = 1, 5 do
      local grid = self.grid[i]
      if grid ~= nil and grid.role ~= nil and not LuaSkillCtrl:IsFixedObstacle(grid.role) and grid.role.belongNum ~= self.caster.belongNum then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, grid.role, self.config.Aoe)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
          self.arglist[2]
        })
        LuaSkillCtrl:CallEffect(grid.role, self.config.effectIdHit, self)
        skillResult:EndResult()
      end
    end
  end, self, time - 1)
end

function bs_206703:PhaseMoveRole(role, emptyGrid)
  self:TryResetMoveState(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId_Stun, 1, self.arglist[1] + 3)
  LuaSkillCtrl:CallPhaseMove(self, role, emptyGrid.x, emptyGrid.y, 3, 63, 1, true)
end

function bs_206703:InspectGridTarget(targetList)
  local isCheck = false
  for i = 5, 1, -1 do
    local grid = LuaSkillCtrl:GetGridWithPos(i - 1, 2)
    if grid ~= nil then
      if self.caster.recordTable.RootAddGrid ~= nil then
        LuaSkillCtrl:CallCreateEfcGrid(i - 1, 2, 15)
      end
      self.grid[i] = grid
      if grid:IsGridEmpty() then
        if targetList.Count <= 0 then
          return
        end
        if i == 5 then
          local roleT = self:FindTForFirstGrid(targetList)
          if roleT ~= nil then
            self:PhaseMoveRole(roleT, grid)
        end
        else
          if not isCheck then
            for j = targetList.Count - 1, 0, -1 do
              local targetRole = targetList[j].targetRole
              if not LuaSkillCtrl:CheckReletionWithRoleBelong(targetRole, self.caster, 2) or LuaSkillCtrl:RoleContainsBuffFeature(targetRole, eBuffFeatureType.CtrlImmunity) or 5 > targetRole.x and targetRole.y == 2 then
                targetList:RemoveAt(j)
              end
            end
            isCheck = true
          end
          for j = 0, targetList.Count - 1 do
            local targetRole = targetList[j].targetRole
            self:PhaseMoveRole(targetRole, grid)
            targetList:RemoveAt(j)
            break
          end
        end
      end
    end
  end
end

function bs_206703:FindTForFirstGrid(targetList)
  local topRole = self.caster.recordTable.lastAttackRole
  if topRole ~= nil and topRole.career == 1 and LuaSkillCtrl:CheckReletionWithRoleBelong(topRole, self.caster, 2) and not LuaSkillCtrl:RoleContainsBuffFeature(topRole, eBuffFeatureType.CtrlImmunity) then
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole == topRole then
        targetList:RemoveAt(i)
        return topRole
      end
    end
  end
  for i = targetList.Count - 1, 0, -1 do
    local target = targetList[i]
    local targetRole = target.targetRole
    if targetRole.career == 1 and LuaSkillCtrl:CheckReletionWithRoleBelong(targetRole, self.caster, 2) and not LuaSkillCtrl:RoleContainsBuffFeature(targetRole, eBuffFeatureType.CtrlImmunity) then
      targetList:RemoveAt(i)
      return targetRole
    end
  end
end

function bs_206703:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_206703:OnBreakSkill(breakRole)
  if breakRole == self.caster then
    LuaSkillCtrl:CanclePreSetPos(self.caster)
    self:KillAllGridEffect()
  end
  base.OnBreakSkill(self, breakRole)
end

function bs_206703:LuaDispose()
  base.LuaDispose(self)
  self.grid = nil
  self.gridEffect = nil
end

return bs_206703
