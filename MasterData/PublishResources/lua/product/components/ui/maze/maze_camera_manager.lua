_class("MazeCameraManager", Object)
MazeCameraManager = MazeCameraManager

function MazeCameraManager:Constructor()
  self._enabled = false
  self._currentPos = nil
  self._reportError = false
end

function MazeCameraManager:Dispose()
  self._enabled = false
  self._inputManager = nil
  self._camera = nil
end

function MazeCameraManager:Init(_3dmanager, camera, petStart, petEnd)
  self._inputManager = _3dmanager:GetInputManager()
  self._3dManager = _3dmanager
  self._enabled = true
  self._camera = camera
  self._cameraOriginPos = camera.transform.position
  self.petStart = petStart
  self.petEnd = petEnd
  self.startDelta = -7
  self.endDelta = -17
  self.cameraStart = Vector3(petStart.x + self.startDelta, self._cameraOriginPos.y, self._cameraOriginPos.z)
  self.cameraEnd = Vector3(petEnd.x + self.endDelta, self._cameraOriginPos.y, self._cameraOriginPos.z)
  self._currentPos = self:_CalculateCameraPos(self._3dManager:GetActorManager():ActorPosition())
  self.pixel2Distance = 0.015
  self.smoothRate = 0.8
  self._actorMoving = false
  self._dragged = false
end

function MazeCameraManager:FocusWayPoint(actorPos, onFinish, MoveTime)
  local moveTime
  if MoveTime then
    moveTime = MoveTime
  else
    moveTime = 0.5
  end
  if self._dragged then
    self._enabled = false
    local target = self:_CalculateCameraPos(actorPos)
    self._camera.transform:DOMove(target, moveTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
      self._currentPos = target
      onFinish(true)
      self._enabled = true
      self._dragged = false
    end)
  else
    onFinish(false)
  end
end

function MazeCameraManager:SetActorMove(moving)
  self._actorMoving = moving
end

function MazeCameraManager:_CalculateCameraPos(pointPos)
  local percent = math.abs(pointPos.x - self.petStart.x) / math.abs(self.petEnd.x - self.petStart.x)
  local x = self.cameraStart.x + math.abs(self.cameraStart.x - self.cameraEnd.x) * percent
  return Vector3(x, self._cameraOriginPos.y, self._cameraOriginPos.z)
end

function MazeCameraManager:TryClickRoom(clickPos)
  local clickRay = self._camera:ScreenPointToRay(clickPos)
  local castRes, hitInfo = UnityEngine.Physics.Raycast(clickRay, nil)
  if castRes then
    return hitInfo.transform.gameObject
  end
  return nil
end

function MazeCameraManager:OnDrag(dragStart, dragEnd)
  self._dragged = true
  local delta = dragEnd - dragStart
  local horiDis = -delta.x * self.pixel2Distance
  self._currentPos.x = self._currentPos.x + horiDis
  self._currentPos.x = Mathf.Clamp(self._currentPos.x, self.cameraStart.x, self.cameraEnd.x)
end

function MazeCameraManager:Update(deltaTime)
  if not self._enabled then
    return
  end
  if self._actorMoving then
    self._currentPos = self:_CalculateCameraPos(self._3dManager:GetActorManager():ActorPosition())
  else
  end
  if self._reportError then
    return
  end
  if tolua.isnull(self._camera) then
    local loadingHandler = GameGlobal.LoadingManager()._latestHandler
    Log.fatal("场景像机被销毁，最近一次的loading为：", loadingHandler)
    HelperProxy:GetInstance():ReportException("[Maze_Error]" .. loadingHandler)
    self._reportError = true
    return
  end
  local cameraPos = self._camera.transform.position
  cameraPos = Vector3.Lerp(cameraPos, self._currentPos, self.smoothRate)
  self._camera.transform.position = cameraPos
end
