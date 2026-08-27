local UICommonReward = class("UICommonReward", UIBaseWindow)
local base = UIBaseWindow
local UICommonItem = require("Game.CommonUI.Item.UICommonRewardItem")
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local UINCommonRewardTimeTips = require("Game.CommonUI.UINCommonRewardTimeTips")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UICommonReward:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.rewardData = nil
  self.__isShowingReward = false
  self.commonRewardQueue = {}
  self.exitFuncList = {}
  self.__rewardItemDic = {}
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  self.__OnRewardItemClick = BindCallback(self, self.OnRewardItemClick)
  self.ui.loopScroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loopScroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.loopScroll.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self._timeTipPool = UIItemPool.New(UINCommonRewardTimeTips, self.ui.monthCardTime, false)
  self.__UpdateRewardShowFunc = BindCallback(self, self.__UpdateRewardShow)
  self.__SetCanClickClose = BindCallback(self, self.SetIsCanClickClose, true)
  self:SetIsCanClickClose(true)
  self._challengeStarWidth = self.ui.img_ChallengeAll.sizeDelta.x
  self.__onOPenShowReward = false
end

function UICommonReward:AddAndTryShowReward(commonRewardData)
  local staminaRewardData = commonRewardData:TryCutOutStaminaRewards()
  local greadRewardData = commonRewardData:CutOutGreatRewards()
  if greadRewardData ~= nil then
    table.insert(self.commonRewardQueue, 1, greadRewardData)
  end
  if staminaRewardData then
    table.insert(self.commonRewardQueue, staminaRewardData)
  end
  if #commonRewardData.rewardIds > 0 then
    table.insert(self.commonRewardQueue, commonRewardData)
  end
  if commonRewardData.exitAction ~= nil then
    table.insert(self.exitFuncList, commonRewardData.exitAction)
  end
  commonRewardData:ClearCRMonthCardTimeTips()
  self:__ShowNextRewardOrDelete()
end

function UICommonReward:__ShowNextRewardOrDelete()
  if #self.commonRewardQueue > 0 then
    self:__ShowNextReward()
  else
    self:Delete()
    for index, func in ipairs(self.exitFuncList) do
      func()
    end
  end
end

function UICommonReward:__ShowNextReward()
  if self.__isShowingReward then
    return
  end
  self.__isShowingReward = true
  if self.challengeFxGoList ~= nil then
    for i, v in ipairs(self.challengeFxGoList) do
      v:SetActive(false)
    end
  end
  self.rewardData = self.commonRewardQueue[1]
  table.remove(self.commonRewardQueue, 1)
  local isRewardNeedShowInSide, messageSideDataList = UIUtil.IsRewardNeedShowInSide(self.rewardData.rewardIds, self.rewardData.rewardNums, self.rewardData.crItemTransDic)
  if isRewardNeedShowInSide and messageSideDataList ~= nil then
    UIUtil.RewardShowInSide(messageSideDataList)
    self:__ShowNextRewardOrDelete()
    return
  end
  ControllerManager:GetController(ControllerTypeId.Skin, true):CheckItemListsForSkins(self.rewardData.rewardIds, self.__UpdateRewardShowFunc, self.rewardData)
end

function UICommonReward:__UpdateRewardShow()
  local selfWin = UIManager:ShowWindowOnly(UIWindowTypeID.CommonReward)
  if selfWin == nil then
    return
  end
  if not string.IsNullOrEmpty(self.rewardData.title) then
    self.ui.txt_RewardTitle.text = self.rewardData.title
  end
  if not string.IsNullOrEmpty(self.rewardData.rewardTips) then
    self.ui.obj_tips:SetActive(true)
    self.ui.tex_Tips.text = self.rewardData.rewardTips
  else
    self.ui.obj_tips:SetActive(false)
  end
  if not string.IsNullOrEmpty(self.rewardData.downTitle) then
    self.ui.Obj_DownInfo:SetActive(true)
    self.ui.Tex_DownInfoTitle.text = self.rewardData.downTitle
    self.ui.Tex_DownInfoContent.text = self.rewardData.downContent
  else
    self.ui.Obj_DownInfo:SetActive(false)
  end
  if Consts.GameChannelType.IsJp() and self.rewardData:HasCRQZ() then
    local itemDic = self.rewardData:GetCRBeforeMergeItemDic()
    local freeQZNum = itemDic[ConstGlobalItem.PaidItem] or 0
    local paidQZNum = itemDic[ConstGlobalItem.PaidQZ] or 0
    self.ui.obj_JpQZTag:SetActive(true)
    self.ui.tex_FreeCount:SetIndex(0, tostring(freeQZNum))
    self.ui.tex_PayCount:SetIndex(0, tostring(paidQZNum))
  else
    self.ui.obj_JpQZTag:SetActive(false)
  end
  self._timeTipPool:HideAll()
  for iMonthCardType = 1, EPeriodicCardType.PeriodicCardCount do
    if self.rewardData:HasCRMonthCardTimeTips(iMonthCardType) then
      local timeTipItem = self._timeTipPool:GetOne()
      timeTipItem:InitCommonRewardTipeTips(iMonthCardType)
    end
  end
  if self.rewardData.heroIdList ~= nil and 0 < #self.rewardData.heroIdList then
    self:Hide()
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
      if window == nil then
        return
      end
      if self.rewardData.crUpHeroFragDic ~= nil then
        window:SetGetHeroConvertFrag(self.rewardData.crUpHeroFragDic)
      end
      window:InitGetHeroList(self.rewardData.heroIdList, false, true, self.rewardData.newHeroIndexDic, function()
        self:Show()
        self:__RefreshList()
        AudioManager:PlayAudioById(1115)
        UIManager:DeleteWindow(UIWindowTypeID.GetHero)
      end, self.rewardData.skipOldHero)
    end)
  else
    self:_PlayCommonItemRewardAudio()
    self:__RefreshList()
  end
end

function UICommonReward:_PlayCommonItemRewardAudio()
  local commonItemRewardAudioId = 1029
  if CommonUIUtil.GetCommonItemRewardAudioId() ~= nil then
    commonItemRewardAudioId = CommonUIUtil.GetCommonItemRewardAudioId()
  end
  AudioManager:PlayAudioById(commonItemRewardAudioId)
end

function UICommonReward:_ShowChallengeTask(rewardData)
  self.ui.img_ChallengeAll.gameObject:SetActive(true)
  local fromNum = rewardData.challengeModeTaskFromNum
  local toNum = rewardData.challengeModeTaskToNum
  local size = self.ui.img_ChallengeAll.sizeDelta
  size.x = self._challengeStarWidth * rewardData.challengeModeTaskTotalNum
  self.ui.img_ChallengeAll.sizeDelta = size
  size.x = self._challengeStarWidth * fromNum
  self.ui.img_ChallengeCur.sizeDelta = size
  local fxGoList = self.challengeFxGoList or {}
  self.challengeFxGoList = fxGoList
  for i = 1, rewardData.challengeModeTaskTotalNum do
    local fxGo = fxGoList[i]
    if fxGo == nil then
      if 1 < i then
        local go = self.ui.challengeFxItem:Instantiate()
        fxGo = go.transform:GetChild(0).gameObject
      else
        fxGo = self.ui.challengeFxItem.transform:GetChild(0).gameObject
      end
      table.insert(fxGoList, fxGo)
    end
    fxGo:SetActive(false)
  end
  if self._challengeTimerId ~= nil then
    TimerManager:StopTimer(self._challengeTimerId)
  end
  self._challengeTimerId = TimerManager:StartTimer(0.2, function()
    if fromNum >= toNum then
      TimerManager:StopTimer(self._challengeTimerId)
      self:__PlayTooMuchRewardAnima()
      return
    end
    fromNum = fromNum + 1
    local fxGo = fxGoList[fromNum]
    if fxGo ~= nil then
      fxGo:SetActive(true)
    end
  end, self, false)
end

function UICommonReward:_ShowReward()
end

function UICommonReward:__RefreshList()
  self.ui.loopScroll.totalCount = #self.rewardData.rewardIds
  self:__ShowGetRewardFx()
end

function UICommonReward:__OnNewItem(go)
  local item = UICommonItem.New()
  go.transform.localScale = Vector3.one
  item:Init(go)
  item:BindRewardResloader(self.resloader)
  self.__rewardItemDic[go] = item
end

function UICommonReward:__OnChangeItem(go, index)
  local item = self.__rewardItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local itemId = self.rewardData.rewardIds[index + 1]
  local itemNum = self.rewardData.rewardNums[index + 1]
  local itemCfg = ConfigData.item[itemId]
  if self.rewardData.crUpHeroFragDic ~= nil then
    item:SetIsConvertHeroFrag()
  end
  if self.rewardData.crCustomItemTransDic ~= nil and self.rewardData.customItemIndexs[index + 1] == true then
    local customTransData = self.rewardData.crCustomItemTransDic[itemId]
    if customTransData ~= nil and customTransData.itemNum > 0 then
      local transNum = customTransData.itemNum
      local transIds = {}
      local tansNums = {}
      for key, value in pairs(customTransData.product) do
        table.insert(transIds, key)
        table.insert(tansNums, value)
      end
      item:SetItemTranNum(transNum)
      item:SetCommonRewardItemCustomTrans(transIds, tansNums)
      self:SetCannotClickCloseTimer()
    else
      item:SetCommonRewardItemCustomTrans(nil, nil)
      item:SetItemTranNum(nil)
    end
  end
  if self.rewardData.crItemTransDic ~= nil then
    local transNum = self.rewardData.crItemTransDic[itemId]
    if transNum ~= nil then
      item:SetItemTranNum(transNum)
      self:SetCannotClickCloseTimer()
    else
      item:SetItemTranNum(nil)
    end
  end
  item.baseItem.baseItem:SetIsShowNewTag(false)
  if self.rewardData.crItemNewDic ~= nil and self.rewardData.crItemNewDic[itemId] ~= nil then
    item.baseItem.baseItem:SetIsShowNewTag(true)
  end
  item:InitCommonRewardItem(itemCfg, itemNum, self.rewardData.heroSnapshoot, self.__OnRewardItemClick)
  item:BindRewardClickCustomArg(index + 1)
end

function UICommonReward:__OnReturnItem(go)
  local item = self.__rewardItemDic[go]
  item.baseItem:CloseGreatRewardLoopFx()
  item.baseItem:CloseQualityFx()
end

function UICommonReward:__GetItemByIndex(index)
  local go = self.ui.loopScroll:GetCellByIndex(index)
  if go ~= nil then
    return self.__rewardItemDic[go]
  end
  return nil
end

function UICommonReward:OnRewardItemClick(itemCfg, index)
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:SetNotNeedAnyJump(true)
      win:InitListDetail(self.rewardData.rewardDataList, index)
    end
  end)
end

function UICommonReward:__ShowGetRewardFx()
  self.ui.dotween_rewardContent:DORestart()
  self.ui.dotween_list:DORestart()
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill(true)
    self.tweenSeq = nil
  end
  self.__onOPenShowReward = true
  if not self.__isAdded then
    self.__isAdded = true
    self.ui.dotween_rewardContent.onComplete:AddListener(function()
      self.__onOPenShowReward = false
      if self.rewardData.challengeModeTaskFromNum == nil then
        self.ui.img_ChallengeAll.gameObject:SetActive(false)
        self:__PlayTooMuchRewardAnima()
        return
      end
      self:_ShowChallengeTask(self.rewardData)
    end)
  end
end

local anchorLeft = Vector2.New(0, 0.5)
local anchorMid = Vector2.New(0.5, 0.5)

function UICommonReward:__PlayTooMuchRewardAnima()
  local maxCouldContainNum = math.ceil((self.ui.loopScroll.transform.rect.width - self.ui.layoutGroup.padding.left) / (self.ui.layoutGroup.cellSize.x + self.ui.layoutGroup.spacing.x))
  local maxPage = math.ceil(#self.rewardData.rewardIds / maxCouldContainNum)
  if 1 < maxPage then
    self.ui.layoutGroup.transform.anchorMax = anchorLeft
    self.ui.layoutGroup.transform.anchorMin = anchorLeft
    self.ui.layoutGroup.transform.pivot = anchorLeft
  else
    self.ui.layoutGroup.transform.anchorMax = anchorMid
    self.ui.layoutGroup.transform.anchorMin = anchorMid
    self.ui.layoutGroup.transform.pivot = anchorMid
  end
  
  local function ShowOnePage(pageIndex)
    if self.tweenSeq ~= nil then
      self.tweenSeq:Kill(true)
      self.tweenSeq = nil
    end
    if pageIndex >= maxPage then
      return
    end
    self.tweenSeq = cs_DoTween.Sequence()
    self.tweenSeq:AppendInterval(0.05)
    self.ui.loopScroll:RefillCells(pageIndex * maxCouldContainNum)
    for i = pageIndex * maxCouldContainNum, (pageIndex + 1) * maxCouldContainNum - 1 do
      if i >= #self.rewardData.rewardIds then
        break
      end
      local item = self:__GetItemByIndex(i)
      if item ~= nil then
        item.transform.localScale = Vector3.one
        self.tweenSeq:Append(item.transform:DOScale(Vector3.zero, 0.2):From():SetEase(cs_Ease.OutBack))
        self.tweenSeq:AppendCallback(function()
          if ConfigData.game_config.itemWithGreatFxDic[item.itemCfg.id] then
            item.baseItem:LoadGetGreatRewardFx(self.resloader, 0)
          else
            item.baseItem:LoadGetRewardFx(self.resloader, 0)
          end
        end)
      end
    end
    self.tweenSeq:AppendCallback(function()
      ShowOnePage(pageIndex + 1)
    end)
  end
  
  ShowOnePage(0)
end

function UICommonReward:SetIsCanClickClose(isCan)
  self.__isCanClickClose = isCan
end

function UICommonReward:SetCannotClickCloseTimer()
  self:SetIsCanClickClose(false)
  if self.__cannotClickCloseTimerId ~= nil then
    TimerManager:StopTimer(self.__cannotClickCloseTimerId)
  end
  local time = ConfigData.game_config.itemOverflowShowTime
  self.__cannotClickCloseTimerId = TimerManager:StartTimer(time, self.__SetCanClickClose)
end

function UICommonReward:SetColseCallback(closeCallback)
  self.closeCallback = closeCallback
end

function UICommonReward:OnClickClose()
  if self.tweenSeq ~= nil and self.tweenSeq:IsPlaying() then
    self.tweenSeq.timeScale = 1000
  elseif self.__isAdded and not self.__onOPenShowReward then
    if not self.__isCanClickClose then
      return
    end
    if #self.commonRewardQueue > 0 then
      self.__isShowingReward = false
    end
    self:__ShowNextRewardOrDelete()
  end
end

function UICommonReward:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if not IsNull(self.ui.dotween_list) then
    self.ui.dotween_list:DOKill()
  end
  if not IsNull(self.ui.dotween_rewardContent) then
    self.ui.dotween_rewardContent:DOKill()
  end
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill(true)
    self.tweenSeq = nil
  end
  for go, item in pairs(self.__rewardItemDic) do
    item:Delete()
  end
  if self._challengeTimerId ~= nil then
    TimerManager:StopTimer(self._challengeTimerId)
  end
  if self.__cannotClickCloseTimerId ~= nil then
    TimerManager:StopTimer(self.__cannotClickCloseTimerId)
    self.__cannotClickCloseTimerId = nil
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
    self.closeCallback = nil
  end
  base.OnDelete(self)
end

return UICommonReward
