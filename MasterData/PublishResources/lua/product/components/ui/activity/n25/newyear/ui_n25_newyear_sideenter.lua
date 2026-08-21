_class("UIN25NewYearSideEnter", UICustomWidget)
UIN25NewYearSideEnter = UIN25NewYearSideEnter

function UIN25NewYearSideEnter:Constructor()
end

function UIN25NewYearSideEnter:OnShow(uiParams)
  self:_GetComponents()
end

function UIN25NewYearSideEnter:_GetComponents()
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._red = self:GetGameObject("red")
  self._new = self:GetGameObject("new")
end

function UIN25NewYearSideEnter:SetData()
end

function UIN25NewYearSideEnter:BtnOnClick(go)
  local open = self._campaign:CheckCampaignOpen()
  if not open then
    self.root:SetActive(open)
    self._setShowCallback(open)
    ToastManager.ShowToast(StringTable.Get("str_n25_newyear_close"))
    return
  end
  self:ShowDialog("UIN25NewYear")
end

function UIN25NewYearSideEnter:OnSideEnterLoad(TT, setShowCallback, setNewRedCallback)
  self._setShowCallback = setShowCallback
  self._setNewRedCallback = setNewRedCallback
  self.root = self:GetGameObject()
  self:Lock("UIN25NewYearSideEnter")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self:UnLock("UIN25NewYearSideEnter")
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

function UIN25NewYearSideEnter:GetSideEnterRawImage()
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  return cfg and cfg.SideEnterIcon
end
