local UIWhiteDayAccOrder = class("UIWhiteDayAccOrder", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UIWhiteDayAccOrder:OnInit()
  self.accSelectNum = 0
  self.ticketNum = 0
  self.ticketAccTime = 0
  self.ticketItemId = nil
  self.orderItem = UINBaseItemWithCount.New()
  self.orderItem:Init(self.ui.uINBaseItemWithCount)
  self.accTicketItem = UINBaseItemWithCount.New()
  self.accTicketItem:Init(self.ui.uINBaseItemWithCount_ticket)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_QuickBy, self, self.__OnClickQuickBuy)
  UIUtil.AddButtonListener(self.ui.btn_Plus, self, self.AddOne)
  UIUtil.AddButtonListener(self.ui.btn_Reduce, self, self.MinusOne)
  self.ui.inputField_count.onEndEdit:AddListener(BindCallback(self, self._OnInputFieldEndEdit))
  self.ui.btn_Plus.onPress:AddListener(BindCallback(self, self.PressAdd))
  self.ui.btn_Reduce.onPress:AddListener(BindCallback(self, self.PressMinus))
  self.__onItemUpdate = BindCallback(self, self.__OnItemUpdate)
end

function UIWhiteDayAccOrder:InitWDAccOrder(AWDCtrl, AWDLineData)
  self.AWDCtrl = AWDCtrl
  self.AWDLineData = AWDLineData
  self.AWDData = AWDLineData:GetAWDData()
  self.ticketAccTime = self.AWDData:GetWDAccItemAcctime()
  self.ticketItemId = self.AWDData:GetWDAccItemId()
  self.ticketNum = PlayerDataCenter:GetItemCount(self.ticketItemId)
  self:__RefreshItemUI()
  self:__RefreshQuickBuy()
  self:__AfterSelectNumChange()
  self:UpdateWDAccTimeChange()
  self.lineTimerId = TimerManager:StartTimer(1, self.__OnWDTimeUpdate, self, false, nil, true)
end

function UIWhiteDayAccOrder:__RefreshItemUI()
  local WDOrderData = self.AWDLineData:GetWDProductionOrderData()
  local orderItemCfg, itemNum = WDOrderData:GetWDOrderItemIdAndNum()
  self.orderItem:InitItemWithCount(orderItemCfg, itemNum)
  local itemCfg = ConfigData.item[self.ticketItemId]
  local wareHousNum = PlayerDataCenter:GetItemCount(self.ticketItemId)
  self.accTicketItem:InitItemWithCount(itemCfg, wareHousNum)
end

function UIWhiteDayAccOrder:__RefreshQuickBuy()
  local isUnlockQuickBuy = self.AWDData:GetWDCouldBuyAccItem()
  self.ui.btn_QuickBy.gameObject:SetActive(isUnlockQuickBuy)
end

function UIWhiteDayAccOrder:__OnWDTimeUpdate()
  self:UpdateWDAccTimeChange()
  self:_OnInputFieldEndEdit(self.accSelectNum)
end

function UIWhiteDayAccOrder:UpdateWDAccTimeChange()
  local leftTime = self.AWDLineData:GetInProductionLeftTime()
  local accTime = self.accSelectNum * self.ticketAccTime
  self.ui.tex_CurTime.text = TimeUtil:TimestampToTime(leftTime, false, false, true)
  self.ui.tex_SpeedupTime.text = TimeUtil:TimestampToTime(math.clamp(leftTime - accTime, 0, math.maxinteger), false, false, true)
end

function UIWhiteDayAccOrder:__AfterSelectNumChange()
  self:UpdateWDAccTimeChange()
  local numStr = tostring(self.accSelectNum)
  self.ui.inputField_count.text = numStr
  self.ui.tex_Info:SetIndex(0, numStr)
end

function UIWhiteDayAccOrder:AddOne()
  if self.accSelectNum + 1 > self.ticketNum then
    return
  end
  local leftTime = self.AWDLineData:GetInProductionLeftTime()
  local leftTimeNeedNum = math.ceil(leftTime / self.ticketAccTime)
  if leftTimeNeedNum < self.accSelectNum + 1 then
    return
  end
  AudioManager:PlayAudioById(1200)
  self.accSelectNum = self.accSelectNum + 1
  self:__AfterSelectNumChange()
end

function UIWhiteDayAccOrder:PressAdd()
  if self.accSelectNum == self.ticketNum then
    return
  end
  local pressedTime = self.ui.btn_Plus:GetPressedTime()
  local addNum = math.ceil(pressedTime * pressedTime / 5)
  local leftTime = self.AWDLineData:GetInProductionLeftTime()
  local leftTimeNeedNum = math.ceil(leftTime / self.ticketAccTime)
  if self.accSelectNum + addNum > self.ticketNum or leftTimeNeedNum < self.accSelectNum + addNum then
    local remainNum = self.ticketNum - self.accSelectNum
    addNum = math.min(remainNum, leftTimeNeedNum - self.accSelectNum)
    if addNum <= 0 then
      return
    end
  end
  AudioManager:PlayAudioById(1200)
  self.accSelectNum = self.accSelectNum + addNum
  self:__AfterSelectNumChange()
end

function UIWhiteDayAccOrder:MinusOne()
  AudioManager:PlayAudioById(1200)
  if self.accSelectNum - 1 < 0 then
    local leftTime = self.AWDLineData:GetInProductionLeftTime()
    local leftTimeNeedNum = math.ceil(leftTime / self.ticketAccTime)
    local num = math.min(self.ticketNum, leftTimeNeedNum)
    self.accSelectNum = num
    self:__AfterSelectNumChange()
    return
  end
  self.accSelectNum = self.accSelectNum - 1
  self:__AfterSelectNumChange()
end

function UIWhiteDayAccOrder:PressMinus()
  if self.accSelectNum == 0 then
    return
  end
  local pressedTime = self.ui.btn_Reduce:GetPressedTime()
  local minusNum = math.ceil(pressedTime * pressedTime / 10)
  if self.accSelectNum - minusNum <= 0 then
    self.accSelectNum = 0
  else
    self.accSelectNum = self.accSelectNum - minusNum
    AudioManager:PlayAudioById(1200)
  end
  self:__AfterSelectNumChange()
end

function UIWhiteDayAccOrder:_OnInputFieldEndEdit(value)
  local num = 0
  if type(value) == "number" then
    num = value
  elseif not string.IsNullOrEmpty(value) then
    num = tonumber(value)
  end
  local leftTime = self.AWDLineData:GetInProductionLeftTime()
  local leftTimeNeedNum = math.ceil(leftTime / self.ticketAccTime)
  if num >= self.ticketNum or num > leftTimeNeedNum then
    num = math.min(self.ticketNum, leftTimeNeedNum)
  end
  if self.accSelectNum == num then
    return
  end
  self.accSelectNum = num
  self:__AfterSelectNumChange()
end

function UIWhiteDayAccOrder:__OnClickConfirm()
  if self.accSelectNum <= 0 then
    return
  end
  local actFrameId = self.AWDData:GetActFrameId()
  local lineId = self.AWDLineData:GetWDLDLineID()
  self.AWDCtrl:WDAccLineOrder(actFrameId, self.ticketItemId, self.accSelectNum, lineId, function()
    self.accSelectNum = 0
    self:__AfterSelectNumChange()
    UIUtil.OnClickBackByUiTab(self)
  end)
end

function UIWhiteDayAccOrder:__OnClickQuickBuy()
  local ShopEnum = require("Game.Shop.ShopEnum")
  local quickBuyData = ShopEnum.eQuickBuy.whiteDayAcc
  local cfg = self.AWDData:GetWDCfg()
  local shopId = cfg.speed_shop
  local shelfId = cfg.speed_shelve
  local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  ctrl:GetShopData(shopId, function(shopData)
    local goodData = shopData.shopGoodsDic[shelfId]
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      if win == nil then
        error("can't open QuickBuy win")
        return
      end
      win:SlideIn()
      win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds)
      win:OnClickAdd(true)
    end)
  end)
end

function UIWhiteDayAccOrder:__OnItemUpdate(itemUpdate)
  if self.ticketItemId == nil or itemUpdate[self.ticketItemId] == nil then
    return
  end
  self.ticketNum = PlayerDataCenter:GetItemCount(self.ticketItemId)
  self:__RefreshItemUI()
end

function UIWhiteDayAccOrder:BackAction()
  if self.lineTimerId ~= nil then
    TimerManager:StopTimer(self.lineTimerId)
    self.lineTimerId = nil
  end
  self.accSelectNum = 0
  self:Hide()
end

function UIWhiteDayAccOrder:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDayAccOrder:OnShow()
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  base.OnShow(self)
end

function UIWhiteDayAccOrder:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  base.OnHide(self)
end

function UIWhiteDayAccOrder:OnDelete()
  if self.lineTimerId ~= nil then
    TimerManager:StopTimer(self.lineTimerId)
    self.lineTimerId = nil
  end
  base.OnDelete(self)
end

return UIWhiteDayAccOrder
