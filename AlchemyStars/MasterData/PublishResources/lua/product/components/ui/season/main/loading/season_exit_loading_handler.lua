_class("SeasonExitLoadingHandler", LoadingHandler)
SeasonExitLoadingHandler = SeasonExitLoadingHandler

function SeasonExitLoadingHandler:Constructor()
  GameGlobal.UIStateManager():Lock("SeasonExitLoadingHandler")
end

function SeasonExitLoadingHandler:PreLoadBeforeLoadLevel(TT)
  local module = GameGlobal.GetModule(SeasonModule)
  local uimodule = GameGlobal.GetUIModule(SeasonModule)
  uimodule:ExitSeasonGame()
end

function SeasonExitLoadingHandler:OnLoadingFinish(...)
  local loadingParams = {
    ...
  }
  local param = loadingParams[1]
  local uiState, exitCb
  if param then
    if type(param) == "function" then
      exitCb = param
    elseif type(param) == "string" then
      uiState = param
    else
      Log.exception("赛季退出参数错误")
    end
  else
    uiState = UIStateType.UIMain
  end
  if uiState then
    GameGlobal.UIStateManager():SwitchState(uiState)
  elseif exitCb then
    exitCb()
  end
  GameGlobal.UIStateManager():UnLock("SeasonExitLoadingHandler")
end

function SeasonExitLoadingHandler:LoadingType()
  return LoadingType.STATICPIC
end

function SeasonExitLoadingHandler:LoadingID()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonID = seasonModule:UIModule():GetSeasonID()
  if not seasonID or seasonID <= 0 then
    seasonID = seasonModule:UIModule():GetLatestSeasonID()
    Log.error("当前赛季已关闭 取最近一次开放的赛季loading图", seasonID)
  end
  local cfg = Cfg.cfg_season_loading[seasonID]
  if cfg then
    local ids = cfg.loadingids
    return GameGlobal.LoadingManager():FilterAndRandomLoadingID(ids)
  end
  return nil
end
