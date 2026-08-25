local StageGroupUnlockItemTid = DT.GetConstant("KeysItemIndex")
local UICoinInfoComponent, Super = NewViewComponent("CoinInfoComponent")
local challengeSkipConsumeList = DT.GetOriginalConstant("DailyChallengeSkipConsume")
local challengeSkipConsumeItem = challengeSkipConsumeList[1]

function UICoinInfoComponent:ctor(uiNode, view, itemTid, clickCallBack, showTipCallBack, ingCheckReddot)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_CoinResource(uiNode)
  self.itemTid = itemTid
  self.clickCallBack = clickCallBack
  self.showTipCallBack = showTipCallBack
  self.ingCheckReddot = ingCheckReddot
end

function UICoinInfoComponent:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
  self:RegisterNotify(NotifyId.OnGetDiamondExchangeAwards, self._OnGetDiamondExchangeAwards, self)
end

function UICoinInfoComponent:RegisterEvents()
  if self.clickCallBack then
    self:AddButtonClickListener(self.ui.Btn_Add, System.fn(self, self.OnClick))
  end
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.ShowTips))
  self:AddButtonClickListener(self.ui.Btn_Icon_Click, function()
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Image_Icon, nil, self.itemTid)
  end)
end

function UICoinInfoComponent:OnEnterComponent()
  self:_RefreshCoinInfo()
  self:_RefreshReddot()
end

function UICoinInfoComponent:OnExitComponent()
  if self.countDownTimer then
    self:StopTimer(self.countDownTimer)
    self.countDownTimer = nil
  end
  Super.OnExitComponent(self)
end

function UICoinInfoComponent:_RefreshCoinInfo()
  local cfg = ItemDataUtils.GetItemConfig(self.itemTid)
  local smallIcon = cfg.SpIcon or cfg.Icon
  local nVal = ItemDataUtils.IsPayMoneyType(self.itemTid) and ItemDataUtils.GetPayMoneyTotalNum() or ItemDataUtils.GetItemNum(self.itemTid)
  local showVal = nVal
  if self.itemTid == CommonDefine.CurrencyType.Energy then
    showVal = UICurrencyUtils.GetEnergyCurrencyShow(nVal)
  elseif self.itemTid == StageGroupUnlockItemTid then
    showVal = UICurrencyUtils.GetStageGroupUnlockItemCurrencyShow(nVal)
  elseif self.itemTid == challengeSkipConsumeItem then
    local MaxOwnNum = GetChallengeSkipItemCheckUtils.GetLimit()
    if MaxOwnNum then
      showVal = nVal .. "/" .. MaxOwnNum
    else
      showVal = nVal
    end
  end
  self:SetImage(self.ui.Image_Icon, smallIcon)
  self:SetText(self.ui.Text_Count, showVal)
  if self.ui and self.ui.Btn_Add and not IsNil(self.ui.Btn_Add) then
    self.ui.Btn_Add:SetActive(self.clickCallBack ~= nil)
  end
  self:SetText(self.ui.Text_Time_Counter, "")
  if self.itemTid ~= CommonDefine.CurrencyType.Ticket then
    if not self.countDownTimer then
      self.countDownTimer = self:BindTimer(1, -1, System.fn(self, self._UpdateCountDownTime))
    end
    self:_UpdateCountDownTime()
  else
    if self.countDownTimer then
      self:StopTimer(self.countDownTimer)
      self.countDownTimer = nil
    end
    self:SetText(self.ui.Text_Time_Counter, "")
  end
end

function UICoinInfoComponent:_GetCountDownDesc(countDown)
  local showStr = ""
  local restoreMaxNum = PlayerDataUtils.GetMaxTicketRestoreNum()
  if restoreMaxNum <= 0 or restoreMaxNum <= PlayerDataUtils.GetTicketNum() then
    return showStr
  end
  if not countDown or type(countDown) ~= "number" then
    return showStr
  end
  if countDown <= 0 then
    return showStr
  end
  local showTime = TimeUtils.format(countDown, CommonDefine.TimeParseType.hms)
  showStr = LT.Textf("Ticket_Countdown_Str", showTime)
  return showStr
end

function UICoinInfoComponent:_UpdateCountDownTime()
  if self.itemTid ~= CommonDefine.CurrencyType.Ticket then
    return
  end
  local countDown = PlayerDataUtils.GetTicketRestoreLeftTime()
  local countDownDesc = self:_GetCountDownDesc(countDown)
  self:SetText(self.ui.Text_Time_Counter, countDownDesc)
end

function UICoinInfoComponent:ShowTips()
  if self.showTipCallBack then
    self.showTipCallBack()
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Image_Icon, nil, self.itemTid)
end

function UICoinInfoComponent:OnClick()
  if self.clickCallBack then
    self.clickCallBack()
  end
end

function UICoinInfoComponent:SetTid(tid)
  self.itemTid = tid
  self:_RefreshCoinInfo()
end

function UICoinInfoComponent:_OnBagItemDataChanged(uid, tid)
  if IsNil(self.gameObject) then
    return
  end
  if self.itemTid == tid or ItemDataUtils.IsPayMoneyType(self.itemTid) and ItemDataUtils.IsPayMoneyType(tid) then
    self:_RefreshCoinInfo()
    self:_RefreshReddot()
  end
end

function UICoinInfoComponent:_RefreshReddot()
  if self.ingCheckReddot then
    return
  end
  if IsNil(self.ui.Image_RedDot) then
    return
  end
  if not self.clickCallBack then
    self.ui.Image_RedDot:SetActive(false)
    return
  end
  if self.itemTid == CommonDefine.CurrencyType.SeniorMoney then
    self.ui.Image_RedDot:SetActive(DiamondShopDataUtils.ExistDiamondExchangeCanReceived())
  else
    self.ui.Image_RedDot:SetActive(false)
  end
end

function UICoinInfoComponent:_OnGetDiamondExchangeAwards()
  self:_RefreshReddot()
end

return UICoinInfoComponent
