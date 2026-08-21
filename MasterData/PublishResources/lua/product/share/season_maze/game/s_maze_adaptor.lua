_class("SMazeAdaptor", Object)
SMazeAdaptor = SMazeAdaptor

local function _TryGetCurState(stateID)
  local uiModule = GameGlobal.GetModule(SeasonMazeModule):UIModule()
  if not uiModule:IsRunning() then
    Log.error("赛季秘境未运行")
    return
  end
  local state = uiModule:SeasonMazeManager():GetCurState()
  if state:StateID() == stateID then
    return state
  end
end

function SMazeAdaptor.PlayCard(id)
  local state = _TryGetCurState(SMazeStateID.PlayCard)
  if not state then
    Log.error("严重错误 当前不是选卡状态 不可以打出行动卡", debug.traceback())
    return
  end
  state:PlayCard(id)
end

function SMazeAdaptor.UseActiveProp(id)
  local state = _TryGetCurState(SMazeStateID.PlayCard)
  if not state then
    Log.exception("严重错误 当前不是选卡状态 不可以使用主动道具", debug.traceback())
    return
  end
  state:UseProp(id)
end

function SMazeAdaptor.OnRoomSettleFinish(room)
  local state = _TryGetCurState(SMazeStateID.RoomSettle)
  if not state then
    Log.exception("严重错误 当前不是选卡状态 不可以使用主动道具", debug.traceback())
    return
  end
  state:SettleFinish(room)
end

function SMazeAdaptor.OnChooseCard(id, select)
  local state = _TryGetCurState(SMazeStateID.PlayCard)
  if not state then
    Log.error("严重错误 当前不是选卡状态 不可以预览目标点", debug.traceback())
    return
  end
  state:PreviewTargetNode(id, select)
end

function SMazeAdaptor.OnShowMainUI()
  local state = _TryGetCurState(SMazeStateID.Born)
  if not state then
    Log.exception("严重错误 当前不是角色出生状态", debug.traceback())
    return
  end
  state:Start()
end

function SMazeAdaptor.OnLvUpDialogClose()
  local state = _TryGetCurState(SMazeStateID.Levelup)
  if not state then
    Log.exception("严重错误 当前不是升级状态", debug.traceback())
    return
  end
  state:OnDialogClose()
end

function SMazeAdaptor.CanUseActiveProp()
  local state = _TryGetCurState(SMazeStateID.PlayCard)
  return state ~= nil
end

function SMazeAdaptor.OnUseBombSelect(targetNode)
  local state = _TryGetCurState(SMazeStateID.PlayCard)
  if not state then
    Log.exception("严重错误 当前不是选卡状态 不可以选择炸弹目标", debug.traceback())
    return
  end
  state:SelectBombTarget(targetNode)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeSelectBombTarget, targetNode)
end

function SMazeAdaptor.OnUseBombConfirm()
  local state = _TryGetCurState(SMazeStateID.PlayCard)
  if not state then
    Log.exception("严重错误 当前不是选卡状态 不可以确认使用炸弹", debug.traceback())
    return
  end
  state:ConfirmUseBomb()
end

function SMazeAdaptor.OnUseBombCancel()
  local state = _TryGetCurState(SMazeStateID.PlayCard)
  if not state then
    Log.exception("严重错误 当前不是选卡状态 不可以取消使用炸弹", debug.traceback())
    return
  end
  state:CancelUseBomb()
end

function SMazeAdaptor.PlayerHeadPos()
  local uiModule = GameGlobal.GetModule(SeasonMazeModule):UIModule()
  if uiModule:IsRunning() then
    return uiModule:SeasonMazeManager():Player():HeadPosition()
  end
end

function SMazeAdaptor.MainCam()
  local uiModule = GameGlobal.GetModule(SeasonMazeModule):UIModule()
  if uiModule:IsRunning() then
    return uiModule:SeasonMazeManager():SeasonMazeCameraManager():Camera()
  end
end

function SMazeAdaptor.OnPickCardFinish()
  local state = _TryGetCurState(SMazeStateID.Levelup)
  if not state then
    Log.exception("严重错误 当前不是升级状态", debug.traceback())
    return
  end
  state:OnFinish()
end

function SMazeAdaptor.GetCurRoomType()
  local uiModule = GameGlobal.GetModule(SeasonMazeModule):UIModule()
  if not uiModule:IsRunning() then
    Log.error("赛季秘境未运行")
    return
  end
  local node = uiModule:SeasonMazeManager():GetCurNode()
  if node then
    return node:Room():Type()
  end
end

function SMazeAdaptor.ChooseFullPetFinish(petID)
  local state = _TryGetCurState(SMazeStateID.ChooseFullPet)
  if not state then
    Log.exception("严重错误 选择满破星灵状态", debug.traceback())
    return
  end
  state:OnChooseFinish(petID)
end

function SMazeAdaptor.CurNodeID()
  local uiModule = GameGlobal.GetModule(SeasonMazeModule):UIModule()
  if not uiModule:IsRunning() then
    Log.error("赛季秘境未运行")
    return
  end
  local node = uiModule:SeasonMazeManager():GetCurNode()
  if node then
    return node:ID()
  end
end

function SMazeAdaptor.OnRelicObtained(relicEfts, reason)
  local uiModule = GameGlobal.GetModule(SeasonMazeModule):UIModule()
  if not uiModule:IsRunning() then
    Log.error("赛季秘境未运行")
    return
  end
  local state = uiModule:SeasonMazeManager():GetCurState()
  Log.info("获得圣物 当前状态:", state:StateID())
  state:OnObainedRelic(relicEfts, reason)
end
