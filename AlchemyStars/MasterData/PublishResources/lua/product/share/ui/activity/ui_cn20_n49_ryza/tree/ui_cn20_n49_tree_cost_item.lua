_class("UICN20N49CostItem", UICustomWidget)
UICN20N49CostItem = UICN20N49CostItem

function UICN20N49CostItem:OnShow()
  self:AttachEvent(GameEventType.ItemCountChanged, self.ShowTex)
end

function UICN20N49CostItem:SetData(id, callback)
  self._numberTex = self:GetUIComponent("UILocalizationText", "number")
  self._icon = self:GetUIComponent("Image", "icon")
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._id = id
  self._callback = callback
  self:ShowTex()
end

function UICN20N49CostItem:ShowTex()
  local number = self._itemModule:GetItemCount(self._id)
  self._numberTex:SetText(number)
  self._icon.sprite = self.uiCommonAtlas:GetSprite("toptoon_" .. self._id)
end

function UICN20N49CostItem:IconOnClick(go)
  if self._callback then
    self._callback(self._id, go)
  end
end
