_class("SeasonMazeLoadingEnter", LoadingHandler)
SeasonMazeLoadingEnter = SeasonMazeLoadingEnter

function SeasonMazeLoadingEnter:Constructor()
  GameGlobal.UIStateManager():Lock("SeasonMazeLoadingEnter")
  self._loginModule = GameGlobal.GetModule(LoginModule)
end

function SeasonMazeLoadingEnter:PreLoadBeforeLoadLevel()
end

function SeasonMazeLoadingEnter:PreLoadAfterLoadLevel(TT, ...)
  GameGlobal:GetInstance():ExitCoreGame()
  local module = GameGlobal.GetModule(SeasonMazeModule)
  local res = module:ReqCurSeasonMazeDetailInfo(TT)
  self._canEnter = false
  if not res:GetSucc() then
    return
  end
  local obj = module:CurSeasonObj()
  Log.info("请求赛季秘境详细数据成功")
  self._canEnter = true
  YIELD(TT)
  module:UIModule():Run(obj:GetMazeID())
end

function SeasonMazeLoadingEnter:OnLoadingFinish(...)
  GameGlobal.UIStateManager():UnLock("SeasonMazeLoadingEnter")
  if self._canEnter then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UISeasonMazeScene)
  else
    Log.error("赛季秘境不可进入 弹回到游戏主界面")
    GameGlobal.GetModule(SeasonMazeModule):CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
end

function SeasonMazeLoadingEnter:NeedSwitchState()
  return true
end

function SeasonMazeLoadingEnter:_CacheRT(TT)
  local controller = GameGlobal.UIStateManager():GetController("UICommonLoading")
  if controller then
    controller:CacheRT(TT)
  end
end

function SeasonMazeLoadingEnter:LoadingID()
  local seasonID = GameGlobal.GetModule(SeasonMazeModule):UIModule():GetSeasonID()
  local cfg = Cfg.cfg_season_loading[seasonID]
  if cfg then
    local ids = cfg.loadingids
    return GameGlobal.LoadingManager():FilterAndRandomLoadingID(ids)
  end
  return nil
end

function SeasonMazeLoadingEnter:_CheckLoginState()
  return self._loginModule:IsLogin()
end
