local TutorialResultCtrl = class("TutorialResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
TutorialResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goComplete = {sComponentName = "GameObject"},
  goFailed = {sComponentName = "GameObject"},
  Mask = {
    sComponentName = "CanvasGroup"
  },
  txtName = {nCount = 2, sComponentName = "TMP_Text"},
  ButtonClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  txtQuestTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_Result_QuestTitle"
  },
  txtQuestValue1 = {sComponentName = "TMP_Text"},
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_Result_FailTips"
  },
  txtTipShadow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_Result_FailTips"
  },
  NextLevelName = {},
  txtNextName = {sComponentName = "TMP_Text"},
  btn_goNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoNext"
  },
  txt_goNext = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_NextLevel"
  },
  btn_retry = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Retry"
  },
  txt_retry = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_Restart"
  },
  btn_complete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txt_complete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_Complete"
  },
  animComplete = {sNodeName = "goComplete", sComponentName = "Animator"},
  animFailed = {sNodeName = "goFailed", sComponentName = "Animator"}
}
TutorialResultCtrl._mapEventConfig = {}
TutorialResultCtrl._mapRedDotConfig = {}

function TutorialResultCtrl:Awake()
  EventManager.Hit(EventId.AvgBubbleShutDown)
  NovaAPI.SetComponentEnableByName(self.gameObject, "Canvas", false)
end

function TutorialResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nResultState = tbParam[1]
  self.nLevelId = tbParam[2]
  local GenerRewardItems = tbParam[3] or {}
  local nCurQuest = tbParam[4] or 0
  local nMaxQuest = tbParam[5] or 0
  local tbChar = tbParam[6] or {}
  self.mapChangeInfo = tbParam[7] or {}
  local bPureAvg = tbParam[8] or false
  self.bSuccess = nResultState == 1
  local levelConfig = ConfigTable.GetData("TutorialLevel", self.nLevelId)
  local sLevelName = ""
  if levelConfig ~= nil then
    sLevelName = levelConfig.Title
  end
  for _, v in ipairs(self._mapNode.txtName) do
    NovaAPI.SetTMPText(v, sLevelName)
  end
  self.nextLevelId = PlayerData.TutorialData:GetNextLevelId(self.nLevelId)
  if self.nextLevelId == 0 then
    self._mapNode.NextLevelName:SetActive(false)
    self._mapNode.btn_goNext.gameObject:SetActive(false)
  else
    local nextLevelConfig = ConfigTable.GetData("TutorialLevel", self.nextLevelId)
    if nextLevelConfig ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtNextName, nextLevelConfig.Title)
    end
  end
  self.mapReward = {}
  for _, v in pairs(GenerRewardItems) do
    table.insert(self.mapReward, v)
  end
  NovaAPI.SetTMPText(self._mapNode.txtQuestValue1, nCurQuest .. "/" .. nMaxQuest)
  local nCurTeam = 5
  if PlayerData.nCurGameType == AllEnum.WorldMapNodeType.Mainline then
    nCurTeam = PlayerData.Mainline.nCurTeamIndex
  end
  local tbTeamMemberId, nCaptain
  if tbChar == nil then
    nCaptain, tbTeamMemberId = PlayerData.Team:GetTeamData(nCurTeam)
  else
    tbTeamMemberId = tbChar
  end
  local tbRoleId = {}
  for i = 1, #tbTeamMemberId do
    if tbTeamMemberId[i] ~= nil and 0 < tbTeamMemberId[i] then
      table.insert(tbRoleId, tbTeamMemberId[i])
    end
  end
  if #tbRoleId == 0 then
    table.insert(tbRoleId, 112)
  end
  WwiseManger:PostEvent("ui_loading_combatSFX_mute", nil, false)
  WwiseManger:PostEvent("char_common_all_pause")
  WwiseManger:PostEvent("mon_common_all_pause")
  WwiseManger:SetState("level", "None")
  WwiseManger:SetState("combat", "None")
  local nAnimTime
  if nResultState == 1 then
    WwiseManger:PlaySound("ui_roguelike_victory")
    WwiseManger:SetState("system", "victory")
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.goFailed:SetActive(false)
    self._mapNode.goComplete:SetActive(true)
    nAnimTime = 4
  else
    WwiseManger:SetState("system", "defeat")
    CS.AdventureModuleHelper.PauseLogic()
    self._mapNode.goRoot.gameObject:SetActive(false)
    self._mapNode.imgBlurredBg.gameObject:SetActive(true)
    self._mapNode.goFailed:SetActive(true)
    self._mapNode.goComplete:SetActive(false)
    nAnimTime = 3
  end
  self._mapNode.Mask.gameObject:SetActive(false)
  self._mapNode.ButtonClose.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.ButtonClose.gameObject:SetActive(true)
    NovaAPI.SetComponentEnableByName(self.gameObject, "Canvas", true)
    if bPureAvg then
      self:OpenReward()
    end
  end
  
  cs_coroutine.start(wait)
  self:AddTimer(1, nAnimTime, "PlayAnim", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  PlayerData.Voice:PlayBattleResultVoice(tbRoleId, nResultState == 1)
  self.bProcessingClose = false
end

function TutorialResultCtrl:OnDisable()
  PlayerData.Voice:StopCharVoice()
end

function TutorialResultCtrl:OnDestroy()
end

function TutorialResultCtrl:PlayAnim()
  PlayerData.SideBanner:TryOpenSideBanner()
  
  local function callback()
    self:OpenReward()
  end
  
  self.bOpenUpgrade = PlayerData.Base:TryOpenWorldClassUpgrade(callback)
end

function TutorialResultCtrl:ClosePanel()
  if self.bProcessingClose then
    return
  end
  self.bProcessingClose = true
  
  local function levelEndCallback()
    CS.AdventureModuleHelper.ResumeLogic()
    if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
      EventManager.Hit(EventId.CloesCurPanel)
      PlayerData.Base:OnBackToMainMenuModule()
    else
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
      self._mapNode.Mask.gameObject:SetActive(true)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
      local sequence = DOTween.Sequence()
      sequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
      sequence:AppendCallback(function()
        if self.bSuccess then
          NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
          self._mapNode.imgBlurredBg:SetActive(false)
        else
          local function levelEndCallback()
            EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
            
            NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
            self._mapNode.imgBlurredBg:SetActive(false)
          end
          
          EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
          CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
        end
      end)
      sequence:SetUpdate(true)
    end
  end
  
  if self.bSuccess then
    PlayerData.TutorialData:GetLevelReward(self.nLevelId, levelEndCallback)
  else
    levelEndCallback()
  end
end

function TutorialResultCtrl:Close()
  if self.bOpenUpgrade then
    self:ClosePanel()
  else
    self:OpenReward()
  end
end

function TutorialResultCtrl:OpenReward(callback)
  if self.mapChangeInfo and next(self.mapChangeInfo) ~= nil then
    local function callback()
      self:ClosePanel()
    end
    
    UTILS.OpenReceiveByChangeInfo(self.mapChangeInfo, callback)
  else
    self:ClosePanel()
  end
end

function TutorialResultCtrl:OnBtnClick_Close()
  self:Close()
end

function TutorialResultCtrl:OnBtnClick_GoNext()
  self:Close()
end

function TutorialResultCtrl:OnBtnClick_Retry()
  self:Close()
end

return TutorialResultCtrl
