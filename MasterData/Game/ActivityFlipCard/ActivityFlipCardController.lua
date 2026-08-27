local ActivityFlipCardController = class("ActivityFlipCardController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFlipCardData = require("Game.ActivityFlipCard.Data.ActivityFlipCardData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function ActivityFlipCardController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_flipcards_round)
  self._dataDic = {}
  self._net = NetworkManager:GetNetwork(NetworkTypeID.FlipCard)
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self.__OnItemUpdate = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  self.__TaskChangeCallback = BindCallback(self, self.TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

function ActivityFlipCardController:InitFlipCard(msg)
  local data = ActivityFlipCardData.New()
  self._dataDic[msg.actId] = data
  data:InitFlipCardData(msg)
  return data
end

function ActivityFlipCardController:RemoveFlipCard(actId)
  self._dataDic[actId] = nil
end

function ActivityFlipCardController:IsHaveFlipCard()
  return table.count(self._dataDic) > 0
end

function ActivityFlipCardController:ShowFlipCardMainByActId(actId)
  local flipCardData = self:GetFlipCardDataByActId(actId)
  if flipCardData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFlipCardMain, function(window)
    if window == nil then
      return
    end
    window:InitFlipCardMain(actId)
  end)
end

function ActivityFlipCardController:ShowFlipCardReward(actId, rewardIds, rewardNums, afterRewardCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRShowOverFunc(afterRewardCallback)
    window:AddAndTryShowReward(CRData)
  end)
end

function ActivityFlipCardController:ShowUseFlipCardItemConfirm(itemId, itemNum, confirmFunc)
  local isShowConfirm = PlayerDataCenter.cacheSaveData:GetEnableUseFlipCardItemConfirm()
  if not isShowConfirm then
    confirmFunc()
    return
  end
  local itemCfg = ConfigData.item[itemId]
  local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  local msg = string.format(ConfigData:GetTipContent(303), tostring(itemNum), itemName)
  window:ShowItemCost(msg, itemId, itemNum, confirmFunc, nil, true)
  window:ShowDontRemindTog(function(isOn)
    PlayerDataCenter.cacheSaveData:SetEnableUseFlipCardItemConfirm(not isOn)
  end)
end

function ActivityFlipCardController:ShowFlipCardGetMoreConfirm(itemId, confirmFunc)
  local itemCfg = ConfigData.item[itemId]
  local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(24001), itemName), confirmFunc)
end

function ActivityFlipCardController:ShowFlipCardGoNextConfirm(isShowFinalPoolText, confirmFunc)
  local msgId = isShowFinalPoolText and 24004 or 24003
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(msgId), confirmFunc)
end

function ActivityFlipCardController:Try2ShowFlipCardDrawMulti(actId, records, isSkip)
  local flipCardData = self:GetFlipCardDataByActId(actId)
  if flipCardData == nil then
    return
  end
  flipCardData:SetFlipCardDrawMulti(records, isSkip)
end

function ActivityFlipCardController:GetFlipCardDataByActId(actId)
  return self._dataDic[actId]
end

function ActivityFlipCardController:ReqFlipCardDraw(actId, idx, callback)
  local flipCardData = self:GetFlipCardDataByActId(actId)
  
  local function reqDrawFunc()
    self._net:CS_Activity_FlipCards_Draw(flipCardData:GetActId(), idx, callback)
  end
  
  local function jumpToGetMoreFunc()
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFlipCardGetMore, function(window)
      if window ~= nil then
        window:InitFlipCardGetMore(flipCardData:GetActId(), flipCardData:GetActFrameId())
      end
    end)
  end
  
  local freeItemRemain = flipCardData:GetFlipCardFreeItemRemain()
  local paidItemRemain = flipCardData:GetFlipCardPaidItemRemain()
  local isCanFlip = false
  local itemId, itemNum
  if 0 < freeItemRemain then
    itemId, itemNum = flipCardData:GetFlipCardFreeCost()
    isCanFlip = true
  elseif 0 < paidItemRemain then
    itemId, itemNum = flipCardData:GetFlipCardPaidCost()
    isCanFlip = true
  end
  if isCanFlip then
    self:ShowUseFlipCardItemConfirm(itemId, itemNum, reqDrawFunc)
  else
    itemId, itemNum = flipCardData:GetFlipCardPaidCost()
    self:ShowFlipCardGetMoreConfirm(itemId, jumpToGetMoreFunc)
  end
end

function ActivityFlipCardController:ReqFlipCardNewRound(actId, callback, forceSkipConfirm)
  local flipCardData = self:GetFlipCardDataByActId(actId)
  
  local function reqNextRounFunc()
    self._net:CS_Activity_FlipCards_Next_Round(flipCardData:GetActId(), callback)
  end
  
  if forceSkipConfirm then
    reqNextRounFunc()
    return
  end
  local isShowFinalPoolText = false
  local currentRoundId = flipCardData:GetCurrentFlipRound()
  local hasFinalReward = flipCardData:GetRoundHasFinalReward(currentRoundId + 1)
  if not hasFinalReward then
    isShowFinalPoolText = true
  end
  self:ShowFlipCardGoNextConfirm(isShowFinalPoolText, reqNextRounFunc)
end

function ActivityFlipCardController:ReqFlipCardDrawMulti(actId, count, callback)
  local flipCardData = self:GetFlipCardDataByActId(actId)
  if flipCardData == nil then
    error("cant find flipCardData")
    return
  end
  
  local function jumpToGetMoreFunc()
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFlipCardGetMore, function(window)
      if window ~= nil then
        window:InitFlipCardGetMore(flipCardData:GetActId(), flipCardData:GetActFrameId())
      end
    end)
  end
  
  if count == nil or count < 1 then
    local itemId, itemNum = flipCardData:GetFlipCardPaidCost()
    self:ShowFlipCardGetMoreConfirm(itemId, jumpToGetMoreFunc)
  else
    local freeItemNum = flipCardData:GetFlipCardFreeItemRemain()
    freeItemNum = math.min(count, freeItemNum)
    local idx = flipCardData:GetFlipCardNotGetRewardIdx(count)
    self._net:CS_Activity_FlipCards_Draw_Multi(flipCardData:GetActId(), idx, freeItemNum, callback)
    flipCardData:SetIsCanRefreshItem(false)
  end
end

function ActivityFlipCardController:TaskProcessUpdate()
  for k, v in pairs(self._dataDic) do
    v:__RefreshFlipCardRedHasTask()
  end
end

function ActivityFlipCardController:__ItemUpdate()
  for k, v in pairs(self._dataDic) do
    v:__RefreshFlipCardRedHasFlipToken()
  end
end

function ActivityFlipCardController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_flipcards_round)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
end

return ActivityFlipCardController
