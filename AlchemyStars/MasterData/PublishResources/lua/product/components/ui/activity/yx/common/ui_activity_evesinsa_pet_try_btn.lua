_class("UIActivityEveSinsaPetTryBtn", UICustomWidget)
UIActivityEveSinsaPetTryBtn = UIActivityEveSinsaPetTryBtn

function UIActivityEveSinsaPetTryBtn:_GetComponents()
  self._press = self:GetGameObject("PetTryBtnPress")
  self._btn = self:GetGameObject("PetTryBtn")
  self._red = self:GetGameObject("red")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.Press, function(go)
    self._press:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.Release, function(go)
    self._press:SetActive(false)
  end)
end

function UIActivityEveSinsaPetTryBtn:OnShow()
  self:_GetComponents()
end

function UIActivityEveSinsaPetTryBtn:SetData(campaign)
  self._campaign = campaign
  self._line_component = self._campaign:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM)
  self:_CheckRedPoint()
end

function UIActivityEveSinsaPetTryBtn:_CheckRedPoint()
  local campaignModule = self:GetModule(CampaignModule)
  local data = campaignModule:GetEveSinsaNewFlagRedPoint()
  self._red:SetActive(data:PetStageRedPoint())
end

function UIActivityEveSinsaPetTryBtn:PetTryBtnOnClick()
  Log.info("UIActivityEveSinsaPetTryBtn:btnOnClick")
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM, function(missionid)
    return self:ESPetTryMissionPass(missionid)
  end, function(missionid)
    self:ESPetTryGoBattle(missionid)
  end)
end

function UIActivityEveSinsaPetTryBtn:ESPetTryMissionPass(missionid)
  return self._line_component:IsPassCamMissionID(missionid)
end

function UIActivityEveSinsaPetTryBtn:ESPetTryGoBattle(missionid)
  local missiontModule = GameGlobal.GetModule(MissionModule)
  local ctx = missiontModule:TeamCtx()
  local param = {
    missionid,
    self._line_component:GetCampaignMissionComponentId(),
    self._line_component:GetCampaignMissionParamKeyMap()
  }
  ctx:Init(TeamOpenerType.Campaign, param)
  ctx:ShowDialogUITeams(false)
end
