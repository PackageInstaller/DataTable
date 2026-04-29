_class("UIHomePetFollowItem", UICustomWidget)
UIHomePetFollowItem = UIHomePetFollowItem

function UIHomePetFollowItem:OnShow(uiParams)
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.select = self:GetGameObject("select")
  self.using = self:GetGameObject("using")
  self:AttachEvent(GameEventType.OnHomePetFollowClick, self.OnHomePetFollowClick)
end

function UIHomePetFollowItem:SetData(idx, shape, usingType, currentType, callback)
  self._callback = callback
  self._idx = idx
  self._shape = shape
  self._type = self._shape.Type
  self.icon:LoadImage(self._shape.Icon)
  self:Using(usingType == self._type)
  self:Select(currentType == self._type)
end

function UIHomePetFollowItem:OnHomePetFollowClick(type)
  self:Select(type == self._type)
end

function UIHomePetFollowItem:Using(using)
  self.using:SetActive(using)
end

function UIHomePetFollowItem:Select(select)
  self.select:SetActive(select)
end

function UIHomePetFollowItem:BgOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end
