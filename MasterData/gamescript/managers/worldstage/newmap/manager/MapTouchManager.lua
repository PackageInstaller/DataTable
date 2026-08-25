local MapTouchManager, Super = System.NewClass("MapTouchManager", Manager)

function MapTouchManager:ctor()
  Super.ctor(self)
  self.touchIndex = nil
  self.curPos = nil
  self.isCanTouch = true
  self.rect = {
    x = 2,
    y = -3,
    width = 12,
    height = 5
  }
end

function MapTouchManager:Awake(binder)
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self.OnTouchBegin))
  binder:BindEvent(EventMgr.Instance.TouchMoveEvent, System.fn(self, self.OnTouchMove))
  binder:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self.OnTouchEnd))
  binder:BindEvent(EventMgr.Instance.TouchGestureEvent, System.fn(self, self.OnZoom))
end

function MapTouchManager:OnInit()
  self.cameraMgr = self:GetComponent(MapCameraManager)
  self.gearMgr = self:GetComponent(MapGearManager)
end

function MapTouchManager:OnTouchBegin(x, y, index, overUI)
  if not self.gearMgr or BattleManager.Instance:IsInBattle() then
    return
  end
  if self.touchIndex then
    return
  end
  if not self:GetCanTouch() then
    return
  end
  if 1 == overUI then
    return
  end
  if InputManager.Instance:GetFingerCount() > 1 then
    return
  end
  if self.gearMgr:InTrigger() then
    Logger.Info("InTrigger", "不可拖动~~~")
    return
  end
  self.touchIndex = index
  self.curPos = {x = x, y = y}
end

function MapTouchManager:OnTouchMove(x, y, index, _)
  if BattleManager.Instance:IsInBattle() then
    return
  end
  if self.touchIndex ~= index then
    return
  end
  if not self:GetCanTouch() then
    return
  end
  if self.curPos == nil then
    Logger.Warn("OnTouchMove failed, no startPos")
    return
  end
  if self.gearMgr:InTrigger() then
    return
  end
  if InputManager.Instance:GetFingerCount() > 1 then
    return
  end
  local delta = {
    x - self.curPos.x,
    y - self.curPos.y
  }
  local minMoveDist = 10
  if minMoveDist < math.abs(delta[1]) or minMoveDist < math.abs(delta[2]) then
    if not self.isMoving then
      self.isMoving = true
      if self.cameraMgr:GetFollowCameraState() then
        self.cameraMgr:InitDragCameraPos()
        self.cameraMgr:SetFollowCameraState(false)
      end
    end
  else
    return
  end
  local biasX, biasZ = -delta[1] / 200, -delta[2] / 200
  local cameraPos = self.cameraMgr.dragVMCamera.localPosition
  cameraPos.x = cameraPos.x + biasX
  cameraPos.z = cameraPos.z + biasZ
  cameraPos.x = math.min(math.max(cameraPos.x, self.rect.x), self.rect.width)
  cameraPos.z = math.min(math.max(cameraPos.z, self.rect.y), self.rect.height)
  self.cameraMgr:SetDragCameraPos(cameraPos)
  self.curPos.x = x
  self.curPos.y = y
end

function MapTouchManager:OnTouchEnd(_, _, index, _)
  if BattleManager.Instance:IsInBattle() then
    return
  end
  if self.touchIndex == index then
    self.touchIndex = nil
    self.curPos = nil
    if self.isMoving then
      self.isMoving = nil
      local cameraMgr = self:GetComponent(MapCameraManager)
      if cameraMgr then
        cameraMgr:SetFollowCameraState(true)
      end
    elseif not self.isScaled then
      local curSceneType = SceneMgr.Instance:GetSceneType()
      if not self:IsTouchAvailable() and curSceneType and type(curSceneType) == "string" and curSceneType == CommonDefine.SceneType.Copies then
        local touchForbidTipsId = 10519
        Alert.ShowTopTips(touchForbidTipsId)
      end
    end
  end
  self.isScaled = false
  self:SetTouchAvailable(false)
end

function MapTouchManager:IsTouchAvailable()
  return self.isAvailable
end

function MapTouchManager:SetTouchAvailable(state)
  self.isAvailable = state
end

function MapTouchManager:SetCanTouch(state)
  self.isCanTouch = state
end

function MapTouchManager:GetCanTouch()
  return self.isCanTouch
end

function MapTouchManager:OnZoom(count, scale)
  local cameraMgr = self.cameraMgr
  if not cameraMgr then
    return
  end
  if not self:GetCanTouch() then
    return
  end
  if count >= 2 then
    self.isScaled = true
    cameraMgr:CameraZoom(scale)
  end
end

function MapTouchManager:GetIsMoving()
  return self.isMoving
end

function MapTouchManager:GetIsScaled()
  return self.isScaled
end

return MapTouchManager
