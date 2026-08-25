local CompActivityDrawPrizeReward, Super = NewViewComponent("CompActivityDrawPrizeReward")

function CompActivityDrawPrizeReward:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Event_Activity_Thing_ItemResource(uiNode)
  self.drawPrizeData = data.drawPrizeData or {}
end

function CompActivityDrawPrizeReward:OnEnterComponent()
  self:Refresh(self.drawPrizeData)
end

function CompActivityDrawPrizeReward:Refresh(drawPrizeData)
  local tid = drawPrizeData.tid
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, tid)
  end)
  local showDropNum = 1 ~= drawPrizeData.dropNum and ItemNumUtils.GetStr(drawPrizeData.dropNum) or ""
  self:SetText(self.ui.Text_Name, string.format("%s%s", LT.Text(ItemDataUtils.GetItemName(tid)), showDropNum))
  self:SetImage(self.ui.Image_Icon_1, ItemDataUtils.GetIcon(tid))
  self:SetImage(self.ui.Image_Quality, DT.ItemQuality[DT.Item[tid].Quality].BlackBgBottomQualityFrame)
  local remain, limit = drawPrizeData.remain or 0, drawPrizeData.limit or 0
  if 0 == limit then
    self.ui.Sold_Out:SetActive(false)
    self.ui.Image_Quantity:SetActive(false)
    self:SetText(self.ui.Text_Quantity, LT.Text("ActivityExtraDropTimes"))
  else
    self.ui.Sold_Out:SetActive(0 == remain)
    self.ui.Image_Quantity:SetActive(true)
    self:SetText(self.ui.Text_Quantity, LT.Textf("LotteryProgressText", remain, limit))
  end
end

function CompActivityDrawPrizeReward:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompActivityDrawPrizeReward
