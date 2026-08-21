_class("AircraftEnterLoadingHandler", LoadingHandler)
AircraftEnterLoadingHandler = AircraftEnterLoadingHandler

function AircraftEnterLoadingHandler:Constructor()
  Log.notice("[Aircraft] 开始风船Loading")
  GameGlobal.UIStateManager():Lock("AircraftEnterLoading")
end

function AircraftEnterLoadingHandler:PreLoadBeforeLoadLevel()
end

function AircraftEnterLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
  self:ReqData(TT)
  local _module = GameGlobal.GetModule(AircraftModule)
  _module:ReqFurnitureInfo(TT)
  if _module:GetClientMain() then
    Log.exception("严重错误，当前风船正在运行！")
  end
  local _main = AircraftMain:New()
  _main:Init()
  _module:SetClientMain(_main)
end

function AircraftEnterLoadingHandler:ReqData(TT)
  local airModule = GameGlobal.GameLogic():GetModule(AircraftModule)
  local ack = airModule:AircraftUpdate(TT, true)
  if ack:GetSucc() then
  else
    ToastManager.ShowToast(airModule:GetErrorMsg(ack:GetResult()))
  end
end

function AircraftEnterLoadingHandler:OnLoadingFinish(...)
  local loadingParams = {
    ...
  }
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIAircraft, self.sceneResReq, table.unpack(loadingParams))
  GameGlobal.UIStateManager():UnLock("AircraftEnterLoading")
end
