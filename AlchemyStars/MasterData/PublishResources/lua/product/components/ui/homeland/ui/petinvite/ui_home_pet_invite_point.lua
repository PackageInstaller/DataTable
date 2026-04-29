_class("UIHomePetInvitePoint", UICustomWidget)
UIHomePetInvitePoint = UIHomePetInvitePoint

function UIHomePetInvitePoint:Constructor()
  self._atlas = self:GetAsset("UIHomelandInvite.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomePetInvitePoint:OnShow(uiParams)
  self:_GetComponents()
  self:AttachEvent(GameEventType.OnPetInvitePreview, self.Refresh)
end

function UIHomePetInvitePoint:OnHide()
  self:DetachEvent(GameEventType.OnPetInvitePreview, self.Refresh)
end

function UIHomePetInvitePoint:_GetComponents()
  self._selectImg = self:GetUIComponent("Image", "SelectImg")
  self._invitePointIndex = self:GetUIComponent("UILocalizationText", "InvitePointIndex")
  self._petIcon = self:GetUIComponent("RawImageLoader", "PetIcon")
  self._petIconGo = self:GetGameObject("PetIcon")
  self._removeBtnGo = self:GetGameObject("RemoveBtn")
end

function UIHomePetInvitePoint:SetData(inviteManager, index, pet, callback)
  self._inviteManager = inviteManager
  self._index = index
  self._callback = callback
  self._invitePointIndex:SetText(self._index)
  self:SetPetInfo(pet)
end

function UIHomePetInvitePoint:AddBtnOnClick(go)
  if not self._pet then
    self:OnSelect()
  end
end

function UIHomePetInvitePoint:RemoveBtnOnClick(go)
  if self._pet then
    self._inviteManager:InviteEnterListPreview(self._pet, false)
    self:SetPetInfo(nil)
    self.uiOwner:DefaultSelect()
    self._inviteManager:UpdateInvitedPets(self._index, nil)
  end
end

function UIHomePetInvitePoint:Refresh(pet, enter)
  if not self._pet then
    return
  end
  if not pet or pet:TemplateID() ~= self._pet:TemplateID() or enter then
  else
    self:SetPetInfo(nil)
    self.uiOwner:DefaultSelect()
    self._inviteManager:UpdateInvitedPets(self._index, nil)
  end
end

function UIHomePetInvitePoint:RefreshSelectImg(selected)
  if selected then
    self._selectImg.sprite = self._atlas:GetSprite("N17_hudong_icon06_02")
  else
    self._selectImg.sprite = self._atlas:GetSprite("N17_hudong_icon06_01")
  end
end

function UIHomePetInvitePoint:SetPetInfo(pet)
  self._pet = pet
  if self._pet then
    local icon
    if self._pet._clothSkinID ~= nil then
      local headicon = Cfg.cfg_pet_skin[self._pet._clothSkinID]
      icon = headicon.Head
    else
      icon = "head1_" .. self._pet._tmpID
    end
    self._petIcon:LoadImage(icon)
  end
  local selected = self._pet ~= nil
  self._petIconGo:SetActive(selected)
  self._removeBtnGo:SetActive(selected)
end

function UIHomePetInvitePoint:GetPet()
  return self._pet
end

function UIHomePetInvitePoint:GetIndex()
  return self._index
end

function UIHomePetInvitePoint:OnSelect()
  self:RefreshSelectImg(true)
  self._callback(self)
end
