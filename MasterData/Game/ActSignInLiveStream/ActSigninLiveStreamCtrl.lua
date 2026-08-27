local base = ControllerBase
local ActSigninLiveStreamCtrl = class("ActSigninLiveStreamCtrl", base)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local SigninLiveStreamData = require("Game.ActSignInLiveStream.Data.SigninLiveStreamData")

function ActSigninLiveStreamCtrl:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_kurolive)
  ConfigData:LoadDynCfg(eDynConfigData.activity_kurolive_reward)
  ConfigData:LoadDynCfg(eDynConfigData.activity_kurolive_bullet)
  self._dataDic = {}
end

function ActSigninLiveStreamCtrl:InitSILSDataByAct(actFrameData)
  if actFrameData == nil then
    return
  end
  local actId = actFrameData:GetActId()
  if self._dataDic[actId] ~= nil then
    return
  end
  local data = SigninLiveStreamData.New(actFrameData)
  self._dataDic[actId] = data
end

function ActSigninLiveStreamCtrl:UpdateSILSDataByMsg(msg)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameId = msg.actLongId
  local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
  local actId = actFrameData:GetActId()
  local data = self._dataDic[actId]
  if data == nil then
    self:InitSILSDataByAct(actFrameData)
    data = self._dataDic[actId]
  end
  data:RefreshSILSData(msg)
end

function ActSigninLiveStreamCtrl:UpdateSILSDataByMsgList(msgs)
  for _, singleMsg in ipairs(msgs) do
    self:UpdateSILSDataByMsg(singleMsg)
  end
end

function ActSigninLiveStreamCtrl:GetSILSDataByActId(actId)
  return self._dataDic[actId]
end

function ActSigninLiveStreamCtrl:GetSILSData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActSigninLiveStreamCtrl:TryOpenSigninLiveStreamUI(actId, closeCallback)
  local SILSData = self:GetSILSDataByActId(actId)
  UIManager:ShowWindowAsync(UIWindowTypeID.SignInLiveStream, function(window)
    window:InitSILSUI(SILSData, closeCallback)
  end)
end

function ActSigninLiveStreamCtrl:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_kurolive)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_kurolive_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_kurolive_bullet)
end

return ActSigninLiveStreamCtrl
