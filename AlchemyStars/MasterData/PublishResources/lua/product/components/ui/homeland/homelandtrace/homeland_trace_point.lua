_class("HomelandTracePoint", Object)
HomelandTracePoint = HomelandTracePoint

function HomelandTracePoint:Constructor(traceItem, info, Index, pet)
  self._traceId = traceItem:GetTraceId()
  self._traceItem = traceItem
  self._tracemanager = traceItem:GetManager()
  self._traceManagerHelper = self._tracemanager:GetHomelandTraceManagerHelper()
  self._interactPointManager = self._tracemanager:GetInteractPointManager()
  self._config = info
  self._position = info.position
  self._index = Index
  self._pet = pet
  self._traceMinimapType = HomelandMapIconType.TracePoint
  self:Init()
end

function HomelandTracePoint:Dispose()
  self:ClearInteractPoint()
  if self._go then
    self._go:Destroy()
  end
  if self._req ~= nil then
    self._req:Dispose()
    self._req = nil
  end
  if self._resRequest ~= nil then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
  if self._reqEffectObj ~= nil then
    self._reqEffectObj:Destroy()
  end
end

function HomelandTracePoint:Init()
  if self._config.obj then
    self._req = ResourceManager:GetInstance():SyncLoadAsset(self._config.obj, LoadType.GameObject)
    if not self._req then
      Log.error("找不到模型:", self._config.obj)
    end
    self._go = self._req.Obj
    self._go.transform.position = self._position
    self._go:SetActive(true)
    self._transform = self._go.transform
  end
  if self._pet then
    self._transform = self._pet.transform
  end
  self._interactPoint = self._interactPointManager:AddBuildInteractPoint(self, self._index, InteractPointType.TracePoint)
  if self._config.radius then
    self._interactPoint.interactDistance = self._config.radius
  end
  self:MiniMapEvent()
end

function HomelandTracePoint:MiniMapEvent()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, self._traceMinimapType, self._index, self._transform, self._config)
  if self._config.Minimap == 1 then
  end
end

function HomelandTracePoint:ClearInteractPoint()
  if self._interactPoint then
    self._interactPointManager:RemoveBuildInteractPoint(self._interactPoint)
  end
  self._interactPoint = nil
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, self._traceMinimapType, self._index)
end

function HomelandTracePoint:GetIndex()
  return self._index
end

function HomelandTracePoint:GetTraceID()
  return self._traceId
end

function HomelandTracePoint:GetPosition()
  return self._position
end

function HomelandTracePoint:GetRotation()
  return self._rotation
end

function HomelandTracePoint:GetCfg()
  return self._config
end

function HomelandTracePoint:OnTrigger(point)
  if point:GetPointType() ~= InteractPointType.TracePoint then
    return
  end
  if point:GetIndex() ~= self._index then
    return
  end
  if self._go then
    self._go:SetActive(false)
  end
  if self._config.effectObj and self._config.effectObj ~= "" then
    if self._reqEffectObj == nil then
      self._resRequest = ResourceManager:GetInstance():SyncLoadAsset(self._config.effectObj, LoadType.GameObject)
      self._reqEffectObj = self._resRequest.Obj
      self._reqEffectObj.transform:SetParent(self._transform.parent)
      self._reqEffectObj.transform.position = self._position
      self._reqEffectObj:SetActive(true)
    else
      self._reqEffectObj:SetActive(true)
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnGetTracePoint, self._index, self._config)
end

function HomelandTracePoint:OnLeave(point)
  if point:GetPointType() ~= InteractPointType.TracePoint then
    return
  end
  if point:GetIndex() ~= self._index then
    return
  end
  if self._go then
    self._go:SetActive(true)
  end
  if self._reqEffectObj ~= nil then
    self._reqEffectObj:SetActive(false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnLeaveTracePoint, self._index, self._config)
end

function HomelandTracePoint:GetInteractPosition()
  return self._position
end

function HomelandTracePoint:GetInteractRedStatus()
  return false
end

function HomelandTracePoint:GetInteractAreaPosition()
  return self._position
end

function HomelandTracePoint:EnterInteractArea()
end

function HomelandTracePoint:LeaveInteractArea()
end
