local UISetUserInfoType = {
  OpenSource = 0,
  PrivacyProto = 1,
  UserProto = 2,
  DataCopy = 3,
  PrivacySet = 4,
  AgeConfirm = 5,
  Live2DUserDes = 6,
  Max = 7
}
_enum("UISetUserInfoType", UISetUserInfoType)
_class("UISetUserInfoItem", UICustomWidget)
UISetUserInfoItem = UISetUserInfoItem

function UISetUserInfoItem:OnShow()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._userInfoType = nil
end

function UISetUserInfoItem:SetData(userInfoType)
  self._userInfoType = userInfoType
  if not self._userInfoType then
    return
  end
  local name = ""
  if self._userInfoType == UISetUserInfoType.OpenSource then
    name = StringTable.Get("str_set_user_info_open_source_name")
  elseif self._userInfoType == UISetUserInfoType.PrivacyProto then
    name = StringTable.Get("str_set_user_info_privacy_proto_name")
  elseif self._userInfoType == UISetUserInfoType.UserProto then
    name = StringTable.Get("str_set_user_info_user_proto_name")
  elseif self._userInfoType == UISetUserInfoType.DataCopy then
    name = StringTable.Get("str_set_user_info_data_copy_name")
  elseif self._userInfoType == UISetUserInfoType.PrivacySet then
    name = StringTable.Get("str_set_user_info_privacy_set")
  elseif self._userInfoType == UISetUserInfoType.AgeConfirm then
    name = StringTable.Get("str_set_user_info_age_confirm_name")
  elseif self._userInfoType == UISetUserInfoType.Live2DUserDes then
    name = StringTable.Get("str_set_live2d_user_des")
  end
  self._name:SetText(name)
end

function UISetUserInfoItem:BgOnClick()
  if not self._userInfoType then
    return
  end
  if self._userInfoType == UISetUserInfoType.OpenSource then
    UnityEngine.Application.OpenURL(StringTable.Get("str_set_open_source_url"))
  elseif self._userInfoType == UISetUserInfoType.PrivacyProto then
    local gv = HelperProxy:GetInstance():GetGameVersion()
    if gv == GameVersionType.INTL then
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_privacy_proto_url"))
    elseif gv == GameVersionType.HMT then
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_privacy_proto_hmt_url"))
    else
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_privacy_proto_us_url"))
    end
  elseif self._userInfoType == UISetUserInfoType.UserProto then
    local gv = HelperProxy:GetInstance():GetGameVersion()
    if gv == GameVersionType.INTL then
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_user_proto_url"))
    elseif gv == GameVersionType.HMT then
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_user_proto_hmt_url"))
    else
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_user_proto_us_url"))
    end
  elseif self._userInfoType == UISetUserInfoType.DataCopy then
    self:ShowDialog("UISetDataCopyController")
  elseif self._userInfoType == UISetUserInfoType.PrivacySet then
    self:ShowDialog("UISetPrivacySetController")
  elseif self._userInfoType == UISetUserInfoType.AgeConfirm then
    self:ShowDialog("UISetAgeConfirmController")
  elseif self._userInfoType == UISetUserInfoType.Live2DUserDes then
    UnityEngine.Application.OpenURL("https://www.live2d.com/zh-CHS/about/?algorithm=itop&encode=2&os=2&ts=1694595427&version=5.31.000.7553&seq=16277-9C1978F7-E455-4646-AE6B-39DBF3C0CDAF-1694595427-232&sig=a1cfafeb4513a8ee47a8f8fae7e1836a6")
  end
end
