_class("InteractPointManager", Object)
InteractPointManager = InteractPointManager

function InteractPointManager:Constructor()
  self._interactPoints = {}
  self._interactAreas = {}
end

function InteractPointManager:Init(homelandClient)
  self._homelandCharacterManager = homelandClient:CharacterManager()
  self._triggerInteractPoints = {}
  self._client = homelandClient
end

function InteractPointManager:Dispose()
  for i = 1, #self._interactPoints do
    self._interactPoints[i]:Dispose()
  end
  self._interactPoints = nil
  self._triggerInteractPoints = nil
  self._homelandCharacterManager = nil
  for i = 1, #self._interactAreas do
    self._interactAreas[i]:Dispose()
  end
  self._interactAreas = nil
end

function InteractPointManager:Update(deltaTimeMS)
  if self._last_update_time == nil then
    self._last_update_time = 0
  end
  if self._cur_time == nil then
    self._cur_time = 0
  end
  self._cur_time = self._cur_time + deltaTimeMS
  if self._cur_time - self._last_update_time < 200 then
    return
  end
  self._last_update_time = self._cur_time
  local characterTransform = self._homelandCharacterManager:GetCharacterTransform()
  if not characterTransform then
    return
  end
  local characterPostion = characterTransform.position
  for i = 1, #self._interactAreas do
    local interactArea = self._interactAreas[i]
    if interactArea:IsActive() then
      if interactArea:IsTrigger(characterPostion) then
        interactArea:InteractArea()
      else
        interactArea:UnInteractArea()
      end
    end
  end
  for i = #self._interactAreas, 1, -1 do
    local interactArea = self._interactAreas[i]
    if not interactArea:IsActive() then
      table.remove(self._interactAreas, i)
    end
  end
  for i = 1, #self._interactPoints do
    local interactPoint = self._interactPoints[i]
    if self._homelandCharacterManager:CharacterInteractable(interactPoint:GetPointType()) and interactPoint:IsTrigger(characterPostion) and interactPoint:Interactable() then
      self:_AddTriggerPoint(interactPoint)
    else
      self:_RemoveTriggerPoint(interactPoint)
    end
  end
end

function InteractPointManager:GetPoints(typeFilter)
  local points = {}
  for i = 1, #self._interactPoints do
    if self._interactPoints[i]:GetPointType() == typeFilter then
      table.insert(points, self._interactPoints[i])
    end
  end
  return points
end

function InteractPointManager:_AddTriggerPoint(point)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.EnterBuildInteract, point)
  if self._triggerInteractPoints[point] then
    return
  end
  self._triggerInteractPoints[point] = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowInteractUI)
end

function InteractPointManager:_RemoveTriggerPoint(point)
  if not self._triggerInteractPoints[point] then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LeaveBuildInteract, point)
  self._triggerInteractPoints[point] = nil
  for k, v in pairs(self._triggerInteractPoints) do
    if k and v then
      return
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HideInteractUI)
end

function InteractPointManager:ShowDialog(name, ...)
  GameGlobal.UIStateManager():ShowDialog(name, ...)
end

function InteractPointManager:CloseDialog(name)
  GameGlobal.UIStateManager():CloseDialog(name)
end

function InteractPointManager:AddBuildInteractPoint(build, index, interactPointCfgId)
  if self._client:IsVisit() then
    return self:_AddVisitPoint(build, index, interactPointCfgId)
  else
    local interactPoint = InteractPoint:New(build, index, interactPointCfgId)
    self._interactPoints[#self._interactPoints + 1] = interactPoint
    return interactPoint
  end
end

function InteractPointManager:RemoveBuildInteractPoint(interactPoint)
  if not self._interactPoints then
    return
  end
  for i = 1, #self._interactPoints do
    if self._interactPoints[i] == interactPoint then
      table.remove(self._interactPoints, i)
      self:_RemoveTriggerPoint(interactPoint)
      return
    end
  end
end

function InteractPointManager:GetInteractPoints()
  return self._interactPoints
end

function InteractPointManager:AddBuildInteractArea(build, distance)
  local interactArea = InteractArea:New(build, distance)
  self._interactAreas[#self._interactAreas + 1] = interactArea
  return interactArea
end

function InteractPointManager:RemoveBuildInteractArea(interactArea)
  if not self._interactAreas then
    return
  end
  for i = 1, #self._interactAreas do
    if self._interactAreas[i] == interactArea then
      table.remove(self._interactAreas, i)
      interactArea:UnInteractArea()
      return
    end
  end
end

function InteractPointManager:GetInteractAreas()
  return self._interactAreas
end

function InteractPointManager:_AddVisitPoint(build, index, interactPointCfgId)
  local interactPoint
  local cfg = Cfg.cfg_building_interact_point[interactPointCfgId]
  if cfg.FunctionType == InteractPointType.Build then
    local uiModule = GameGlobal.GetUIModule(HomelandModule)
    interactPointCfgId = InteractPointType.Visit_Build
    interactPoint = InteractPoint:New(build, index, interactPointCfgId)
  elseif cfg.FunctionType == InteractPointType.Storehouse then
    local uiModule = GameGlobal.GetUIModule(HomelandModule)
    if uiModule:GetVisitUIInfo():HasGift() then
      interactPointCfgId = InteractPointType.Visit_GetGift
      interactPoint = InteractPoint:New(build, index, interactPointCfgId)
    end
  elseif cfg.FunctionType == InteractPointType.Breed then
    local uiModule = GameGlobal.GetUIModule(HomelandModule)
    local info = uiModule:GetVisitInfo().cultivation_info
    local land = build
    if info.land_cultivation_infos[land:PstID()] and not land:IsMature() then
      interactPointCfgId = InteractPointType.Visit_Water
      interactPoint = InteractPoint:New(build, index, interactPointCfgId)
    end
  elseif cfg.FunctionType == InteractPointType.ShowMedalWall and not build:IsShabby() then
    interactPoint = InteractPoint:New(build, index, interactPointCfgId)
  end
  if interactPoint then
    self._interactPoints[#self._interactPoints + 1] = interactPoint
  end
  return interactPoint
end
