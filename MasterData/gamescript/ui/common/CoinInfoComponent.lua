local challengeSkipConsumeList = DT.GetOriginalConstant("DailyChallengeSkipConsume")
local challengeSkipConsumeItem = challengeSkipConsumeList[1]
local CoinInfoComponent, Super = System.NewComponent("CoinInfoComponent")

function CoinInfoComponent:ctor(uiNode, itemTid, clickCallBack, showTipCallBack, clickBlockFilter)
  Super.ctor(self)
  self.ui = UI_Common_Item_CoinResource(uiNode)
  self.itemTid = Vue.ref(itemTid)
  self.clickCallBack = clickCallBack
  self.showTipCallBack = showTipCallBack
  self.clickBlockFilter = clickBlockFilter
  self.countDown = Vue.ref(0)
end

function CoinInfoComponent:OnBind(binder)
  self.binder = binder
  GlobalDispatcher:AddListener(NotifyId.OnGetDiamondExchangeAwardsBatch, self._RefreshReddot, self)
  local StageGroupUnlockItemTid = CommonDefine.CurrencyType.StageGroupUnlockItemTid
  self.binder:BindToRaw(function(childBinder, nVal, _)
    local cfg = ItemDataUtils.GetItemConfig(self.itemTid.value)
    local icon = cfg.SpIcon or cfg.Icon
    local showVal = nVal
    if ItemDataUtils.IsPayMoneyType(self.itemTid.value) then
      showVal = ItemDataUtils.GetPayMoneyTotalNum()
    end
    if self.itemTid.value == CommonDefine.CurrencyType.Energy then
      showVal = UICurrencyUtils.GetEnergyCurrencyShow(nVal)
    elseif self.itemTid.value == StageGroupUnlockItemTid then
      showVal = UICurrencyUtils.GetStageGroupUnlockItemCurrencyShow(nVal)
    elseif self.itemTid.value == challengeSkipConsumeItem then
      local MaxOwnNum = GetChallengeSkipItemCheckUtils.GetLimit()
      if MaxOwnNum then
        showVal = nVal .. "/" .. MaxOwnNum
      else
        showVal = nVal
      end
    elseif self.itemTid.value == CommonDefine.CurrencyType.SummerChapter1Ticket then
      local ticketInfo = ActivityCfgUtils.GetTicketInfoByTicketItemTid(self.itemTid.value)
      local maxHoldNum = ticketInfo and ticketInfo.ticketMaxHoldNum
      if maxHoldNum then
        showVal = nVal .. "/" .. maxHoldNum
      else
        showVal = nVal
      end
    end
    childBinder:SetImage(self.ui.Image_Icon, icon)
    childBinder:SetText(self.ui.Text_Count, showVal)
    self:_RefreshReddot()
  end, function()
    if ItemDataUtils.IsPayMoneyType(self.itemTid.value) then
      do return end
      return ItemDataUtils.GetPayMoneyTotalNum, self.itemTid.value
    end
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, self.itemTid.value
  end)
  if self.clickCallBack then
    binder:BindButtonClick(self.ui.Btn_Add, System.fn(self, self.OnClick))
  end
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.ShowTips))
  binder:BindButtonClick(self.ui.Btn_Icon_Click, function()
    if self.clickBlockFilter and self.clickBlockFilter() then
      return
    end
    ItemDataUtils.ShowItemDetailTips(binder, self.ui.Image_Icon, nil, self.itemTid.value)
  end)
  binder:SetActive(self.ui.Btn_Add, self.clickCallBack)
  binder:BindToText(self.ui.Text_Time_Counter, function()
    if self.itemTid.value ~= CommonDefine.CurrencyType.Ticket then
      return ""
    end
    local showStr = ""
    local restoreMaxNum = PlayerDataUtils.GetMaxTicketRestoreNum()
    if restoreMaxNum <= 0 or restoreMaxNum <= PlayerDataUtils.GetTicketNum() then
      return showStr
    end
    if not self.countDown.value or type(self.countDown.value) ~= "number" then
      return showStr
    end
    if self.countDown.value <= 0 then
      return showStr
    end
    local showTime = TimeUtils.format(self.countDown.value, CommonDefine.TimeParseType.hms)
    showStr = LT.Textf("Ticket_Countdown_Str", showTime)
    return showStr
  end)
  local firstInit = true
  if self.itemTid.value == CommonDefine.CurrencyType.Ticket then
    binder:BindToRaw(function(cb, nVal)
      if not nVal then
        return
      end
      if not firstInit then
        self.countDown.value = PlayerDataUtils.GetTicketRestoreLeftTime()
      else
        firstInit = false
        cb:BindTimer(1, 0, nil, function()
          self.countDown.value = PlayerDataUtils.GetTicketRestoreLeftTime()
        end)
      end
      self.countDownTimer = cb:BindTimer(1, -1, function()
        if self.countDown.value <= 0 then
          if self.countDownTimer then
            TimerManager.Instance:StopTimer(self.countDownTimer)
            self.countDownTimer = nil
          end
          return
        end
        self.countDown.value = self.countDown.value - 1
      end)
    end, function()
      return DataCenter.playerData.DRole.ticketRestoredTimestamp or 0
    end)
  end
  self:_RefreshReddot()
end

function CoinInfoComponent:OnUnbind()
  GlobalDispatcher:RemoveListener(NotifyId.OnGetDiamondExchangeAwardsBatch, self._RefreshReddot, self)
  Super.OnUnbind(self)
end

function CoinInfoComponent:ShowTips()
  if self.clickBlockFilter and self.clickBlockFilter() then
    return
  end
  if self.showTipCallBack then
    self.showTipCallBack()
    return
  end
  local binder = self.binder
  ItemDataUtils.ShowItemDetailTips(binder, self.ui.Image_Icon, nil, self.itemTid.value)
end

function CoinInfoComponent:OnClick()
  if self.clickBlockFilter and self.clickBlockFilter() then
    return
  end
  if self.clickCallBack then
    self.clickCallBack()
  end
end

function CoinInfoComponent:SetTid(tid)
  self.itemTid.value = tid
  self:_RefreshReddot()
end

function CoinInfoComponent:_RefreshReddot()
  if not self.ui.Image_RedDot then
    return
  end
  if not self.clickCallBack then
    self.ui.Image_RedDot:SetActive(false)
    return
  end
  if self.itemTid.value == CommonDefine.CurrencyType.SeniorMoney then
    self.ui.Image_RedDot:SetActive(DiamondShopDataUtils.ExistDiamondExchangeCanReceived())
  else
    self.ui.Image_RedDot:SetActive(false)
  end
end

return CoinInfoComponent
