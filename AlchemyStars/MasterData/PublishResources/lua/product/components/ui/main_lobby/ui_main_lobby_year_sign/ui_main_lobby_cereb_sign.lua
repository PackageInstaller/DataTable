_class("UIMainLobbyCerebSign", UICustomWidget)
UIMainLobbyCerebSign = UIMainLobbyCerebSign

function UIMainLobbyCerebSign:OnShow()
  self._go = self:GetGameObject("go")
  self._campType = ECampaignType.CAMPAIGN_TYPE_ANNIVERSARY
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._pstid = self._roleModule:GetPstId()
  self._red = self:GetGameObject("red")
  self._new = self:GetGameObject("new")
end

function UIMainLobbyCerebSign:OnAfterUILayerChanged()
  self:SetData()
end

function UIMainLobbyCerebSign:SetData()
  self._sampleInfo = self._campModule:GetSampleByType(self._campType)
  local svrTime = self._svrTimeModule:GetServerTime() * 0.001
  local show = false
  if self._sampleInfo and self._sampleInfo:IsShow(svrTime) then
    show = true
  end
  self._go:SetActive(show)
  if show then
    local new = self._sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
    local red = self._sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
    self._new:SetActive(new)
    self._red:SetActive(not new and red)
  end
end

function UIMainLobbyCerebSign:BtnOnClick(go)
  local svrTime = self._svrTimeModule:GetServerTime() * 0.001
  if self._sampleInfo and self._sampleInfo:IsShow(svrTime) then
    self:ShowDialog("UIActivityAnniversaryLoginController")
  else
    local tips = StringTable.Get("str_activity_common_notice_content")
    ToastManager.ShowToast(tips)
  end
end
