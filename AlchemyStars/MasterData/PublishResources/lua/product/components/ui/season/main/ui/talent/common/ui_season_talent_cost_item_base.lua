_class("UISeasonTalentCostItemBase", UICustomWidget)
UISeasonTalentCostItemBase = UISeasonTalentCostItemBase

function UISeasonTalentCostItemBase:OnShow()
  self:AttachEvent(GameEventType.ItemCountChanged, self.ShowTex)
end

function UISeasonTalentCostItemBase:SetData(id, callback)
  self._numberTex = self:GetUIComponent("UILocalizationText", "number")
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._id = id
  self._callback = callback
  self:ShowTex()
end

function UISeasonTalentCostItemBase:ShowTex()
  local number = self._itemModule:GetItemCount(self._id)
  self._numberTex:SetText(number)
end

function UISeasonTalentCostItemBase:IconOnClick(go)
  if self._callback then
    self._callback(self._id, go)
  end
end
