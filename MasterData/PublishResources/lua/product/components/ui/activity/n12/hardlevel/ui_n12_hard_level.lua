_class("UIN12HardlLevel", UIController)
UIN12HardlLevel = UIN12HardlLevel

function UIN12HardlLevel:Constructor()
  self._levelCount = 5
  self._levelWidgets = {}
  self._levelData = {}
end

function UIN12HardlLevel:LoadDataOnEnter(TT, res, uiParams)
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._redDotModule = self:GetModule(RedDotModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._challengeMissionComponent = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._challengeMissionCompInfo = self._challengeMissionComponent:GetComponentInfo()
  self:_FilterLevelData()
end

function UIN12HardlLevel:_FilterLevelData()
  local missionInfos = self._challengeMissionCompInfo.m_challenge_unlock_time
  local tempTable = {}
  for key, value in pairs(missionInfos) do
    local tempCfg = Cfg.cfg_component_challenge_mission({CampaignMissionId = key})
    if not table.icontains(tempTable, tempCfg[1].LeveIndex) then
      table.insert(tempTable, tempCfg[1].LeveIndex)
      self._levelData[tempCfg[1].LeveIndex] = {key, value}
    end
  end
end

function UIN12HardlLevel:OnShow(uiParams)
  self:_AttachEvent()
  self:_GetComponent()
  self:RefreshTryout()
end

function UIN12HardlLevel:_AttachEvent()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIN12HardlLevel:_GetComponent()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end)
  for i = 1, self._levelCount do
    local levelCell = self:GetUIComponent("UISelectObjectPath", "Level" .. i)
    self._levelWidgets[i] = levelCell:SpawnObject("UIN12HardLevelCell")
    self._levelWidgets[i]:SetData(self._campaign, i, self._levelData, self._challengeMissionCompInfo.m_max_score[i])
  end
  self._petRedPoint = self:GetGameObject("PetRedPoint")
  self._challengeMissionComponent:CloseTodayRedPoint()
end

function UIN12HardlLevel:AfterUILayerChanged()
  for key, value in pairs(self._levelWidgets) do
    value:RefreshUIInfo(self._challengeMissionCompInfo.m_max_score[key])
  end
  self:_RefreshRedPoint()
end

function UIN12HardlLevel:_RefreshRedPoint()
  self._petRedPoint:SetActive(self._redDotModule:_RequestRedDotStatus4N12(RedDotType.RDT_N12_FIXLINEMISSION))
end

function UIN12HardlLevel:_Close()
  self:SwitchState(UIStateType.UIN12MainController)
end

function UIN12HardlLevel:ChallengeTaskBtnOnClick(go)
  self:ShowDialog("UIN12ChallengesContorl", self._levelData)
end

function UIN12HardlLevel:RefreshTryout()
  local cmp = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM)
  local cmpInfo = cmp:GetComponentInfo()
  local passInfo = cmpInfo.m_pass_mission_info or {}
  
  function self._isTryoutLevelPass(mid)
    return passInfo[mid] ~= nil
  end
end

function UIN12HardlLevel:PetBtnOnClick(go)
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM, self._isTryoutLevelPass, function(missionid)
    local missionModule = self:GetModule(MissionModule)
    local ctx = missionModule:TeamCtx()
    local localProcess = self._campaign:GetLocalProcess()
    local missionComponent = localProcess:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM)
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end
