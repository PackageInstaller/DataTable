_class("UIHomePetInviteItem", UICustomWidget)
UIHomePetInviteItem = UIHomePetInviteItem

function UIHomePetInviteItem:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomePetInviteItem:OnShow(uiParams)
  self:GetComponent()
end

function UIHomePetInviteItem:OnHide()
end

function UIHomePetInviteItem:GetComponent()
  self._state = self:GetGameObject("state")
  self._remove = self:GetGameObject("remove")
  self._headimg = self:GetUIComponent("RawImageLoader", "head")
end

function UIHomePetInviteItem:SetData(index, pet, invitemanager, atlas)
  self._index = index
  self._invitemanager = invitemanager
  self._atlas = atlas
  self._data = pet
  self:RefreshUI()
end

function UIHomePetInviteItem:RefreshUI()
  local petId
  if not self._data then
    return
  end
  if self._data._skinID ~= nil then
    petId = "head1_" .. self._data._skinID
  else
    petId = "head1_" .. self._data._tmpID
  end
  self._headimg:LoadImage(petId)
  local isbusy = self._invitemanager:CheckIsBusy(self._data)
  self._state:SetActive(isbusy)
  self._remove:SetActive(not isbusy)
end

function UIHomePetInviteItem:BtnOnClick(go)
  local isbusy = self._invitemanager:CheckIsBusy(self._data)
  if isbusy then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_invite_item_busy"))
    return
  end
end

function UIHomePetInviteItem:RemoveOnClick(go)
  self._invitemanager:InviteEnterListPreview(self._data, false)
end
