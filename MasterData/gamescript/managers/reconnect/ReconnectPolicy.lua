local ReconnectRet = ReconnectDefine.Ret
local ReconnectState = ReconnectDefine.State

local function GosconReconnect(callback)
  Logger.Info("[ReconnectMgr] network: GosconReconnect")
  
  local function reconnectCb(ret, err)
    Logger.Info("[ReconnectMgr] network: gosconReconnectCb ", ret, err or "")
    if type(ret) == "boolean" and ret then
      callback(ReconnectRet.Success)
    else
      Logger.Info("[ReconnectMgr] GosconReconnect enter ReconnectRet.Reconnect")
      callback(ReconnectRet.Reconnect)
    end
  end
  
  RpcMgr.Instance:GosconReconnect(reconnectCb)
end

local function CancelAllBlockMask()
  WaitingView.Instance:CancelAll()
  if bg.battleScene and BattleManager.Instance and BattleManager.Instance.battleSceneLoader then
    BattleManager.Instance.battleSceneLoader:StopTimelineLoop()
  end
end

local function MannulReconnect(callback)
  Logger.Info("[ReconnectMgr] network: MannulReconnect")
  CancelAllBlockMask()
  ReconnectMgr.Instance:SetState(ReconnectState.Stop)
  local panel = Alert.Show(20005, function()
    callback(ReconnectRet.Failed)
    RpcMgr.Instance:Disconnect()
    SceneMgr.Instance:EnterLogin()
  end, function()
    callback(ReconnectRet.ChooseConnect)
  end)
  panel:SetIgnorePushBackCommand()
end

local function FailedReconnect(callback)
  CancelAllBlockMask()
  Alert.Show(20006, nil, function()
    callback(ReconnectRet.Failed)
    RpcMgr.Instance:Close()
    DataCenter.playerData.netDelayTime = 0
    SceneMgr.Instance:EnterLogin()
  end)
end

local function SeamlessReLogin(callback)
  Logger.Info("[ReconnectMgr] network: SeamlessReLogin")
  RpcMgr.Instance:Close()
  DataCenter.playerData.netDelayTime = 0
  LoginMgr.Instance:SeamlessReLogin(callback)
end

local function ServerConnectBreak(callback)
  CancelAllBlockMask()
  Alert.Show(20007, nil, function()
    if callback then
      callback()
    end
    RpcMgr.Instance:Close()
    DataCenter.playerData.netDelayTime = 0
    SceneMgr.Instance:EnterLogin()
  end)
end

return {
  GosconReconnect = GosconReconnect,
  MannulReconnect = MannulReconnect,
  FailedReconnect = FailedReconnect,
  ServerConnectBreak = ServerConnectBreak,
  SeamlessReLogin = SeamlessReLogin
}
