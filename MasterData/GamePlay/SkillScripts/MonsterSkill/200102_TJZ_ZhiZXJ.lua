local bs_200102 = class("bs_200102", LuaSkillBase)
local base = LuaSkillBase
bs_200102.config = {
  selectTargetId = 9,
  select_range = 20,
  select_target_buff_stun = 278,
  select_target_buff_super = 198,
  effectId = 10085,
  damageFormular = 1047,
  action_start = 1008,
  action_end = 1009,
  start_time = 6,
  pre_action_start_time = 15,
  phase_move_duration = 6,
  audioId1 = 51,
  audioId2 = 52,
  buffId_196 = 196,
  effectId1 = 10084,
  effectId2 = 10864,
  effectId3 = 10867,
  phaseMoveBuffId_69 = 69
}

function bs_200102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_200102:PlaySkill(data)
  if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.NotMove) then
    return
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId, self.config.select_range)
  if targetlist == nil or targetlist.Count <= 0 then
    return
  end
  local targetRole = targetlist[0].targetRole
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, targetRole) then
    self:CallCasterWait(self.config.start_time + 5)
    self:PlayActionAndDamage(targetRole)
    return
  end
  local role, emptyGrid, dontNeedMove = self:CheckAndGetEmptyRole(targetlist)
  if dontNeedMove and role ~= nil then
    self:CallCasterWait(self.config.start_time + 5)
    self:PlayActionAndDamage(role)
    return
  end
  if role == nil or emptyGrid == nil then
    return
  end
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, role) then
    self:CallCasterWait(self.config.start_time + 5)
    self:PlayActionAndDamage(role)
  else
    LuaSkillCtrl:PreSetRolePos(emptyGrid, self.caster)
    local moveAttackTrigger = BindCallback(self, self.PhaseMoveHandle, role, emptyGrid)
    role.recordTable.isPhaseSelect = true
    local waitSecond = self.config.pre_action_start_time + 15 + self.config.start_time
    LuaSkillCtrl:CallBreakAllSkill(role)
    LuaSkillCtrl:CallBuff(self, role, self.config.select_target_buff_stun, 1, waitSecond + 1, true)
    self.effect0 = LuaSkillCtrl:CallEffect(role, self.config.effectId3, self)
    LuaSkillCtrl:StartTimer(nil, 23, function()
      if self.effect0 ~= nil then
        self.effect0:Die()
        self.effect0 = nil
      end
    end)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, waitSecond + 1)
    self:CallCasterWait(waitSecond)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action_start, 1, 15, moveAttackTrigger)
  end
end

function bs_200102:PhaseMoveHandle(targetRole, emptyGrid)
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  LuaSkillCtrl:CallPhaseMove(self, self.caster, emptyGrid.x, emptyGrid.y, self.config.phase_move_duration, self.config.phaseMoveBuffId_69)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.PlayActionAndDamage, targetRole))
end

function bs_200102:CheckAndGetEmptyRole(roleList)
  local result, emptyGrid
  local dontNeedMove = false
  for i = 0, roleList.Count - 1 do
    local targetRole = roleList[i].targetRole
    if not (0 >= targetRole.intensity) and targetRole ~= nil and targetRole.lastPreSetGrid == nil and (targetRole.recordTable.isPhaseSelect == nil or not targetRole.recordTable.isPhaseSelect) then
      if LuaSkillCtrl:IsRoleAdjacent(self.caster, targetRole) then
        dontNeedMove = true
        return targetRole, nil, dontNeedMove
      end
      emptyGrid = LuaSkillCtrl:FindEmptyGridAroundRole(targetRole)
      if emptyGrid ~= nil and self:CheckAbandonRoleNextRoutes(roleList, emptyGrid) then
        return targetRole, emptyGrid, dontNeedMove
      end
    end
  end
  for i = 0, roleList.Count - 1 do
    local targetRole = roleList[i].targetRole
    if targetRole ~= nil and targetRole.lastPreSetGrid == nil then
      emptyGrid = LuaSkillCtrl:FindEmptyGridAroundRole(targetRole)
      if emptyGrid ~= nil and self:CheckAbandonRoleNextRoutes(roleList, emptyGrid) then
        return targetRole, emptyGrid, dontNeedMove
      end
    end
  end
  return result, emptyGrid, dontNeedMove
end

function bs_200102:PlayActionAndDamage(targetRole)
  targetRole.recordTable.isPhaseSelect = false
  local lookAtCallBack = BindCallback(self, function(table, caster, targetRole)
    caster:LookAtTarget(targetRole)
  end, self.caster, targetRole)
  LuaSkillCtrl:StartTimer(self, 3, lookAtCallBack)
  local attackEndTrigger = BindCallback(self, self.DamageAndEffect, targetRole)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_end, 1)
  LuaSkillCtrl:StartTimer(nil, self.config.start_time + 3, attackEndTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.effect0 ~= nil then
    self.effect0:Die()
    self.effect0 = nil
  end
end

function bs_200102:DamageAndEffect(targetRole)
  local damageNum1 = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormular, self.caster, targetRole, self)
  local damageNum2 = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormular, targetRole, self.caster, self)
  LuaSkillCtrl:RemoveLife(damageNum2, self, targetRole, false, nil, true, false, eHurtType.RealDmg)
  LuaSkillCtrl:RemoveLife(damageNum1, self, self.caster, false, nil, true, false, eHurtType.RealDmg)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc)
end

function bs_200102:CheckAbandonRoleNextRoutes(targetRoles, emptyGrid)
  for i = 0, targetRoles.Count - 1 do
    local targetRole = targetRoles[i].targetRole
    local nextRoutes = targetRole.nextCoordRoute
    if nextRoutes ~= nil and 0 < nextRoutes.Count then
      local index = nextRoutes.Count - 1
      if nextRoutes[index].x == emptyGrid.x and nextRoutes[index].y == emptyGrid.y then
        return false
      end
    end
  end
  return true
end

function bs_200102:OnCasterDie()
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  base.OnCasterDie(self)
  if self.effect0 ~= nil then
    self.effect0:Die()
    self.effect0 = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_200102:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_200102
