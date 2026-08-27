local gs_3 = class("gs_3", LuaGridBase)
local base = LuaGridBase
gs_3.config = {
  effectId = 10358,
  buffId = 1033,
  buffTier = 1,
  buffDuration = 15,
  heal_config = {
    baseheal_formula = 10052,
    heal_number = 0,
    correct_formula = 9990
  },
  buffId_techBuff = 2156
}

function gs_3:ctor()
end

function gs_3:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_3:OnGridEnterRole(role)
  local commander = LuaSkillCtrl:GetPlayerRoleEntity()
  if commander == nil then
    return
  end
  local per = commander.life_steal
  if 0 < per then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_techBuff, per, 150)
  end
  if role.attackRange <= 1 and role.roleDataId ~= 1042 and role.roleDataId ~= 9001042 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier, self.config.buffDuration)
    if role.belongNum == 2 then
      LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
      self:OnArriveAction(role)
    else
      local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
      if self.__arriveCallBackTimer ~= nil then
        self.__arriveCallBackTimer:Stop()
      end
      self.__arriveCallBackTimer = LuaSkillCtrl:StartTimer(nil, self.config.buffDuration, arriveCallBack)
      local arriveCallBack1 = BindCallback(self, self.OnArriveAction1, role)
      if self.__arriveCallBac2kTimer ~= nil then
        self.__arriveCallBac2kTimer:Stop()
      end
      self.__arriveCallBac2kTimer = LuaSkillCtrl:StartTimer(nil, self.config.buffDuration - 1, arriveCallBack1)
    end
  else
    self:GridLoseEffect()
  end
end

function gs_3:OnArriveAction1(role)
  if self.cEffectGrid ~= nil and not self.cEffectGrid.isGridValid then
    return
  end
  LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
end

function gs_3:OnArriveAction(role)
  if self.cEffectGrid ~= nil and not self.cEffectGrid.isGridValid then
    return
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 48, 10, role, true)
  if targetlist.Count > 0 then
    local target = targetlist[0].targetRole
    local maxRange = 3
    local grid
    for tempRange = 1, maxRange do
      for i = 0, targetlist.Count - 1 do
        target = targetlist[i].targetRole
        if target.belongNum ~= 0 then
          grid = LuaSkillCtrl:FindEmptyGridWithinRange(target, tempRange)
          if grid ~= nil then
            LuaSkillCtrl:CallEffect(role, 10263, self)
            LuaSkillCtrl:SetRolePos(grid, role)
            LuaSkillCtrl:CallEffect(role, 10264, self)
            break
          end
        end
      end
      if grid ~= nil then
        break
      end
    end
    if grid == nil then
      error("cant find empty grid")
      self:GridLoseEffect()
      return
    end
    role.recordTable.lastAttackRole = target
  end
  self:GridLoseEffect()
end

function gs_3:OnGridExitRole(role)
end

function gs_3:OnGridRoleDead(role)
end

function gs_3:LuaDispose()
  if self.__arriveCallBackTimer ~= nil then
    self.__arriveCallBackTimer:Stop()
    self.__arriveCallBackTimer = nil
  end
  if self.__arriveCallBac2kTimer ~= nil then
    self.__arriveCallBac2kTimer:Stop()
    self.__arriveCallBac2kTimer = nil
  end
  base:LuaDispose()
end

return gs_3
