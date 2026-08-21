local LoadingTargetResult = {
  None = 0,
  Success = 1,
  Fail = 2
}
_enum("LoadingTargetResult", LoadingTargetResult)
_class("LoadingNetEventProxy", Object)

function LoadingNetEventProxy:Constructor()
  self.loadingTargetResult = LoadingTargetResult.None
  self.matchStart = false
  Log.debug("LoadingNetEventProxy:Constructor ")
  self.autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self.autoBinder:BindEvent(GameEventType.MatchStart, self, self.HandleMatchStartMsg)
  self.autoBinder:BindEvent(GameEventType.LoadingProgressChanged, self, self.HandleLoadingProgressChanged)
end

function LoadingNetEventProxy:Remove()
  self.loadingTargetResult = LoadingTargetResult.None
  self.matchStart = false
  Log.debug("LoadingNetEventProxy:Remove RemoveCallbackListener")
  self.autoBinder:UnBindAllEvents()
end

function LoadingNetEventProxy:GetLoadingTargetResult()
  return self.loadingTargetResult
end

function LoadingNetEventProxy:IsMatchStart()
  return self.matchStart
end

function LoadingNetEventProxy:StartEnterMatch()
  self:StartTask(LoadingNetEventProxy.StartEnterMatchTask, self)
end

function LoadingNetEventProxy:StartEnterMatchTask(TT)
  local loginModule = self:GetModule(LoginModule)
  local gameMatchModule = self:GetModule(GameMatchModule)
  local matchModule = self:GetModule(MatchModule)
  local res = matchModule:EnterMatch(TT, loginModule.PstID, gameMatchModule.match_token)
  if not res:GetSucc() then
    Log.fatal("LoadingNetEventProxy:StartEnterMatchTask 进入对局失败，错误码 ", res:GetResult())
    self.loadingTargetResult = LoadingTargetResult.Fail
    return
  end
  Log.debug("LoadingNetEventProxy:StartEnterMatchTask 进入对局成功")
  self.loadingTargetResult = LoadingTargetResult.Success
end

function LoadingNetEventProxy:HandleMatchStartMsg()
  self.matchStart = true
end

function LoadingNetEventProxy:HandleLoadingProgressChanged(progress)
  if progress == nil then
    return
  end
  local matchModule = self:GetModule(MatchModule)
  matchModule:Loading(progress)
end

function LoadingNetEventProxy:StartTask(func, ...)
  TaskManager:GetInstance():StartTask(func, ...)
end

function LoadingNetEventProxy:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end
