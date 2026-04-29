_class("UIN28GronruGameLevel", UIController)
UIN28GronruGameLevel = UIN28GronruGameLevel

function UIN28GronruGameLevel:Constructor()
  self._wayPointCell = {}
  self._wayLineCell = {}
  self._current_waypoint_index = 1
end

function UIN28GronruGameLevel:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  local campaignModule = self:GetModule(CampaignModule)
  self._campaignModule = campaignModule
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME, ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  self._component = self._campaign:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() / 1000
  if openTime > nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
  if closeTime < nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
end

function UIN28GronruGameLevel:OnShow(uiParams)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
  self:AttachEvent(GameEventType.OnN28ActivityMinigameGetReward, self.CheckRedPoint)
  self._stage = Cfg.cfg_component_bounce_mission({})
  self:InitWidget()
  self:Flush()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN28GronruGameLevel)
end

function UIN28GronruGameLevel:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
  self:DetachEvent(GameEventType.OnN28ActivityMinigameGetReward, self.CheckRedPoint)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  for i = 1, 6 do
    self._wayPointCell[i]:OnHide()
  end
end

function UIN28GronruGameLevel:InitWidget()
  self._atlas = self:GetAsset("UIN28Minigame.spriteatlas", LoadType.SpriteAtlas)
  UIN28GronruGameLevel.LevelCfg = {
    [1] = {
      normal = "N28_yrj_junei_spot01",
      pass = "N28_yrj_junei_spot02",
      close = "N28_yrj_junei_spot03"
    },
    [2] = {
      normal = "N28_yrj_junei_spot01",
      pass = "N28_yrj_junei_spot02",
      close = "N28_yrj_junei_spot03"
    },
    [3] = {
      normal = "N28_yrj_junei_spot01",
      pass = "N28_yrj_junei_spot02",
      close = "N28_yrj_junei_spot03"
    },
    [4] = {
      normal = "N28_yrj_junei_spot01",
      pass = "N28_yrj_junei_spot02",
      close = "N28_yrj_junei_spot03"
    },
    [5] = {
      normal = "N28_yrj_junei_spot01",
      pass = "N28_yrj_junei_spot02",
      close = "N28_yrj_junei_spot03"
    },
    [6] = {
      normal = "N28_yrj_junei_spot05",
      pass = "N28_yrj_junei_spot07",
      close = "N28_yrj_junei_spot06"
    },
    [7] = {
      normal = "N28_yrj_junei_spot04",
      pass = "N28_yrj_junei_spot04",
      close = "N28_yrj_junei_spot04"
    }
  }
  self._wayPointCell = {}
  self._normalLevel = 6
  for i = 1, 6 do
    self._wayPointCell[i] = UIN28GronruGameLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
  end
  self._wayLineCell = {}
  for i = 1, 6 do
    self._wayLineCell[i] = self:GetUIComponent("RectTransform", "way" .. i)
  end
  self._endLess = self:GetGameObject("Levelendless")
  self._specialRedPoint = self:GetGameObject("specialRedPoint")
  self:SetLocalizedTMPMaterial("titleText", "ui_n28_title_text.mat")
end

function UIN28GronruGameLevel:SetLocalizedTMPMaterial(widgetName, matName)
  self._localizedTMP = self:GetUIComponent("UILocalizedTMP", widgetName)
  self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset(matName, LoadType.Mat)
  self._EMIMat = self._EMIMatResRequest.Obj
  local mat = self._localizedTMP.fontMaterial
  self._localizedTMP.fontMaterial = self._EMIMat
  self._localizedTMP.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN28GronruGameLevel:Flush()
  for i = 1, #self._wayPointCell do
    local data = self:_GetServerData(self._stage[i].CampaignMissionId)
    self._wayPointCell[i]:Flush(i, self._stage[i], data, self:_GetCurrentMission(), self._atlas, self)
  end
  for i = 1, #self._wayLineCell do
    local isOpen = true
    self._wayLineCell[i].transform.gameObject:SetActive(isOpen ~= nil and isOpen)
  end
  self._endLess:SetActive(self:CheckEndlessOpen())
  self:CheckRedPoint()
end

function UIN28GronruGameLevel:CheckEndlessOpen()
  if not self._componentInfo.m_pass_mission_info then
    return false
  end
  return self._componentInfo.m_pass_mission_info and self._componentInfo.m_pass_mission_info[self._stage[1].CampaignMissionId] and self._componentInfo.m_pass_mission_info[self._stage[1].CampaignMissionId].status == 1
end

function UIN28GronruGameLevel:ShowRewardsInfo(index)
  if self:CheckActivityOver() then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  local state = true
  if self._wayPointCell[index] then
    state = self._wayPointCell[index]:GetUnLockState()
  end
  if state and (self:_CheckMissionPassed(self._stage[index].CampaignMissionId) or index == self:_GetCurrentMission() or index == 7) then
    self:ShowDialog("UIN28GronruGameRewards", index, self._stage[index])
  else
    self:CheckLevelItem(index)
  end
end

function UIN28GronruGameLevel:CheckLevelItem(index)
  if self._wayPointCell[index] then
    local state = self._wayPointCell[index]:GetUnLockState()
    if not state then
      local t = self._wayPointCell[index]:GetUnLockTime()
      ToastManager.ShowToast(StringTable.Get("str_n28_gronru_minigame_unlock_tips3", UIActivityHelper.GetFormatTimerStr(t)))
      return
    end
    ToastManager.ShowToast(StringTable.Get("str_n28_gronru_minigame_unlock_tips1"))
  end
end

function UIN28GronruGameLevel:_GetServerData(missionId)
  if not self._componentInfo then
    return
  end
  if not self._componentInfo.m_pass_mission_info then
    return
  end
  for index, value in pairs(self._componentInfo.m_pass_mission_info) do
    if missionId == value.mission_id then
      return value
    end
  end
  return
end

function UIN28GronruGameLevel:_CheckMissionPassed(missionId)
  if not self._componentInfo.m_pass_mission_info then
    return false
  end
  for key, value in pairs(self._componentInfo.m_pass_mission_info) do
    if value.mission_id == missionId and value.status == 1 then
      return true
    end
  end
  return false
end

function UIN28GronruGameLevel:_GetCurrentMission()
  local curMission = 1
  if not self._componentInfo.m_pass_mission_info then
    return curMission
  end
  for index, value in pairs(self._stage) do
    if not self:_CheckMissionPassed(value.CampaignMissionId) then
      return index <= self._normalLevel and index or self._normalLevel
    end
  end
  return curMission
end

function UIN28GronruGameLevel:Press1OnClick()
  self:ShowRewardsInfo(1)
end

function UIN28GronruGameLevel:Press2OnClick()
  self:ShowRewardsInfo(2)
end

function UIN28GronruGameLevel:Press3OnClick()
  self:ShowRewardsInfo(3)
end

function UIN28GronruGameLevel:Press4OnClick()
  self:ShowRewardsInfo(4)
end

function UIN28GronruGameLevel:Press5OnClick()
  self:ShowRewardsInfo(5)
end

function UIN28GronruGameLevel:Press6OnClick()
  self:ShowRewardsInfo(6)
end

function UIN28GronruGameLevel:EndlessOnClick()
  self:ShowRewardsInfo(7)
end

function UIN28GronruGameLevel:BackBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  self:CloseDialog()
end

function UIN28GronruGameLevel:CheckRedPoint()
  for i = 1, #self._wayPointCell do
    local data = self:_GetServerData(self._stage[i].CampaignMissionId)
    self._wayPointCell[i]:FlushData(data)
    self._wayPointCell[i]:SetRedPoint()
  end
  self:SpecialCheckRedPoint()
end

function UIN28GronruGameLevel:SpecialCheckRedPoint()
  self._specialRedPoint:SetActive(false)
  local data = self:_GetServerData(self._stage[#self._stage].CampaignMissionId)
  if data then
    for index, value in pairs(data.enties_list) do
      if value == 1 then
        self._specialRedPoint:SetActive(true)
        break
      end
    end
  else
    self._specialRedPoint:SetActive(false)
  end
end

function UIN28GronruGameLevel:CheckActivityOver()
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() * 0.001
  if closeTime < nowtime then
    self:CloseDialog()
    return true
  end
  return false
end

function UIN28GronruGameLevel:_Refresh(bo)
  local topDepth = GameGlobal.UIStateManager().uiControllerManager:TopDepth()
  if topDepth == self:GetDepth() and not self:CheckActivityOver() then
    self._componentInfo = self._campaign:GetComponentInfo(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
    self:Flush()
  end
end
