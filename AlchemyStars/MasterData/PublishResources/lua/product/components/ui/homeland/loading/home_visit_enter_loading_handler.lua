_class("HomeVisitEnterLoadingHandler", LoadingHandler)
HomeVisitEnterLoadingHandler = HomeVisitEnterLoadingHandler

function HomeVisitEnterLoadingHandler:Constructor()
  Log.notice("[Homeland] 开始拜访家园Loading")
  GameGlobal.UIStateManager():Lock(self._className)
end

function HomeVisitEnterLoadingHandler:PreLoadBeforeLoadLevel()
end

function HomeVisitEnterLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  self._canEnter = false
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
  local _module = GameGlobal.GetModule(HomelandModule)
  local _uimodule = GameGlobal.GetUIModule(HomelandModule)
  if _uimodule:IsRunning() then
    Log.exception("严重错误，当前家园正在运行！")
    return
  end
  local ack1 = _module:EnterHomeLand(TT)
  if not ack1:GetSucc() then
    Log.fatal("请求家园数据失败:", ack1:GetResult())
    return
  end
  _module:ClearNormalData()
  local params = {
    ...
  }
  local ack, data = _module:HomelandVisitFriendReq(TT, params[1])
  if not ack:GetSucc() then
    ToastManager.ShowHomeToast(_module:GetVisitErrorMsg(ack:GetResult()))
    return
  end
  _uimodule:SetVisitInfo(data.infos)
  YIELD(TT)
  _uimodule:EnterHomeland(TT, true)
  self._canEnter = true
end

function HomeVisitEnterLoadingHandler:OnLoadingFinish(...)
  if self._canEnter then
    local loadingParams = {
      ...
    }
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeland, self.sceneResReq, table.unpack(loadingParams))
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
  GameGlobal.UIStateManager():UnLock(self._className)
end
