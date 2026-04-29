_class("UIN48MainLobbyEntry", UICustomWidget)
UIN48MainLobbyEntry = UIN48MainLobbyEntry

function UIN48MainLobbyEntry:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN48MainLobbyEntry:SetData(sampleInfo, controller)
  self:_InitWidget()
  self:_RefView()
end

function UIN48MainLobbyEntry:_InitWidget()
  self._redPoint = self:GetGameObject("_redPoint")
  self._newFlag = self:GetGameObject("_newFlag")
  self.shopText = self:GetGameObject("shopText")
  self.lineText = self:GetGameObject("lineText")
  self.blackText = self:GetGameObject("blackText")
  self.gameText = self:GetGameObject("gameText")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "shot")
end

function UIN48MainLobbyEntry:_RefView()
  self:StartTask(self._SetState, self)
end

function UIN48MainLobbyEntry:_SetState(TT)
  self.shopText:SetActive(false)
  self.lineText:SetActive(false)
  self.blackText:SetActive(false)
  self.gameText:SetActive(false)
  self:Lock("UIN48MainLobbyEntry")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N48)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res:GetSucc() then
    local process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N48)
    local showNew = process:GetEntryNew()
    local showredPoint = process:GetEntryRedDot()
    self._newFlag:SetActive(showNew)
    self._redPoint:SetActive(showredPoint and not showNew)
    if UIActivityN48Helper.CheckComponentStatus(process:GetComponent(UIActivityN48Helper.GetComponentId("game"))) == ActivityN48ComponentStatus.Open then
      self.gameText:SetActive(true)
      self:UnLock("UIN48MainLobbyEntry")
      return
    elseif UIActivityN48Helper.CheckComponentStatus(process:GetComponent(UIActivityN48Helper.GetComponentId("black"))) == ActivityN48ComponentStatus.Open then
      self.blackText:SetActive(true)
      self:UnLock("UIN48MainLobbyEntry")
      return
    elseif UIActivityN48Helper.CheckComponentStatus(process:GetComponent(UIActivityN48Helper.GetComponentId("line"))) == ActivityN48ComponentStatus.Open then
      self.lineText:SetActive(true)
      self:UnLock("UIN48MainLobbyEntry")
      return
    elseif UIActivityN48Helper.CheckComponentStatus(process:GetComponent(UIActivityN48Helper.GetComponentId("shop"))) == ActivityN48ComponentStatus.Open then
      self.shopText:SetActive(true)
      self:UnLock("UIN48MainLobbyEntry")
      return
    end
  end
  self:UnLock("UIN48MainLobbyEntry")
end

function UIN48MainLobbyEntry:EntryBtnOnClick(go)
  self:SwitchState(UIStateType.UIN48MainController)
end
