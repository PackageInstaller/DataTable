local base = UIBaseWindow
local UISignInLiveStream = class("UISignInLiveStream", base)
local UINSignInLiveStreamRewardNode = require("Game.ActSignInLiveStream.UI.UINSignInLiveStreamRewardNode")
local UINSignInLiveStreamChatLog = require("Game.ActSignInLiveStream.UI.UINSignInLiveStreamChatLog")
local UINSignInLiveStreamItem = require("Game.ActSignInLiveStream.UI.UINSignInLiveStreamItem")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local util = require("XLua.Common.xlua_util")
local cs_UnityEngine = CS.UnityEngine
local cs_RandomUtility = CS.RandomUtility
local cs_Ease = CS.DG.Tweening.Ease
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_ResLoader = CS.ResLoader

function UISignInLiveStream:OnInit()
  self.resloader = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self.__OnClickBack)
  UIUtil.AddButtonListener(self.ui.Btn_RequestClick, self, self.__OnClickRequest)
  UIUtil.AddButtonListener(self.ui.Btn_HistoryReward, self, self.__OnClickHistoryReward)
  UIUtil.AddButtonListener(self.ui.Btn_Tip, self, self.__OnClickTip)
  UIUtil.AddButtonListener(self.ui.btn_StoryReview, self, self.OnClickStoryReview)
  self.itemPool = UIItemPool.New(UINSignInLiveStreamItem, self.ui.item, false)
  self.chatLogPool = UIItemPool.New(UINSignInLiveStreamChatLog, self.ui.Tex_ChatLog, false)
  self.rewardNode = UINSignInLiveStreamRewardNode.New()
  self.rewardNode:Init(self.ui.RewardNode)
  self.rewardNode:BindResloader(self.resloader)
  self.rewardNode:Hide()
  self.__refreshCurReward = BindCallback(self, self.__RefreshCurReward)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshCurReward)
end

function UISignInLiveStream:InitSILSUI(SILSData, closeCallback)
  self.SILSData = SILSData
  self.closeCallback = closeCallback
  self:__RefreshActInfo()
  self:__RefreshCurReward()
  self:__PlayBullet()
  self:__TimeCountdown()
  if self._timerId == nil then
    self._timerId = TimerManager:StartTimer(1, BindCallback(self, self.__TimeCountdown), self)
  end
  self.SILSData:SetActIsLooked()
  
  local function PlayFx()
    local prefab = self.resloader:LoadABAsset("FX/UI_effct/UI_yingyuan/FXP_yingyuan_zhuanchang.prefab")
    self.openEffect = prefab:Instantiate(self.transform)
    local uiParticle = self.openEffect:GetComponentInChildren(typeof(CS.Coffee.UIExtensions.UIParticle))
    if not IsNull(uiParticle) then
      local screenWidth = CS.UnityEngine.Screen.width
      local screenHeight = CS.UnityEngine.Screen.height
      local normal = 1.7777777777777777
      local current = screenWidth / screenHeight
      if normal > current then
        uiParticle.scale = normal / current
      elseif normal < current then
        uiParticle.scale = current / normal
      end
    end
  end
  
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local acgId = self.SILSData:GetSILSDataAvgId()
  if acgId ~= nil then
    if not avgPlayCtrl:IsAvgPlayed(acgId) then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, acgId, PlayFx)
    else
      PlayFx()
    end
  end
end

function UISignInLiveStream:OnSILSDataRTefresh()
  self:__RefreshActInfo()
  self:__RefreshCurReward()
end

function UISignInLiveStream:__RefreshActInfo()
  local collectedNum = self.SILSData:GetSILSDataCollectedRewardNum()
  local totalNum = self.SILSData:GetSILSDataTotalewardNum()
  self.ui.Tex_Nums:SetIndex(0, tostring(collectedNum), tostring(totalNum))
end

function UISignInLiveStream:__TimeCountdown()
  local endTime = self.SILSData:GetActivityEndTime()
  local diffTime = endTime - PlayerDataCenter.timestamp
  if diffTime <= 0 then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
    return
  end
  local lastTime = math.max(diffTime, 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(lastTime, false, true)
  if 0 < s then
    m = m + 1
  end
  self.ui.Tex_ActLeftTime:SetIndex(0, tostring(d), tostring(h), tostring(m))
end

function UISignInLiveStream:__RefreshCurReward()
  local rewardId = self.SILSData:GetSILSDataCurRewardId()
  local isTodayCompleted = self.SILSData:GetSILSDataIsCompleteTodayReward()
  local isAllCompleted = self.SILSData:GetSILSDataIsCompleteAllReward()
  local itemIdList, itemNumList
  self.ui.Btn_RequestClick.gameObject:SetActive(not isTodayCompleted and not isAllCompleted)
  self.ui.Obj_AfterClick.gameObject:SetActive(isTodayCompleted or isAllCompleted)
  if isTodayCompleted or isAllCompleted then
    itemIdList, itemNumList = self.SILSData:GetSILSDataRewardItemInfo(rewardId)
    self.ui.Text_subInfo:SetIndex(1)
    self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_SignInLiveStream"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      local itemId, name, icon_src = self.SILSData:GetSILSDataRewardItemIdAndName(rewardId)
      self.ui.Img_RewardPic.sprite = AtlasUtil.GetResldSprite(spriteAtlas, icon_src)
    end)
    if isAllCompleted then
      self.ui.Text_completed:SetIndex(1)
      self.ui.tex_CurState:SetIndex(1)
    else
      self.ui.Text_completed:SetIndex(0)
      self.ui.tex_CurState:SetIndex(0)
    end
  else
    itemIdList, itemNumList = self.SILSData:GetSILSDataRewardMaterial(rewardId)
    self.ui.Text_subInfo:SetIndex(0)
    self.ui.tex_CurState:SetIndex(2)
    self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_SignInLiveStream"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      local secretItemId, secretItemSrc, secretItemName = self.SILSData:GetSecretRewardInfo()
      self.ui.Img_RewardPic.sprite = AtlasUtil.GetResldSprite(spriteAtlas, secretItemSrc)
    end)
  end
  self.itemPool:HideAll()
  for index, rewardId in ipairs(itemIdList) do
    local rewardNum = itemNumList[index]
    local item = self.itemPool:GetOne()
    item:RefreshSILSItem(rewardId, rewardNum, isTodayCompleted or isAllCompleted)
  end
end

function UISignInLiveStream:__PlayBullet()
  self.chatLogPool:HideAll()
  if self._chatlogFlyCo ~= nil then
    GR.StopCoroutine(self._chatlogFlyCo)
    self._chatlogFlyCo = nil
  end
  local chatLogLineTime = {}
  local chatLogMaxLine = 2
  local linePadding = 40
  local topPadding = 15
  local flyTime = 5
  local bgSizeX = self.ui.ChatLogHoler.sizeDelta.x
  local bulletNums = #ConfigData.activity_kurolive_bullet
  cs_RandomUtility.Init(PlayerDataCenter.timestamp)
  self._chatlogFlyCo = GR.StartCoroutine(util.cs_generator(function()
    while true do
      local randIndex = cs_RandomUtility.Range(1, bulletNums)
      local item = self.chatLogPool:GetOne(true)
      local content = ConfigData.activity_kurolive_bullet[randIndex]
      item:RefreshSILSChatLog(LanguageUtil.GetLocaleText(content.text))
      CS_LayoutRebuilder.ForceRebuildLayoutImmediate(item.transform)
      local itemSizeX = item.transform.sizeDelta.x
      local fly2blankTime = itemSizeX * flyTime / bgSizeX
      local lineIndex
      for i = 1, chatLogMaxLine do
        if chatLogLineTime[i] == nil or chatLogLineTime[i] <= 0 then
          chatLogLineTime[i] = fly2blankTime
          lineIndex = i
          break
        end
      end
      if lineIndex == nil then
        self.chatLogPool:HideOne(item)
      else
        item.transform.anchoredPosition = Vector3.New(0, -(linePadding * (lineIndex - 1) + topPadding), 0)
        item.transform:DOLocalMoveX(-(bgSizeX + itemSizeX), flyTime + fly2blankTime):SetRelative(true):SetEase(cs_Ease.Linear):OnComplete(function()
          self.chatLogPool:HideOne(item)
        end):SetLink(self.gameObject)
      end
      local nextTime = cs_RandomUtility.Range(800, 1200) / 1000
      coroutine.yield(cs_UnityEngine.WaitForSeconds(nextTime))
      for key, value in pairs(chatLogLineTime) do
        chatLogLineTime[key] = math.max(value - nextTime, 0)
      end
    end
  end))
end

function UISignInLiveStream:__OnClickRequest()
  if self.SILSData:GetSILSDataIsCompleteTodayReward() then
    return
  end
  local actLongId = self.SILSData:GetActFrameId()
  local rewardId = self.SILSData:GetSILSDataCurRewardId()
  if rewardId == 0 then
    return
  end
  local itemIdList, itemNumList = self.SILSData:GetSILSDataRewardMaterial(rewardId)
  for index, rewardId in ipairs(itemIdList) do
    local rewardNum = itemNumList[index]
    if rewardNum > PlayerDataCenter:GetItemCount(rewardId) then
      return
    end
  end
  NetworkManager:GetNetwork(NetworkTypeID.ActSigninLiveStream):CS_ActivityOrder_Commit(actLongId, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local rewards = args[0]
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(rewards)
      window:AddAndTryShowReward(CRData)
    end)
    self:OnSILSDataRTefresh()
  end)
end

function UISignInLiveStream:__OnClickHistoryReward()
  self.rewardNode:RefreshSILSRewardNode(self.SILSData)
  self.rewardNode:Show()
end

function UISignInLiveStream:__OnClickTip()
  local tipTitle, tipContent = self.SILSData:GetSILSDataTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(tipContent), ConfigData:GetTipContent(tipTitle))
  end)
end

function UISignInLiveStream:OnClickStoryReview()
  local acgId = self.SILSData:GetSILSDataAvgId()
  if acgId ~= nil then
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, acgId)
  end
end

function UISignInLiveStream:__OnClickBack(isToHome)
  if not isToHome and self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UISignInLiveStream:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._chatlogFlyCo ~= nil then
    GR.StopCoroutine(self._chatlogFlyCo)
    self._chatlogFlyCo = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  DestroyUnityObject(self.openEffect.gameObject)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshCurReward)
  base.OnDelete(self)
end

return UISignInLiveStream
