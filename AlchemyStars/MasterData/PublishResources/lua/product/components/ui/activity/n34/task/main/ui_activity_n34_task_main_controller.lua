_class("UIActivityN34TaskMainController", UIController)
UIActivityN34TaskMainController = UIActivityN34TaskMainController

function UIActivityN34TaskMainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N34, ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY, ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST)
  if res and not res:GetSucc() then
    return
  end
  if not self._campaign then
    res:SetSucc(false)
    return
  end
  local localProcess = self._campaign:GetLocalProcess()
  if not localProcess then
    res:SetSucc(false)
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._surveyComponent = localProcess:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY)
  self._surveyComponentInfo = localProcess:GetComponentInfo(ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY)
  self._questComponent = localProcess:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST)
  self._questComponentInfo = localProcess:GetComponentInfo(ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local sample = self._campaign:GetSample()
  if not sample then
    return
  end
  self._activeEndTime = sample.end_time
  self._taskData = UIActivityN34TaskData:New(self._campaign, self._surveyComponent, self._surveyComponentInfo, self._questComponent, self._questComponentInfo)
end

function UIActivityN34TaskMainController:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN34MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, function()
    self:InfoOnClick()
  end, nil, false)
  self._place = self:GetGameObject("Place")
  self._placeBtn = self:GetGameObject("PlaceBtn")
  self._placeComplete = self:GetGameObject("PlaceComplete")
  self._placing = self:GetGameObject("Placing")
  self._recoveryTimeLabel = self:GetUIComponent("UILocalizationText", "RecoveryTime")
  self._recoveryCountLabel = self:GetUIComponent("UILocalizationText", "RecoveryCount")
  self._placeRemainCountLabel = self:GetUIComponent("UILocalizationText", "PlaceRemainCount")
  self._itemCountLabel = self:GetUIComponent("UILocalizationText", "ItemCount")
  self._itemTips = self:GetGameObject("ItemTips")
  self._bossSpine = self:GetUIComponent("SpineLoader", "Boss")
  self._bossSpine:LoadSpine(self._taskData:GetSpineName())
  self:PlayBossSpineAnimation(self._taskData:GetIdleAnim())
  self._bossAnimTimer = 0
  self._bossAnimLength = self._taskData:GetIdleAnimLength()
  self._startBtn = self:GetGameObject("StartBtn")
  self._delegatePerson = self:GetGameObject("DelegatePerson")
  self._delegatePersonLoader = self:GetUIComponent("SpineLoader", "DelegatePersonLoader")
  self._delegatePersonNameLabel = self:GetUIComponent("UILocalizationText", "DelegatePersonName")
  self._delegateProgress = self:GetUIComponent("Image", "DelegateProgress")
  self._complete = self:GetGameObject("Complete")
  self._delegateSpeek = self:GetGameObject("DelegateSpeek")
  self._speekLabel = self:GetUIComponent("UILocalizationText", "Speek")
  self._currentTipsId = -1
  self._currentTipsTimer = 0
  self._currentTipsLength = 0
  self._currentTipsInterval = 1000
  self._nextBtn = self:GetGameObject("NextBtn")
  self._completes = {}
  self._completes[#self._completes + 1] = self:GetGameObject("1")
  self._completes[#self._completes + 1] = self:GetGameObject("2")
  self._completes[#self._completes + 1] = self:GetGameObject("3")
  self._completes[#self._completes + 1] = self:GetGameObject("4")
  self:AttachEvent(GameEventType.OnN34TaskRefreshEvent, self.RefreshData)
  self._startRed = self:GetGameObject("StartRed")
  self._nextPersonRed = self:GetGameObject("NextPersonRed")
  self._informationRed = self:GetGameObject("InformationRed")
  self._progressLabel = self:GetUIComponent("UILocalizationText", "ProgressLabel")
  self._completeAnim = self:GetUIComponent("Animation", "Completes")
  self._itemAnim = self:GetUIComponent("Animation", "ItemTips")
  self:Init()
end

function UIActivityN34TaskMainController:OnUpdate(deltaTimeMS)
  self:RefreshPlaceUI()
  if self._bossAnimTimer >= self._bossAnimLength then
    self:RandomPlayBossAnim()
  else
    self._bossAnimTimer = self._bossAnimTimer + deltaTimeMS
  end
  if self._currentTipsId >= 0 then
    self._currentTipsTimer = self._currentTipsTimer + deltaTimeMS
    if self._currentTipsTimer >= self._currentTipsLength then
      self._delegateSpeek:SetActive(false)
      self._currentTipsId = -1
      self._currentTipsTimer = 0
      self._currentTipsLength = 0
    end
  else
    self._currentTipsTimer = self._currentTipsTimer + deltaTimeMS
    if self._currentTipsTimer > self._currentTipsInterval then
      self:DelegatePersonSpeek()
    end
  end
end

function UIActivityN34TaskMainController:OnHide()
  self:DetachEvent(GameEventType.OnN34TaskRefreshEvent, self.RefreshData)
end

function UIActivityN34TaskMainController:RandomPlayBossAnim()
  local index = math.random(1, 2)
  self._bossAnimTimer = 0
  if index == 1 then
    self:PlayBossSpineAnimation(self._taskData:GetIdleAnim())
    self._bossAnimLength = self._taskData:GetIdleAnimLength()
  else
    self:PlayBossSpineAnimation(self._taskData:GetRandomAnim())
    self._bossAnimLength = self._taskData:GetRandomAnimLenth()
  end
end

function UIActivityN34TaskMainController:Init()
  self._itemTips:SetActive(false)
  self:PlayPlot()
  self:RefreshPlaceUI()
  self:Refresh()
end

function UIActivityN34TaskMainController:RefreshData()
  self._taskData:Refresh()
  self:Refresh()
end

function UIActivityN34TaskMainController:Refresh()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local num = itemModule:GetItemCount(self._taskData:GetItemId())
  if 9999999 < num then
    num = 9999999
  end
  self._itemCountLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, num, "#F2F2F2", "#F2F2F2"))
  self:RefreshDelegatePersonUI()
  self:RefreshInfomation()
  self:RefreshRed()
end

function UIActivityN34TaskMainController:ShowInformationRed()
  self._itemModule = GameGlobal.GetModule(ItemModule)
  local red = false
  local cfgs = Cfg.cfg_component_survey({})
  
  local function checkFun(cfg)
    for index, value in ipairs(self._surveyComponentInfo.info.pet_unlock) do
      if value == cfg.PetID then
        return true
      end
    end
  end
  
  for key, cfg in pairs(cfgs) do
    local count = self._itemModule:GetItemCount(cfg.TrustItem)
    if count >= cfg.TrustTotal and not checkFun(cfg) then
      red = true
      return red
    end
  end
  local questModule = GameGlobal.GetModule(QuestModule)
  local cfg = Cfg.cfg_global.survey_main_task_id
  local mainTaskId
  if cfg and cfg.IntValue then
    mainTaskId = cfg.IntValue
  end
  if #self._surveyComponentInfo.info.pet_unlock >= #cfgs then
    local quest = questModule:GetQuest(mainTaskId)
    local status = self._questComponent:CheckCampaignQuestStatus(quest:QuestInfo())
    if status == CampaignQuestStatus.CQS_Completed then
      red = true
    end
  end
  return red
end

function UIActivityN34TaskMainController:ShowStartRed()
  local currentDelegatePerson = self._taskData:GetCurrentDelegatePerson()
  if currentDelegatePerson then
    if currentDelegatePerson:ShowAcceptOneRed() then
      return true
    end
    if currentDelegatePerson:HasCanGetProgressReward() then
      return true
    end
    if currentDelegatePerson:GetFinaleRewardStatus() == 1 then
      return true
    end
  end
  return false
end

function UIActivityN34TaskMainController:ShowNextPersonRed()
  if not self:CheckActivityStatus() then
    return false
  end
  local currentDelegatePerson = self._taskData:GetCurrentDelegatePerson()
  if not currentDelegatePerson then
    return false
  end
  if not currentDelegatePerson:IsComplete() then
    return false
  end
  if currentDelegatePerson:IsPaste() == false then
    return false
  end
  if currentDelegatePerson:HasCanGetProgressReward() then
    return false
  end
  return true
end

function UIActivityN34TaskMainController:RefreshRed()
  self._startRed:SetActive(self:ShowStartRed())
  self._nextPersonRed:SetActive(self:ShowNextPersonRed())
  self._informationRed:SetActive(self:ShowInformationRed())
end

function UIActivityN34TaskMainController:RefreshInfomation()
  local persons = self._taskData:GetDelegatePersons()
  local count = 0
  for i = 1, #persons do
    if persons[i]:IsPaste() then
      count = count + 1
    end
  end
  for i = 1, #self._completes do
    if i <= count then
      self._completes[i]:SetActive(true)
      if self._taskData:CanPlayCompleteAnimation(i) then
        self._completeAnim:Play("uieff_UIActivityN34TaskMainController_Info_in" .. i)
        self._taskData:PlayCompleteAnimation(i)
      end
    else
      self._completes[i]:SetActive(false)
    end
  end
end

function UIActivityN34TaskMainController:RefreshDelegatePersonUI()
  local currentDelegatePerson = self._taskData:GetCurrentDelegatePerson()
  if currentDelegatePerson then
    self._delegatePerson:SetActive(true)
    self._delegatePersonLoader:LoadSpine(currentDelegatePerson:GetSpine())
    self._delegatePersonNameLabel:SetText(currentDelegatePerson:GetName())
    local totalTrust = currentDelegatePerson:GetTotalTrust()
    local trustValue = currentDelegatePerson:GetTrustValue()
    local progress = trustValue / totalTrust
    self._delegateProgress.fillAmount = progress
    self._progressLabel:SetText(math.floor(progress * 100) .. "%")
    if 1 <= progress then
      self._complete:SetActive(true)
    else
      self._complete:SetActive(false)
    end
    local isLast = false
    local petid = currentDelegatePerson:GetPersonId()
    local all_cfgs = Cfg.cfg_component_survey({})
    local cfgs = Cfg.cfg_component_survey({PetID = petid})
    if cfgs and next(cfgs) then
      local cfg = cfgs[1]
      local cfgid = cfg.ID
      if cfgid == table.count(all_cfgs) then
        isLast = true
      end
    else
      Log.error("###[UIActivityN34TaskMainController]  cfg_component_survey is nil !id :", petid)
    end
    if isLast then
      self._nextBtn:SetActive(false)
    elseif currentDelegatePerson:IsComplete() then
      self._nextBtn:SetActive(true)
    else
      self._nextBtn:SetActive(false)
    end
  else
    self._delegatePerson:SetActive(false)
    self._delegateSpeek:SetActive(false)
    self._nextBtn:SetActive(false)
  end
end

function UIActivityN34TaskMainController:RefreshPlaceUI()
  local remainCount = self._taskData:GetRemainRewardCount()
  if 0 < remainCount then
    self._place:SetActive(true)
    local rewardRemainTime = self._taskData:GetRewardRemainTime()
    if 0 < rewardRemainTime then
      self._placeBtn:SetActive(false)
      self._placeComplete:SetActive(false)
      self._placing:SetActive(true)
      local timestr = UIActivityCustomHelper.GetTimeString(rewardRemainTime, "str_n34_task_day", "str_n34_task_hour", "str_n34_task_minus", "str_n34_task_less_one_minus")
      self._recoveryTimeLabel:SetText(StringTable.Get("str_n34_task_place_recovery_time_tips", timestr))
    else
      self._placeBtn:SetActive(true)
      self._placeComplete:SetActive(true)
      self._placing:SetActive(false)
      local recoveryCount = self._taskData:GetRewardCount()
      self._recoveryCountLabel:SetText(StringTable.Get("str_n34_task_place_recovery_count_tips", recoveryCount))
      self._placeRemainCountLabel:SetText(StringTable.Get("str_n34_task_place_remain_count_tips", remainCount))
    end
  else
    self._place:SetActive(false)
  end
end

function UIActivityN34TaskMainController:PlayBossSpineAnimation(spineAnim)
  self._bossSpine:SetAnimation(0, spineAnim, true)
end

function UIActivityN34TaskMainController:PlayPlot(callback)
  if self._taskData:CanPlayPlot() == false then
    if callback then
      callback()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", self._taskData:GetPlotId(), function()
    self._taskData:PlayPlot()
    if callback then
      callback()
    end
  end)
end

function UIActivityN34TaskMainController:IsActivityEnd()
  if not self._activeEndTime then
    return true
  end
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._activeEndTime - nowTime)
  if seconds <= 0 then
    return true
  end
  return false
end

function UIActivityN34TaskMainController:CheckActivityStatus()
  if self:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_n34_task_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return false
  end
  if not self._surveyComponent:ComponentIsOpen() then
    ToastManager.ShowToast(StringTable.Get("str_n34_task_activity_end"))
    self:SwitchState(UIStateType.UIActivityN34MainController)
    return false
  end
  return true
end

function UIActivityN34TaskMainController:PlotOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", self._taskData:GetPlotId())
end

function UIActivityN34TaskMainController:PlaceBtnOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  self:StartTask(self.PlaceCoro, self)
end

function UIActivityN34TaskMainController:PlaceCoro(TT)
  self:Lock("UIActivityN34TaskMainController_PlaceCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._surveyComponent:HandleSurveyClientDataReq(TT, res, SurveyOperateType.SurveyOperateType_GetToken, 0)
  if not res:GetSucc() then
    self:UnLock("UIActivityN34TaskMainController_PlaceCoro")
    Log.error("get failed")
    return
  end
  local awards = {}
  awards[1] = {
    assetid = self._taskData:GetItemId(),
    count = self._taskData:GetRewardCount()
  }
  self:ShowDialog("UIGetItemController", awards)
  self._taskData:RefreshRewardInfo()
  self:Refresh()
  self:UnLock("UIActivityN34TaskMainController_PlaceCoro")
end

function UIActivityN34TaskMainController:ItemBtnOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  self._itemTips:SetActive(true)
end

function UIActivityN34TaskMainController:TipsMaskOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  self:StartTask(function(TT)
    self._itemAnim:Play("uieff_UIActivityN34TaskMainController_ItemTips_out")
    YIELD(TT, 200)
    self._itemTips:SetActive(false)
  end, self)
end

function UIActivityN34TaskMainController:InfoOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  self:ShowDialog("UIIntroLoader", "UIN34TaskIntro")
end

function UIActivityN34TaskMainController:StartBtnOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  if not self._taskData then
    return
  end
  if not self._taskData:GetCurrentDelegatePerson() then
    return
  end
  self:ShowDialog("UIN34TaskDelegatePerson", self._taskData, self._taskData:GetCurrentDelegatePerson())
end

function UIActivityN34TaskMainController:DelegateBtnOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  if self._taskData == nil then
    return
  end
  local currentDelegatePerson = self._taskData:GetCurrentDelegatePerson()
  if not currentDelegatePerson then
    return
  end
  self:DelegatePersonSpeek()
end

function UIActivityN34TaskMainController:DelegatePersonSpeek()
  local currentDelegatePerson = self._taskData:GetCurrentDelegatePerson()
  if currentDelegatePerson == nil then
    return
  end
  local tips = currentDelegatePerson:GetTips()
  local totalTrust = currentDelegatePerson:GetTotalTrust()
  local trustValue = currentDelegatePerson:GetTrustValue()
  local progress = trustValue / totalTrust
  for i = 1, #tips do
    local tip = tips[i]
    if progress >= tip.min and progress < tip.max then
      local contents = {}
      for j = 1, #tip.tips do
        if tip.tips[j]:GetId() ~= self._currentTipsId then
          contents[#contents + 1] = tip.tips[j]
        end
      end
      if 0 < #contents then
        local index = math.random(1, #contents)
        self._currentTipsTimer = 0
        self._currentTipsLength = contents[index]:GetLength()
        self._currentTipsInterval = contents[index]:GetInterval()
        self._currentTipsId = contents[index]:GetId()
        self._delegateSpeek:SetActive(true)
        self._speekLabel:SetText(contents[index]:GetTips())
      end
      break
    end
  end
end

function UIActivityN34TaskMainController:InformationBtnOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  self:ShowDialog("UIActivityN34TaskInfomationMainController")
end

function UIActivityN34TaskMainController:NextBtnOnClick()
  if not self:CheckActivityStatus() then
    return
  end
  local currentDelegatePerson = self._taskData:GetCurrentDelegatePerson()
  if not currentDelegatePerson then
    return
  end
  if not currentDelegatePerson:IsComplete() then
    return
  end
  if currentDelegatePerson:IsPaste() == false then
    ToastManager.ShowToast(StringTable.Get("str_n34_task_delegate_person_not_paste_tips"))
    return
  end
  if currentDelegatePerson:HasCanGetProgressReward() then
    ToastManager.ShowToast(StringTable.Get("str_n34_task_delegate_person_rewards_unclaim_tips"))
    return
  end
  self:StartTask(self.NextBtnOnClickCoro, self)
end

function UIActivityN34TaskMainController:NextBtnOnClickCoro(TT)
  self:Lock("UIActivityN34TaskMainController_NextBtnOnClickCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._surveyComponent:HandleSurveyClientDataReq(TT, res, SurveyOperateType.SurveyOperateType_Next, 0)
  if not res:GetSucc() then
    self:UnLock("UIActivityN34TaskMainController_NextBtnOnClickCoro")
    Log.error("next delegate person failed, res ", res:GetResult())
    return
  end
  self._taskData:Refresh()
  self:Refresh()
  self:UnLock("UIActivityN34TaskMainController_NextBtnOnClickCoro")
end
