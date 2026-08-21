_class("UIN27SelectItemTypeItem", UICustomWidget)
UIN27SelectItemTypeItem = UIN27SelectItemTypeItem

function UIN27SelectItemTypeItem:InitWidget()
  self._allObj = self:GetGameObject("AllObj")
  self._otherObj = self:GetGameObject("OtherObj")
  if self._typeID == 99 then
    self._select = self:GetGameObject("allSelect")
    self._unSelect = self:GetGameObject("allUnSelect")
  else
    self._unSelectImage = self:GetUIComponent("Image", "unSelectImage")
    self._selectImage = self:GetUIComponent("Image", "selectImage")
    self._select = self:GetGameObject("select")
    self._unSelect = self:GetGameObject("unSelect")
  end
  self._atlas = self:GetAsset("PostInGame.spriteatlas", LoadType.SpriteAtlas)
end

function UIN27SelectItemTypeItem:SetData(typeID, bgImg, selectImg)
  self._typeID = typeID
  self._bgImg = bgImg
  self._selectImg = selectImg
  self:AttachEvent(GameEventType.OnN27PostGameItemTypeChange, self.OnSelect)
  self:InitWidget()
  self:OnValue()
end

function UIN27SelectItemTypeItem:OnValue()
  if self._typeID == 99 then
    self._allObj:SetActive(true)
  else
    self._otherObj:SetActive(true)
    self._unSelectImage.sprite = self._atlas:GetSprite(self._bgImg)
    self._selectImage.sprite = self._atlas:GetSprite(self._selectImg)
  end
end

function UIN27SelectItemTypeItem:BgOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN27PostGameItemTypeChange, self._typeID)
end

function UIN27SelectItemTypeItem:OnSelect(typeID)
  self._select:SetActive(typeID == self._typeID)
  self._unSelect:SetActive(typeID ~= self._typeID)
end

function UIN27SelectItemTypeItem:OnHide()
  self:DetachEvent(GameEventType.OnN27PostGameItemTypeChange, self.OnSelect)
end
