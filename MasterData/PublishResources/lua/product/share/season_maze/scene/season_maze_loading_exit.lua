_class("SeasonMazeLoadingExit", LoadingHandler)
SeasonMazeLoadingExit = SeasonMazeLoadingExit

function SeasonMazeLoadingExit:Constructor()
  GameGlobal.UIStateManager():Lock("SeasonMazeLoadingExit")
end

function SeasonMazeLoadingExit:PreLoadBeforeLoadLevel(TT)
  GameGlobal.GetModule(SeasonMazeModule):UIModule():DisposeLogic()
end

function SeasonMazeLoadingExit:OnLoadingFinish(uistate)
  GameGlobal.UIStateManager():SwitchState(uistate)
  GameGlobal.UIStateManager():UnLock("SeasonMazeLoadingExit")
end

function SeasonMazeLoadingExit:LoadingType()
  return LoadingType.STATICPIC
end

function SeasonMazeLoadingExit:LoadingID()
  local seasonID = GameGlobal.GetModule(SeasonMazeModule):UIModule():GetSeasonID()
  local cfg = Cfg.cfg_season_loading[seasonID]
  if cfg then
    local ids = cfg.loadingids
    return GameGlobal.LoadingManager():FilterAndRandomLoadingID(ids)
  end
  return nil
end
