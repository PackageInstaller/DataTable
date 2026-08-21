_class("ReStartCoreGameHandler", LoadingHandler)
ReStartCoreGameHandler = ReStartCoreGameHandler

function ReStartCoreGameHandler:PreLoadBeforeLoadLevel(TT)
  local module = GameGlobal.GetModule(GameMatchModule)
  module:QuickReStartMatchTT(TT)
  Log.fatal("ReStartCoreGameHandler:PreLoadBeforeLoadLevel")
end

function ReStartCoreGameHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
  local enterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
  local enterPreferenceData = GameGlobal.GetModule(MatchModule):GetMatchEnterPreferenceData()
  GameGlobal:GetInstance():EnterCoreGame(enterData, enterPreferenceData)
  Log.fatal("ReStartCoreGameHandler:PreLoadAfterLoadLevel")
end

function ReStartCoreGameHandler:OnLoadingFinish(...)
  GameGlobal:GetInstance():GetCollector("CoreGameLoading"):Sample("ReStartCoreGameHandler:OnLoadingFinish() begin")
  local matchModule = GameGlobal.GetModule(MatchModule)
  if matchModule then
    matchModule:Loading(100)
  end
  GameGlobal:GetInstance():GetCollector("CoreGameLoading"):Sample("ReStartCoreGameHandler:OnLoadingFinish()")
  Log.fatal("ReStartCoreGameHandler:OnLoadingFinish")
end
