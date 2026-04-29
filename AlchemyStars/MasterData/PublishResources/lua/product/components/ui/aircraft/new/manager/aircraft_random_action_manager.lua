_class("AircraftRandomActionManager", Object)
AircraftRandomActionManager = AircraftRandomActionManager

function AircraftRandomActionManager:Constructor(aircraftMain)
  self._main = aircraftMain
end

function AircraftRandomActionManager:Init()
  self._boards = self._main:GetAllBoards()
end

function AircraftRandomActionManager:Update(deltaTimeMS)
end

function AircraftRandomActionManager:Dispose()
end

function AircraftRandomActionManager:RandomActionForPet(pet)
  self:_randomForPet(pet, false)
end

function AircraftRandomActionManager:RandomInitActionForPet(pet)
  self:_randomForPet(pet, true)
end

function AircraftRandomActionManager:_randomForPet(pet, isInit)
  local lib = self:_1_getLib(pet)
  local list = self:_2_getActionList(pet, lib)
  local action = self:_3_getValidAction(pet, list, isInit)
  self:_4_startAction(pet, action, isInit)
end

function AircraftRandomActionManager:_1_getLib(pet)
  local petID = pet:TemplateID()
  local actionLibID = -1
  if pet:IsGiftPet() or pet:IsVisitPet() then
    actionLibID = Cfg.cfg_aircraft_pet[petID].GiftLib
  else
    actionLibID = Cfg.cfg_aircraft_pet[petID].ActionLib
  end
  local cfg = Cfg.cfg_aircraft_random_actions[actionLibID]
  if cfg == nil then
    Log.exception("找不到行为，星灵id：", petID, "，配置：", actionLibID)
  end
  return cfg
end

function AircraftRandomActionManager:_2_getActionList(pet, cfgLib)
  local list = {}
  local totalWeight1 = cfgLib.WWeight + cfgLib.FWeight
  local wweight = cfgLib.WWeight / totalWeight1
  local fweight = cfgLib.FWeight / totalWeight1
  local totalWeightWander = 0
  for _, cfg in ipairs(cfgLib.WAreas) do
    totalWeightWander = totalWeightWander + cfg[3]
  end
  local totalWeightFurArea = 0
  for _, cfg in ipairs(cfgLib.FAreas) do
    totalWeightFurArea = totalWeightFurArea + cfg[2]
  end
  local totalWeightFur = 0
  for _, cfg in ipairs(cfgLib.FFurniture) do
    totalWeightFur = totalWeightFur + cfg[3]
  end
  local w = 0
  local idx = 1
  for _, cfg in ipairs(cfgLib.WAreas) do
    list[#list + 1] = {
      Index = idx,
      Type = AirRandomActionType.Wandering,
      Area = cfg[1],
      Duration = cfg[2],
      Weight = cfg[3] / totalWeightWander * wweight,
      Condition = cfg[4]
    }
    idx = idx + 1
    w = w + cfg[3] / totalWeightWander * wweight
  end
  for _, cfg in ipairs(cfgLib.FAreas) do
    local aweight = cfg[2] / totalWeightFurArea
    for __, cfgF in ipairs(cfgLib.FFurniture) do
      list[#list + 1] = {
        Index = idx,
        Type = AirRandomActionType.Furniture,
        Area = cfg[1],
        Duration = cfgF[2],
        Weight = cfgF[3] / totalWeightFur * aweight * fweight,
        FurType = cfgF[1],
        Condition = cfgF[4]
      }
      w = w + cfgF[3] / totalWeightFur * aweight * fweight
      idx = idx + 1
    end
  end
  local cur = 1
  local weight = 1.0
  while cur < #list do
    local r = math.random() * weight
    local temp = 0
    local target = cur
    for i = cur, #list - cur + 1 do
      temp = temp + list[i].Weight
      if r <= temp then
        target = i
        break
      end
    end
    weight = weight - list[target].Weight
    if cur ~= target then
      local t = list[cur]
      list[cur] = list[target]
      list[target] = t
    end
    cur = cur + 1
  end
  return list
end

function AircraftRandomActionManager:_3_getValidAction(pet, list, isInit)
  local currentIdx = pet:GetRandomActionCfgID()
  for _, action in ipairs(list) do
    if action.Index ~= currentIdx then
      if action.Type == AirRandomActionType.Wandering then
        local area = action.Area
        if self._main:CanWanderingInArea(area) then
          return action
        end
      elseif action.Type == AirRandomActionType.Furniture then
        local area = action.Area
        local furType = action.FurType
        if isInit and furType == AirFurnitureType.RestEmpty then
          AirLog("初始化时随到了星灵去空地, 不处理, 星灵:", pet:TemplateID(), ", 索引:", action.Index)
        else
          local furs = self._main:GetFurnituresByArea(area)
          for _, fur in pairs(furs) do
            if fur:Type() == furType then
              local condCfg = action.Condition
              local cond = AircraftPetFurPointCondition:New(pet, fur, condCfg)
              if cond:PreCheck() then
                action.Fur = fur
                action.PointCond = cond
                return action
              end
            end
          end
        end
      else
        Log.exception("星灵行为类型错误：", action.Type)
      end
    end
  end
end

function AircraftRandomActionManager:_4_startAction(pet, action, isInit)
  if action == nil then
    Log.exception("星灵没有可执行行为：", pet:TemplateID())
    return
  end
  local area = pet:GetWanderingArea()
  if area then
    local room = self._main:GetRoomByArea(area)
    if room then
      room:PetLeaveWandering(pet:TemplateID())
    end
    pet:SetWanderingArea(nil)
  end
  if isInit then
    local petAction
    if action.Type == AirRandomActionType.Wandering then
      local area = action.Area
      self._main:EnterAreaToWandering(pet, area)
      local holder = self._main:GetPointHolder(area)
      pet:SetFloor(holder:Floor())
      pet:SetPosition(self._main:GetInitPos(holder))
      AirLog("初始化，星灵开始漫游:", pet:TemplateID(), "，区域：", area, "，楼层：", holder:Floor())
      petAction = AirActionWandering:New(pet, holder, action.Duration, "漫游-初始化", self._main)
    elseif action.Type == AirRandomActionType.Furniture then
      local area = action.Area
      local furn = action.Fur
      local cond = action.PointCond
      local point = cond:TakePointOnStart()
      pet:SetFloor(furn:Floor())
      pet:SetState(AirPetState.OnFurniture)
      AirLog("初始化，星灵与家具交互:", pet:TemplateID(), "，家具：", furn:GetPstKey(), "，索引点：", point:Index())
      petAction = AirActionOnFurniture:New(pet, furn, point, cond, action.Duration, true)
    end
    self._main:StartInitAction(pet, petAction, action.Index)
    pet:SetRandomActionCfgID(action.Index)
  else
    pet:StopMainAction()
    local petAction
    if action.Type == AirRandomActionType.Wandering then
      local area = action.Area
      self._main:EnterAreaToWandering(pet, area)
      local holder = self._main:GetPointHolder(area)
      local point = holder:PopPoint()
      AirLog("运行时，星灵走向漫游点:", pet:TemplateID(), "，区域:", area, "，楼层:", holder:Floor())
      petAction = AirActionMoveToWandering:New(self._main, pet, holder, point, action.Duration)
    elseif action.Type == AirRandomActionType.Furniture then
      local area = action.Area
      local furn = action.Fur
      local cond = action.PointCond
      local point = cond:TakePointOnStart()
      AirLog("运行时，星灵走向家具:", pet:TemplateID(), "，家具：", furn:CfgID(), "，索引点：", point:Index(), "，楼层：", furn:Floor())
      petAction = AirActionMoveToFurniture:New(self._main, pet, furn, point, cond, action.Duration)
    end
    pet:StartMainAction(petAction)
    pet:SetRandomActionCfgID(action.Index)
  end
end

local PetCfgAction = {
  Index = nil,
  Type = nil,
  Area = nil,
  Duration = nil,
  FurType = nil,
  Weight = nil,
  Condition = nil,
  Fur = nil,
  PointCond = nil
}
_class("AircraftPetFurPointCondition", Object)
AircraftPetFurPointCondition = AircraftPetFurPointCondition

function AircraftPetFurPointCondition:Constructor(pet, fur, cfgID, point)
  if point then
    self._point = point
    self._social = true
  elseif cfgID then
    self._cfg = Cfg.cfg_aircraft_special_action[cfgID]
    if self._cfg == nil then
      Log.exception("找不到特殊行为配置：", cfgID)
    end
  end
  self._furniture = fur
  self._pet = pet
end

function AircraftPetFurPointCondition:PreCheck()
  if self._social then
    Log.exception("社交反序列化行为不需要调用PreCheck", debug.traceback())
  end
  self._available = false
  if self._cfg == nil then
    self._available = self._furniture:AvailableCount() > 0
  elseif self._cfg.Type == AircraftPetFurSpacialActionType.WithGivenPoint then
    local pointNames = self._cfg.Params[1].points
    for _, name in ipairs(pointNames) do
      if self._furniture:HasAvailablePoint(name) then
        self._availablePointName = name
        self._available = true
        break
      end
    end
  elseif self._cfg.Type == AircraftPetFurSpacialActionType.OccupyFurniture and self._furniture:IsEmpty() then
    local pointNames = self._cfg.Params[1].points
    for _, name in ipairs(pointNames) do
      if self._furniture:HasAvailablePoint(name) then
        self._availablePointName = name
        self._available = true
        break
      end
    end
  end
  return self._available
end

function AircraftPetFurPointCondition:TakePointOnStart()
  if not self._available then
    Log.exception("当前条件不可用，不可调用TakePointOnStart")
    return
  end
  if self._social then
    Log.exception("社交反序列化行为不需要调用TakePointOnStart.", debug.traceback())
  end
  if not self._cfg then
    self._point = self._furniture:PopPoint()
    if self._point == nil then
      Log.exception("Sit取不到家具点：", self._furniture:GetPstKey(), "，星灵:", self._pet:TemplateID())
    end
  elseif self._cfg.Type == AircraftPetFurSpacialActionType.WithGivenPoint then
    self._point = self._furniture:PopPointByName(self._availablePointName)
    if self._point == nil then
      Log.exception("找不到家具点，类型1：", self._availablePointName, "，家具：", self._furniture:CfgID())
    end
  elseif self._cfg.Type == AircraftPetFurSpacialActionType.OccupyFurniture then
    self._point = self._furniture:GetPointByName(self._availablePointName)
    if self._point == nil then
      Log.exception("找不到家具点，类型2：", self._availablePointName, "，家具：", self._furniture:CfgID())
    end
    self._furniture:OccupyAllPoint(true)
  end
  self._pet:SetOccupyFurniture(self._furniture:InstanceID())
  if self._point == nil then
    Log.exception("取不到家具点：", self._furniture:GetPstKey(), "，星灵:", self._pet:TemplateID())
  end
  return self._point
end

function AircraftPetFurPointCondition:ReleasePointOnStop()
  if self._social then
    AirLog("社交反序列化行为释放家具点")
  elseif not self._available then
    Log.exception("当前条件不可用，不可调用ReleasePointOnStop.", debug.traceback())
    return
  end
  if not self._cfg then
    self._furniture:ReleasePoint(self._point)
  elseif self._cfg.Type == AircraftPetFurSpacialActionType.WithGivenPoint then
    self._furniture:ReleasePoint(self._point)
  elseif self._cfg.Type == AircraftPetFurSpacialActionType.OccupyFurniture then
    self._furniture:OccupyAllPoint(false)
  end
  self._pet:SetOccupyFurniture(nil)
end
