local UISetPrivacySetType = {
  ParentAgree = 0,
  TranlateProto = 1,
  PrivacyProcy = 2,
  UserProcy = 3,
  Max = 4
}
_enum("UISetPrivacySetType", UISetPrivacySetType)
_class("UISetPrivacySetController", UIController)
UISetPrivacySetController = UISetPrivacySetController

function UISetPrivacySetController:OnShow(uiParams)
  self._item = self:GetGameObject("Item")
  self._content = self:GetGameObject("Content").transform
  for i = 0, UISetPrivacySetType.Max - 1 do
    if self:IsPrivacyShow(i) then
      local go = UnityEngine.GameObject.Instantiate(self._item, self._content)
      go:SetActive(true)
      local com = self:GetUIComponentDynamic("UISelectObjectPath", go)
      local item = com:SpawnObject("UISetPrivacySetItem")
      item:SetData(i)
    end
  end
end

function UISetPrivacySetController:IsPrivacyShow(privacySetType)
  if privacySetType == UISetPrivacySetType.ParentAgree then
    return not SDKProxy:GetInstance():IsAdult()
  elseif privacySetType == UISetPrivacySetType.TranlateProto then
    return SDKProxy:GetInstance():IsEEA()
  end
  return true
end

function UISetPrivacySetController:MaskOnClick()
  self:CloseDialog()
end
