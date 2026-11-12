local TDBattleResultCtrl = class("TDBattleResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
TDBattleResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goComplete = {sComponentName = "GameObject"},
  goFailed = {sComponentName = "GameObject"},
  Mask = {
    sComponentName = "CanvasGroup"
  },
  goMainlineNameSuc = {
    sComponentName = "RectTransform"
  },
  txtMainlineName = {nCount = 2, sComponentName = "TMP_Text"},
  ButtonClose = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnDamageResult = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowDamageResult"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animatorRoot = {sNodeName = "goComplete", sComponentName = "Animator"},
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
  imgBlack = {},
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Fail_Tip"
  },
  txtTipShadow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Fail_Tip"
  },
  txtExp = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_ExpTips"
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
  goAffixes = {},
  TMPTitleAffix = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_Affixes_Title"
  },
  goAffix = {sComponentName = "Transform", nCount = 25},
  TMPHardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_Result_Difficulty"
  },
  txtRankTimeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Battle_Time"
  },
  TMPHard = {sComponentName = "TMP_Text"},
  txtRankTime = {sComponentName = "TMP_Text"},
  imgNewRecord = {},
  imgHardTitleBg = {},
  imgHardScoreTitleBg = {},
  imgTimeScoreTitleBg = {},
  TMPFinalScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_FinalScore_Title"
  },
  TMPFinalScore = {sComponentName = "TMP_Text"},
  TMPTimeScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_TimeScore_Title"
  },
  TMPTimeScore = {sComponentName = "TMP_Text"},
  TMPHardScore = {sComponentName = "TMP_Text"},
  TMPHardScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_BaseScore_Title"
  },
  txtClickToContinue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  }
}
TDBattleResultCtrl._mapEventConfig = {}
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
local name_bg_pos_y_1 = 220
local name_bg_pos_y_2 = 119
local time_bg_pos_y_1 = -4.1
local time_bg_pos_y_2 = -113

function TDBattleResultCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  EventManager.Hit(EventId.AvgBubbleShutDown)
  NovaAPI.SetComponentEnable(self.canvas, false)
  self._mapNode.goGacha.gameObject:SetActive(false)
end

function TDBattleResultCtrl:OnEnable()
  self.bAnimEnd = false
  local tbParam = self:GetPanelParam()
  self.nResultState = 0
  if tbParam[1] == false then
    self.nResultState = 3
  elseif tbParam[1] then
    self.nResultState = 1
  end
  local tbStar = tbParam[2]
  local GenerRewardItems = tbParam[3]
  local FirstRewardItems = tbParam[4]
  local ChestRewardItems = tbParam[5]
  local nExp = tbParam[6] or 0
  local bPureAvg = tbParam[7]
  local nTime = tbParam[8]
  local nTDLevelId = tbParam[9]
  local tbChar = tbParam[10]
  local tbAffixes = tbParam[11]
  local nTimeScore = tbParam[12]
  local nHardScore = tbParam[13]
  local nFinalScore = tbParam[14]
  local bNewRecord = tbParam[15]
  self.mapChangeInfo = tbParam[16]
  local SurpriseItems = tbParam[17]
  local CustomItems = tbParam[18]
  self.tbCharDamage = tbParam[19] or {}
  local nHard = 0
  for i = 1, 2 do
    self._mapNode.btnDamageResult[i].gameObject:SetActive(self.tbCharDamage ~= nil and 0 < #self.tbCharDamage)
  end
  self.bNewRecord = bNewRecord
  self.nFinalScore = nFinalScore
  self.tbChar = tbChar
  for _, nAffixesId in ipairs(tbAffixes) do
    local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixesId)
    if mapAffixCfgData ~= nil then
      nHard = nHard + mapAffixCfgData.Difficulty
    end
  end
  for index = 1, 25 do
    self:SetAffixIcon(self._mapNode.goAffix[index], tbAffixes[index])
  end
  NovaAPI.SetTMPText(self._mapNode.TMPHard, nHard)
  NovaAPI.SetTMPText(self._mapNode.txtRankTime, nTime .. ConfigTable.GetUIText("Talent_Sec"))
  NovaAPI.SetTMPText(self._mapNode.TMPFinalScore, nFinalScore)
  NovaAPI.SetTMPText(self._mapNode.TMPTimeScore, nTimeScore)
  NovaAPI.SetTMPText(self._mapNode.TMPHardScore, nHardScore)
  self._mapNode.imgNewRecord:SetActive(bNewRecord)
  self.mapTravelerDuelLevel = ConfigTable.GetData("TravelerDuelBossLevel", nTDLevelId)
  local sTravelerDuelLevelName = ""
  if self.mapTravelerDuelLevel ~= nil then
    if self.nResultState == 1 then
      sTravelerDuelLevelName = self.mapTravelerDuelLevel.Name
    else
      sTravelerDuelLevelName = self.mapTravelerDuelLevel.Name .. "<space=9>" .. orderedFormat(ConfigTable.GetUIText("TD_BattleResultDifficulty"), nHard)
    end
  end
  local nStar = 0
  for i = 0, 2 do
    if tbStar[i] then
      nStar = nStar + 1
    end
  end
  self.nLevelStar = nStar
  self.bSuccess = 0 < nStar
  self.mapReward = {}
  if SurpriseItems ~= nil then
    for _, v in pairs(SurpriseItems) do
      v.rewardType = AllEnum.RewardType.Extra
      table.insert(self.mapReward, v)
    end
  end
  for _, v in pairs(GenerRewardItems) do
    table.insert(self.mapReward, v)
  end
  if CustomItems ~= nil then
    for _, v in pairs(CustomItems) do
      table.insert(self.mapReward, v)
    end
  end
  for _, v in pairs(FirstRewardItems) do
    v.rewardType = AllEnum.RewardType.First
    table.insert(self.mapReward, v)
  end
  for _, v in pairs(ChestRewardItems) do
    v.rewardType = AllEnum.RewardType.Three
    table.insert(self.mapReward, v)
  end
  for _, v in ipairs(self._mapNode.txtMainlineName) do
    NovaAPI.SetTMPText(v, sTravelerDuelLevelName)
  end
  self:RefreshWorldClass(nExp)
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
  self.tbRoleList = tbRoleId
  self._mapNode.imgHardTitleBg:SetActive(true)
  self._mapNode.imgHardScoreTitleBg:SetActive(false)
  self._mapNode.imgTimeScoreTitleBg:SetActive(false)
  self._mapNode.TMPFinalScoreTitle.gameObject:SetActive(false)
  WwiseManger:PostEvent("ui_loading_combatSFX_mute", nil, false)
  WwiseManger:PostEvent("char_common_all_pause")
  WwiseManger:PostEvent("mon_common_all_pause")
  WwiseManger:SetState("level", "None")
  WwiseManger:SetState("combat", "None")
  local nAnimTime
  if self.nResultState == 1 then
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.imgBlurredBg.gameObject:SetActive(false)
    self._mapNode.goFailed:SetActive(false)
    self._mapNode.goComplete:SetActive(true)
    WwiseManger:PlaySound("ui_roguelike_victory")
    WwiseManger:SetState("system", "victory2")
    if 0 < #tbAffixes then
      nAnimTime = 4.2
      self._mapNode.animatorRoot:Play("TravelerDuelBattleResultPanel_victory_out")
      self._mapNode.imgBlack:SetActive(true)
    else
      nAnimTime = 4
      self._mapNode.imgBlack:SetActive(false)
    end
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
    self._mapNode.ButtonClose[1].gameObject:SetActive(true)
    self._mapNode.ButtonClose[2].gameObject:SetActive(true)
    NovaAPI.SetComponentEnable(self.canvas, true)
    if bPureAvg then
      self:OpenReward()
    end
  end
  
  self._coroutine = cs_coroutine.start(wait)
  nAnimTime = nAnimTime + 1.5
  self:AddTimer(1, nAnimTime, "PlayAnim", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  self._mapNode.txtClickToContinue[1].gameObject:SetActive(false)
  self._mapNode.txtClickToContinue[2].gameObject:SetActive(false)
  local sType = self.nResultState == 1 and "TrekkerVersus_victory" or "TrekkerVersus_fail"
  local sVoiceRes = PlayerData.Voice:PlayCharVoice(sType, 917202, nil, true)
  self.bProcessingClose = false
end

function TDBattleResultCtrl:OnDisable()
  if self._sequence ~= nil then
    self._sequence:Kill()
    self._sequence = nil
  end
  if self._coroutine ~= nil then
    cs_coroutine.stop(self._coroutine)
    self._coroutine = nil
  end
  if self._coroutineOpen ~= nil then
    cs_coroutine.stop(self._coroutineOpen)
    self._coroutineOpen = nil
  end
  PlayerData.Voice:StopCharVoice()
end

function TDBattleResultCtrl:SetAffixIcon(trIcon, nAffixId)
  local rtIconRoot = trIcon:Find("rtIcon")
  local imgIcon = trIcon:Find("rtIcon/imgIcon"):GetComponent("Image")
  local TMPLevel = trIcon:Find("rtIcon/imgBgLevel/TMPLevel"):GetComponent("TMP_Text")
  if nAffixId == nil then
    rtIconRoot.gameObject:SetActive(false)
    return
  end
  local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
  if mapAffixCfgData == nil then
    rtIconRoot.gameObject:SetActive(false)
    return
  end
  NovaAPI.SetTMPText(TMPLevel, mapAffixCfgData.Difficulty)
  self:SetPngSprite(imgIcon, mapAffixCfgData.Icon)
end

function TDBattleResultCtrl:PlayAnim()
  self.bAnimEnd = true
  PlayerData.SideBanner:TryOpenSideBanner()
  self._mapNode.txtClickToContinue[1].gameObject:SetActive(true)
  self._mapNode.txtClickToContinue[2].gameObject:SetActive(true)
end

function TDBattleResultCtrl:RefreshWorldClass(nExp)
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local nCurExp = PlayerData.Base:GetWorldExp()
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = 1
  if mapCfg then
    nFullExp = mapCfg.Exp or 1
  end
  NovaAPI.SetTMPText(self._mapNode.txtRank, nWorldClass)
  NovaAPI.SetTMPText(self._mapNode.txtWorldExp, nCurExp .. "/" .. nFullExp)
  local nfillAmount = nCurExp / nFullExp
  NovaAPI.SetImageFillAmount(self._mapNode.imgExp, 1 < nfillAmount and 1 or nfillAmount)
  self._mapNode.imgExpBg.gameObject:SetActive(0 < nExp)
  NovaAPI.SetTMPText(self._mapNode.txtGetWorldExp, "+" .. nExp)
  self._mapNode.goRankArrow.gameObject:SetActive(false)
end

function TDBattleResultCtrl:ClosePanel()
  if self.bProcessingClose then
    return
  end
  self.bProcessingClose = true
  if self.nResultState ~= 1 then
    CS.AdventureModuleHelper.ResumeLogic()
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
  self._mapNode.Mask.gameObject:SetActive(true)
  self._sequence = DOTween.Sequence()
  self._sequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
  self._sequence:AppendCallback(dotween_callback_handler(self, self.OnFadeComplete))
  self._sequence:SetUpdate(true)
end

function TDBattleResultCtrl:OnFadeComplete()
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
end

function TDBattleResultCtrl:RefreshGacha()
  local sIconPath = "UI/big_sprites/"
  local gachaCfg = starGachaCfg[self.nLevelStar]
  if nil ~= gachaCfg then
    self:SetPngSprite(self._mapNode.imgFull, sIconPath .. string.format(gachaCfg.iconPath, "a"))
    self:SetPngSprite(self._mapNode.imgSplitB, sIconPath .. string.format(gachaCfg.iconPath, "b"))
    self:SetPngSprite(self._mapNode.imgSplitC, sIconPath .. string.format(gachaCfg.iconPath, "c"))
    self:SetPngSprite(self._mapNode.imgSplitD, sIconPath .. string.format(gachaCfg.iconPath, "d"))
    self._mapNode.animGacha:Play(gachaCfg.animName)
  end
end

function TDBattleResultCtrl:OnBtnClick_Close(btn)
  if not self.bAnimEnd then
    return
  end
  self:ClosePanel()
end

function TDBattleResultCtrl:OpenReward()
  if #self.mapReward > 0 then
    local nAnimTime = 2
    self._mapNode.goGacha.gameObject:SetActive(true)
    WwiseManger:PlaySound("ui_roguelike_gacha_specialOpen")
    self:RefreshGacha()
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(nAnimTime))
      
      local function callback()
        self:ClosePanel()
      end
      
      UTILS.OpenReceiveByDisplayItem(self.mapReward, self.mapChangeInfo, callback)
    end
    
    self._coroutineOpen = cs_coroutine.start(wait)
  else
    self:ClosePanel()
  end
end

function TDBattleResultCtrl:OnBtnClick_ShowDamageResult()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
end

return TDBattleResultCtrl
