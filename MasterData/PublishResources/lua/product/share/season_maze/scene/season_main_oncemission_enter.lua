_class("SeasonMainOnceMissionEnter", LoadingHandler)
SeasonMainOnceMissionEnter = SeasonMainOnceMissionEnter

function SeasonMainOnceMissionEnter:Constructor()
end

function SeasonMainOnceMissionEnter:PreLoadBeforeLoadLevel(TT)
end

function SeasonMainOnceMissionEnter:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
  YIELD(TT)
end

function SeasonMainOnceMissionEnter:OnLoadingFinish(...)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  GameGlobal.UIStateManager():Lock("EnterOnceMission")
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 100)
    GameGlobal.UIStateManager():UnLock("EnterOnceMission")
    local uiName = GameGlobal.GetUIModule(SeasonModule):GetCurOnceMissionUI()
    GameGlobal.UIStateManager():ShowDialog(uiName, nil, nil, nil, true, true)
  end)
end

function SeasonMainOnceMissionEnter:LoadingType()
  return LoadingType.BOTTOM
end
