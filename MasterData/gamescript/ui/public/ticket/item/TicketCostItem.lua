local TicketCostItem, Super = System.NewComponent("TicketCostItem")

function TicketCostItem:ctor(res)
  Super.ctor(self)
  self.ui = Item_Key_RevertResource(res)
  self.restoreLeftTime = PlayerDataUtils.GetTicketRestoreLeftTime()
  self.costNum = 1
end

function TicketCostItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.ShowTips))
  binder:BindToRaw(function(_, nVal)
    if not nVal then
      return
    end
    local nextTicketShow = "--"
    if nVal > 0 then
      nextTicketShow = nVal - self.costNum
    end
    binder:SetText(self.ui.Text_Key_All, nVal)
    binder:SetText(self.ui.Text_Key_Next, nextTicketShow)
    self:SetCounterText()
  end, function()
    local itemData = ItemDataUtils.GetItemByTid(CommonDefine.CurrencyType.Ticket)
    local num = itemData and itemData.num or 0
    return num
  end)
  self:SetCounterText()
  self.timer = binder:BindTimer(1, -1, function()
    self.restoreLeftTime = self.restoreLeftTime - 1
    if self.restoreLeftTime < 0 then
      self.restoreLeftTime = 0
    end
    self:SetCounterText()
  end)
  binder:BindToRaw(function(_, nVal)
    if not nVal then
      return
    end
    self.restoreLeftTime = PlayerDataUtils.GetTicketRestoreLeftTime()
  end, function()
    return DataCenter.playerData.DRole.ticketRestoredTimestamp or 0
  end)
end

function TicketCostItem:ShowTips()
  local binder = self.binder
  local data = {
    configId = CommonDefine.CurrencyType.Ticket,
    isItem = true,
    rootGameObject = self.ui.uiNode,
    autoAdjustPos = true
  }
  binder:BindNewComponentWithMask(UIManager.GetTipPopRoot(), ItemObjectTip, Item_Public_Object_TipResource, data)
end

function TicketCostItem:SetCounterText()
  local binder = self.binder
  local showStr = self:GetCounterStr()
  binder:SetText(self.ui.Text_Revert, showStr)
end

function TicketCostItem:GetCounterStr()
  local showStr = ""
  local restoreMaxNum = PlayerDataUtils.GetMaxTicketRestoreNum()
  if restoreMaxNum <= 0 or restoreMaxNum <= PlayerDataUtils.GetTicketNum() then
    return showStr
  end
  if not self.restoreLeftTime or type(self.restoreLeftTime) ~= "number" then
    return showStr
  end
  if self.restoreLeftTime <= 0 then
    return showStr
  end
  local showTime = TimeUtils.format(self.restoreLeftTime, CommonDefine.TimeParseType.hms)
  showStr = LT.Textf("Ticket_Countdown_Str", showTime)
  return showStr
end

return TicketCostItem
