_class("UISummerActivityTwoLevelController", UIController)
UISummerActivityTwoLevelController = UISummerActivityTwoLevelController

function UISummerActivityTwoLevelController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_II, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_2, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_3, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_4, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_5, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_6)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._missionComponentInfo = self._localProcess:GetComponentInfo(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  self._missionComponent = self._localProcess:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  self._personProgress1CompInfo = self._localProcess:GetComponentInfo(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1)
  self._totalLevelDatas = campaignModule:GetSummerTwoLevelData(TT)
  self._isSwitchStatus = true
  if uiParams and uiParams[1] then
    self._isSwitchStatus = uiParams[1][1]
  end
  self:RefreshData()
end

function UISummerActivityTwoLevelController:RefreshData()
  self._totalScore = 0
  local levelDatas = self._totalLevelDatas:GetLevelDatas()
  for i = 1, #levelDatas do
    local levelGroupData = levelDatas[i]
    for j = 1, #levelGroupData do
      local levelData = levelGroupData[j]
      if levelData:GetStatus() == UISummerActivityTwoLevelStatus.Complete then
        self._totalScore = self._totalScore + levelData:GetMaxScore()
      end
    end
  end
  local bossLevelData = self._totalLevelDatas:GetBossLevelData()
  if bossLevelData and bossLevelData:GetStatus() == UISummerActivityTwoLevelStatus.Complete then
    self._totalScore = self._totalScore + bossLevelData:GetMaxScore()
  end
end

function UISummerActivityTwoLevelController:OnShow(uiParams)
  self._inRt = nil
  if uiParams and uiParams[1] then
    self._inRt = uiParams[1][2]
  end
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:Shot()
    if self._rt then
      local outRenderer = self:GetUIComponent("MeshRenderer", "Out")
      local outMaterial = outRenderer.material
      outMaterial:SetTexture("_MainTex", self._rt)
    end
    if self._isSwitchStatus then
      self:SwitchState(UIStateType.UISummer2)
    else
      self:CloseDialog()
    end
  end, function()
    self:ShowDialog("UIHelpController", "UISummerActivityTwoLevelController")
  end, function()
    self:Shot()
    if self._rt then
      local outRenderer = self:GetUIComponent("MeshRenderer", "Out")
      local outMaterial = outRenderer.material
      outMaterial:SetTexture("_MainTex", self._rt)
    end
    self:SwitchState(UIStateType.UIMain)
  end)
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._totalScoreLabel = self:GetUIComponent("UILocalizationText", "TotalScore")
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._scoreRed = self:GetGameObject("ScoreRed")
  self._petRed = self:GetGameObject("PetRed")
  local normalLevel = self:GetUIComponent("UISelectObjectPath", "NormalLevel")
  local levelDatas = self._totalLevelDatas:GetLevelDatas()
  normalLevel:SpawnObjects("UISummerActivityTwoLevelGroup", #levelDatas)
  self._levelGroups = normalLevel:GetAllSpawnList()
  for i = 1, #levelDatas do
    self._levelGroups[i]:Refresh(levelDatas[i], i)
  end
  local bossLevelData = self._totalLevelDatas:GetBossLevelData()
  if bossLevelData then
    local boosLevel = self:GetUIComponent("UISelectObjectPath", "BossLevel")
    local bossItem = boosLevel:SpawnObject("UISummerActivityTwoLevelBossItem", 1)
    bossItem:Refresh(bossLevelData)
  end
  self:AttachEvent(GameEventType.SummerTwoRewardRefresh, self.RefreshRewardRedStatus)
  self:RefreshUI()
  self:PlayAnim()
end

function UISummerActivityTwoLevelController:OnHide()
  self:DetachEvent(GameEventType.SummerTwoRewardRefresh, self.RefreshRewardRedStatus)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSummerActivityTwoLevelUIClose)
end

function UISummerActivityTwoLevelController:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UISummerActivityTwoLevelController.super:Dispose()
end

function UISummerActivityTwoLevelController:PlayAnim()
  if self._inRt then
    local inRenderer = self:GetUIComponent("MeshRenderer", "In")
    local inMaterial = inRenderer.material
    inMaterial:SetTexture("_MainTex", self._inRt)
  else
    local go = self:GetGameObject("In")
    go.transform.localScale = Vector3.zero
  end
end

function UISummerActivityTwoLevelController:Shot()
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local shotRect = self:GetUIComponent("RectTransform", "screenShot")
  self._shot.width = shotRect.rect.width
  self._shot.height = shotRect.rect.height
  self._shot.blurTimes = 0
  self._shot:CleanRenderTexture()
  self._rt = self._shot:RefreshBlurTexture()
end

function UISummerActivityTwoLevelController:RefreshRewardRedStatus()
  local status1 = self:HasCanGetReward(self._personProgress1CompInfo)
  if status1 then
    self._scoreRed:SetActive(true)
  else
    self._scoreRed:SetActive(false)
  end
end

function UISummerActivityTwoLevelController:RefreshPetRedStatus()
  local _cfg_data = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_SUMMER_II
  })
  if not _cfg_data then
    Log.error("###[UISummerActivityTwoLevelController] cfg_campaign_pet_try is nil ! self._CampaignId --> ", ECampaignType.CAMPAIGN_TYPE_SUMMER_II)
    return
  end
  local pass = true
  for i = 1, #_cfg_data do
    local missionid = _cfg_data[i].CampaignMissionId
    pass = self:SummerTwoPetTryMissionPass(missionid)
    if not pass then
      break
    end
  end
  self._petRed:SetActive(not pass)
end

function UISummerActivityTwoLevelController:RefreshUI()
  self._totalScoreLabel.text = self._totalScore
  self._iconImg:LoadImage(UISummerActivityTwoConst.EntryIcon)
  self:RefreshRewardRedStatus()
  self:RefreshPetRedStatus()
end

function UISummerActivityTwoLevelController:ScorePanelOnClick()
  self:ShowDialog("UISummerActivityTwoScoreController")
end

function UISummerActivityTwoLevelController:PetBtnOnClick()
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_SUMMER_II, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION, function(missionid)
    return self:SummerTwoPetTryMissionPass(missionid)
  end, function(missionid)
    self:SummerTwoPetTryGoBattle(missionid)
  end)
end

function UISummerActivityTwoLevelController:SummerTwoPetTryGoBattle(missionid)
  local missiontModule = GameGlobal.GetModule(MissionModule)
  local ctx = missiontModule:TeamCtx()
  local levelData = self._totalLevelDatas:GetLevelDataById(missionid)
  if not levelData then
    return
  end
  local param = {
    levelData:GetMissionId(),
    self._missionComponent:GetCampaignMissionComponentId(),
    self._missionComponent:GetCampaignMissionParamKeyMap()
  }
  ctx:Init(TeamOpenerType.Campaign, param)
  ctx:ShowDialogUITeams(false)
end

function UISummerActivityTwoLevelController:SummerTwoPetTryMissionPass(missionid)
  return self._totalLevelDatas:IsLevelComplete(missionid)
end

function UISummerActivityTwoLevelController:HasCanGetReward(progressComponentInfo)
  local progressRewards = progressComponentInfo.m_progress_rewards
  local currentProgress = progressComponentInfo.m_current_progress
  local receivedProgress = progressComponentInfo.m_received_progress
  for k, v in pairs(progressRewards) do
    local progress = k
    local status = false
    if currentProgress > progress then
      status = true
      for i = 1, #receivedProgress do
        if progress == receivedProgress[i] then
          status = false
          break
        end
      end
    end
    if status then
      return true
    end
  end
  return false
end
