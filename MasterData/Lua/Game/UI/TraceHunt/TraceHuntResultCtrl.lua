local TraceHuntResultCtrl = class("TraceHuntResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
TraceHuntResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  Mask = {
    sComponentName = "CanvasGroup"
  },
  bgComplete = {},
  goComplete = {},
  goCompleteTips2 = {},
  txtCompleteTipsPrev1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Result_Star"
  },
  txtCompleteTipsPrev2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Result_Exp"
  },
  ScoreStar = {nCount = 7, sComponentName = "Button"},
  txtCompleteTipsSuf = {sComponentName = "TMP_Text"},
  txtBossName = {nCount = 2, sComponentName = "TMP_Text"},
  txtClickToContinue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  btnDamageResult = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_DamageResult"
  },
  bgFail = {},
  goFail = {},
  goFailTips = {},
  imgHuntCoin = {sComponentName = "Image"},
  txtFailTipsPrev = {sComponentName = "TMP_Text"},
  txtFailTipsSuf = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Result_Return"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
TraceHuntResultCtrl._mapEventConfig = {}

function TraceHuntResultCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.Mask.gameObject:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
end

function TraceHuntResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nLevelId = tbParam[1]
  self.totalStar = tbParam[2]
  self.nExp = tbParam[3]
  self.bSelfBoss = tbParam[4]
  self.mapChangeInfo = tbParam[5]
  self.bUpgrade = tbParam[6]
  self.nBeforeMaxStar = tbParam[7]
  self.tbCharDamage = tbParam[8]
  self.callback = tbParam[9]
  self.bSuccess = self.totalStar > 0
  CS.AdventureModuleHelper.PauseLogic()
  self._mapNode.imgBlurredBg:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self:Refresh()
  end
  
  cs_coroutine.start(wait)
end

function TraceHuntResultCtrl:Refresh()
  local bossLevelData = ConfigTable.GetData("TraceHuntBoss", self.nLevelId)
  local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  for i = 1, 2 do
    NovaAPI.SetTMPText(self._mapNode.txtBossName[i], mManual.Name)
  end
  WwiseManger:PostEvent("ui_loading_combatSFX_mute", nil, false)
  WwiseManger:PostEvent("char_common_all_pause")
  WwiseManger:PostEvent("mon_common_all_pause")
  self._mapNode.bgComplete:SetActive(self.bSuccess)
  self._mapNode.goComplete:SetActive(self.bSuccess)
  self._mapNode.bgFail:SetActive(not self.bSuccess)
  self._mapNode.goFail:SetActive(not self.bSuccess)
  local nAnimTime
  if self.bSuccess then
    self:RefreshSuc()
    nAnimTime = 0.7
    self._mapNode.animRoot:Play("TraceHuntBattleResult_Complete")
  else
    self:RefreshFail()
    nAnimTime = 0.4
    self._mapNode.animRoot:Play("TraceHuntBattleResult_Fail")
  end
  self:AddTimer(1, nAnimTime, function()
    self._mapNode.btnClose.gameObject:SetActive(true)
    NovaAPI.SetButtonInteractable(self._mapNode.btnClose, true)
  end, true, true, true)
end

function TraceHuntResultCtrl:RefreshSuc()
  WwiseManger:PlaySound("ui_infinity_victory")
  self._mapNode.btnDamageResult[1].gameObject:SetActive(self.tbCharDamage ~= nil and #self.tbCharDamage > 0)
  local nMaxStar = self.nBeforeMaxStar
  for i = 1, 7 do
    self._mapNode.ScoreStar[i].gameObject:SetActive(i <= nMaxStar)
    if i <= nMaxStar then
      self._mapNode.ScoreStar[i].interactable = i <= self.totalStar
    end
  end
  self._mapNode.goCompleteTips2:SetActive(0 < self.nExp)
  NovaAPI.SetTMPText(self._mapNode.txtCompleteTipsSuf, self.nExp)
end

function TraceHuntResultCtrl:RefreshFail()
  WwiseManger:SetState("level", "None")
  WwiseManger:SetState("combat", "None")
  WwiseManger:SetState("system", "defeat")
  self._mapNode.btnDamageResult[2].gameObject:SetActive(self.tbCharDamage ~= nil and #self.tbCharDamage > 0)
  local nCost = PlayerData.TraceHunt:GetHuntCostCount(self.bSelfBoss)
  local bShowRes = false
  if self.bSelfBoss then
    bShowRes = 0 < nCost
  else
    local nHasCoin = PlayerData.TraceHunt:GetHuntTokenCount()
    bShowRes = 0 < nCost and nCost <= nHasCoin
  end
  self._mapNode.goFailTips:SetActive(bShowRes)
  if bShowRes then
    local nId = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
    local mapItemCfg = ConfigTable.GetData_Item(nId)
    self:SetSprite_Coin(self._mapNode.imgHuntCoin, nId)
    NovaAPI.SetTMPText(self._mapNode.txtFailTipsPrev, orderedFormat(ConfigTable.GetUIText("TraceHunt_Result_Cost"), mapItemCfg.Title, nCost))
  end
end

function TraceHuntResultCtrl:OnBtnClick_Close()
  NovaAPI.SetButtonInteractable(self._mapNode.btnClose, false)
  
  local function close()
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
        local function levelEndCallback()
          EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
          
          NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
          self._mapNode.imgBlurredBg:SetActive(false)
        end
        
        EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
      end)
      sequence:SetUpdate(true)
    end
  end
  
  local function up()
    local nLevel = PlayerData.TraceHunt:GetTraceHuntLevel()
    local mapLevel = PlayerData.TraceHunt:GetTraceHuntLevelData(nLevel)
    local mapData = {nLevel = nLevel, mapLevel = mapLevel}
    EventManager.Hit(EventId.OpenPanel, PanelId.TraceHuntSucBar, mapData, close)
  end
  
  if self.mapChangeInfo and next(self.mapChangeInfo) ~= nil then
    if self.bUpgrade then
      UTILS.OpenReceiveByChangeInfo(self.mapChangeInfo, up)
    else
      UTILS.OpenReceiveByChangeInfo(self.mapChangeInfo, close)
    end
  elseif self.bUpgrade then
    up()
  else
    close()
  end
end

function TraceHuntResultCtrl:OnBtnClick_DamageResult()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
end

function TraceHuntResultCtrl:OnDestroy()
end

return TraceHuntResultCtrl
