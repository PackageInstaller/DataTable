local ActivityTurntableItem, Super = System.NewComponent("ActivityTurntableItem")

function ActivityTurntableItem:ctor(res, turntableTid, idx, rewardList)
  Super.ctor(self)
  self.ui = UI_Events_Item_ClotherLotteryGroupResource(res)
  self.turntableTid = turntableTid
  self.idx = idx
  self.rewardList = rewardList
end

function ActivityTurntableItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_PrizeInfo, function()
    local leftNum = self:GetLeftNum()
    local maxNum = self:GetMaxNum()
    do return LT.Text end
    return LT.Text, "PrizeNum" .. self.idx + 1, self.idx + 1
  end)
  self:BindRewards()
end

function ActivityTurntableItem:GetMaxNum()
  local maxNum = 0
  for _, item in ipairs(self.rewardList) do
    maxNum = maxNum + TurntableDataUtils.GetCfgMaxDropNum(self.turntableTid, item.dropItemId)
  end
  return maxNum
end

function ActivityTurntableItem:GetLeftNum()
  local leftNum = 0
  for _, item in ipairs(self.rewardList) do
    leftNum = leftNum + TurntableDataUtils.GetDropLeftNum(self.turntableTid, item.dropItemId)
  end
  return leftNum
end

function ActivityTurntableItem:BindRewards()
  local rewardGo = self.ui.UI_Event_Item_ClotherLottery
  local containerTf = self.ui.Group_PrizeCon.transform
  for i, item in ipairs(self.rewardList) do
    local itemGo = 1 == i and rewardGo
    if i > 1 then
      itemGo = self.binder:Instantiate(rewardGo, containerTf)
    end
    local itemResUI = UI_Event_Item_ClotherLotteryResource(itemGo)
    self.binder:SetImage(itemResUI.Image_Icon, ItemDataUtils.GetIcon(item.itemTid))
    self.binder:SetImage(itemResUI.Image_Quality, ItemDataUtils.GetQualityIcon(item.itemTid))
    self.binder:SetText(itemResUI.Text_Count, item.itemCount)
    self.binder:BindButtonClick(itemResUI.Btn_Click, function()
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, item.itemTid)
    end)
    self.binder:BindToText(itemResUI.Text_RemainCount, function()
      do return LT.Textf, "Event_ItemUseLeftCnt", TurntableDataUtils.GetDropLeftNum(self.turntableTid, item.dropItemId) end
      return LT.Textf, "Event_ItemUseLeftCnt", TurntableDataUtils.GetDropLeftNum(self.turntableTid, item.dropItemId)
    end)
    self.binder:BindToVisible(itemResUI.Image_Get, function()
      do return TurntableDataUtils.IsGot, self.turntableTid end
      return TurntableDataUtils.IsGot, self.turntableTid, item.dropItemId
    end)
  end
end

return ActivityTurntableItem
