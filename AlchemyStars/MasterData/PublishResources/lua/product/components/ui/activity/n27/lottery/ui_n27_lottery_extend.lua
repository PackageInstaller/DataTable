require("ui_get_item_controller")
require("ui_get_item_controller_item")
require("ui_item")
require("ui_item_node")
_class("UIN27LotteryGetItem", UIGetItemController)
UIN27LotteryGetItem = UIN27LotteryGetItem

function UIN27LotteryGetItem:Constructor()
end

function UIN27LotteryGetItem:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local count
  if table.count(self._itemList) > 5 then
    count = 5
  else
    count = table.count(self._itemList)
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN27LotteryGetItemRowItem", count)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, count do
    local giftItem = rowList[i]
    local itemIndex = self:_GetCurPageFirstIndex() + i - 1
    if itemIndex > self._listItemTotalCount then
      giftItem:GetGameObject():SetActive(false)
    else
      self:_ShowItem(giftItem, itemIndex, i)
    end
  end
  return item
end

function UIN27LotteryGetItem:_ShowItem(giftItem, index, tweenIdx)
  local beforeTime = 0
  if not self._inited then
    beforeTime = self._beforeTime
  end
  local item_data = self:_GetItemDataByIndex(index)
  if item_data then
    giftItem:SetData(item_data, index, function(id, pos)
      self:OnItemSelect(id, pos)
    end, Color(0.8705882352941177, 0.8470588235294118, 0.8235294117647058, 1), tweenIdx, beforeTime)
    giftItem:GetGameObject():SetActive(true)
  else
    giftItem:GetGameObject():SetActive(false)
  end
end

_class("UIN27LotteryGetItemRowItem", UIGetItemControllerItem)
UIN27LotteryGetItemRowItem = UIN27LotteryGetItemRowItem

function UIN27LotteryGetItemRowItem:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._anim = self:GetUIComponent("Animation", "rect")
  self._eff = self:GetGameObject("Effect")
  self._itemAlpha = self:GetUIComponent("CanvasGroup", "uiitem")
  self._index = -1
  self._pstid = -1
  self._itemCount = 0
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIN27LotteryGetItemUIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self.uiItem:SetClickCallBack(function(go)
    self:itemOnClick(go)
  end)
end

_class("UIN27LotteryGetItemUIItem", UIItem)
UIN27LotteryGetItemUIItem = UIN27LotteryGetItemUIItem

function UIN27LotteryGetItemUIItem:OnShow(uiParams)
  UIItem.OnShow(self, uiParams)
  self._nodes[UIItemNode.Normal] = UIN27ItemNormalNode:New(self:GetUIComponent("UIView", "g_normal"), self)
end

_class("UIN27ItemNormalNode", UIItemNormalNode)
UIN27ItemNormalNode = UIN27ItemNormalNode
UIN27ItemNormalNode._itemColorFrame = {
  [ItemColor.ItemColor_White] = "N27_shop_se1",
  [ItemColor.ItemColor_Green] = "N27_shop_se2",
  [ItemColor.ItemColor_Blue] = "N27_shop_se3",
  [ItemColor.ItemColor_Purple] = "N27_shop_se4",
  [ItemColor.ItemColor_Yellow] = "N27_shop_se5",
  [ItemColor.ItemColor_Golden] = "N27_shop_se6"
}

function UIN27ItemNormalNode:SetOffset(showText1)
  if showText1 then
    self._qualityRect.anchoredPosition = Vector2(0, 0)
  else
    self._qualityRect.anchoredPosition = Vector2(0, 0)
  end
end

function UIN27ItemNormalNode:SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(0, 15)
  else
    self._iconRect.anchoredPosition = Vector2(0, 20)
  end
end

function UIN27ItemNormalNode:SetQuality(quality)
  if quality <= 0 then
    self:ShowQuality(false)
    return
  end
  local atlas = self:CallUIMethod("UIN27LotteryMain", "GetSpriteAtlas")
  local qualityName = self._itemColorFrame[quality]
  if atlas ~= nil and qualityName ~= "" then
    self:ShowQuality(true)
    self._quality.sprite = atlas:GetSprite(qualityName)
  else
    self:ShowQuality(false)
  end
end

function UIN27ItemNormalNode:CallUIMethod(uiName, methodName, ...)
  return GameGlobal.UIStateManager():CallUIMethod(uiName, methodName, ...)
end
