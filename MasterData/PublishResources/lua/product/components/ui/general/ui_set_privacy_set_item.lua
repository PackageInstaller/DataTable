_class("UISetPrivacySetItem", UICustomWidget)
UISetPrivacySetItem = UISetPrivacySetItem

function UISetPrivacySetItem:OnShow()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._btn = self:GetUIComponent("UILocalizationText", "Btn")
  self._agreeBtn = self:GetGameObject("AgreeBtn")
  self._privacySetType = nil
end

function UISetPrivacySetItem:SetData(privacySetType)
  self._privacySetType = privacySetType
  if not self._privacySetType then
    return
  end
  self._agreeBtn:SetActive(true)
  local name = ""
  if self._privacySetType == UISetPrivacySetType.ParentAgree then
    self._agreeBtn:SetActive(false)
    name = StringTable.Get("str_set_parent_agree_name")
  elseif self._privacySetType == UISetPrivacySetType.TranlateProto then
    name = StringTable.Get("str_set_translate_proto_name")
  elseif self._privacySetType == UISetPrivacySetType.PrivacyProcy then
    name = StringTable.Get("str_set_privacy_proto_name")
  elseif self._privacySetType == UISetPrivacySetType.UserProcy then
    name = StringTable.Get("str_set_user_proto_name")
  end
  self._name.text = name
  self._btn.text = StringTable.Get("str_set_prvacy_tips1", name)
end

function UISetPrivacySetItem:AgreeBtnOnClick()
  if not self._privacySetType then
    return
  end
  if not self:CanCancelAgree() then
    return
  end
  if self._privacySetType == UISetPrivacySetType.ParentAgree then
    self:ShowDialog("UISetPrivacySetTipsController", StringTable.Get("str_set_privacy_tips_parent_agree_tips"), function()
      self:CancelAgree()
      self:Logout()
    end)
  elseif self._privacySetType == UISetPrivacySetType.TranlateProto then
    self:ShowDialog("UISetPrivacySetTipsController", StringTable.Get("str_set_privacy_tips_translate_proto_tips"), function()
      self:CancelAgree()
      SDKProxy:GetInstance():CancleEEA()
      self:Logout()
    end)
  elseif self._privacySetType == UISetPrivacySetType.PrivacyProcy then
    self:ShowDialog("UISetPrivacySetTipsController", StringTable.Get("str_set_privacy_tips_privacy_proto_tips"), function()
      self:CancelAgree()
      SDKProxy:GetInstance():CancelPrivacyProto()
      self:Logout()
    end)
  elseif self._privacySetType == UISetPrivacySetType.UserProcy then
    self:ShowDialog("UISetPrivacySetTipsController", StringTable.Get("str_set_privacy_tips_user_proto_tips"), function()
      self:CancelAgree()
      SDKProxy:GetInstance():CancelUserProto()
      self:Logout()
    end)
  end
end

function UISetPrivacySetItem:CancelAgree()
  local key = self:GetKey()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = math.floor(timeModule:GetServerTime() / 1000)
  UnityEngine.PlayerPrefs.SetInt(key, nowTime)
end

function UISetPrivacySetItem:CanCancelAgree()
  local key = self:GetKey()
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local cdTime = Cfg.cfg_global.ui_set_cancel_agree_proto_cd.IntValue
  local startTime = UnityEngine.PlayerPrefs.GetInt(key)
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = math.floor(timeModule:GetServerTime() / 1000)
  local seconds = nowTime - startTime
  local min = math.floor(seconds / 60)
  if cdTime <= min then
    return true
  end
  local remaindTime = cdTime - min
  ToastManager.ShowToast(StringTable.Get("str_set_cancel_agree_proto_in_cd", remaindTime))
  return false
end

function UISetPrivacySetItem:GetKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  return "CANCEL_AGREE_SET_PROTOCOL" .. pstId .. self._privacySetType
end

function UISetPrivacySetItem:BtnOnClick()
  if not self._privacySetType then
    return
  end
  if self._privacySetType == UISetPrivacySetType.ParentAgree then
    UnityEngine.Application.OpenURL(StringTable.Get("str_set_parent_agree_url"))
  elseif self._privacySetType == UISetPrivacySetType.TranlateProto then
    UnityEngine.Application.OpenURL(StringTable.Get("str_set_translate_proto_url"))
  elseif self._privacySetType == UISetPrivacySetType.PrivacyProcy then
    local gv = HelperProxy:GetInstance():GetGameVersion()
    if gv == GameVersionType.INTL then
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_privacy_proto_url"))
    elseif gv == GameVersionType.HMT then
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_privacy_proto_hmt_url"))
    else
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_privacy_proto_us_url"))
    end
  elseif self._privacySetType == UISetPrivacySetType.UserProcy then
    local gv = HelperProxy:GetInstance():GetGameVersion()
    if gv == GameVersionType.INTL then
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_user_proto_url"))
    elseif gv == GameVersionType.HMT then
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_user_proto_hmt_url"))
    else
      UnityEngine.Application.OpenURL(StringTable.Get("str_set_user_proto_us_url"))
    end
  end
end

function UISetPrivacySetItem:Logout()
  GameGlobal.GameLogic():BackToLogin(false, LoginModule, "un agree privacy", false)
end
