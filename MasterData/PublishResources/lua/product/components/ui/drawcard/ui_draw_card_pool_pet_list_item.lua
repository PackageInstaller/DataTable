_class("UIDrawCardPoolPetListItem", UICustomWidget)
UIDrawCardPoolPetListItem = UIDrawCardPoolPetListItem

function UIDrawCardPoolPetListItem:Constructor()
end

function UIDrawCardPoolPetListItem:OnShow(uiParams)
  self:InitWidget()
end

function UIDrawCardPoolPetListItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
end

function UIDrawCardPoolPetListItem:SetData(tmpID, icon)
  self.ID = tmpID
  if icon then
    self.icon:LoadImage(icon)
  end
end

function UIDrawCardPoolPetListItem:iconOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self.ID)
end
