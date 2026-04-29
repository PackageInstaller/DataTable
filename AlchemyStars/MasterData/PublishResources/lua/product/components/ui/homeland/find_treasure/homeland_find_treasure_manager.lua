_class("HomelandFindTreasureManager", Object)
HomelandFindTreasureManager = HomelandFindTreasureManager

function HomelandFindTreasureManager:Constructor(homelandClient)
  self._homelandClient = homelandClient
  self._activeRemainTime = HomelandFindTreasureConst.GetFindTreasureActiveRemainTime()
  if self._activeRemainTime then
    self._activeRemainTimerHandler = GameGlobal.Timer():AddEventTimes(self._activeRemainTime * 1000, 1, function()
      self:ActiveEnd()
    end)
  end
  self._npc = HomelandFindTreasureNPC:New(self)
  self._find_treasure = nil
end

function HomelandFindTreasureManager:Destroy()
  self:Release()
  HomelandFindTreasureConst.Destroy()
end

function HomelandFindTreasureManager:Release()
  if self._activeRemainTimerHandler then
    GameGlobal.Timer():CancelEvent(self._activeRemainTimerHandler)
    self._activeRemainTimerHandler = nil
  end
  if self._find_treasure then
    self._find_treasure:Destroy()
    self._find_treasure = nil
  end
  if self._npc then
    self._npc:Destroy()
  end
end

function HomelandFindTreasureManager:IsFindingTreasure()
  if self._find_treasure then
    return true
  end
  return false
end

function HomelandFindTreasureManager:ActiveEnd()
  if self._find_treasure then
    if self._activeRemainTimerHandler then
      GameGlobal.Timer():CancelEvent(self._activeRemainTimerHandler)
      self._activeRemainTimerHandler = nil
    end
    return
  end
  self:Release()
end

function HomelandFindTreasureManager:EnterFindTreasure(posId)
  if HomelandFindTreasureConst.IsGameActivityEnd() then
    self:Release()
    return
  end
  if self._npc then
    self._npc:SetStatusStatus(false)
  end
  if self._find_treasure then
    self._find_treasure:Destroy()
  end
  self._find_treasure = HomelandFindTreasure:New(self, posId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.EnterFindTreasure)
end

function HomelandFindTreasureManager:AttachModel()
  if self._find_treasure then
    return self._find_treasure:AttachModel()
  end
end

function HomelandFindTreasureManager:StartFindTreasure()
  if self._find_treasure then
    return self._find_treasure:Start()
  end
  return nil
end

function HomelandFindTreasureManager:ExitFindTreasure()
  if self._find_treasure then
    self._find_treasure:Destroy()
    self._find_treasure = nil
  end
  if self._npc then
    self._npc:SetStatusStatus(true)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ExitFindTreasure)
  if HomelandFindTreasureConst.IsGameActivityEnd() then
    self:Release()
  end
end

function HomelandFindTreasureManager:Pause()
  if self._find_treasure then
    self._find_treasure:Pause()
  end
end

function HomelandFindTreasureManager:Resume()
  if self._find_treasure then
    self._find_treasure:Resume()
  end
end

function HomelandFindTreasureManager:GetFindTreasure()
  return self._find_treasure
end
