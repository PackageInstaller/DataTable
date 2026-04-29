_class("UIN25VampireMain", UIController)
UIN25VampireMain = UIN25VampireMain

function UIN25VampireMain:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN25Data()
  self.strsLeftTime = {
    "str_n25_left_time_d_h",
    "str_n25_left_time_d",
    "str_n25_left_time_h_m",
    "str_n25_left_time_h",
    "str_n25_left_time_m"
  }
end

function UIN25VampireMain:LoadDataOnEnter(TT, res, uiParams)
  res = self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N25, res)
  if N25Data.CheckCode(res) then
    self.data:InitVampire()
    self._activityConst = UIActivityN25Const:New()
    self._activityConst:LoadData(TT, res)
  end
end

function UIN25VampireMain:OnShow(uiParams)
  local spine, bgm = self._activityConst:GetSpineAndBgm()
  if bgm then
    AudioHelperController.PlayBGM(bgm, AudioConstValue.BGMCrossFadeTime)
  end
  local TopBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtns = TopBtn:SpawnObject("UINewCommonTopButton")
  backBtns:SetData(function()
    if not self:CheckCampaignOpen() then
      self:SwitchState(UIStateType.UIMain)
      return
    end
    self:SwitchState(UIStateType.UIActivityN25MainController)
  end, function()
    self:ShowDialog("UIN25VampireTalentIntro", "str_n25_vampire_main_intro_title", "str_n25_vampire_main_intro_")
  end, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self.txtLeftTime = self:GetUIComponent("RollingText", "txtLeftTime")
  self.redTalentTree = self:GetGameObject("redTalentTree")
  self.redChallengeTask = self:GetGameObject("redChallengeTask")
  self.challengeTaskLock = self:GetGameObject("challengeTaskLock")
  self.talentTreeLock = self:GetGameObject("talentTreeLock")
  self.poolPet = self:GetUIComponent("UISelectObjectPath", "Content")
  self.shot = self:GetUIComponent("RawImage", "shot")
  self.imgRT = uiParams[1]
  if self.imgRT then
    self.shot.color = Color.white
    self.shot.texture = self.imgRT
  else
    self.shot.color = Color.black
  end
  self.teActivity = UIActivityHelper.StartTimerEvent(self.teActivity, function()
    self:FlushCDActivity()
  end, 60000)
  self:Flush()
  self:PlayEnterAnim()
end

function UIN25VampireMain:OnHide()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
  self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
end

function UIN25VampireMain:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIN25VampireMain:PlayEnterAnimCoro(TT)
  self:Lock("UIN25VampireMain_PlayEnterAnimCoro")
  YIELD(TT, 600)
  self:UnLock("UIN25VampireMain_PlayEnterAnimCoro")
  self:_CheckGuide()
end

function UIN25VampireMain:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN25VampireMain)
end

function UIN25VampireMain:Flush()
  self:FlushCDActivity()
  self:FlushRedPointTalentTree()
  self:FlushRedPointChallengeTask()
  self:FlushPetPool()
end

function UIN25VampireMain:FlushCDActivity()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local endTime = self.data:GetVimpireEndTime()
  if nowTimestamp < endTime then
    UIForge.FlushCDText(self.txtLeftTime, endTime, self.strsLeftTime, false)
  else
    self.txtLeftTime:RefreshText(StringTable.Get("str_activity_finished"))
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
end

function UIN25VampireMain:FlushRedPointTalentTree()
  if self.data then
    local red = self.data:CheckRedTalentTree()
    local condition = self._activityConst:CheckBloodSuckerMissionJoind(10008)
    self.redTalentTree:SetActive(red and condition)
    self.talentTreeLock:SetActive(not condition)
  end
end

function UIN25VampireMain:FlushRedPointChallengeTask()
  if self.data then
    local red = self._activityConst:GetTaskRedPoint()
    local condition = self._activityConst:CheckBloodSuckerMissionJoind(10008)
    self.redChallengeTask:SetActive(red and condition)
    self.challengeTaskLock:SetActive(not condition)
  end
end

function UIN25VampireMain:FlushPetPool()
  local len = table.count(self.data.pets)
  self.poolPet:SpawnObjects("UIN25VampirePetItem", len)
  local uis = self.poolPet:GetAllSpawnList()
  for i, pet in pairs(self.data.pets) do
    local ui = uis[i]
    local tplId = pet:TplId()
    ui:Flush(tplId, function()
      UIN25VampireUtil.ShowTryPetInfoUI(self.data:GetComponentCfgId(), tplId)
    end)
  end
end

function UIN25VampireMain:BtnTalentTreeOnClick(go)
  if not self:CheckCondition() then
    return
  end
  if not self:CheckCampaignOpen() then
    return
  end
  self:SwitchState(UIStateType.UIN25VampireTalentTree)
end

function UIN25VampireMain:BtnChallengeTaskOnClick(go)
  if not self:CheckCondition() then
    return
  end
  if not self:CheckCampaignOpen() then
    return
  end
  self:ShowDialog("UIN25VampireChallengeTask")
end

function UIN25VampireMain:BtnLevelOnClick(go)
  if not self:CheckCampaignOpen() then
    return
  end
  self:SwitchState(UIStateType.UIN25VampireLevel)
end

function UIN25VampireMain:CheckCampaignOpen()
  local isOpen = self.data:GetActivityCampaign():CheckCampaignOpen()
  if not isOpen then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
  end
  return isOpen
end

function UIN25VampireMain:CheckCondition()
  local condition = self._activityConst:CheckBloodSuckerMissionJoind(10008)
  if not condition then
    local cfg = Cfg.cfg_component_bloodsucker({CampaignMissionID = 10008})
    ToastManager.ShowToast(StringTable.Get("str_n25_vampire_main_locktip", StringTable.Get(cfg[1].MissionName)))
  end
  return condition
end
