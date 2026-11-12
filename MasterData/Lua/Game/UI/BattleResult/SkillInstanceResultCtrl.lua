local SkillInstanceResultCtrl = class("SkillInstanceResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
SkillInstanceResultCtrl._mapNodeConfig = {
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
    callback = "OnBtnClick_Close"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  goWorldLevel = {},
  imgExp = {
    sComponentName = "RectTransform"
  },
  imgExp1 = {
    sComponentName = "RectTransform"
  },
  txtRank = {sComponentName = "TMP_Text"},
  txtRankEn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  txtWorldExp = {sComponentName = "TMP_Text"},
  imgExpBg = {},
  txtGetWorldExp = {sComponentName = "TMP_Text"},
  goRankArrow = {},
  goRank = {},
  goStarList = {},
  getStar = {nCount = 3, sComponentName = "Transform"},
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
  btnDamageResult = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowDamageResult"
  },
  imgExpFillBg = {
    sComponentName = "RectTransform"
  },
  txtClickToContinue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  }
}
SkillInstanceResultCtrl._mapEventConfig = {}
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
local resultType = {
  None = 0,
  Victory = 1,
  Defeat = 2
}

function SkillInstanceResultCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  EventManager.Hit(EventId.AvgBubbleShutDown)
  NovaAPI.SetComponentEnable(self.canvas, false)
  self._mapNode.goGacha.gameObject:SetActive(false)
end

function SkillInstanceResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nResultState = resultType.None
  if tbParam[1] then
    nResultState = resultType.Victory
  else
    nResultState = resultType.Defeat
  end
  local tbStar = tbParam[2]
  local GenerRewardItems = tbParam[3]
  local FirstRewardItems = tbParam[4]
  local ChestRewardItems = tbParam[5]
  local nExp = tbParam[6] or 0
  local bPureAvg = tbParam[7]
  local sLarge = tbParam[8]
  local sSmall = tbParam[9]
  local nSkillInstanceId = tbParam[10]
  local tbChar = tbParam[11]
  self.mapChangeInfo = tbParam[12]
  local SurpriseItems = tbParam[13]
  local DoubleItems = tbParam[14]
  self.tbCharDamage = tbParam[15] or {}
  for i = 1, 2 do
    self._mapNode.btnDamageResult[i].gameObject:SetActive(self.tbCharDamage ~= nil and 0 < #self.tbCharDamage)
  end
  self.mapSkillInstance = ConfigTable.GetData("SkillInstance", nSkillInstanceId)
  if self.mapSkillInstance ~= nil then
    local sSkillInstanceName = self.mapSkillInstance.Name
    for _, v in ipairs(self._mapNode.txtMainlineName) do
      local sName = orderedFormat(ConfigTable.GetUIText("Dungeon_Difficulty") or "", sSkillInstanceName, ConfigTable.GetUIText("Diffculty_" .. self.mapSkillInstance.Difficulty) or "")
      NovaAPI.SetTMPText(v, sName)
    end
    self:RefreshTarget(tbStar)
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
  for _, v in pairs(GenerRewardItems) do
    table.insert(self.mapReward, v)
  end
  for _, v in pairs(FirstRewardItems) do
    v.rewardType = AllEnum.RewardType.First
    table.insert(self.mapReward, v)
  end
  for _, v in pairs(ChestRewardItems) do
    v.rewardType = AllEnum.RewardType.Three
    table.insert(self.mapReward, v)
  end
  for _, v in pairs(SurpriseItems) do
    v.rewardType = AllEnum.RewardType.Extra
    table.insert(self.mapReward, v)
  end
  for _, v in pairs(DoubleItems) do
    v.rewardType = AllEnum.RewardType.Double
    table.insert(self.mapReward, v)
  end
  self:RefreshWorldClass(nExp)
  local nCurTeam = 5
  if PlayerData.nCurGameType == AllEnum.WorldMapNodeType.Mainline then
    nCurTeam = PlayerData.Mainline.nCurTeamIndex
  end
  local tbTeamMemberId
  if tbChar == nil then
    _, tbTeamMemberId = PlayerData.Team:GetTeamData(nCurTeam)
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
  if nResultState == resultType.Victory then
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.goFailed:SetActive(false)
    self._mapNode.imgBlurredBg.gameObject:SetActive(false)
    self._mapNode.goComplete:SetActive(true)
    WwiseManger:PlaySound("ui_roguelike_victory")
    WwiseManger:SetState("system", "victory")
    nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animComplete, {
      "BattleResultPanel_victory_out"
    })
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
  
  cs_coroutine.start(wait)
  nAnimTime = nAnimTime + 1.5
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  self:AddTimer(1, nAnimTime, "PlayAnim", true, true, true)
  PlayerData.Voice:PlayBattleResultVoice(tbRoleId, nResultState == resultType.Victory)
  self.bProcessingClose = false
end

function SkillInstanceResultCtrl:OnDisable()
  PlayerData.SkillInstance:SetSettlementState(false)
  PlayerData.Voice:StopCharVoice()
  if self.closeSequence then
    self.closeSequence:Kill()
  end
  if self.bAddLevelEndEvent then
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, self.levelEndCallback)
  end
end

function SkillInstanceResultCtrl:PlayAnim()
  PlayerData.SideBanner:TryOpenSideBanner()
  
  local function callback()
    self:OpenReward()
  end
  
  self.bOpenUpgrade = PlayerData.Base:TryOpenWorldClassUpgrade(callback)
end

function SkillInstanceResultCtrl:RefreshWorldClass(nExp)
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local nCurExp = PlayerData.Base:GetWorldExp()
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.Exp
  end
  local bMax = nFullExp == 0
  self._mapNode.txtExp.gameObject:SetActive(true)
  self._mapNode.txtMaxLevel.gameObject:SetActive(bMax)
  self._mapNode.txtWorldExp.gameObject:SetActive(not bMax)
  self._mapNode.goRank:SetActive(not bMax)
  self._mapNode.goRankArrow.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtRank, orderedFormat(ConfigTable.GetUIText("CommonTips_LevelFormat") or "", nWorldClass))
  local nMaxWidth = 443
  local v2Size = self._mapNode.imgExpFillBg.sizeDelta
  v2Size.y = self._mapNode.imgExp.sizeDelta.y
  if bMax then
    v2Size.x = nMaxWidth
    self._mapNode.imgExp.sizeDelta = v2Size
  else
    local nfillAmount = (nCurExp - nExp) / nFullExp
    local nAddAmount = nCurExp / nFullExp
    if nCurExp - nExp <= 0 then
      nfillAmount = 0
      nAddAmount = nCurExp / nFullExp
    end
    nfillAmount = 1 < nfillAmount and 1 or nfillAmount
    v2Size.x = nMaxWidth * nfillAmount
    self._mapNode.imgExp.sizeDelta = v2Size
    nAddAmount = 1 < nAddAmount and 1 or nAddAmount
    v2Size.x = nMaxWidth * nAddAmount
    self._mapNode.imgExp1.sizeDelta = v2Size
    NovaAPI.SetTMPText(self._mapNode.txtWorldExp, nCurExp .. "/" .. nFullExp)
    NovaAPI.SetTMPText(self._mapNode.txtGetWorldExp, "+" .. nExp)
  end
end

function SkillInstanceResultCtrl:RefreshTarget(tbStar)
  local tbCond = {}
  table.insert(tbCond, decodeJson(self.mapSkillInstance.OneStarCondition))
  table.insert(tbCond, decodeJson(self.mapSkillInstance.TwoStarCondition))
  table.insert(tbCond, decodeJson(self.mapSkillInstance.ThreeStarCondition))
  for i = 1, 3 do
    local tr = self._mapNode.getStar[i]
    local star = tr:Find("star"):GetComponent("Transform")
    local starPass = star:Find("starPass")
    local txtCondition = tr:Find("texCondition"):GetComponent("TMP_Text")
    local cond = tbCond[i]
    if cond ~= nil then
      local _floorData = ConfigTable.GetData("SkillInstanceFloor", self.mapSkillInstance.FloorId)
      if _floorData then
        if cond[1] == 1 then
          NovaAPI.SetTMPText(txtCondition, orderedFormat(ConfigTable.GetUIText("SkillInstance_PassConfition_1"), _floorData.LevelTotalTime))
        else
          NovaAPI.SetTMPText(txtCondition, orderedFormat(ConfigTable.GetUIText("SkillInstance_PassConfition_2"), _floorData.LevelTotalTime - cond[2]))
        end
      end
    end
    if nil ~= starPass then
      starPass.gameObject:SetActive(tbStar[i - 1])
    end
  end
end

function SkillInstanceResultCtrl:ClosePanel()
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
    self.closeSequence = DOTween.Sequence()
    self.closeSequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
    self.closeSequence:AppendCallback(function()
      if self.bSuccess then
        self._mapNode.imgBlurredBg:SetActive(false)
        NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
      else
        function self.levelEndCallback()
          self.bAddLevelEndEvent = false
          
          EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, self.levelEndCallback)
          self._mapNode.imgBlurredBg:SetActive(false)
          NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
        end
        
        self.bAddLevelEndEvent = true
        EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, self.levelEndCallback)
        CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
      end
      self.closeSequence = nil
    end)
    self.closeSequence:SetUpdate(true)
  end
end

function SkillInstanceResultCtrl:RefreshGacha()
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

function SkillInstanceResultCtrl:OnBtnClick_Close(btn)
  if self.bOpenUpgrade then
    self:ClosePanel()
  else
    self:OpenReward()
  end
end

function SkillInstanceResultCtrl:OpenReward()
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
    
    cs_coroutine.start(wait)
  else
    self:ClosePanel()
  end
end

function SkillInstanceResultCtrl:OnBtnClick_ShowDamageResult()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
end

return SkillInstanceResultCtrl
