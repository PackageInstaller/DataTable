local InputManager, Super = System.NewClass("InputManager", Manager, IUpdater)

function InputManager:ctor()
  Super.ctor(self)
end

function InputManager:Awake()
  Super.Awake(self)
  self.lastMoveX = 0
  self.lastMoveY = 0
  self.touchMgr = CS.Z1Client.General.LeanTouchMgr.Instance
  self.enabledOrientationRef = 0
  self:Init()
end

function InputManager:Init()
  self.touchMgr:SetLuaTouchBegin(System.fn(self, self.TouchBegin))
  self.touchMgr:SetLuaTouchMove(System.fn(self, self.TouchMove))
  self.touchMgr:SetLuaTouchEnd(System.fn(self, self.TouchEnd))
  self.touchMgr:SetLuaSwipe(System.fn(self, self.Swipe))
  self.touchMgr:SetLuaGesture(System.fn(self, self.Gesture))
end

function InputManager:TouchBegin(x, y, index, overUI)
  if Main.isAppDestroyed then
    return
  end
  local screenWidth = CS.UnityEngine.Screen.width
  local screenHeight = CS.UnityEngine.Screen.height
  local UIRootWidth = UIRootMgr.GetUIRootWidth()
  local UIRootHeight = UIRootMgr.GetUIRootHeight()
  local uiX = UIRootWidth / screenWidth * x
  local uiY = UIRootHeight / screenHeight * y
  local topAreaHeight = UIRootMgr.GetTopBottomBarHeight()
  local leftAreaWidth = UIRootMgr.GetLeftRightBarWidth()
  self.startMoveX = x
  self.startMoveY = y
  self.lastMoveX = x
  self.lastMoveY = y
  local minX, maxX = leftAreaWidth, UIRootWidth - leftAreaWidth
  local minY, maxY = topAreaHeight, UIRootHeight - topAreaHeight
  if uiX >= minX and uiX <= maxX and uiY >= minY and uiY <= maxY then
    EventMgr.Instance.TouchBeginEvent:Dispatch(x, y, index, overUI)
  end
end

function InputManager:TouchMove(x, y, index, overUI)
  if Main.isAppDestroyed then
    return
  end
  self.lastMoveX = x
  self.lastMoveY = y
  EventMgr.Instance.TouchMoveEvent:Dispatch(x, y, index, overUI)
end

function InputManager:TouchEnd(x, y, index, overUI)
  if Main.isAppDestroyed then
    return
  end
  EventMgr.Instance.TouchEndEvent:Dispatch(x, y, index, overUI)
end

function InputManager:Swipe(x, y, index, overUI)
  if Main.isAppDestroyed then
    return
  end
  if self.startMoveX and math.abs(x - self.startMoveX) >= 50 then
    local direction = CommonDefine.SwipeDirection.SwipeRightToLeft
    if x - self.lastMoveX > 0 then
      direction = CommonDefine.SwipeDirection.SwipeLeftToRight
    end
    EventMgr.Instance.TouchSwipeEvent:Dispatch(direction, x, y, index, overUI)
  end
  if self.startMoveY and math.abs(y - self.startMoveY) >= 50 then
    local direction = CommonDefine.SwipeDirection.SwipeUpToDown
    if y - self.lastMoveY > 0 then
      direction = CommonDefine.SwipeDirection.SwipeDownToUp
    end
    EventMgr.Instance.TouchSwipeEvent:Dispatch(direction, x, y, index, overUI)
  end
end

function InputManager:Gesture(count, scale)
  EventMgr.Instance.TouchGestureEvent:Dispatch(count, scale)
end

function InputManager:IsClickGameObject()
  local check = CS.Framework.UIUtilTool.IsClickUIPoint()
  Logger.Debug("点在GameObject上面 check == %s", check)
  if 1 == check then
    return true
  end
  return false
end

function InputManager:GetFingerCount()
  local count = self.touchMgr:GetFingerCount()
  return count
end

function InputManager:EnableDeviceOrientation()
  self.enabledOrientationRef = self.enabledOrientationRef or 0
  self.enabledOrientationRef = self.enabledOrientationRef + 1
  if not self.lastOrientation then
    self.lastOrientation = CS.UnityEngine.Screen.orientation
  end
end

function InputManager:DisableDeviceOrientation()
  if self.enabledOrientationRef > 0 then
    self.enabledOrientationRef = self.enabledOrientationRef - 1
  end
  if self.enabledOrientationRef <= 0 then
    self.lastOrientation = nil
  end
end

function InputManager:Update()
  if Main.isAppDestroyed then
    return
  end
  local curDeviceOrientation = CS.UnityEngine.Input.deviceOrientation
  if not self.lastDeviceOrientation then
    self.lastDeviceOrientation = curDeviceOrientation
  end
  if self.lastDeviceOrientation ~= curDeviceOrientation then
    print("InputManager:Update OnInputDeviceOrientationChanged ", curDeviceOrientation)
    self.lastDeviceOrientation = curDeviceOrientation
    GlobalDispatcher:Dispatch(NotifyId.OnInputDeviceOrientationChanged)
  end
  local curOrientation = CS.UnityEngine.Screen.orientation
  if not self.lastOrientation then
    self.lastOrientation = curOrientation
  end
  if self.lastOrientation ~= curOrientation then
    self.lastOrientation = curOrientation
    if self.enabledOrientationRef > 0 then
      GlobalDispatcher:Dispatch(NotifyId.OnDeviceOrientationChanged)
    end
    GlobalDispatcher:Dispatch(NotifyId.OnScreenOrientationChanged)
  end
end

function InputManager:OnDestroy()
  Super.OnDestroy(self)
end

return InputManager
