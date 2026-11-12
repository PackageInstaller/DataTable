local TrialResultCtrl = class("TrialResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
TrialResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goComplete = {sComponentName = "GameObject"},
  animComplete = {sNodeName = "goComplete", sComponentName = "Animator"},
  goFailed = {sComponentName = "GameObject"},
  Mask = {
    sComponentName = "CanvasGroup"
  },
  txtMainlineName = {nCount = 2, sComponentName = "TMP_Text"},
  ButtonClose = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Retry"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  goWorldLevel = {},
  imgExp = {sComponentName = "Image"},
  txtRank = {sComponentName = "TMP_Text"},
  txtRankEn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  txtWorldExp = {sComponentName = "TMP_Text"},
  imgExpBg = {},
  txtGetWorldExp = {sComponentName = "TMP_Text"},
  goRankArrow = {},
  goStarList = {},
  getStar = {nCount = 3, sComponentName = "Transform"},
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Result_Fail_Tip"
  },
  txtTipShadow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Result_Fail_Tip"
  },
  txtExp = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_ExpTips"
  },
  txtMaxLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Max_Level"
  },
  goGacha = {},
  animGacha = {
    sNodeName = "goGachaItem",
    sComponentName = "Animator"
  },
  imgFull = {sComponentName = "Image"},
  imgSplitB = {sComponentName = "Image"},
  imgSplitC = {sComponentName = "Image"},
  imgSplitD = {sComponentName = "Image"},
  txtAllTime = {sComponentName = "TMP_Text"},
  txtTimeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_TimeCount_All"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtBtnClose = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_Complete"
  },
  btnRetry = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Retry"
  },
  txtBtnRetry = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_Restart"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  txtBtnNext = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_NextTrial"
  },
  imgHead = {sComponentName = "Image"},
  btnDamageResult = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowDamageResult"
  },
  txtClickToContinue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  buttonList = {}
}
TrialResultCtrl._mapEventConfig = {}
local starGachaCfg = {
  [1] = {
    iconPath = "icon_roguegacha_03%s",
    animName = "BattleResultgoGacha_r"
  },
  [2] = {
    iconPath = "icon_roguegacha_02%s",
    animName = "BattleResultgoGacha_sr"
  },
  [3] = {
    iconPath = "icon_roguegacha_01%s",
    animName = "BattleResultgoGacha_ssr"
  }
}

function TrialResultCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  EventManager.Hit(EventId.AvgBubbleShutDown)
  NovaAPI.SetComponentEnable(self.canvas, false)
  self._mapNode.goGacha.gameObject:SetActive(false)
  self._mapNode.buttonList:SetActive(false)
end

function TrialResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.bSuccess = tbParam[1] == true
  local nLevelTime = tbParam[2]
  local tbChar = tbParam[3]
  self.nActId = tbParam[4]
  self.mapChangeInfo = tbParam[5]
  self.tbCharDamage = tbParam[6]
  self.bHasReward = tbParam[7] ~= false
  if PlayerData.Trial:IsSkinTrialMode() then
    PlayerData.Trial:UserEventUpload_TrialBattle(self.bSuccess and 2 or 3)
  end
  for i = 1, 2 do
    self._mapNode.btnDamageResult[i].gameObject:SetActive(self.tbCharDamage ~= nil and #self.tbCharDamage > 0)
  end
  nLevelTime = math.floor(nLevelTime)
  NovaAPI.SetTMPText(self._mapNode.txtAllTime, orderedFormat(ConfigTable.GetUIText("StarTower_Result_Time") or "", nLevelTime))
  self.nNextGroup = PlayerData.Trial:GetNextUnreceiveGroup()
  self._mapNode.btnNext.gameObject:SetActive(self.nNextGroup)
  if self.nNextGroup then
    local mapGroup = ConfigTable.GetData("TrialGroup", self.nNextGroup)
    if mapGroup then
      local mapTrial = ConfigTable.GetData("TrialCharacter", mapGroup.TrialChar)
      if mapTrial then
        local nCharSkinId = ConfigTable.GetData_Character(mapTrial.CharId).AdvanceSkinId
        local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
        if mapCharSkin then
          self:SetPngSprite(self._mapNode.imgHead, mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.S)
        end
      end
    end
  end
  local sTitle = PlayerData.Trial:GetLevelTitle()
  for _, v in ipairs(self._mapNode.txtMainlineName) do
    NovaAPI.SetTMPText(v, sTitle)
  end
  local tbTeamMemberId = tbChar
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
  if self.bSuccess then
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.goFailed:SetActive(false)
    self._mapNode.imgBlurredBg.gameObject:SetActive(false)
    self._mapNode.goComplete:SetActive(true)
    WwiseManger:PlaySound("ui_roguelike_victory")
    WwiseManger:SetState("system", "victory")
    nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animComplete, {
      "BattleResultPanel_victory_out"
    })
    self._mapNode.animComplete:Play("TrialResultPanel_victory_out")
    self:AddTimer(1, 3, function()
      self._mapNode.buttonList:SetActive(true)
    end, true, true, true)
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
  self._mapNode.ButtonClose[1].gameObject:SetActive(false)
  self._mapNode.ButtonClose[2].gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    if not self.bSuccess then
      self._mapNode.ButtonClose[1].gameObject:SetActive(true)
      self._mapNode.ButtonClose[2].gameObject:SetActive(true)
    end
    NovaAPI.SetComponentEnable(self.canvas, true)
  end
  
  cs_coroutine.start(wait)
  self:AddTimer(1, nAnimTime, "PlayAnim", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 3)
  PlayerData.Voice:PlayBattleResultVoice(tbRoleId, self.bSuccess)
  self.bProcessingClose = false
end

function TrialResultCtrl:OnDisable()
  PlayerData.Trial:SetSettlementState(false)
  PlayerData.Voice:StopCharVoice()
end

function TrialResultCtrl:PlayAnim()
  PlayerData.SideBanner:TryOpenSideBanner()
  
  local function callback()
    self:OpenReward()
  end
  
  self.bOpenUpgrade = PlayerData.Base:TryOpenWorldClassUpgrade(callback)
end

function TrialResultCtrl:ClosePanel()
  if self.bProcessingClose then
    return
  end
  self.bProcessingClose = true
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

function TrialResultCtrl:RefreshGacha()
  local sIconPath = "UI/big_sprites/"
  local gachaCfg = starGachaCfg[3]
  if nil ~= gachaCfg then
    self:SetPngSprite(self._mapNode.imgFull, sIconPath .. string.format(gachaCfg.iconPath, "a"))
    self:SetPngSprite(self._mapNode.imgSplitB, sIconPath .. string.format(gachaCfg.iconPath, "b"))
    self:SetPngSprite(self._mapNode.imgSplitC, sIconPath .. string.format(gachaCfg.iconPath, "c"))
    self:SetPngSprite(self._mapNode.imgSplitD, sIconPath .. string.format(gachaCfg.iconPath, "d"))
    self._mapNode.animGacha:Play(gachaCfg.animName)
  end
end

function TrialResultCtrl:Close()
  if self.bOpenUpgrade then
    self:ClosePanel()
  else
    self:OpenReward()
  end
end

function TrialResultCtrl:OnBtnClick_Close(btn)
  if PlayerData.Trial:IsActivityTrialMode() then
    PlayerData.Trial:SetSelectTrialGroup()
    EventManager.Hit(EventId.ClosePanel, PanelId.TrialLevelSelect)
    self:Close()
  elseif PlayerData.Trial:IsSkinTrialMode() then
    local function transitionOpenCallback()
      PanelManager.IGNORE_CS_TRANS_EVENT = true
      
      local function OnEventAfterEnterMain()
        EventManager.Remove(EventId.AfterEnterMain, PanelManager, OnEventAfterEnterMain)
        EventManager.Hit(EventId.ClosePanel, PanelId.TrialSkinSelectPanel)
        
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForSeconds(2))
          PanelManager.IGNORE_CS_TRANS_EVENT = false
          EventManager.Hit(EventId.SetTransition)
        end
        
        cs_coroutine.start(wait)
      end
      
      EventManager.Add(EventId.AfterEnterMain, PanelManager, OnEventAfterEnterMain)
      self:Close()
    end
    
    EventManager.Hit(EventId.SetTransition, 17, transitionOpenCallback)
  else
    self:Close()
  end
end

function TrialResultCtrl:OnBtnClick_Retry(btn)
  self:Close()
end

function TrialResultCtrl:OnBtnClick_Next(btn)
  PlayerData.Trial:SetSelectTrialGroup(self.nNextGroup)
  self:Close()
end

function TrialResultCtrl:OnBtnClick_ShowDamageResult()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
end

function TrialResultCtrl:OpenReward()
  if self.bHasReward and self.mapChangeInfo and next(self.mapChangeInfo) ~= nil then
    local function callback()
      self:ClosePanel()
    end
    
    UTILS.OpenReceiveByChangeInfo(self.mapChangeInfo, callback)
  else
    self:ClosePanel()
  end
end

return TrialResultCtrl
