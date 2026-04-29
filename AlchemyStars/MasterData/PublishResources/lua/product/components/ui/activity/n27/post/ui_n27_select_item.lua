_class("UIN27SelectItem", UICustomWidget)
UIN27SelectItem = UIN27SelectItem

function UIN27SelectItem:InitWidget()
  self._atlas = self:GetAsset("PostInGame.spriteatlas", LoadType.SpriteAtlas)
  self._nameText = self:GetUIComponent("UILocalizationText", "nameText")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
  self._iconRawImage = self:GetUIComponent("RawImageLoader", "icon")
  self._thumbImage = self:GetUIComponent("Image", "thumb")
  self._btnObj = self:GetGameObject("btn")
  self._anim = self:GetUIComponent("Animation", "anim")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnObj), UIEvent.Press, function(go)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN27PostGameItemPress, self)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnObj), UIEvent.Release, function(go)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN27PostGameItemRelease, self)
  end)
end

function UIN27SelectItem:OnValue()
  self._nameText:SetText(StringTable.Get(self._name))
  self._countText.text = self._count .. ""
  self._iconRawImage:LoadImage(self._icon)
  self._thumbImage.sprite = self._atlas:GetSprite(self._thumbIcon)
end

function UIN27SelectItem:PlayShowAnimation()
  self._anim:Play("uieff_UIN27SelectItem_in")
end

function UIN27SelectItem:SetData(cfg)
  self._cfg = cfg
  self._name = cfg.ItemName
  self._icon = cfg.ItemIcon
  self._thumbIcon = cfg.ItemThumbIcon
  self._count = cfg.ItemNumLimit
  self._id = cfg.ID
  self:InitWidget()
  self:OnValue()
end

function UIN27SelectItem:GetItemCount()
  return self._count
end

function UIN27SelectItem:GetItemID()
  return self._id
end
