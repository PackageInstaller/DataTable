_class("SeasonMazeInputManager", Object)
SeasonMazeInputManager = SeasonMazeInputManager

function SeasonMazeInputManager:Constructor(mn)
  self._manager = mn
  self._lockKey = {}
end

function SeasonMazeInputManager:OnInit(seasonID)
  if EDITOR or IsPc() then
    self._seasonInput = SeasonMazeInputPc:New(function(objs)
      self:_OnClick(objs)
    end)
  else
    self._seasonInput = SeasonMazeInputMobile:New(function(objs)
      self:_OnClick(objs)
    end)
  end
end

function SeasonMazeInputManager:Update(deltaTime)
  if self:IsLocked() then
    return
  end
  self._seasonInput:Update(deltaTime)
end

function SeasonMazeInputManager:Dispose()
  self._seasonInput:Dispose()
  self._seasonInput = nil
  for key, count in pairs(self._lockKey) do
    for i = 1, count do
      GameGlobal.UIStateManager():UnLock(key)
    end
  end
  self._lockKey = nil
end

function SeasonMazeInputManager:GetInput()
  return self._seasonInput
end

function SeasonMazeInputManager:GetClickUnLockZone()
  return self._seasonInput:GetClickUnLockZone()
end

function SeasonMazeInputManager:_OnClick(results)
  if not results or #results == 0 then
    return
  end
  for _, result in ipairs(results) do
    local gameObject = result.transform.gameObject
    local layer = gameObject.layer
    if layer == SMazeSceneLayer.Room then
      self._manager:OnClickRoom(gameObject)
      return
    elseif layer == SMazeSceneLayer.Arrow then
      self._manager:OnClickArrow(gameObject)
      return
    end
  end
end

function SeasonMazeInputManager:LockInput(name)
  local count = self._lockKey[name]
  if not count then
    self._lockKey[name] = 1
  else
    self._lockKey[name] = count + 1
  end
  GameGlobal.UIStateManager():Lock(name)
end

function SeasonMazeInputManager:UnlockInput(name)
  local count = self._lockKey[name]
  if not count then
    Log.error("SeasonMazeInputManager:未锁定 不可解锁", name)
  else
    if count == 1 then
      self._lockKey[name] = nil
    else
      self._lockKey[name] = count - 1
    end
    GameGlobal.UIStateManager():UnLock(name)
  end
end

function SeasonMazeInputManager:IsLocked()
  return next(self._lockKey) ~= nil
end
