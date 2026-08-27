local bs_104402 = class("bs_104402", LuaSkillBase)
local base = LuaSkillBase
bs_104402.config = {
  start_time = 8,
  end_time = 35,
  buffId_170 = 170,
  actionId = 1008,
  actionId_end = 1009,
  selectid = 501101,
  actionId_speed = 1,
  effectId_Trail = 104406,
  effectId_Trail_Big = 104408,
  effectId_skillStart = 104414,
  effectId_Big_open = 104417,
  effectId_Big_open2 = 104424,
  effectId_loop = 104423,
  effectId_Teleport_ready = 203306,
  effectId_Teleport_arrive = 203306,
  configId_trail = 3,
  weaponLv = 0,
  buffID_range = 104402,
  buff_blind = 3012
}

function bs_104402:ctor()
end

function bs_104402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_104402_1", 1, self.OnAfterBattleStart)
end

function bs_104402:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_range, 1)
end

function bs_104402:PlaySkill(data)
  if self.config.weaponLv > 0 then
    self:ReadyTeleport()
  end
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and 0 < last_target.hp and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, self.cskill.SkillRange) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  local time = self.config.start_time + self.arglist[3] + self.config.end_time
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  self.skillLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillStart, self, nil, nil, nil, true)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 304406 then
    self.skillLoop2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self, nil, nil, nil, true)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.config.start_time + self.arglist[3], true)
end

function bs_104402:OnAttackTrigger(target)
  if target ~= nil and target.hp > 0 then
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[3])
    local starttime = 1 - self.arglist[1]
    local beginTimer = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
      self:beginAttack(target)
    end, self, -1, starttime)
    LuaSkillCtrl:StartTimer(self, self.arglist[3], function()
      if beginTimer ~= nil then
        beginTimer:Stop()
        beginTimer = nil
      end
      self:endAttack(target)
    end)
  else
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
  end
end

function bs_104402:beginAttack(target)
  if target ~= nil and target.hp > 0 and not target:ContainFeature(eBuffFeatureType.Exiled) and not target:ContainFeature(eBuffFeatureType.NotBeSelectedExceptSameBlong) then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_Trail, self, self.SkillEventFunc)
  else
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
  end
end

function bs_104402:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_Trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId_trail, {
      self.arglist[2]
    })
    skillResult:EndResult()
  end
  if effect.dataId == self.config.effectId_Trail_Big and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    if self.config.weaponLv > 0 then
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_blind, 1, self.arglist[6])
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId_trail, {
        self.arglist[4] + self.arglist[5]
      })
    else
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId_trail, {
        self.arglist[4]
      })
    end
    skillResult:EndResult()
    self:OnSkillDamageEnd()
  end
end

function bs_104402:endAttack(target)
  if target == nil or target.hp <= 0 or target:ContainFeature(eBuffFeatureType.Exiled) or target:ContainFeature(eBuffFeatureType.NotBeSelectedExceptSameBlong) then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
  if 0 < self.config.weaponLv and 0 < self.caster:GetBuffTier(self.config.buffID_range) then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_range, 0)
  end
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  LuaSkillCtrl:StartTimer(self, 18, function()
    if target ~= nil and target.hp > 0 and not target:ContainFeature(eBuffFeatureType.Exiled) and not target:ContainFeature(eBuffFeatureType.NotBeSelectedExceptSameBlong) then
      if LuaSkillCtrl:GetCasterSkinId(self.caster) == 304406 then
        LuaSkillCtrl:CallEffect(target, self.config.effectId_Big_open2, self)
      else
        LuaSkillCtrl:CallEffect(target, self.config.effectId_Big_open, self)
      end
      LuaSkillCtrl:CallEffect(target, self.config.effectId_Trail_Big, self, self.SkillEventFunc)
    end
  end)
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  if self.skillLoop2 ~= nil then
    self.skillLoop2:Die()
    self.skillLoop2 = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  LuaSkillCtrl:StartTimer(nil, self.config.end_time, function()
    self:CancleCasterWait()
  end)
end

function bs_104402:ReadyTeleport()
  local targetlist_allies = LuaSkillCtrl:CallTargetSelect(self, self.config.selectid, 10)
  local tar, grid_tar
  local grid_self = LuaSkillCtrl:GetGridWithRole(self.caster)
  if targetlist_allies ~= nil and targetlist_allies.Count > 0 then
    local num_min = self:CountNum(grid_self, eBattleRoleBelong.enemy)
    for i = 0, targetlist_allies.Count - 1 do
      local targetRole = targetlist_allies[i].targetRole
      if targetRole ~= self.caster then
        local tempGrid = LuaSkillCtrl:GetGridWithRole(targetRole)
        local num_current_tar = self:CountNum(tempGrid, eBattleRoleBelong.enemy)
        local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(targetRole.x, targetRole.y, 1)
        if grids ~= nil and grids.Count > 0 then
          for j = 0, grids.Count - 1 do
            local num_current = self:CountNum(grids[j], eBattleRoleBelong.enemy)
            if num_min >= num_current and num_min >= num_current_tar then
              tar = targetlist_allies[i]
              grid_tar = grids[j]
            end
          end
        end
      end
    end
  end
  if tar ~= nil and grid_tar ~= nil and grid_tar ~= grid_self then
    self:Teleport(tar, grid_tar)
  else
    self:Teleport(self.caster, grid_self)
  end
end

function bs_104402:Teleport(target, grid)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_range, 1, 45, true)
  if target == self.caster then
    LuaSkillCtrl:SetGameObjectActive(self.caster.lsObject, false)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:StartTimer(nil, 5, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_Teleport_arrive, self, nil, nil, nil, true)
      LuaSkillCtrl:SetGameObjectActive(self.caster.lsObject, true)
    end)
  else
    local tar_grid, grid_real
    grid_real = grid
    tar_grid = LuaSkillCtrl:GetTargetWithGrid(grid_real.x, grid_real.y)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_Teleport_ready, self, nil, nil, nil, true)
    LuaSkillCtrl:CallEffect(tar_grid, self.config.effectId_Teleport_arrive, self, nil, nil, nil, true)
    LuaSkillCtrl:SetRolePos(grid_real, self.caster)
  end
end

function bs_104402:CountNum(grid, Belongnum)
  if grid == nil then
    return 0
  end
  local targetList = LuaSkillCtrl:FindRolesAroundGrid(grid, Belongnum)
  if targetList == nil then
    return 0
  end
  local targetcount = targetList.Count
  return targetcount
end

function bs_104402:GetRoleBehindGrid(role)
  local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 4)
  if grid_dict == nil or grid_dict.Count <= 0 then
    return nil
  end
  local grid
  for j = 0, grid_dict.Count - 1 do
    grid = grid_dict[j]
    local lsObject = role.lsObject
    local tempdir = CS.TrueSync.TSVector3.Subtract(lsObject.localPosition, grid.fixLogicPosition).normalized
    local qua = CS.TrueSync.TSQuaternion.LookRotation(tempdir)
    if qua.eulerAngles ~= lsObject.localRotation.eulerAngles then
      local angle = CS.TrueSync.TSQuaternion.Angle(qua, lsObject.localRotation):AsInt()
      if -60 < angle and angle < 60 then
        self.caster.recordTable.turn = role
        return grid
      end
    end
    grid = nil
  end
end

function bs_104402:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    if self.skillLoop ~= nil then
      self.skillLoop:Die()
      self.skillLoop = nil
    end
    if self.skillLoop2 ~= nil then
      self.skillLoop2:Die()
      self.skillLoop2 = nil
    end
  end
end

function bs_104402:OnCasterDie()
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  if self.skillLoop2 ~= nil then
    self.skillLoop2:Die()
    self.skillLoop2 = nil
  end
  base.OnCasterDie(self)
end

return bs_104402
