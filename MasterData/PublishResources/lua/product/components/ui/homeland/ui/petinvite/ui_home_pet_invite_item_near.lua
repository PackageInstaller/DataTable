_class("UIHomePetInviteItemNear", UICustomWidget)
UIHomePetInviteItemNear = UIHomePetInviteItemNear
local PetInviteItemState = {
  Allow = 1,
  OutRange = 2,
  EventNeed = 3
}
_enum("PetInviteItemState", PetInviteItemState)

function UIHomePetInviteItemNear:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomePetInviteItemNear:OnShow(uiParams)
  self:GetComponent()
end

function UIHomePetInviteItemNear:OnHide()
end

function UIHomePetInviteItemNear:GetComponent()
  self._state = self:GetUIComponent("Image", "state")
  self._remove = self:GetGameObject("remove")
  self._headimg = self:GetUIComponent("RawImageLoader", "head")
  self._maskimg = self:GetGameObject("mask")
end

function UIHomePetInviteItemNear:SetData(index, data, inviteManager, atlas)
  self._index = index
  self._pet = data
  self._inviteManager = inviteManager
  self._atlas = atlas
  self._inviteItemState = PetInviteItemState.Allow
  self:RefreshUI()
end

function UIHomePetInviteItemNear:RefreshUI()
  local sp = "N17_hudong_icon02"
  if self._inviteManager:CheckIsBusy(self._pet) then
    sp = "N17_hudong_icon04"
  end
  if not self._inviteManager:CheckIsNear(self._pet) then
    sp = "N17_hudong_icon03"
  end
  local petId
  if self._pet._clothSkinID ~= nil then
    local headicon = Cfg.cfg_pet_skin[self._pet._clothSkinID]
    petId = headicon.Head
  else
    petId = "head1_" .. self._pet._tmpID
  end
  self._headimg:LoadImage(petId)
  self._state.sprite = self._atlas:GetSprite(sp)
  local toofar = self._inviteManager:CheckIsNear(self._pet)
  self._canInteract = self._inviteManager:CheckCurInteractPoint(self._pet)
  self._maskimg:SetActive(not toofar or not self._canInteract)
end

function UIHomePetInviteItemNear:AddOnClick()
  if not self._inviteManager:CheckIsNear(self._pet) then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_invite_toofar"))
    return
  end
  if self._inviteManager:CheckIsBusy(self._pet) then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_invite_busy"))
    return
  end
  if not self._canInteract then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_invite_point_invalid"))
    return
  end
  local pet = self._pet
  self.uiOwner:OnClickPet(pet)
  self._inviteManager:InviteEnterListPreview(pet, true)
end
