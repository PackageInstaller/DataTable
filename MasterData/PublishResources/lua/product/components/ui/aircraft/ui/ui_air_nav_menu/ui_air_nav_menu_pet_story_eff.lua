_class("UIAirNavMenuPetStoryEff", UICustomWidget)
UIAirNavMenuPetStoryEff = UIAirNavMenuPetStoryEff

function UIAirNavMenuPetStoryEff:OnShow(uiParams)
  self._offset = Vector2(0, 180)
end

function UIAirNavMenuPetStoryEff:OnHide()
end

function UIAirNavMenuPetStoryEff:SetData(pos, size, data, isVisitPet, callback)
  self:GetComponents()
  self._size = size
  self._data = data
  self._isVisitPet = isVisitPet
  self._petid = self._data:TemplateID()
  self._petGrade = self._data:AwakeLevel()
  self._clothSkinId = self._data:ClothSkinID()
  self._pos = pos
  self._callback = callback
  self:OnValue()
end

function UIAirNavMenuPetStoryEff:OnValue()
  self._rect.anchoredPosition = self._pos + self._offset
  self._rect.sizeDelta = self._size
  local head = HelperProxy:GetInstance():GetPetHead(self._petid, self._petGrade, self._clothSkinId, PetSkinEffectPath.HEAD_ICON_AIR_STORY_TIPS)
  self._petHead:LoadImage(head)
  self._visitGo:SetActive(self._isVisitPet)
  if self._isVisitPet then
    local ownerName = self._data:GetOwnerName()
    Log.debug("###[NavMenu] ownerName --> ", ownerName)
    self._visitTex:SetText(ownerName)
  end
end

function UIAirNavMenuPetStoryEff:FlushPos(pos)
  self._pos = pos
  self._rect.anchoredPosition = self._pos + self._offset
end

function UIAirNavMenuPetStoryEff:GetComponents()
  self._petHead = self:GetUIComponent("UICircleMaskLoader", "petHead")
  self._rect = self:GetUIComponent("RectTransform", "pos")
  self._visitGo = self:GetGameObject("visitGo")
  self._visitTex = self:GetUIComponent("UILocalizationText", "ownerNameTex")
end

function UIAirNavMenuPetStoryEff:btnOnClick(go)
  if self._callback then
    self._callback(self._data)
  end
end
