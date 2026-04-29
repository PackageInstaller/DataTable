require("ui_side_enter_item_campaign")
_class("UIN31SecondAnniversarySideEnter", UISideEnterItem_Campaign)
UIN31SecondAnniversarySideEnter = UIN31SecondAnniversarySideEnter

function UIN31SecondAnniversarySideEnter:OnShow(uiParams)
  self:_GetComponents()
end

function UIN31SecondAnniversarySideEnter:_GetComponents()
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._red = self:GetGameObject("red")
  self._new = self:GetGameObject("new")
end

function UIN31SecondAnniversarySideEnter:BtnOnClick(go)
  local open = self._campaign:CheckCampaignOpen()
  if not open then
    self.root:SetActive(open)
    self._setShowCallback(open)
    ToastManager.ShowToast(StringTable.Get("str_n31_second_anniversary_sign_over"))
    return
  end
  self:ShowDialog("UIN31SecondAnniversaryController")
end

function UIN31SecondAnniversarySideEnter:OnSideEnterLoad(TT, setShowCallback, setNewRedCallback)
  self._setShowCallback = setShowCallback
  self._setNewRedCallback = setNewRedCallback
  self.root = self:GetGameObject()
  self:Lock("UIN31SecondAnniversarySideEnter")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N31_ANNIVERSARY)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self:UnLock("UIN31SecondAnniversarySideEnter")
  if res and not res:GetSucc() then
    self.root:SetActive(false)
    self._setShowCallback(false)
    return
  end
  self.root:SetActive(true)
  self._setShowCallback(true)
  self._red:SetActive(false)
  self._setNewRedCallback(false, false)
end

function UIN31SecondAnniversarySideEnter:GetSideEnterRawImage()
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  return cfg and cfg.SideEnterIcon
end
