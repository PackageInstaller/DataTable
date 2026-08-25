local bg = {
  battleRender = nil,
  battleScene = nil,
  battlePanel = nil,
  battleSpeed = nil,
  isRestart = nil,
  isPVP = nil,
  isPVP_TRAIN = nil,
  isPVE = nil,
  isReplay = nil,
  replayPlayer = nil,
  battleData = nil,
  battleDataCenter = nil,
  mainCamera = nil,
  uiCamera = nil,
  isDebugMode = false,
  debugTimeScale = 1.0,
  lastStastics = nil,
  isDbg = nil,
  DT = DT,
  floatingCount = 0,
  floatingCountInRound = 0,
  floatingDelay = 0,
  BanSpeedCount = 0
}

function bg.SendBattleEvent(eventType, eventData)
  EventMgr.Instance.BattleEvent:Dispatch(eventType, eventData)
end

function bg.ResetTextFloat()
  bg.floatingCount = 0
  bg.floatingCountInRound = 0
  bg.floatingDelay = 0
end

function bg.IsInBattle()
  return bg.battleRender ~= nil
end

function bg.IsRelayOrAutoBattle()
  if bg.isRelay then
    return true
  end
  if bg.battleRender then
    local battlePanel = UIManager.Instance:GetWindow(Urls.DbgBattlePanel)
    if battlePanel then
      do return battlePanel.IsAutoFight end
      return battlePanel.IsAutoFight, battlePanel
    end
  end
  return false
end

function bg.SetIsDelayHideBlack(isDelayHideBlack)
  bg.isDelayHideBlack = isDelayHideBlack
end

function bg.GetIsDelayHideBlack()
  return bg.isDelayHideBlack
end

return bg
