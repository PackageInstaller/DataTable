_class("UIN17GetItemController", UIGetItemController)
UIN17GetItemController = UIN17GetItemController

function UIN17GetItemController:_ShowItem(giftItem, index, tweenIdx)
  local beforeTime = 0
  if not self._inited then
    beforeTime = self._beforeTime
  end
  local item_data = self:_GetItemDataByIndex(index)
  if item_data then
    giftItem:SetData(item_data, index, function(id, pos)
      self:OnItemSelect(id, pos)
    end, Color(0.40784313725490196, 0.40784313725490196, 0.40784313725490196, 1), tweenIdx, beforeTime)
    giftItem:GetGameObject():SetActive(true)
  else
    giftItem:GetGameObject():SetActive(false)
  end
end
