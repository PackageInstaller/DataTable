_class("UIMainLobbyCampaignEnterOld", UICustomWidget)
UIMainLobbyCampaignEnterOld = UIMainLobbyCampaignEnterOld

function UIMainLobbyCampaignEnterOld:Constructor()
  self.mSvrTime = self:GetModule(SvrTimeModule)
  self.mCampaign = self:GetModule(CampaignModule)
  self._loginModule = self:GetModule(LoginModule)
end

function UIMainLobbyCampaignEnterOld:OnShow()
  self.atlas = self:GetAsset("UISummerI.spriteatlas", LoadType.SpriteAtlas)
  self.imgCampaign = self:GetUIComponent("RawImageLoader", "imgCampaign")
  self.imgNameBg = self:GetGameObject("imgNameBg")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.roll = self:GetGameObject("roll")
  self.roll:SetActive(false)
  self.imgRoll = self:GetUIComponent("Image", "imgRoll")
  self.txtRoll = self:GetUIComponent("UILocalizationText", "txtRoll")
  self.rollingText = self:GetUIComponent("RollingText", "txtRoll")
  self._summerTwoPanel = self:GetGameObject("SummerTwo")
  self._title1Label = self:GetUIComponent("UILocalizationText", "Title1")
  self._title2Label = self:GetUIComponent("UILocalizationText", "Title2")
  self._campaignRedAreaGo = self:GetGameObject("ActivityRedArea")
  self._campaignNewAreaGo = self:GetGameObject("ActivityNewFlagArea")
  self.ActivitySummer1New = self:GetGameObject("ActivitySummer1New")
  self.ActivitySummer1New:SetActive(false)
  self.ActivitySummer2New = self:GetGameObject("ActivitySummer2New")
  self.ActivitySummer2New:SetActive(false)
  self.ActivitySummer1Red = self:GetGameObject("ActivitySummer1Red")
  self.ActivitySummer1Red:SetActive(false)
  self.ActivitySummer2Red = self:GetGameObject("ActivitySummer2Red")
  self.ActivitySummer2Red:SetActive(false)
  self:AddListener()
  self._entryLoader = self:GetUIComponent("UISelectObjectPath", "EntryLoader")
  self._old = self:GetGameObject("old")
end

function UIMainLobbyCampaignEnterOld:AddListener()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnCampaignStepChagne)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIMainLobbyCampaignEnterOld:OnHide()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnCampaignStepChagne)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIMainLobbyCampaignEnterOld:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:Flush(self._uiMainLobbyController, self._latestCampObj)
  end
end

function UIMainLobbyCampaignEnterOld:Flush(controller, latestCampObj)
  local oneBtnMode = true
  self._uiMainLobbyController = controller
  self._latestCampObj = latestCampObj
  local sampleInfo = self._latestCampObj:GetSampleInfo()
  local campConfig = Cfg.cfg_campaign[sampleInfo.id]
  if campConfig and campConfig.EntranceIcon and table.count(campConfig.EntranceIcon) >= 3 then
    local entryPrefab = campConfig.EntranceIcon[2]
    local entryClass = campConfig.EntranceIcon[3]
    if entryPrefab and entryClass then
      self._old:SetActive(false)
      self._entryLoader.dynamicInfoOfEngine:SetObjectName(entryPrefab)
      local obj = self._entryLoader:SpawnObject(entryClass)
      if obj.SetData_uiMainLobbyController then
        obj:SetData_uiMainLobbyController(self._uiMainLobbyController)
      end
      return false
    end
  end
  if campConfig and campConfig.EntranceIcon and table.count(campConfig.EntranceIcon) == 1 then
    oneBtnMode = false
    self._missionRight = campConfig.MainUI
    self.imgCampaign:LoadImage(campConfig.EntranceIcon[1])
    self._summerTwoPanel:SetActive(false)
    if sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN then
      GameGlobal.TaskManager():StartTask(self.RequestEveSinsaCampaignData, self)
      self.imgNameBg:SetActive(false)
    elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_HIIRO then
      self.imgCampaign.transform.sizeDelta = Vector2(480, 202)
      self.imgCampaign.transform.localScale = Vector3(0.9, 0.9, 1)
      self.imgCampaign.transform.anchoredPosition = Vector3(32.46, 18.54, 0)
      self.imgNameBg:SetActive(false)
    elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
      self.imgNameBg:SetActive(false)
      GameGlobal.TaskManager():StartTask(self.LoadSummerTwoData, self, function()
        self._summerTwoPanel:SetActive(true)
        self.imgCampaign.transform.sizeDelta = Vector2(522, 215)
        self.imgCampaign.transform.anchoredPosition = Vector3(29.7, 0, 0)
        self._title1Label.text = StringTable.Get(campConfig.CampaignName)
        self._title2Label.text = StringTable.Get(campConfig.CampaignSubtitle)
      end)
    elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_I then
      self.imgCampaign.transform.anchoredPosition = Vector3(10, 0, 0)
      self.imgNameBg:SetActive(false)
      self.imgCampaign.transform.sizeDelta = Vector2(403, 171)
      self.imgCampaign.transform.anchoredPosition = Vector3(-30.9, 7, 0)
    else
      self.imgCampaign.transform.anchoredPosition = Vector3(10, 0, 0)
      self.imgNameBg:SetActive(false)
    end
    self:_BindCampaignEnterBtnAinm(sampleInfo.camp_type)
    self:FlushRoll(sampleInfo, campConfig)
  else
    Log.fatal("[Campaign] can't find campaign config by id:", sampleInfo.id)
  end
  if sampleInfo.camp_type ~= ECampaignType.CAMPAIGN_TYPE_SUMMER_II and sampleInfo.camp_type ~= ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN and not oneBtnMode then
    self:_OnCampaignStepChagne()
  end
  return oneBtnMode
end

function UIMainLobbyCampaignEnterOld:LoadSummerTwoData(TT, callback)
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_II, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1)
  if res and not res:GetSucc() then
    self.mCampaign:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._missionComponentInfo = self._campaign:GetComponentInfo(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  local missionEndTime = 0
  if self._missionComponentInfo then
    missionEndTime = self._missionComponentInfo.m_close_time
  end
  local sample = self._campaign:GetSample()
  self._activeEndTime = sample and sample.end_time or 0
  local nowTime = self.mSvrTime:GetServerTime() / 1000
  if nowTime > self._activeEndTime then
    Log.error("Time error!")
    return
  end
  if missionEndTime <= nowTime then
    self._status = 2
    self._endTime = self._activeEndTime
  else
    self._status = 1
    self._endTime = missionEndTime
  end
  if callback then
    callback()
  end
  self:_OnCampaignStepChagne()
end

function UIMainLobbyCampaignEnterOld:FlushRoll(sampleInfo, campConfig)
  if sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_I then
    self:StartTask(function(TT)
      local summer1Data = self.mCampaign:GetSummer1Data()
      if summer1Data:GetStateGame() == UISummerOneEnterBtnState.Normal or summer1Data:GetStateGame() == UISummerOneEnterBtnState.Locked then
        self.imgRoll.sprite = self.atlas:GetSprite("summer_term1_ent_zjm_normal")
        self.roll:SetActive(true)
        self.txtRoll:SetText(StringTable.Get("str_activity_summer_i_mini_game_roll_text"))
        self.rollingText:RefreshText(StringTable.Get("str_activity_summer_i_mini_game_roll_text"))
      elseif summer1Data:GetStateHard() == UISummerOneEnterBtnState.Locked or summer1Data:GetStateHard() == UISummerOneEnterBtnState.Normal or summer1Data:GetStateGame() == UISummerOneEnterBtnState.Locked then
        self.imgRoll.sprite = self.atlas:GetSprite("summer_term1_ent_zjm_hard")
        self.roll:SetActive(true)
        self.txtRoll:SetText(StringTable.Get("str_activity_summer_i_stage_hard_roll_text"))
        self.rollingText:RefreshText(StringTable.Get("str_activity_summer_i_stage_hard_roll_text"))
      else
        self.roll:SetActive(false)
      end
    end, self)
  else
    self.roll:SetActive(false)
  end
end

function UIMainLobbyCampaignEnterOld:btnCampaignOnClick(go)
  local sampleInfo = self._latestCampObj:GetSampleInfo()
  if sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_HIIRO or sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_I then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(self._missionRight, cache_rt, true)
    end)
  elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
    local open_id = GameGlobal.GameLogic():GetOpenId()
    local save_key = "summer_two_new_" .. open_id
    if LocalDB.HasKey(save_key) and LocalDB.GetInt(save_key) == 0 then
      LocalDB.SetInt(save_key, 1)
    end
    self._campaignNewAreaGo:SetActive(false)
    self:SwitchState(self._missionRight)
  else
    self:SwitchState(self._missionRight)
  end
end

function UIMainLobbyCampaignEnterOld:_BindCampaignEnterBtnAinm(camp_type)
  if camp_type == ECampaignType.CAMPAIGN_TYPE_HIIRO then
    self:_BindCampaignSakuraEnterBtnAinm()
  else
    self:_DisableCampaignEnterBtnAinm()
  end
end

function UIMainLobbyCampaignEnterOld:_DisableCampaignEnterBtnAinm()
  if self._bindCampaignEnterBtnAnim and self._campaignEnterEff then
    self._campaignEnterEff:SetActive(false)
  end
end

function UIMainLobbyCampaignEnterOld:_BindCampaignSakuraEnterBtnAinm()
  if not self._bindCampaignEnterBtnAnim then
    self._campaignEnterEff = UIHelper.GetGameObject("uieff_Sakura_Enter.prefab")
    if not self._campaignEnterEff then
      return
    end
    self._campaignEnterEff.transform.parent = self.imgCampaign.transform
    self._campaignEnterEff.transform.sizeDelta = Vector2(0, 0)
    self._campaignEnterEff.transform.localScale = Vector3(480, 202, 1)
    self._campaignEnterEff.transform.anchoredPosition = Vector3(-10, -2.5, 0)
    self._campaignEnterEffAnim = self._campaignEnterEff:GetComponent("Animation")
    local btnName = "btnCampaign"
    local btnGo = self:GetGameObject(btnName)
    self:AddUICustomEventListener(UICustomUIEventListener.Get(btnGo), UIEvent.Press, function(go)
      self:_PlayCampaignEnterBtnPressAnim()
    end)
    self:AddUICustomEventListener(UICustomUIEventListener.Get(btnGo), UIEvent.Release, function(go)
      self:_PlayCampaignEnterBtnUpAnim()
    end)
  end
  self._bindCampaignEnterBtnAnim = true
end

function UIMainLobbyCampaignEnterOld:_PlayCampaignEnterBtnPressAnim()
  if self._campaignEnterEffAnim then
    self._campaignEnterEffAnim:Play("uieff_Sakura_MainlobbyBtn")
  end
end

function UIMainLobbyCampaignEnterOld:_PlayCampaignEnterBtnUpAnim()
  if self._campaignEnterEffAnim then
    self._campaignEnterEffAnim:Play("uieff_Sakura_MainlobbyBtn_Fade")
  end
end

function UIMainLobbyCampaignEnterOld:_OnCampaignStepChagne(campaign_id, component_id, component_step)
  self:_CheckCampaignNew()
  self:_CheckCampaignRedPoint()
end

function UIMainLobbyCampaignEnterOld:_CheckCampaignNew()
  self._summer_ii_new = false
  if self._latestCampObj then
    local sampleInfo = self._latestCampObj:GetSampleInfo()
    if sampleInfo then
      if sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN then
        local data = self.mCampaign:GetEveSinsaNewFlagRedPoint()
        self._campaignNewAreaGo:SetActive(data:HaveNewFlag())
      elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_HIIRO then
        self._campaignNewAreaGo:SetActive(false)
      elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_I then
        local summer1Data = self.mCampaign:GetSummer1Data()
        local notEnterMain = not Summer1Data.HasPrefsMain()
        local notEnterHard = not Summer1Data.HasPrefsHard()
        local notEnterGame = not Summer1Data.HasPrefsGame()
        local hasHardOpen = summer1Data:GetStateHard() == UISummerOneEnterBtnState.Normal
        local hasGameOpen = summer1Data:GetStateGame() == UISummerOneEnterBtnState.Normal
        local hasNewGameStage = summer1Data:CheckMiniGameNewStage()
        self.ActivitySummer1New:SetActive(notEnterMain or hasHardOpen and notEnterHard or hasGameOpen and (notEnterGame or hasNewGameStage))
      elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
        local summmer2new = false
        local open_id = GameGlobal.GameLogic():GetOpenId()
        local save_key = "summer_two_new_" .. open_id
        if not LocalDB.HasKey(save_key) then
          summmer2new = true
        end
        self.ActivitySummer2New:SetActive(summmer2new)
        self._campaignNewAreaGo:SetActive(false)
        self._summer_ii_new = summmer2new
      elseif sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
        self._campaignNewAreaGo:SetActive(true)
      end
    end
  end
end

function UIMainLobbyCampaignEnterOld:_CheckCampaignRedPoint()
  local showRed = false
  if self._latestCampObj then
    local sampleInfo = self._latestCampObj:GetSampleInfo()
    if sampleInfo then
      if sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN then
        local data = self.mCampaign:GetEveSinsaNewFlagRedPoint()
        showRed = data:HaveRedPoint() and not data:HaveNewFlag()
      elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_I then
        showRed = false
        if not self.ActivitySummer1New.activeInHierarchy then
          self.ActivitySummer1Red:SetActive(sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD))
        end
      elseif sampleInfo.camp_type == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
        showRed = false
        local showRedSummer1 = false
        if not self._summer_ii_new then
          showRedSummer1 = self:_SummerIIRed()
        end
        self.ActivitySummer2Red:SetActive(showRedSummer1)
      elseif sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD) then
        showRed = true
      end
    end
  end
  self._campaignRedAreaGo:SetActive(showRed)
end

function UIMainLobbyCampaignEnterOld:_SummerIIRed()
  local summerTwoLevelData = UISummerActivityTwoLevelDatas:New(self._missionComponentInfo)
  local level_red = summerTwoLevelData:GetLevelRedStatus()
  local login_red = self._campaign:CheckComponentRed(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN)
  local story_red = self._campaign:CheckComponentRed(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY)
  local rewards_red = false
  local _personProgress1CompInfo = self._campaign:GetComponentInfo(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1)
  local _scoreDatas = UISummerActivityTwoScoreData:New(_personProgress1CompInfo)
  local rewards_red = _scoreDatas:HasCanGetReward()
  local red = false
  if login_red or story_red or level_red or rewards_red then
    red = true
  end
  return red
end

function UIMainLobbyCampaignEnterOld:RequestEveSinsaCampaignData(TT)
  local campaignData = self.mCampaign:GetEveSinsaNewFlagRedPoint()
  campaignData:RequestCampaign()
  YIELD(TT)
  self:_CheckCampaignRedPoint()
  self:_CheckCampaignNew()
end
