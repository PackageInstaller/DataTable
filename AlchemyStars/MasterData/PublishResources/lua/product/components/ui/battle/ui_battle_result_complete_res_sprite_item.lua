_class("UIBattleResultCompleteResSpriteItem", UICustomWidget)
UIBattleResultCompleteResSpriteItem = UIBattleResultCompleteResSpriteItem

function UIBattleResultCompleteResSpriteItem:Constructor()
end

function UIBattleResultCompleteResSpriteItem:OnShow()
  self._icon = self:GetUIComponent("Image", "icon")
end

function UIBattleResultCompleteResSpriteItem:OnHide()
end

function UIBattleResultCompleteResSpriteItem:SetData(index, sprite, win)
  self._icon.sprite = sprite
end
