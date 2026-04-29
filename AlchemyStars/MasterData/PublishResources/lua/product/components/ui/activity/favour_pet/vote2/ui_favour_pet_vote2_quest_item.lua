_class("UIFavourPetVote2QuestItem", UICustomWidget)
UIFavourPetVote2QuestItem = UIFavourPetVote2QuestItem

function UIFavourPetVote2QuestItem:SetData(roleAsset, isFin, tipsCallback)
  self._roleAsset = roleAsset
  self._tipsCallback = tipsCallback
  self:_SetItem(roleAsset)
  self:GetGameObject("_isFin"):SetActive(isFin)
end

function UIFavourPetVote2QuestItem:_SetItem(roleAsset)
  UIWidgetHelper.SetItemIcon(self, roleAsset.assetid, "_icon")
  UIWidgetHelper.SetLocalizationText(self, "_txtCount", roleAsset.count)
end

function UIFavourPetVote2QuestItem:IconOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end
