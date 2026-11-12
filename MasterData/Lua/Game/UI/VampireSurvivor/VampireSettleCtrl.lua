local VampireSettleCtrl = class("VampireSettleCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
VampireSettleCtrl._mapNodeConfig = {
  goSuccess = {},
  goFail = {},
  TMPLevelName = {nCount = 2, sComponentName = "TMP_Text"},
  TMPFateCardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireSettle_FateCardTitle"
  },
  TMPFateCardCount = {sComponentName = "TMP_Text"},
  TMPAreaTitle = {nCount = 3, sComponentName = "TMP_Text"},
  TMPTotalTitle = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "VampireSettle_TotalTitle"
  },
  TMPTotalScore = {nCount = 3, sComponentName = "TMP_Text"},
  TMPFailTitle = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "VampireSettle_FailTitle"
  },
  TMPInfo = {nCount = 15, sComponentName = "TMP_Text"},
  TMPScore = {nCount = 15, sComponentName = "TMP_Text"},
  TMPFinalTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireSettle_FinalTitle"
  },
  TMPNewRecord = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireSettle_NewRecord"
  },
  imgNewRecordBg = {},
  TMPFinalScore = {sComponentName = "TMP_Text"},
  ainmator = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  rtContnet = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  goPass = {nCount = 3},
  goInfoFail = {nCount = 3},
  btnScreen = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  blur = {sNodeName = "snapshot"},
  Mask = {
    sComponentName = "CanvasGroup"
  },
  imgSingleBg = {},
  imgInfoBg = {sNodeName = "imgInfoBgD"},
  btnDamageResult1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowDamageResult1"
  },
  btnDamageResult2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowDamageResult2"
  },
  btnDamageResult3 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowDamageResult1"
  }
}
VampireSettleCtrl._mapEventConfig = {}
VampireSettleCtrl._mapRedDotConfig = {}

function VampireSettleCtrl:Awake()
  self._mapNode.rtContnet.localScale = Vector3.zero
end

function VampireSettleCtrl:FadeIn()
end

function VampireSettleCtrl:FadeOut()
end

function VampireSettleCtrl:OnEnable()
  self._mapNode.Mask.gameObject:SetActive(false)
  local bSuccess = self._panel._tbParam[1]
  local nLevelId = self._panel._tbParam[2]
  local nFateCardCount = self._panel._tbParam[3]
  local tbArea1 = self._panel._tbParam[4]
  local tbArea2 = self._panel._tbParam[5]
  local nTotalScore = self._panel._tbParam[6]
  local bNew = self._panel._tbParam[7]
  self.callback = self._panel._tbParam[8]
  self.tbCharDamageFirst = self._panel._tbParam[9]
  self.tbCharDamageSecond = self._panel._tbParam[10]
  self._mapNode.goSuccess:SetActive(bSuccess)
  self._mapNode.goFail:SetActive(not bSuccess)
  self._mapNode.imgNewRecordBg:SetActive(bNew)
  local mapLevelCfgData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  NovaAPI.SetTMPText(self._mapNode.TMPFateCardCount, tostring(nFateCardCount))
  if mapLevelCfgData ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TMPLevelName[1], mapLevelCfgData.Name)
    NovaAPI.SetTMPText(self._mapNode.TMPLevelName[2], mapLevelCfgData.Name)
    NovaAPI.SetTMPText(self._mapNode.TMPAreaTitle[1], mapLevelCfgData.Name1)
    NovaAPI.SetTMPText(self._mapNode.TMPAreaTitle[2], mapLevelCfgData.Name2)
    NovaAPI.SetTMPText(self._mapNode.TMPAreaTitle[3], mapLevelCfgData.Name1)
  else
    return
  end
  if mapLevelCfgData.Mode == GameEnum.vampireSurvivorMode.Double then
    self._mapNode.imgInfoBg:SetActive(true)
    self._mapNode.imgSingleBg:SetActive(false)
    if tbArea1 == nil or tbArea1.KillCount == nil then
      self._mapNode.goPass[1]:SetActive(false)
      self._mapNode.goInfoFail[1]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.TMPTotalScore[1], 0)
    else
      self._mapNode.goPass[1]:SetActive(true)
      self._mapNode.goInfoFail[1]:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[1], orderedFormat(ConfigTable.GetUIText("VampireSettle_MonsterCount"), tbArea1.KillCount[1]))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[1], tbArea1.KillScore[1])
      local nBonusScore = 0
      for i = 5, #tbArea1.KillScore do
        nBonusScore = nBonusScore + tbArea1.KillScore[i]
      end
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[2], ConfigTable.GetUIText("VampireSettle_Bonus"))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[2], nBonusScore)
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[3], orderedFormat(ConfigTable.GetUIText("VampireSettle_EliteCount"), tbArea1.KillCount[2] + tbArea1.KillCount[3]))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[3], tbArea1.KillScore[2] + tbArea1.KillScore[3])
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[4], ConfigTable.GetUIText("VampireSettle_LordCount"))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[4], tbArea1.KillScore[4])
      if tbArea1.KillScore[4] == 0 then
        NovaAPI.SetTMPText(self._mapNode.TMPInfo[5], ConfigTable.GetUIText("Vampire_BossTime_Fail"))
        NovaAPI.SetTMPText(self._mapNode.TMPScore[5], "---")
      else
        NovaAPI.SetTMPText(self._mapNode.TMPInfo[5], orderedFormat(ConfigTable.GetUIText("VampireSettle_TimeTitle"), tbArea1.BossTime))
        local nTimeScore = tbArea1.Score
        for i = 1, #tbArea1.KillScore do
          nTimeScore = nTimeScore - tbArea1.KillScore[i]
        end
        NovaAPI.SetTMPText(self._mapNode.TMPScore[5], nTimeScore)
      end
      NovaAPI.SetTMPText(self._mapNode.TMPTotalScore[1], tbArea1.Score)
    end
    if tbArea2 == nil or tbArea2.KillCount == nil then
      self._mapNode.goPass[2]:SetActive(false)
      self._mapNode.goInfoFail[2]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.TMPTotalScore[2], 0)
    else
      self._mapNode.goPass[2]:SetActive(true)
      self._mapNode.goInfoFail[2]:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[6], orderedFormat(ConfigTable.GetUIText("VampireSettle_MonsterCount"), tbArea2.KillCount[1]))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[6], tbArea2.KillScore[1])
      local nBonusScore = 0
      for i = 5, #tbArea2.KillScore do
        nBonusScore = nBonusScore + tbArea2.KillScore[i]
      end
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[7], ConfigTable.GetUIText("VampireSettle_Bonus"))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[7], nBonusScore)
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[8], orderedFormat(ConfigTable.GetUIText("VampireSettle_EliteCount"), tbArea2.KillCount[2] + tbArea2.KillCount[3]))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[8], tbArea2.KillScore[2] + tbArea2.KillScore[3])
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[9], ConfigTable.GetUIText("VampireSettle_LordCount"))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[9], tbArea2.KillScore[4])
      if tbArea2.KillScore[4] == 0 then
        NovaAPI.SetTMPText(self._mapNode.TMPInfo[10], ConfigTable.GetUIText("Vampire_BossTime_Fail"))
        NovaAPI.SetTMPText(self._mapNode.TMPScore[10], "---")
      else
        NovaAPI.SetTMPText(self._mapNode.TMPInfo[10], orderedFormat(ConfigTable.GetUIText("VampireSettle_TimeTitle"), tbArea2.BossTime))
        local nTimeScore = tbArea2.Score
        for i = 1, #tbArea2.KillScore do
          nTimeScore = nTimeScore - tbArea2.KillScore[i]
        end
        NovaAPI.SetTMPText(self._mapNode.TMPScore[10], nTimeScore)
      end
      NovaAPI.SetTMPText(self._mapNode.TMPTotalScore[2], tbArea2.Score)
    end
  else
    self._mapNode.imgInfoBg:SetActive(false)
    self._mapNode.imgSingleBg:SetActive(true)
    if tbArea1 == nil or tbArea1.KillCount == nil then
      self._mapNode.goPass[3]:SetActive(false)
      self._mapNode.goInfoFail[3]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.TMPTotalScore[3], 0)
    else
      self._mapNode.goPass[3]:SetActive(true)
      self._mapNode.goInfoFail[3]:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[11], orderedFormat(ConfigTable.GetUIText("VampireSettle_MonsterCount"), tbArea1.KillCount[1]))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[11], tbArea1.KillScore[1])
      local nBonusScore = 0
      for i = 5, #tbArea1.KillScore do
        nBonusScore = nBonusScore + tbArea1.KillScore[i]
      end
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[12], ConfigTable.GetUIText("VampireSettle_Bonus"))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[12], nBonusScore)
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[13], orderedFormat(ConfigTable.GetUIText("VampireSettle_EliteCount"), tbArea1.KillCount[2] + tbArea1.KillCount[3]))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[13], tbArea1.KillScore[2] + tbArea1.KillScore[3])
      NovaAPI.SetTMPText(self._mapNode.TMPInfo[14], ConfigTable.GetUIText("VampireSettle_LordCount"))
      NovaAPI.SetTMPText(self._mapNode.TMPScore[14], tbArea1.KillScore[4])
      if tbArea1.KillScore[4] == 0 then
        NovaAPI.SetTMPText(self._mapNode.TMPInfo[15], ConfigTable.GetUIText("Vampire_BossTime_Fail"))
        NovaAPI.SetTMPText(self._mapNode.TMPScore[15], "---")
      else
        NovaAPI.SetTMPText(self._mapNode.TMPInfo[15], orderedFormat(ConfigTable.GetUIText("VampireSettle_TimeTitle"), tbArea1.BossTime))
        local nTimeScore = tbArea1.Score
        for i = 1, #tbArea1.KillScore do
          nTimeScore = nTimeScore - tbArea1.KillScore[i]
        end
        NovaAPI.SetTMPText(self._mapNode.TMPScore[15], nTimeScore)
      end
      NovaAPI.SetTMPText(self._mapNode.TMPTotalScore[3], tbArea1.Score)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.TMPFinalScore, FormatWithCommas(nTotalScore))
  WwiseManger:PostEvent("char_common_all_pause")
  WwiseManger:PostEvent("mon_common_all_pause")
  if bSuccess then
    WwiseManger:PlaySound("ui_infinity_victory")
    self._mapNode.ainmator:Play("VampireSettle_Success")
  else
    self._mapNode.ainmator:Play("VampireSettle_Fail")
  end
  self.bCloseable = false
  
  local function animEnd()
    self.bCloseable = true
  end
  
  self:AddTimer(1, 1.5, animEnd, true, true, true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.btnDamageResult1.gameObject:SetActive(self.tbCharDamageFirst ~= nil and #self.tbCharDamageFirst > 0)
  self._mapNode.btnDamageResult2.gameObject:SetActive(self.tbCharDamageSecond ~= nil and #self.tbCharDamageSecond > 0)
  self._mapNode.btnDamageResult3.gameObject:SetActive(self.tbCharDamageFirst ~= nil and #self.tbCharDamageFirst > 0)
  
  local function wait()
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.blur)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.rtContnet.localScale = Vector3.one
  end
  
  cs_coroutine.start(wait)
end

function VampireSettleCtrl:OnDisable()
end

function VampireSettleCtrl:OnDestroy()
end

function VampireSettleCtrl:OnRelease()
end

function VampireSettleCtrl:OnBtnClick_ShowDamageResult1()
  if self.tbCharDamageFirst ~= nil and #self.tbCharDamageFirst > 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamageFirst)
  end
end

function VampireSettleCtrl:OnBtnClick_ShowDamageResult2()
  if self.tbCharDamageSecond ~= nil and #self.tbCharDamageSecond > 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamageSecond)
  end
end

function VampireSettleCtrl:OnBtnClick_Close()
  if not self.bCloseable then
    return
  end
  self.bCloseable = false
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
  self._mapNode.Mask.gameObject:SetActive(true)
  local sequence = DOTween.Sequence()
  sequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
  sequence:AppendCallback(function()
    if self.callback ~= nil and type(self.callback) == "function" then
      self.callback()
    end
  end)
  sequence:SetUpdate(true)
end

return VampireSettleCtrl
