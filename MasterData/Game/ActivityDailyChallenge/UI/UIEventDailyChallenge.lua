local UIEventDailyChallenge = class("UIEventDailyChallenge", UIBaseWindow)
local base = UIBaseWindow
local UINADCDungeonItem = require("Game.ActivityDailyChallenge.UI.UINADCDungeonItem")
local UINADCModeTogItem = require("Game.ActivityDailyChallenge.UI.UINADCModeTogItem")
local UINADCRewardNode = require("Game.ActivityDailyChallenge.UI.UINADCRewardNode")
local ADCDungeonLevelData = require("Game.ActivityDailyChallenge.ADCDungeonLevelData")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")

function UIEventDailyChallenge:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickADCClose, nil, BindCallback(self, self.OpenGuidePictureFunc))
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickBuy)
  UIUtil.AddButtonListener(self.ui.btn_ScoreReward, self, self.OnClickReward)
  UIUtil.AddButtonListener(self.ui.btn_icon, self, self.OnClickTickets)
  self.__OnOpenDungeonCallback = BindCallback(self, self.__OnOpenDungeon)
  self.__OnTogChangeCallback = BindCallback(self, self.OnADCTogClick)
  self._itemPool = UIItemPool.New(UINADCDungeonItem, self.ui.taskItem)
  self._togItemPool = UIItemPool.New(UINADCModeTogItem, self.ui.obj_togMode, false)
  self.ui.taskItem:SetActive(false)
  self.ui.rewardList:SetActive(false)
  self.__RefreshItemKeyCallback = BindCallback(self, self.__RefreshItemKey)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshItemKeyCallback)
  self.__RefreshChallengeCallback = BindCallback(self, self.__RefreshChallenge)
  MsgCenter:AddListener(eMsgEventId.ActivityDailyChallengeDungeonUpdate, self.__RefreshChallengeCallback)
  self.__RefreshPointAndRewardCallback = BindCallback(self, self.__RefreshPointAndReward)
  self.ui.text_icon_des.text = ConfigData:GetTipContent(8402)
end

function UIEventDailyChallenge:InitADCMain(adcData, callback)
  self._adcData = adcData
  self._callback = callback
  self._mainCfg = self._adcData:GetADCMainCfg()
  self.ui.icon.sprite = CRH:GetSpriteByItemId(self._mainCfg.unlock_item)
  self.ui.tex_Top.text = self._adcData:GetActivityName()
  self._timerId = TimerManager:StartTimer(1, self.__TimeCountdown, self)
  if self._mainCfg.is_infinite then
    self:_InitTogMode()
  else
    self:RefreshADCDungeonList()
    self:RefreshTopTip()
  end
  self:__TimeCountdown()
  self:__RefreshItemKey()
  self:__RefreshPointAndReward()
  self._adcData:SetAdcOpend()
  if self._mainCfg.first_avg > 0 and self._adcData:IsActivityRunning() then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(self._mainCfg.first_avg)
    if not played then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, self._mainCfg.first_avg)
    end
  end
  if 0 < self._mainCfg.last_avg and self._adcData:IsADCAllPass() and self._adcData:IsActivityRunning() then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(self._mainCfg.last_avg)
    if not played then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, self._mainCfg.last_avg)
    end
  end
  self:UpdateBlueDotUI()
end

function UIEventDailyChallenge:_InitTogMode()
  self._togItemPool:HideAll()
  local item1 = self._togItemPool:GetOne()
  item1:InitADCModeTogItem(true, self.__OnTogChangeCallback)
  local item2 = self._togItemPool:GetOne()
  item2:InitADCModeTogItem(false, self.__OnTogChangeCallback)
  local isInfinite = self._adcData:GetIsInfinite()
  if isInfinite then
    item2:SetToggleOpen()
  else
    item1:SetToggleOpen()
  end
end

function UIEventDailyChallenge:OnADCTogClick(isNormal)
  self._adcData:SetIsInfinite(not isNormal)
  self:RefreshADCDungeonList()
  self:RefreshTopTip()
  self:UpdateBlueDotUI()
end

function UIEventDailyChallenge:UpdateBlueDotUI()
  local togList = self._togItemPool.listItem
  local isShowBlueDot = self._adcData:GetIsShowBlueDot()
  for i, v in ipairs(togList) do
    v:UpdateBlueDotUI(isShowBlueDot)
  end
end

function UIEventDailyChallenge:RefreshADCDungeonList()
  if not self._adcData:IsActivityRunning() then
    self:SetADCEmptyShow()
    return
  end
  self._itemPool:HideAll()
  self.ui.obj_empty:SetActive(false)
  local dungeonList = self._adcData:GetADCDungeonCfgList(self._adcData:GetIsInfinite())
  table.sort(dungeonList, function(a, b)
    return a.dungeon_order < b.dungeon_order
  end)
  self._dungeonItemDic = {}
  for _, cfg in ipairs(dungeonList) do
    local item = self._itemPool:GetOne()
    item:InitADCDungeonItem(self._adcData, cfg, self.__OnOpenDungeonCallback)
    self._dungeonItemDic[cfg.dungeon_id] = item
  end
end

function UIEventDailyChallenge:SetADCEmptyShow()
  self._itemPool:DeleteAll()
  self.ui.obj_empty:SetActive(true)
end

function UIEventDailyChallenge:RefreshTopTip()
  local tipId = self._adcData:GetIsInfinite() and self._mainCfg.infinite_des_id or self._mainCfg.normal_des_id
  self.ui.tex_topTip.text = ConfigData:GetTipContent(tipId)
end

function UIEventDailyChallenge:__RefreshItemKey(itemUpdateDic)
  if itemUpdateDic and itemUpdateDic[self._adcData:GetADCKeyItemId()] == nil then
    return
  end
  local hasCount = self._adcData:GetADCKeyItemCount()
  local maxCount = self._mainCfg.unlock_item_max
  self.ui.tex_Count.text = tostring(hasCount) .. "/" .. tostring(maxCount)
  if hasCount < maxCount and not self._adcData:IsEnoughADCItemKey() then
    local shopCfg = ControllerManager:GetController(ControllerTypeId.Shop)
    shopCfg:GetShopData(self._mainCfg.unlock_item_shop, function(shopData)
      if shopData == nil then
        self.ui.btn_Add.gameObject:SetActive(false)
        return
      end
      local goodsData = shopData:GetShopGoodDataByItemId(self._mainCfg.unlock_item)
      if goodsData ~= nil and goodsData:GetCouldBuyMaxBuyNum() > 0 then
        self.ui.btn_Add.gameObject:SetActive(true)
      else
        self.ui.btn_Add.gameObject:SetActive(false)
      end
    end)
  else
    self.ui.btn_Add.gameObject:SetActive(false)
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.QuickBuy) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.EventDaliyChallenge, false)
    end
  end
end

function UIEventDailyChallenge:__RefreshPointAndReward()
  local awardCfg = self._adcData:GetADCAwardCfg()
  local extraCfg = self._adcData:GetADCCycleAward()
  local curPoint = self._adcData:GetADCTotalPoint()
  local hasReward = false
  local nextPoint = 0
  for index, cfg in ipairs(awardCfg) do
    if curPoint < cfg.need_point then
      nextPoint = cfg.need_point
      break
    end
    hasReward = hasReward or self._adcData:IsCanADCFixedReward(cfg.need_point)
  end
  if nextPoint == 0 then
    hasReward = hasReward or self._adcData:IsCanADCExtraReward()
    local diff = curPoint - self._adcData:GetADCMaxFixedPoint()
    diff = math.floor(diff / extraCfg.need_point) + 1
    nextPoint = self._adcData:GetADCMaxFixedPoint() + diff * extraCfg.need_point
  end
  self.ui.info:SetActive(curPoint == 0)
  if 0 < curPoint then
    self.ui.tex_score:SetIndex(1, tostring(curPoint))
  else
    self.ui.tex_score:SetIndex(0)
  end
  self.ui.tex_num.text = tostring(nextPoint)
  self.ui.img_NewReward:SetActive(hasReward)
end

function UIEventDailyChallenge:__RefreshChallenge(dungeonId)
  local item = self._dungeonItemDic[dungeonId]
  if item == nil then
    return
  end
  item:RefreshADCDungeonItem()
  self:__RefreshItemKey()
end

function UIEventDailyChallenge:__OnOpenDungeon(dungeonId, item)
  item:RefreshADCSelectState(dungeonId)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(win)
    if win == nil then
      return
    end
    local dunLevelData = ADCDungeonLevelData.New(dungeonId)
    dunLevelData:SetDungeonADCData(self._adcData)
    win:InitDungeonLevelDetail(dunLevelData, not dunLevelData:IsADCDungeonLevelUnlock())
    win:SetDungeonLevelBgClose(true)
    win:SetDunLevelDetaiHideStartEvent(function()
      if not IsNull(item.transform) then
        item:RefreshADCSelectState(nil)
      end
    end)
  end)
end

function UIEventDailyChallenge:OnClickReward()
  if self._rewardNode == nil then
    self.ui.rewardList:SetActive(true)
    self._rewardNode = UINADCRewardNode.New()
    self._rewardNode:Init(self.ui.rewardList)
    self._rewardNode:InitADCRewardNode(self._adcData, self.__RefreshPointAndRewardCallback)
    self._rewardNode:Roll2LatestItemPosition(true)
  elseif not self._rewardNode.active then
    self._rewardNode:Show()
    self._rewardNode:RefreshADCRewardNode()
    self._rewardNode:Roll2LatestItemPosition(true)
  end
end

function UIEventDailyChallenge:OnClickBuy()
  if self._adcData:GetADCKeyItemCount() >= self._adcData:GetADCMainCfg().unlock_item_max then
    return
  end
  local shopCfg = ControllerManager:GetController(ControllerTypeId.Shop)
  shopCfg:GetShopData(self._mainCfg.unlock_item_shop, function(shopData)
    if shopData == nil then
      self.ui.btn_Add.gameObject:SetActive(false)
      return
    end
    local goodsData = shopData:GetShopGoodDataByItemId(self._mainCfg.unlock_item)
    if goodsData == nil or goodsData.isSoldOut then
      return
    end
    local resIds = {}
    table.insert(resIds, goodsData.currencyId)
    if not table.contain(resIds, ConstGlobalItem.PaidItem) and (goodsData.currencyId == ConstGlobalItem.PaidSubItem or goodsData.currencyId == ConstGlobalItem.SkinTicket) then
      table.insert(resIds, 1, ConstGlobalItem.PaidItem)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
      window:SlideIn()
      window:InitBuyFixedCountGood(1, goodsData, true, resIds, function()
        self:__RefreshItemKey()
      end)
    end)
  end)
end

function UIEventDailyChallenge:__TimeCountdown()
  if (self._nextTime or 0) < PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._adcData)
    self.ui.tex_TimeTitle.text = title
    self.ui.tex_EndTime.text = timeStr
    self._nextTime = expireTime
  end
  local countdownStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._nextTime)
  self.ui.tex_day.text = countdownStr
  if diff < 0 and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIEventDailyChallenge:OnClickTickets()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:SetNotNeedAnyJump(true)
      win:InitCommonItemDetail(ConfigData.item[self._mainCfg.unlock_item])
    end
  end)
end

function UIEventDailyChallenge:OnClickADCClose()
  self._adcData:SetAdcOpend()
  self:Delete()
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  if self._callback ~= nil then
    self._callback()
  end
end

function UIEventDailyChallenge:OpenGuidePictureFunc()
  local guideId = self._mainCfg.guide_id
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(guideId, nil)
end

function UIEventDailyChallenge:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._togItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshItemKeyCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityDailyChallengeDungeonUpdate, self.__RefreshChallengeCallback)
  base.OnDelete(self)
end

return UIEventDailyChallenge
