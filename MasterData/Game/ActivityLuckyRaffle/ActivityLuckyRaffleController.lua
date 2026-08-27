local ActivityLuckyRaffleController = class("ActivityLuckyRaffleController", ControllerBase)
local base = ControllerBase
local mica_sdkManager = CS.MicaSDKManager
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local LuckyRaffleData = require("Game.ActivityLuckyRaffle.Data.ActivityLuckyRaffleData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local CS_MessageCommon = CS.MessageCommon
local cs_HttpDownloadHelper = CS.HttpDownloadHelper.Instance
local rapidjson = require("rapidjson")
local cs_UnityWebRequest = CS.UnityEngine.Networking.UnityWebRequest
local infoUrl = "https://42lab-zoneinfo-qa.sunborngame.com/flexible_config"

function ActivityLuckyRaffleController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_lucky_raffle)
  ConfigData:LoadDynCfg(eDynConfigData.activity_lucky_raffle_main)
  self._dataDic = {}
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ActivityLuckyRaffle)
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._realEnterInfoPaper = BindCallback(self, self.RealEnterInfoPaper)
  self.LuckyRaffleVoteCompleteCallback = BindCallback(self, self.LuckyRaffleVoteComplete)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

function ActivityLuckyRaffleController:InitLuckyRaffle(msg)
  local data = LuckyRaffleData.New()
  self._dataDic[msg.actId] = data
  data:InitActivityLuckyRaffleDataByMsg(msg)
  return data
end

function ActivityLuckyRaffleController:GetLuckyRaffleDataByActId(actId)
  return self._dataDic[actId]
end

function ActivityLuckyRaffleController:GetTheLatestLuckyRaffleData()
  local res
  for k, v in pairs(self._dataDic) do
    if res == nil then
      res = v
    elseif v:GetActivityBornTime() > res:GetActivityBornTime() then
      res = v
    end
  end
  return res
end

function ActivityLuckyRaffleController:RemoveLuckyRaffle(actId)
  self._dataDic[actId] = nil
end

function ActivityLuckyRaffleController:IsHaveLuckyRaffle()
  return table.count(self._dataDic) > 0
end

function ActivityLuckyRaffleController:__ItemUpdate(_, _, itemDic)
  for k, v in pairs(self._dataDic) do
    v:RefreshLuckyRaffleRedDotStarNum()
  end
end

function ActivityLuckyRaffleController:LuckyRaffleVote(actId, poolId)
  self._net:CS_ACTIVITY_LuckyRaffle_Vote(actId, poolId, self.LuckyRaffleVoteCompleteCallback)
end

function ActivityLuckyRaffleController:LuckyRaffleVoteComplete(objList)
  local voteMsg = objList[0]
  local LRData = self:GetLuckyRaffleDataByActId(voteMsg.actId)
  LRData:SetLuckyRaffleVoteNumByPoolId(voteMsg.vote)
  local actWin = UIManager:GetWindow(UIWindowTypeID.LuckyRaffle)
  if actWin then
    actWin:RefreshLuckyRaffleAlreadyVoteNum()
  end
  TimerManager:StartTimer(2, function()
    local actTempWin = UIManager:GetWindow(UIWindowTypeID.LuckyRaffle)
    if actTempWin then
      actTempWin:ReqRafflePercent()
    end
  end, nil, true)
  local rewardDic = objList[1]
  if 0 < table.count(rewardDic) then
    local rewardIds = {}
    local rewardNums = {}
    for id, num in pairs(rewardDic) do
      table.insert(rewardIds, id)
      table.insert(rewardNums, num)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums)
      CRData:SetCRTitle(ConfigData:GetTipContent(19003))
      window:AddAndTryShowReward(CRData)
    end)
  end
end

function ActivityLuckyRaffleController:EnterInfoPaper()
  if self.__isRequested then
    return
  end
  self.__isRequested = true
  CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(19001), ConfigData:GetTipContent(TipContent.commonConfirm), ConfigData:GetTipContent(TipContent.commonCancle), self._realEnterInfoPaper, function()
    self.__isRequested = false
  end)
end

function ActivityLuckyRaffleController:RealEnterInfoPaper()
  local realUrl = infoUrl
  if mica_sdkManager.Instance:IsUseSdk() then
    realUrl = mica_sdkManager.Instance.gameResUrls.GetFlexibleConfigUrl
  end
  self:GetBannerJsonFromURL(realUrl, function(bannerDataJson)
    self.__isRequested = false
    local url = bannerDataJson.data.flexible_config.questionnaire_url
    local token = mica_sdkManager.Instance.accessToken
    token = cs_UnityWebRequest.EscapeURL(token)
    if token == nil then
      token = ""
    end
    if string.match(url, "?") ~= nil then
      url = url .. "&token=" .. token
    else
      url = url .. "?token=" .. token
    end
    CS.UnityEngine.Application.OpenURL(url)
  end)
end

function ActivityLuckyRaffleController:GetBannerJsonFromURL(url, callback)
  cs_HttpDownloadHelper:GetStringFromUrl(url, function(str)
    if str == nil or string.IsNullOrEmpty(str) then
      if isGameDev then
        warn("lucky raffle error url:" .. tostring(url))
      end
      callback(nil)
      return
    end
    local tab = rapidjson.decode(str)
    callback(tab)
  end)
end

function ActivityLuckyRaffleController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_lucky_raffle)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_lucky_raffle_main)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

return ActivityLuckyRaffleController
