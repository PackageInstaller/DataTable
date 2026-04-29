_class("UISeasonBalanceWeightItem", UICustomWidget)
UISeasonBalanceWeightItem = UISeasonBalanceWeightItem

function UISeasonBalanceWeightItem:Constructor()
end

function UISeasonBalanceWeightItem:OnShow()
  self._have = self:GetGameObject("img")
  self._not = self:GetGameObject("not")
end

function UISeasonBalanceWeightItem:OnHide()
end

function UISeasonBalanceWeightItem:SetData(idx, have, itemid)
  self._idx = idx
  self._have:SetActive(have)
  self._not:SetActive(not have)
end
