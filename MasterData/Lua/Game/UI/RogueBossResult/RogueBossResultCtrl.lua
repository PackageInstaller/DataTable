local RogueBossResultCtrl = class("RogueBossResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
RogueBossResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  goComplete = {sComponentName = "GameObject"},
  imgNameBg = {
    nCount = 2,
    sComponentName = "RectTransform"
  },
  txtLevelName = {nCount = 2, sComponentName = "TMP_Text"},
  goStarList = {sComponentName = "GameObject"},
  getStar = {nCount = 3, sComponentName = "Transform"},
  goFailed = {sComponentName = "GameObject"},
  ButtonClose = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  Mask = {
    sComponentName = "CanvasGroup"
  },
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Fail_Tip"
  },
  txtTipShadow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Fail_Tip"
  },
  animComplete = {sNodeName = "goComplete", sComponentName = "Animator"},
  animFailed = {sNodeName = "goFailed", sComponentName = "Animator"},
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
  txtTimeTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_Time_Title"
  },
  txtTimeValue1 = {sComponentName = "TMP_Text"},
  goRankArrow = {},
  txtMaxLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Max_Level"
  },
  txtExp = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_ExpTips"
  },
  btnDamageResult = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowDamageResult"
  },
  txtClickToContinue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  }
}
RogueBossResultCtrl._mapEventConfig = {}

function RogueBossResultCtrl:ShowLevelName()
  local lvId = PlayerData.RogueBoss:GetSelLvId()
  local isWeeklyCopies = PlayerData.RogueBoss:GetIsWeeklyCopies()
  if isWeeklyCopies then
    local lvMsg = ConfigTable.GetData("WeekBossLevel", lvId)
    for _, v in ipairs(self._mapNode.txtLevelName) do
      local sName = orderedFormat(ConfigTable.GetUIText("Dungeon_Difficulty") or "", lvMsg.Name, ConfigTable.GetUIText("Diffculty_" .. lvMsg.Difficulty) or "")
      NovaAPI.SetTMPText(v, sName)
    end
  else
    local lvMsg = ConfigTable.GetData("RegionBossLevel", lvId)
    for _, v in ipairs(self._mapNode.txtLevelName) do
      local sName = orderedFormat(ConfigTable.GetUIText("Dungeon_Difficulty") or "", lvMsg.Name, ConfigTable.GetUIText("Diffculty_" .. lvMsg.Difficulty) or "")
      NovaAPI.SetTMPText(v, sName)
    end
  end
  for _, v in ipairs(self._mapNode.imgNameBg) do
    LayoutRebuilder.ForceRebuildLayoutImmediate(v)
  end
end

function RogueBossResultCtrl:ShowWinStar()
  local lvStarCount = 0
  local lvId = PlayerData.RogueBoss:GetSelLvId()
  local lvCacheBossLevelData = PlayerData.RogueBoss.CacheBossLevelMsg[lvId]
  if lvCacheBossLevelData then
    lvStarCount = lvCacheBossLevelData.Star
  end
  local isWeeklyCopies = PlayerData.RogueBoss:GetIsWeeklyCopies()
  if isWeeklyCopies then
    self._mapNode.goWorldLevel:SetActive(false)
    self._mapNode.goStarList:SetActive(false)
  else
    local lvMsg = ConfigTable.GetData("RegionBossLevel", lvId)
    if lvMsg.RegionType == GameEnum.RegionType.NormalRegion then
      for i = 1, 3 do
        local sCondition = ""
        local passConf
        if i == 1 then
          passConf = decodeJson(lvMsg.OneStarCondition)
        elseif i == 2 then
          passConf = decodeJson(lvMsg.TwoStarCondition)
        elseif i == 3 then
          passConf = decodeJson(lvMsg.ThreeStarCondition)
        end
        if passConf[1] == 1 then
          if i <= lvStarCount then
            sCondition = ConfigTable.GetUIText("RogueBoss_PassConfition_1")
          else
            sCondition = ConfigTable.GetUIText("RogueBoss_PassConfition_1")
          end
        elseif passConf[1] == 2 then
          if i <= lvStarCount then
            sCondition = orderedFormat(ConfigTable.GetUIText("RogueBoss_PassConfition_2"), passConf[2])
          else
            sCondition = orderedFormat(ConfigTable.GetUIText("RogueBoss_PassConfition_2"), passConf[2])
          end
        end
        local star = self._mapNode.getStar[i]:Find("star"):GetComponent("Transform")
        local starPass = star:Find("starPass")
        starPass.gameObject:SetActive(i <= lvStarCount)
        local texCondition = self._mapNode.getStar[i]:Find("texCondition"):GetComponent("TMP_Text")
        NovaAPI.SetTMPText(texCondition, sCondition)
      end
      self._mapNode.goStarList:SetActive(true)
    else
      self._mapNode.goStarList:SetActive(false)
    end
  end
end

function RogueBossResultCtrl:ClosePanel()
  if self.bProcessingClose then
    return
  end
  self.bProcessingClose = true
  CS.AdventureModuleHelper.ResumeLogic()
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    EventManager.Hit(EventId.CloesCurPanel)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
    self._mapNode.Mask.gameObject:SetActive(true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
    local sequence = DOTween.Sequence()
    sequence:Append(self._mapNode.Mask:DOFade(1, 0.2):SetUpdate(true))
    sequence:AppendCallback(function()
      if self.ResultState == 1 then
        NovaAPI.EnterModule("MainMenuModuleScene", true)
      else
        local function levelEndCallback()
          EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
          
          NovaAPI.EnterModule("MainMenuModuleScene", true)
        end
        
        EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        CS.AdventureModuleHelper.LevelStateChanged(true)
      end
    end)
    sequence:SetUpdate(true)
  end
end

function RogueBossResultCtrl:OpenReward()
  if self.ResultState == 2 then
    self:ClosePanel()
  else
    local function callback()
      self:ClosePanel()
    end
    
    UTILS.OpenReceiveByDisplayItem(self.tbReward, self.mapChangeInfo, callback)
  end
end

function RogueBossResultCtrl:PlayAnim()
  PlayerData.SideBanner:TryOpenSideBanner()
  
  local function callback()
    self:OpenReward()
  end
  
  self.bWorldClassUpgrade = PlayerData.Base:TryOpenWorldClassUpgrade(callback)
end

function RogueBossResultCtrl:RefreshWorldClass(nExp)
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

function RogueBossResultCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  EventManager.Hit(EventId.AvgBubbleShutDown)
  NovaAPI.SetComponentEnable(self.canvas, false)
  self.ResultState = 0
end

function RogueBossResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nResultState = tbParam[1]
  local nResultTime = tbParam[2]
  local buildId = tbParam[3]
  local nExp = tbParam[4] or 0
  self.tbReward = tbParam[5] or {}
  self.mapChangeInfo = tbParam[6]
  self.tbCharDamage = tbParam[7] or {}
  NovaAPI.SetTMPText(self._mapNode.txtTimeValue1, orderedFormat(ConfigTable.GetUIText("StarTower_Result_Time") or "", nResultTime))
  for i = 1, #self._mapNode.btnDamageResult do
    self._mapNode.btnDamageResult[i].gameObject:SetActive(self.tbCharDamage ~= nil and 0 < #self.tbCharDamage)
  end
  local buildData = PlayerData.Build:GetBuildData(buildId)
  local teamMemberid = {}
  for i, v in pairs(buildData.tbChar) do
    table.insert(teamMemberid, v.nTid)
  end
  WwiseManger:PostEvent("ui_loading_combatSFX_mute", nil, false)
  WwiseManger:PostEvent("char_common_all_pause")
  WwiseManger:PostEvent("mon_common_all_pause")
  WwiseManger:SetState("level", "None")
  WwiseManger:SetState("combat", "None")
  local nAnimTime
  if nResultState == 1 then
    self._mapNode.goFailed:SetActive(false)
    self._mapNode.goComplete:SetActive(true)
    self.ResultState = 1
    self._mapNode.goRoot.gameObject:SetActive(true)
    WwiseManger:PlaySound("ui_roguelike_victory")
    WwiseManger:SetState("system", "victory")
    nAnimTime = 4
  elseif nResultState == 2 then
    WwiseManger:SetState("system", "defeat")
    CS.AdventureModuleHelper.PauseLogic()
    self._mapNode.imgBlurredBg:SetActive(true)
    self._mapNode.goRoot.gameObject:SetActive(false)
    self._mapNode.imgBlurredBg.gameObject:SetActive(true)
    self._mapNode.goFailed:SetActive(true)
    self._mapNode.goComplete:SetActive(false)
    self.ResultState = 2
    nAnimTime = 3
    CS.AdventureModuleHelper.PauseLogic()
  end
  self._mapNode.Mask.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    NovaAPI.SetComponentEnable(self.canvas, true)
    self:ShowLevelName()
  end
  
  cs_coroutine.start(wait)
  nAnimTime = nAnimTime + 1.5
  self:AddTimer(1, nAnimTime, "PlayAnim", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  PlayerData.Voice:PlayBattleResultVoice(teamMemberid, nResultState == 1)
  self.bProcessingClose = false
end

function RogueBossResultCtrl:OnDestroy()
  EventManager.Hit("OpenRogueBossPanel")
  PlayerData.Voice:StopCharVoice()
end

function RogueBossResultCtrl:OnBtnClick_Close(btn)
  self:OpenReward()
end

function RogueBossResultCtrl:OnBtnClick_ShowDamageResult(btn)
  if self.tbCharDamage ~= nil and #self.tbCharDamage > 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
  end
end

return RogueBossResultCtrl
