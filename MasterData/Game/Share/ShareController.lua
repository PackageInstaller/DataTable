local base = ControllerBase
local ShareController = class("ShareController", base)
local cs_MicaSDKManager = CS.MicaSDKManager
local CS_ClientConsts = CS.ClientConsts
local eShare = require("Game.Share.eShare")

function ShareController:OnInit()
  self._shareNet = NetworkManager:GetNetwork(NetworkTypeID.Share)
end

function ShareController:IsShareUnlock()
  if CS_ClientConsts.IsAudit then
    return false
  end
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Share)
end

function ShareController:SetShareGetRewardCallback(getRewardCallback)
  self._getRewardCallback = getRewardCallback
end

function ShareController:ShareImg(shareId, shareImgChannelType, shareCallback)
  self._shareId = shareId
  self._shareImgChannelType = shareImgChannelType
  self._shareCallback = shareCallback
  if isEditorMode then
    self:_OnShareEnd(true)
    return
  end
  TimerManager:StopTimer(self._shareTimer)
  self._shareCompleteByTimer = false
  self._shareTimer = TimerManager:StartTimer(3, function()
    self:_OnShareEnd(true)
    self._shareCompleteByTimer = true
  end, self, true)
  cs_MicaSDKManager.Instance:ShareImg(shareImgChannelType, PathConsts.PersistentShareImgPath, function(paramStr)
    local success = paramStr == "1"
    self:_OnShareEnd(success)
  end)
end

function ShareController:_OnShareEnd(success)
  TimerManager:StopTimer(self._shareTimer)
  if self._shareCompleteByTimer then
    return
  end
  if self._shareCallback ~= nil then
    self._shareCallback(success)
  end
  if success and self._shareImgChannelType ~= eShare.eShareImgChannelType.SaveGallery then
    self._shareNet:CS_Share(self._shareId, self._shareImgChannelType, function(objList)
      if objList.Count ~= 1 then
        error("objList.Count error:" .. tostring(objList.Count))
        return
      end
      local msg = objList[0]
      local rewardDic = msg.rewards
      if table.IsEmptyTable(rewardDic) then
        return
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards)
        window:AddAndTryShowReward(CRData)
      end)
      if self._getRewardCallback ~= nil then
        self._getRewardCallback()
      end
    end)
  end
  if not success then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(14028))
  end
  if isEditorMode and success then
    CS.UnityEngine.Application.OpenURL(PathConsts.PersistentShareImgPath)
  end
end

function ShareController:CanGetShareReward(shareId)
  local shareCfg = ConfigData.share[shareId]
  if shareCfg == nil then
    error("Cant get shareCfg, id:" .. tostring(shareId))
    return false
  end
  local rewardNum = self:GetShareRewardNum(shareId)
  return rewardNum < shareCfg.reward_num
end

function ShareController:GetShareRewardNum(shareId)
  local elem = ControllerManager:GetController(ControllerTypeId.TimePass, true):getCounterElemData(proto_object_CounterModule.CounterModuleShareReward, shareId)
  if elem == nil or elem.nextExpiredTm <= PlayerDataCenter.timestamp then
    return 0
  end
  return elem.times
end

function ShareController:OnDelete()
  TimerManager:StopTimer(self._shareTimer)
  base.OnDelete(self)
end

return ShareController
