_class("BattleLoadingHandler", LoadingHandler)
BattleLoadingHandler = BattleLoadingHandler

function BattleLoadingHandler:PreLoadBeforeLoadLevel(TT)
  GameGlobal.LoadingManager():CoreGameLoadingStart()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveToBattle)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SeasonLeaveToBattle)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnBattleStartLoading)
end

function BattleLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
  local enterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
  local enterPreferenceData = GameGlobal.GetModule(MatchModule):GetMatchEnterPreferenceData()
  GameGlobal:GetInstance():EnterCoreGame(enterData, enterPreferenceData)
end

function BattleLoadingHandler:OnLoadingFinish(...)
  GameGlobal:GetInstance():GetCollector("CoreGameLoading"):Sample("BattleLoadingHandler:OnLoadingFinish() begin")
  local matchModule = GameGlobal.GetModule(MatchModule)
  if matchModule then
    matchModule:Loading(100)
  end
  GameGlobal:GetInstance():GetCollector("CoreGameLoading"):Sample("BattleLoadingHandler:OnLoadingFinish()")
end
