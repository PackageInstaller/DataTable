_class("HomeTraceIcon", Object)
HomeTraceIcon = HomeTraceIcon

function HomeTraceIcon:Constructor(traceID, traceItem, rootTrans)
  self._traceID = traceID
  self._traceItem = traceItem
  self._tracemanager = self._traceItem:GetManager()
  self._traceManagerHelper = self._tracemanager:GetHomelandTraceManagerHelper()
  self._traceCfg = self._traceManagerHelper:GetTraceInfo(traceID)
  self._traceType = self._traceCfg.TraceType
  self._homelandClient = self._tracemanager:GetHomelandClient()
  self._homelandCameraManager = self._homelandClient:CameraManager()
  self._camera = self._homelandCameraManager:GetCamera()
  self._uiRootRectTransform = rootTrans
  self._iconName = "UIHomelandTraceIcon.prefab"
  self._flashEffect = "UIHomelandTraceFlash.prefab"
  self.screenOffset = Vector2(UnityEngine.Screen.width / 2, UnityEngine.Screen.height / 2)
  self:Init()
end

function HomeTraceIcon:Init()
  self:CreateIcons()
  self._onGetTracePoint = GameHelper:GetInstance():CreateCallback(self.OnGetTracePoint, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnGetTracePoint, self._onGetTracePoint)
  self._onLeaveTracePoint = GameHelper:GetInstance():CreateCallback(self.OnLeaveTracePoint, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnLeaveTracePoint, self._onLeaveTracePoint)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:Emphasize()
end

function HomeTraceIcon:CreateIcons()
  if not self._traceCfg then
    return
  end
  self._resReq = ResourceManager:GetInstance():SyncLoadAsset(self._iconName, LoadType.GameObject)
  self._reqIconObj = self._resReq.Obj
  self._reqIconObj.transform:SetParent(self._uiRootRectTransform, false)
  self._reqIconObj:SetActive(true)
  self.view = self._reqIconObj.transform:GetComponent("UIView")
  self._arrowPoint = self.view:GetGameObject("arrowPoint")
  self._tracePoint = self.view:GetGameObject("tracePoint")
  self._distanceText = self.view:GetGameObject("distance"):GetComponent("UILocalizationText")
  self._arrival = self.view:GetGameObject("arrival")
  self._fxAniGo = self.view:GetGameObject("Fx")
  self._Ani = self.view:GetGameObject("Ani"):GetComponent("Animation")
end

function HomeTraceIcon:Dispose()
  if self._onGetTracePoint then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnGetTracePoint, self._onGetTracePoint)
    self._onGetTracePoint = nil
  end
  if self._onLeaveTracePoint then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnLeaveTracePoint, self._onLeaveTracePoint)
    self._onLeaveTracePoint = nil
  end
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._reqIconObj = nil
  self._resReq:Dispose()
  self._resReq = nil
end

function HomeTraceIcon:GetTraceManager()
  return self._tracemanager
end

function HomeTraceIcon:GetTraceId()
  return self._traceID
end

function HomeTraceIcon:GetTraceType()
  return self._traceType
end

function HomeTraceIcon:SetShow(bShow)
  if self._reqIconObj then
    self._reqIconObj:SetActive(bShow)
  end
end

function HomeTraceIcon:SetParent(parentTransform)
  self._reqIconObj.transform:SetParent(parentTransform)
end

function HomeTraceIcon:Emphasize()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._Ani:Play("UIHomelandMinimapIconTrace_in")
  if not self._timerHandler then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Once, function()
      self._fxAniGo:SetActive(true)
    end)
  end
end

function HomeTraceIcon:GetTransform()
  return self._reqIconObj.transform
end

function HomeTraceIcon:SetTracePointDir(dirInfo)
  self._tracePoint:SetActive(dirInfo[2] > 1 or dirInfo[4] < 0)
  local distance = math.modf(dirInfo[3])
  self._distanceText:SetText(distance .. "m")
  local dir = dirInfo[1] - self.screenOffset
  local vec3 = Vector3(dir.x, dir.y, 0)
  local angle = Vector3.Angle(vec3, Vector3.right)
  if dirInfo[1].y < self.screenOffset.y then
    angle = -angle
  end
  local rot = Quaternion.AngleAxis(angle - 90, Vector3.forward)
  self._tracePoint.transform.localRotation = rot
end

function HomeTraceIcon:OnGetTracePoint(index, config)
  if not config.isNpc and self._reqIconObj then
    self._reqIconObj:SetActive(false)
  end
end

function HomeTraceIcon:OnLeaveTracePoint(index, config)
  if not config.isNpc and self._reqIconObj then
    self._reqIconObj:SetActive(true)
  end
end
