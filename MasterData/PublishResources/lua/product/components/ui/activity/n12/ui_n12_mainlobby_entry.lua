_class("UIN12MainLobbyEntry", UICustomWidget)
UIN12MainLobbyEntry = UIN12MainLobbyEntry

function UIN12MainLobbyEntry:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN12MainLobbyEntry:OnShow(uiParams)
  self:_GetComponents()
  self:StartTask(self.RequestData, self)
end

function UIN12MainLobbyEntry:_GetComponents()
  self._redPoint = self:GetGameObject("RedPoint")
  self._newFlag = self:GetGameObject("NewFlag")
  self._entrust = self:GetGameObject("Entrust")
  self._entrustText = self:GetUIComponent("RollingText", "EntrustText")
end

function UIN12MainLobbyEntry:RequestData(TT)
  self:Lock("UIN12MainLobbyEntry")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST, ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION, ECampaignN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN, ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM, ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE, ECampaignN12ComponentID.ECAMPAIGN_N12_STORY, ECampaignN12ComponentID.ECAMPAIGN_N12_QUEST_MISSION, ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res:GetSucc() then
    local process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N12)
    local showNew = process:GetStepStatusNew()
    local showredPoint = process:GetEntryRedDot()
    self._newFlag:SetActive(showNew)
    self._redPoint:SetActive(showredPoint and not showNew)
    local entrustComponentInfo = self._campaign:GetComponentInfo(ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST)
    local remainTime = entrustComponentInfo.m_unlock_time - self._svrTimeModule:GetServerTime() * 0.001
    self._entrust:SetActive(remainTime <= 0)
    if remainTime <= 0 then
      self._entrustText:RefreshText(StringTable.Get("str_n12_entrust_open"))
    end
  end
  self:UnLock("UIN12MainLobbyEntry")
end

function UIN12MainLobbyEntry:EntryBtnOnClick(go)
  self.uiOwner._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
  local rt = self.uiOwner._screenShot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  self:StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    self:SwitchState(UIStateType.UIN12MainController, cache_rt)
  end)
end
