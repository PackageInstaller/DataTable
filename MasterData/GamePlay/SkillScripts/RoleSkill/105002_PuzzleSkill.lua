local bs_105002 = class("bs_105002", LuaSkillBase)
local base = LuaSkillBase
bs_105002.config = {
  buff_stun = 3006,
  buffId_sum = 105002,
  actionId = 1002,
  action_speed = 1,
  start_time = 14,
  skill_time = 31,
  sumSkill_time = 38,
  effectId_line = 105005,
  effectId_hit = 105006,
  effectId_start = 105015,
  effectId_trail = 104110,
  configId = 3,
  audioId_Refresh = 105008,
  audioId_Counting = 105010,
  weaponLv = 0
}

function bs_105002:ctor()
end

function bs_105002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.config.weaponLv >= 2 then
    self.caster.recordTable.arg4 = self.arglist[4] - self.arglist[6]
  else
    self.caster.recordTable.arg4 = self.arglist[4]
  end
end

function bs_105002:PlaySkill(data)
  local summonerGrid = self.caster.recordTable["105001_summoner_grid"]
  local summoner = self.caster.recordTable["105001_summoner"]
  if self.caster.recordTable["105001_summoner_alive"] then
    self.caster:LookAtTarget(summoner)
    LuaSkillCtrl:CallBuff(self, summoner, self.config.buffId_sum, 1, self.config.sumSkill_time)
  else
  end
  local attackTrigger = BindCallback(self, self.FindRolesBetweenSummoner)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  if self.caster.recordTable["105001_summoner_alive"] then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_Refresh)
  else
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_Counting)
  end
end

function bs_105002:SwichSkill(summoner)
  LuaSkillCtrl:CallEffect(summoner, self.config.effectId_hit, self)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(summoner, 2, false)
  if targetList == 0 then
    return
  end
  for i = targetList.Count - 1, 0, -1 do
    local role = targetList[i]
    if role == nil or role.belongNum == eBattleRoleBelong.player or 2 < LuaSkillCtrl:GetRoleGridsDistance(role, summoner) then
      targetList:RemoveAt(i)
    end
  end
  local target_num = targetList.Count
  for i = 0, targetList.Count - 1 do
    local role = targetList[i]
    if role == nil or self:IsNotCanBeSwithGrid(role) then
      target_num = target_num - 1
    end
  end
  local grid_1 = LuaSkillCtrl:FindAllGridsWithinRange(summoner, 1, false)
  local _gridTip = {}
  local _roleTip = {}
  local _grid_1_num = grid_1.Count
  for i = 0, grid_1.Count - 1 do
    local role = LuaSkillCtrl:GetRoleWithPos(grid_1[i].x, grid_1[i].y)
    if self:IsNotCanBeSwithGrid(role) then
      _gridTip[grid_1[i]] = true
      _grid_1_num = _grid_1_num - 1
    end
  end
  local grid_2
  local _grid_2_num = 0
  if 0 < target_num - _grid_1_num then
    grid_2 = LuaSkillCtrl:FindAllGridsWithinRange(summoner, 2, false)
    _grid_2_num = grid_2.Count
    for i = grid_2.Count - 1, 0, -1 do
      if grid_1:Contains(grid_2[i]) then
        grid_2:RemoveAt(i)
        _grid_2_num = _grid_2_num - 1
      else
        local role = LuaSkillCtrl:GetRoleWithPos(grid_2[i].x, grid_2[i].y)
        if self:IsNotCanBeSwithGrid(role) then
          _gridTip[grid_2[i]] = true
          _grid_2_num = _grid_2_num - 1
        end
      end
    end
  end
  if 0 < _grid_1_num + _grid_2_num then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role == nil or not self:IsNotCanBeSwithGrid(role) then
        local isOne = false
        local role_num = 0
        local role_grid
        for v = 0, grid_1.Count - 1 do
          if not _gridTip[grid_1[v]] and (grid_1[v].x ~= role.x or grid_1[v].y ~= role.y) then
            local role_num_ex = LuaSkillCtrl:GetGridsDistance(grid_1[v].x, grid_1[v].y, role.x, role.y)
            if role_num < role_num_ex then
              role_num = role_num_ex
              role_grid = grid_1[v]
              isOne = true
            end
          end
        end
        if role_grid == nil and grid_2 ~= nil then
          for v = 0, grid_2.Count - 1 do
            if not _gridTip[grid_2[v]] and (grid_2[v].x ~= role.x or grid_2[v].y ~= role.y) then
              local role_num_ex = LuaSkillCtrl:GetGridsDistance(grid_2[v].x, grid_2[v].y, role.x, role.y)
              if role_num < role_num_ex then
                role_num = role_num_ex
                role_grid = grid_2[v]
                isOne = false
              end
            end
          end
        end
        if role_grid == nil then
          role_grid = LuaSkillCtrl:GetGridWithPos(role.x, role.y)
          local role_num_ex = LuaSkillCtrl:GetGridsDistance(summoner.x, summoner.y, role.x, role.y)
          if role_num_ex == 1 then
            isOne = true
          else
            isOne = false
          end
        end
        if role_grid ~= nil then
          if _grid_1_num + _grid_2_num == target_num and i == targetList.Count - 2 then
            _gridTip[role_grid] = true
            local isVaild = true
            local lastRole = targetList[targetList.Count - 1]
            for v = 0, grid_1.Count - 1 do
              if not _gridTip[grid_1[v]] and grid_1[v].x == lastRole.x and grid_1[v].y == lastRole.y then
                isVaild = false
                _gridTip[role_grid] = false
                role_grid = grid_1[v]
                break
              end
            end
            if isVaild and grid_2 ~= nil then
              for v = 0, grid_2.Count - 1 do
                if not _gridTip[grid_2[v]] and grid_2[v].x == lastRole.x and grid_2[v].y == lastRole.y then
                  isVaild = false
                  _gridTip[role_grid] = false
                  role_grid = grid_2[v]
                  break
                end
              end
            end
          end
          _gridTip[role_grid] = true
          if isOne then
            _grid_1_num = _grid_1_num - 1
          else
            _grid_2_num = _grid_2_num - 1
          end
          LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, role, role_grid.x, role_grid.y, 7, 3020, 1)
          target_num = target_num - 1
        end
        if _grid_1_num <= 0 and _grid_2_num <= 0 or target_num == 0 then
          break
        end
      end
    end
  end
  for i = 0, targetList.Count - 1 do
    local role = targetList[i]
    local isCanControl = not LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.Exiled)
    local isCanBeHurt = not LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.Exiled)
    if role.belongNum ~= eBattleRoleBelong.neutral and isCanControl then
      LuaSkillCtrl:CallBuff(self, role, 3019, 1, 7)
    end
    LuaSkillCtrl:StartTimer(nil, 7, function()
      if role.belongNum ~= eBattleRoleBelong.neutral and isCanControl then
        LuaSkillCtrl:CallBuff(self, role, self.config.buff_stun, 1, self.arglist[1])
      end
      if isCanBeHurt then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        if self.config.weaponLv >= 2 then
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
            self.arglist[3] + self.arglist[5]
          })
        else
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
            self.arglist[3]
          })
        end
        skillResult:EndResult()
      end
    end)
  end
  LuaSkillCtrl:StartTimer(nil, 8, function()
    self:OnSkillDamageEnd()
  end)
end

function bs_105002:FindRolesBetweenSummoner()
  local summonerGrid = self.caster.recordTable["105001_summoner_grid"]
  local summoner = self.caster.recordTable["105001_summoner"]
  if self.caster.recordTable["105001_summoner_alive"] then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.PuzzleSummonerTimerAcc, -2)
    self:SwichSkill(summoner)
  elseif self.caster.recordTable.newSummoner_alive then
    summoner = self.caster.recordTable.new_summoner
    self:SwichSkill(summoner)
    if self.config.weaponLv >= 2 then
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.PuzzleSummonerTimerAcc, self.arglist[4] - self.arglist[6])
    else
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.PuzzleSummonerTimerAcc, self.arglist[4])
    end
  elseif self.config.weaponLv >= 2 then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.PuzzleSummonerTimerAcc, self.arglist[4] - self.arglist[6])
  else
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.PuzzleSummonerTimerAcc, self.arglist[4])
  end
end

function bs_105002:IsNotCanBeSwithGrid(role)
  if role == nil then
    return false
  end
  return role.belongNum ~= eBattleRoleBelong.enemy or LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.Exiled) or LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.CtrlImmunity)
end

function bs_105002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105002
