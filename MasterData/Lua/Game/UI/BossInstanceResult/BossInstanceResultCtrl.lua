local BossInstanceResultCtrl = class("BossInstanceResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
BossInstanceResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goComplete = {sComponentName = "GameObject"},
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
BossInstanceResultCtrl._mapEventConfig = {}
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

function BossInstanceResultCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  EventManager.Hit(EventId.AvgBubbleShutDown)
  NovaAPI.SetComponentEnable(self.canvas, false)
  self._mapNode.goGacha.gameObject:SetActive(false)
end

function BossInstanceResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local bResultState = tbParam[1]
  local nStar = tbParam[2]
  local mapReward = tbParam[3]
  local nExp = tbParam[4] or 0
  local RegionBossLevelId = tbParam[5]
  local tbChar = tbParam[6]
  self.mapChangeInfo = tbParam[7]
  self.tbCharDamage = tbParam[8]
  for i = 1, 2 do
    self._mapNode.btnDamageResult[i].gameObject:SetActive(self.tbCharDamage ~= nil and 0 < #self.tbCharDamage)
  end
  self.mapRegionBossLevel = ConfigTable.GetData("RegionBossLevel", RegionBossLevelId)
  local sRegionBossLevelName = ""
  if self.mapRegionBossLevel ~= nil then
    sRegionBossLevelName = self.mapRegionBossLevel.Name
  end
  self.nLevelStar = nStar
  self.bSuccess = 0 < nStar
  self.mapReward = mapReward
  for _, v in ipairs(self._mapNode.txtMainlineName) do
    local sName = orderedFormat(ConfigTable.GetUIText("Dungeon_Difficulty") or "", sRegionBossLevelName, ConfigTable.GetUIText("Diffculty_" .. self.mapRegionBossLevel.Difficulty) or "")
    NovaAPI.SetTMPText(v, sName)
  end
  self:RefreshWorldClass(nExp)
  self:RefreshTarget(nStar)
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
  if bResultState then
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.goFailed:SetActive(false)
    self._mapNode.imgBlurredBg.gameObject:SetActive(false)
    self._mapNode.goComplete:SetActive(true)
    CS.WwiseAudioManager.Instance:PlaySound("ui_roguelike_victory")
    WwiseManger:SetState("system", "victory")
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
  self._mapNode.ButtonClose[1].gameObject:SetActive(false)
  self._mapNode.ButtonClose[2].gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.ButtonClose[1].gameObject:SetActive(true)
    self._mapNode.ButtonClose[2].gameObject:SetActive(true)
    NovaAPI.SetComponentEnable(self.canvas, true)
  end
  
  cs_coroutine.start(wait)
  nAnimTime = nAnimTime + 1.5
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  self:AddTimer(1, nAnimTime, "PlayAnim", true, true, true)
  PlayerData.Voice:PlayBattleResultVoice(tbRoleId, self.bSuccess)
  self.bProcessingClose = false
end

function BossInstanceResultCtrl:OnDisable()
  PlayerData.Voice:StopCharVoice()
end

function BossInstanceResultCtrl:PlayAnim()
  PlayerData.SideBanner:TryOpenSideBanner()
  
  local function callback()
    self:OpenReward()
  end
  
  self.bOpenUpgrade = PlayerData.Base:TryOpenWorldClassUpgrade(callback)
end

function BossInstanceResultCtrl:RefreshWorldClass(nExp)
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

function BossInstanceResultCtrl:RefreshTarget(nStar)
  local tmpTwoTime = 300
  for i = 1, 3 do
    local sCondition = ""
    local passConf
    if i == 1 then
      passConf = decodeJson(self.mapRegionBossLevel.OneStarCondition)
    elseif i == 2 then
      passConf = decodeJson(self.mapRegionBossLevel.TwoStarCondition)
      tmpTwoTime = passConf[2]
    elseif i == 3 then
      passConf = decodeJson(self.mapRegionBossLevel.ThreeStarCondition)
    end
    if passConf ~= nil then
      if i == 1 then
        sCondition = ConfigTable.GetUIText("RegionBoss_PassConfition_1")
      elseif i == 2 then
        sCondition = ConfigTable.GetUIText("RegionBoss_PassConfition_2")
      elseif i == 3 then
        sCondition = orderedFormat(ConfigTable.GetUIText("RegionBoss_PassConfition_3"), tmpTwoTime - passConf[2])
      end
    end
    local star = self._mapNode.getStar[i]:Find("star"):GetComponent("Transform")
    local starPass = star:Find("starPass")
    if nil ~= starPass then
      starPass.gameObject:SetActive(i <= nStar)
    end
    local texCondition = self._mapNode.getStar[i]:Find("texCondition"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(texCondition, sCondition)
  end
  self._mapNode.goStarList:SetActive(true)
end

function BossInstanceResultCtrl:ClosePanel()
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

function BossInstanceResultCtrl:RefreshGacha()
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

function BossInstanceResultCtrl:OnBtnClick_Close(btn)
  if self.bOpenUpgrade then
    self:ClosePanel()
  else
    self:OpenReward()
  end
end

function BossInstanceResultCtrl:OpenReward()
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

function BossInstanceResultCtrl:OnBtnClick_ShowDamageResult()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
end

return BossInstanceResultCtrl
