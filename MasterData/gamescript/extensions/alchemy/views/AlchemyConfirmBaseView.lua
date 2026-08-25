local ONE_PAGE_SHOW_REWARD_NUM = 6
local AlchemyConfirmBaseView, Super = NewClass("AlchemyConfirmBaseView", BaseView)

function AlchemyConfirmBaseView:ctor(confirmCb)
  Super.ctor(self)
  self.confirmCb = confirmCb
  self.showItemGroup = {}
  self:_InitViewData()
end

function AlchemyConfirmBaseView:RegisterEvents()
  self:_InitRewardListView()
end

function AlchemyConfirmBaseView:_InitRewardListView()
  local cellRT = self.ui.UI_Common_Item_WuPin_Type1.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.rewardListView = self:CreateTableview(self.ui.ScrollView_Item, function()
    if not self.showItemGroup then
      return 0
    end
    return #self.showItemGroup
  end, function(view, index)
    do return self._RewardCellAtIndex, self, view end
    return self._RewardCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self.rewardListView:ReloadData()
end

function AlchemyConfirmBaseView:_RewardCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  self:AddAlchemyItemComp(cell.gameObject, self.showItemGroup[index])
  return cell
end

function AlchemyConfirmBaseView:OnEnterView()
  Super.OnEnterView(self)
  self:_OnInitConfirmTips()
  self:_InitRewardGroup()
  self.ui.ScrollView_Item:SetActive(#self.showItemGroup > ONE_PAGE_SHOW_REWARD_NUM)
  self.ui.ScrollView_Item_1:SetActive(#self.showItemGroup <= ONE_PAGE_SHOW_REWARD_NUM)
end

function AlchemyConfirmBaseView:_InitRewardGroup()
  for i = 1, ONE_PAGE_SHOW_REWARD_NUM do
    local tmpData = self.showItemGroup[i]
    if tmpData then
      local uiName = "Image_WuPin_0" .. i
      local obj = self.ui[uiName]
      if not obj then
        obj = self:Instantiate(self.ui.Image_WuPin, self.ui.Content_1.transform)
        obj.name = uiName
      end
      self:AddAlchemyItemComp(obj, tmpData)
      obj:SetActive(true)
    end
  end
end

function AlchemyConfirmBaseView:OnExitView()
  Super.OnExitView(self)
end

return AlchemyConfirmBaseView
