local bs_106002 = class("bs_106002", LuaSkillBase)
local base = LuaSkillBase
bs_106002.config = {
  skill_time = 20,
  start_time = 15,
  buffId_skill = 106002,
  buffId_170 = 170,
  buffId_3004 = 3004,
  buffId_3024 = 3024,
  effectId_start = 106009,
  effectId_start2 = 106014,
  effectId_go = 106007,
  effectId_down = 106008,
  actionId = 1002,
  action_speed = 1
}

function bs_106002:ctor()
end

function bs_106002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.passive_skill1 = self.arglist[1]
  self.caster.recordTable.passive_arg4 = self.arglist[4]
  self.caster.recordTable.passive_arg5 = self.arglist[5]
  self.caster.recordTable.passive_arg6 = self.arglist[6]
end

function bs_106002:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start2, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_3024, 1, self.config.start_time + self.arglist[2], true)
end

function bs_106002:OnAttackTrigger()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_go, self)
  self.caster.recordTable.turn = nil
  local behindGrid
  local onFireRole = self.caster:TryToGetFocusFiringRole()
  if onFireRole ~= nil then
    behindGrid = LuaSkillCtrl:FindEmptyGridAroundRole(onFireRole)
  end
  if behindGrid == nil then
    local clueTable = self.caster.recordTable.clueTable
    if 0 < #clueTable then
      local tempTable = {}
      for i, v in ipairs(clueTable) do
        local uid = math.modf(v / 100000)
        if tempTable[uid] == nil then
          tempTable[uid] = 1
        else
          tempTable[uid] = tempTable[uid] + 1
        end
      end
      local count = 0
      for k, v in pairs(tempTable) do
        count = count + 1
      end
      behindGrid = self:FindAroundGrid(tempTable, count)
    end
  end
  if behindGrid == nil then
    local lastAttackRole = self.caster.recordTable.lastAttackRole
    self.caster.recordTable.turn = self.caster.recordTable.lastAttackRole
    if lastAttackRole ~= nil then
      behindGrid = LuaSkillCtrl:FindEmptyGridAroundRole(lastAttackRole)
    end
  end
  if behindGrid == nil then
    local moveTarget = self:GetMoveSelectTarget()
    if moveTarget == nil then
      return
    end
    behindGrid = LuaSkillCtrl:FindEmptyGridAroundRole(moveTarget.targetRole)
    self.caster.recordTable.turn = moveTarget.targetRole
  end
  if behindGrid ~= nil then
    if self.caster.recordTable.lastAttackRole ~= self.caster.recordTable.turn then
      self.caster.recordTable.lastAttackRole = self.caster.recordTable.turn
    end
    LuaSkillCtrl:SetRolePos(behindGrid, self.caster)
    if self.caster.recordTable.turn ~= nil then
      self.caster:LookAtTarget(self.caster.recordTable.turn)
    end
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_down, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skill, 1, self.arglist[2])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_3004, 1, self.arglist[7])
end

function bs_106002:FindAroundGrid(clueCountTable, index)
  if index == 0 then
    return nil
  end
  local targetUid = 0
  local maxCount = 0
  for k, v in pairs(clueCountTable) do
    if v > maxCount then
      targetUid = k
      maxCount = v
    end
  end
  if targetUid ~= 0 then
    local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    for i = 0, enemyList.Count - 1 do
      if enemyList[i].uid == targetUid then
        local behindGrid = LuaSkillCtrl:FindEmptyGridAroundRole(enemyList[i])
        if behindGrid == nil then
          return self:FindAroundGrid(clueCountTable, index - 1)
        else
          self.caster.recordTable.turn = enemyList[i]
          return behindGrid
        end
      end
    end
  end
  return self:FindAroundGrid(clueCountTable, index - 1)
end

function bs_106002:GetRoleBehindGrid(role)
  local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
  if grid ~= nil then
    self.caster.recordTable.turn = role
    return grid
  end
  return nil
end

function bs_106002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106002
