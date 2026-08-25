local ChristmasOptionGiftItem, Super = NewClass("ChristmasOptionGiftItem", ViewComponent)
local Vector2 = CS.UnityEngine.Vector2

function ChristmasOptionGiftItem:ctor(uiNode, view, data, itemType2GameObject)
  Super.ctor(self, uiNode, view)
  self.ui = UIBaseResource(uiNode)
  self.data = data
  self.itemType2GameObject = itemType2GameObject
end

function ChristmasOptionGiftItem:RegisterNotifications()
end

function ChristmasOptionGiftItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:_CreateItemTableView()
end

function ChristmasOptionGiftItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshView()
end

function ChristmasOptionGiftItem:_CreateItemTableView()
  local itemGameObj = self.itemType2GameObject
  local sizeDelta = itemGameObj.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._itemTableView = self:CreateTableview(self.ui.ItemView, function()
    return #self.data.dropDataList
  end, function(view, index)
    do return self._FillItem, self, view end
    return self._FillItem, self, view, index
  end, function()
    return w, h
  end)
  self._itemTableView.cellOffset = Vector2(7, -3)
end

function ChristmasOptionGiftItem:_FillItem(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.itemType2GameObject)
  local dropData = self.data.dropDataList[index]
  if dropData then
    local viewData = {
      itemTid = dropData.DropItem,
      itemCount = dropData.DropNum or 1,
      clickFunc = function()
        self:OnItemClick(index, true)
      end,
      subSelectFunc = function()
        self:OnItemClick(index, false)
      end,
      isSubSelect = self:IsSelected(index)
    }
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
  end
  return cell
end

function ChristmasOptionGiftItem:OnItemClick(index, isSelect)
  local dropData = self.data.dropDataList[index]
  if not dropData then
    return
  end
  if isSelect then
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, dropData.DropItem, true, {posX = 60})
  end
  if self.data.isFixedDrop then
    return
  end
  local giftIndex = self.data.giftIndex
  if not isSelect then
    index = nil
  end
  self.data.selectedItemIndex = index
  self:_RefreshView()
  self:Notify(NotifyId.OnChristmasItemChoose, giftIndex, index)
end

function ChristmasOptionGiftItem:IsSelected(index)
  return self.data.selectedItemIndex == index
end

function ChristmasOptionGiftItem:_RefreshView()
  local giftTypeText = self.data.isFixedDrop and LT.Text("MultiSelectBox_FixItemTitle") or LT.Text("MultiSelectBox_SelectItemTitle")
  self:SetText(self.ui.Text_Name, giftTypeText)
  self._itemTableView:ReloadData()
  self:SetActive(self.ui.Image_Seleted, self.data.selectedItemIndex ~= nil or self.data.isFixedDrop)
  self:SetText(self.ui.Text_Index, self.data.giftIndex)
  self:SetActive(self.ui.Text_FixTips, self.data.isFixedDrop)
  self:SetText(self.ui.Text_FixTips, LT.TipsText("MultiSelectBox_FixItemTips"))
end

function ChristmasOptionGiftItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return ChristmasOptionGiftItem
