local SoldierBattleResultCtrl = class("SoldierBattleResultCtrl", BaseCtrl)
SoldierBattleResultCtrl._mapNodeConfig = {
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  Bg = {},
  BgFail = {},
  goNodeSuccess = {},
  goNodeFail = {},
  goNodeExpansion = {},
  goNodeExpansionFail = {},
  goBattleReputation = {},
  imgNumBarReputation = {sComponentName = "Image"},
  txtNumPrestige = {sComponentName = "TMP_Text"},
  txtNumPrestigeAdd = {sComponentName = "TMP_Text"},
  goBattleRound = {},
  BarContainer = {
    sComponentName = "RectTransform"
  },
  imgNodeIcon = {sComponentName = "Image"},
  txt_NodeIndex = {sComponentName = "TMP_Text"},
  Partner = {nCount = 2},
  txt_PartnerBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "SoldierNodeType_Event"
  },
  txt_PartnerWinning = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_WinningTitle"
  },
  txt_PartnerWinningNum = {sComponentName = "TMP_Text"},
  imgNumBar = {sComponentName = "Image"},
  txtNumRoundPrestige = {sComponentName = "TMP_Text"},
  txtNumRoundTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_Prestige"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  txtExp = {sComponentName = "TMP_Text"},
  txtNumLvTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_ExperienceTitle"
  },
  txtDataStatisticsTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_StatisticsTitle"
  },
  txtNumCoinsTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_CoinsTitle"
  },
  txtCoinsTotalCount = {sComponentName = "TMP_Text"},
  coinItem = {sComponentName = "Transform"},
  CoinListRoot = {sComponentName = "Transform"},
  gosoldierItemRoot = {sComponentName = "Transform"},
  soldierDamageItem = {sComponentName = "Transform"},
  goBattleExpansion = {},
  NumLayout = {sComponentName = "Transform"},
  NumRootItem = {sComponentName = "Transform"},
  txtListTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_ScoreTitle_1"
  },
  txtListTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_ScoreTitle_2"
  },
  txtListTitle3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_ScoreTitle_3"
  },
  txtListNum = {nCount = 3, sComponentName = "TMP_Text"},
  goReward = {nCount = 3, sComponentName = "Transform"},
  txtAwardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_AwardTitle"
  },
  txtScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Result_ScoreTitle"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Level_Select_Continue"
  },
  btnSettlement = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Result"
  },
  txtBtnSettlement = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Level_Select_GoResult"
  },
  Mask = {
    sComponentName = "CanvasGroup"
  },
  goBattleReport = {
    sCtrlName = "Game.UI.Soldier.Battle.SoldierResultReportCtrl"
  }
}
SoldierBattleResultCtrl._mapEventConfig = {
  SoldierChallengeEnd = "OnEvent_SoldierChallengeEnd"
}
SoldierBattleResultCtrl._mapRedDotConfig = {}
local CSColor = Color(1.0, 0.8392156862745098, 0.5333333333333333, 1)
local CFColor = Color(0.9137254901960784, 0.9294117647058824, 0.9490196078431372, 1)
local _NS = AllEnum.SoldierResultType.NodeSuccess
local _NF = AllEnum.SoldierResultType.NodeFail
local _CS = AllEnum.SoldierResultType.ChallengeSuccess
local _CF = AllEnum.SoldierResultType.ChallengeFail
local AssetRoot = "Icon/SoldierOtherIcon/"

function SoldierBattleResultCtrl:RefreshResult()
  self.bInBattleReport = false
  self._mapNode.goBattleReport.gameObject:SetActive(false)
  self._mapNode.BgFail.gameObject:SetActive(self.nResultType == _NF or self.nResultType == _CF)
  self._mapNode.Bg.gameObject:SetActive(self.nResultType == _NS or self.nResultType == _CS)
  self._mapNode.goNodeSuccess.gameObject:SetActive(self.nResultType == _NS)
  self._mapNode.goNodeFail.gameObject:SetActive(self.nResultType == _NF)
  self._mapNode.goNodeExpansion.gameObject:SetActive(self.nResultType == _CS)
  self._mapNode.goNodeExpansionFail.gameObject:SetActive(self.nResultType == _CF)
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  if self.nResultType == _NS or self.nResultType == _NF then
    self:SetGoBattleReputationMsg()
    self:SetGoBattleRoundMsg()
    self._mapNode.goBattleReputation:SetActive(true)
    self._mapNode.goBattleRound:SetActive(true)
    self._mapNode.goBattleExpansion:SetActive(false)
    if self.levelData:GetHp() > 0 then
      self._mapNode.btnConfirm.gameObject:SetActive(true)
      self._mapNode.btnSettlement.gameObject:SetActive(false)
    else
      self._mapNode.btnConfirm.gameObject:SetActive(false)
      self._mapNode.btnSettlement.gameObject:SetActive(true)
    end
    NovaAPI.SetTMPText(self._mapNode.txtBtnConfirm, ConfigTable.GetUIText("Soldier_Result_Continue"))
  elseif self.nResultType == _CS or self.nResultType == _CF then
    self.challengeColor = self.nResultType == _CS and CSColor or CFColor
    self:SetGoBattleExpansionMsg()
    self._mapNode.goBattleReputation:SetActive(false)
    self._mapNode.goBattleRound:SetActive(false)
    self._mapNode.goBattleExpansion:SetActive(true)
    self._mapNode.btnConfirm.gameObject:SetActive(true)
    self._mapNode.btnSettlement.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtBtnConfirm, ConfigTable.GetUIText("Soldier_Result_Continue_Report"))
  end
  self:AddTimer(1, 0.1, function()
    if self.nResultType == _NS then
      self.nAnimator:Play("SoldierResult_successfulchallenge01")
    elseif self.nResultType == _NF then
      self.nAnimator:Play("SoldierResult_failchallenge01")
    elseif self.nResultType == _CS then
      self.nAnimator:Play("SoldierResult_successfulexpansion02")
    elseif self.nResultType == _CF then
      self.nAnimator:Play("SoldierResult_failexpansion02")
    end
  end, true, true, true)
end

function SoldierBattleResultCtrl:ClosePanel()
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
      end
      
      EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
      CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
    end)
    sequence:SetUpdate(true)
  end
end

function SoldierBattleResultCtrl:Awake()
end

function SoldierBattleResultCtrl:OnEnable()
  self.mapNextData = nil
  CS.AdventureModuleHelper.PauseLogic()
  self.nAnimator = self.gameObject:GetComponent("Animator")
  self._mapNode.goBattleReport.gameObject:SetActive(false)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nResultType = tbParam[1]
    self.mapData = tbParam[2]
    self.callback = tbParam[3]
    self:RefreshResult()
  end
end

function SoldierBattleResultCtrl:OnDisable()
  if self.callback ~= nil then
    self.callback()
  end
end

function SoldierBattleResultCtrl:OnDestroy()
  if self.tbSoldierGridCtrl ~= nil then
    for nInstanceId, objCtrl in pairs(self.tbSoldierGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbSoldierGridCtrl[nInstanceId] = nil
    end
    self.tbSoldierGridCtrl = {}
  end
  if self.ReputationTweener ~= nil then
    self.ReputationTweener:Kill()
    self.ReputationTweener = nil
  end
  if self.tbScoreDigitTweeners ~= nil then
    for _, tw in ipairs(self.tbScoreDigitTweeners) do
      if tw ~= nil then
        tw:Kill()
      end
    end
    self.tbScoreDigitTweeners = nil
  end
end

function SoldierBattleResultCtrl:OnBtnClick_Confirm()
  if self.mapNextData ~= nil then
    self.nResultType = self.mapNextData.nType
    self.mapData = self.mapNextData.mapData
    self.callback = self.mapNextData.callback
    self:RefreshResult()
    self.mapNextData = nil
    return
  end
  if (self.nResultType == _CS or self.nResultType == _CF) and not self.bInBattleReport then
    self:ShowBattleReport()
    return
  end
  self:ClosePanel()
end

function SoldierBattleResultCtrl:ShowBattleReport()
  self.bInBattleReport = true
  self._mapNode.goBattleExpansion:SetActive(false)
  self._mapNode.goNodeExpansion.gameObject:SetActive(false)
  self._mapNode.goNodeExpansionFail.gameObject:SetActive(false)
  self._mapNode.goBattleReport.gameObject:SetActive(true)
  self._mapNode.goBattleReport:SetData(self.mapData or {})
  NovaAPI.SetTMPText(self._mapNode.txtBtnConfirm, ConfigTable.GetUIText("Soldier_Result_Report_Confirm"))
  if self.nResultType == _CS then
    self.nAnimator:Play("SoldierResult_successfulexpansion03")
  elseif self.nResultType == _CF then
    self.nAnimator:Play("SoldierResult_failexpansion03")
  end
end

function SoldierBattleResultCtrl:OnBtnClick_Result()
  self:ClosePanel()
end

function SoldierBattleResultCtrl:OnEvent_SoldierChallengeEnd(nType, mapData, callback)
  self.mapNextData = {
    nType = nType,
    mapData = mapData,
    callback = callback
  }
end

function SoldierBattleResultCtrl:SetGoBattleReputationMsg()
  NovaAPI.SetTMPText(self._mapNode.txtNumPrestige, self.levelData:GetHp())
  if self.mapData.tbChange.nHpChange >= 0 then
    NovaAPI.SetTMPText(self._mapNode.txtNumPrestigeAdd, ConfigTable.GetUIText("Soldier_Result_Prestige") .. " +" .. self.mapData.tbChange.nHpChange)
  else
    NovaAPI.SetTMPText(self._mapNode.txtNumPrestigeAdd, ConfigTable.GetUIText("Soldier_Result_Prestige") .. " " .. self.mapData.tbChange.nHpChange)
  end
  CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_result_reputationUp")
  local imgBar = self._mapNode.imgNumBarReputation
  local nHpEnd = self.levelData:GetHp()
  local nFullHp = 100
  imgBar.fillAmount = 0
  self:AddTimer(1, 1, function()
    local nTarget = nHpEnd / nFullHp
    if nTarget < 0 then
      nTarget = 0
    end
    if 1 < nTarget then
      nTarget = 1
    end
    self.reputationBarTweener = DOTween.To(function()
      return imgBar.fillAmount
    end, function(value)
      imgBar.fillAmount = value
    end, nTarget, 0.5):SetUpdate(true)
  end, true, true, true)
end

function SoldierBattleResultCtrl:GetCurChallengeState()
  if PlayerData.SoldierData.curChallengeData == nil then
    return 0, 0
  end
  if PlayerData.SoldierData.curChallengeData.nGradeChallengeId == 0 then
    return 0, 0
  end
  local curChallengeCfg = ConfigTable.GetData("SoldierGradeChallenge", PlayerData.SoldierData.curChallengeData.nGradeChallengeId)
  if not curChallengeCfg then
    return 0, 0
  end
  local tbAllNodeList = {}
  
  local function func_ForEach_SoldierNodePlan(mapLine)
    if curChallengeCfg.NodeGroupId == mapLine.NodeGroupId then
      table.insert(tbAllNodeList, mapLine)
    end
  end
  
  ForEachTableLine(DataTable.SoldierNodePlan, func_ForEach_SoldierNodePlan)
  table.sort(tbAllNodeList, function(a, b)
    return a.Index < b.Index
  end)
  local mapCfg = ConfigTable.GetData("SoldierNodePlan", self.mapData.tbChange.tbNodeChange.nLastNodeId)
  local nNodexIndex = mapCfg.Index
  local nStage = self.mapData.tbChange.tbNodeChange.nLastStageId
  for i = 1, #tbAllNodeList do
    local nodeCfg = tbAllNodeList[i]
    if nStage > nodeCfg.Stage then
      nNodexIndex = nNodexIndex - 1
    end
  end
  return nStage, nNodexIndex
end

function SoldierBattleResultCtrl:SetGoBattleRoundMsg()
  local nStage, nNodexIndex = self:GetCurChallengeState()
  local nNodeType = self.mapData.tbChange.tbNodeChange.nLastNodeType
  local tbNodeType = AllEnum.SoliderNoteTypeCfg[nNodeType]
  self:SetPngSprite(self._mapNode.imgNodeIcon, AssetRoot .. tbNodeType.Icon)
  NovaAPI.SetTMPText(self._mapNode.txt_PartnerBattle, ConfigTable.GetUIText(tbNodeType.Language))
  NovaAPI.SetTMPText(self._mapNode.txt_NodeIndex, nStage .. "-" .. nNodexIndex)
  if self.mapData.bEventBattle then
    self._mapNode.Partner[2]:SetActive(false)
  else
    local nWiningStreak, nLosingStreak = self.levelData:GetStreakCount()
    if 0 < nWiningStreak then
      NovaAPI.SetTMPText(self._mapNode.txt_PartnerWinning, ConfigTable.GetUIText("Soldier_Result_WinningTitle"))
      NovaAPI.SetTMPText(self._mapNode.txt_PartnerWinningNum, "x" .. nWiningStreak)
    elseif 0 < nLosingStreak then
      NovaAPI.SetTMPText(self._mapNode.txt_PartnerWinning, ConfigTable.GetUIText("Soldier_Result_LosingingTitle"))
      NovaAPI.SetTMPText(self._mapNode.txt_PartnerWinningNum, "x" .. nLosingStreak)
    end
    self._mapNode.Partner[2]:SetActive(true)
  end
  local nCurLevel, nMaxLevel = self.levelData:GetShopLevel()
  NovaAPI.SetTMPText(self._mapNode.txtNumRoundPrestige, self.levelData:GetHp())
  self._mapNode.imgNumBar.fillAmount = self.levelData:GetHp() / 100
  NovaAPI.SetTMPText(self._mapNode.txtLevel, "<size=20>LV</size>" .. tostring(nCurLevel))
  if nCurLevel == nMaxLevel then
    self._mapNode.BarContainer.sizeDelta = Vector2(134, 28)
    NovaAPI.SetTMPText(self._mapNode.txtExp, ConfigTable.GetUIText("Soldier_Sandtable_MaxLevel"))
  else
    local nNeedExp = ConfigTable.GetData("SoldierShopLevel", nCurLevel).Exp
    local nCurExp = self.levelData:GetExp()
    self._mapNode.BarContainer.sizeDelta = Vector2(134 * (nCurExp / nNeedExp), 28)
    NovaAPI.SetTMPText(self._mapNode.txtExp, tostring(nCurExp) .. "/" .. tostring(nNeedExp))
  end
  self._mapNode.coinItem.gameObject:SetActive(false)
  local totalC = self.mapData.tbCoinReward.base + self.mapData.tbCoinReward.interest + self.mapData.tbCoinReward.winningStreak + self.mapData.tbCoinReward.losingStreak + self.mapData.tbCoinReward.other
  NovaAPI.SetTMPText(self._mapNode.txtCoinsTotalCount, totalC)
  self:SetRewardItem(self.mapData.tbCoinReward.base, "Soldier_GoldTips_BasicReward")
  self:SetRewardItem(self.mapData.tbCoinReward.interest, "Soldier_GoldTips_Interest")
  self:SetRewardItem(self.mapData.tbCoinReward.winningStreak, "Soldier_GoldTips_Winningstreak")
  self:SetRewardItem(self.mapData.tbCoinReward.losingStreak, "Soldier_GoldTips_Losingingstreak")
  self:SetRewardItem(self.mapData.tbCoinReward.other, "Soldier_GoldTips_Other")
  local maxDamage = 0
  self.tbSoldierGridCtrl = {}
  local tbSortedDamage = {}
  for i, v in pairs(self.mapData.tbDamage) do
    if maxDamage < v.nDamage then
      maxDamage = v.nDamage
    end
    table.insert(tbSortedDamage, {id = i, data = v})
  end
  table.sort(tbSortedDamage, function(a, b)
    return a.data.nDamage > b.data.nDamage
  end)
  self._mapNode.soldierDamageItem.gameObject:SetActive(false)
  for _, item in ipairs(tbSortedDamage) do
    self:SetSoldierDamageItem(item.id, item.data, maxDamage)
  end
end

function SoldierBattleResultCtrl:SetRewardItem(count, languageId)
  if count == nil or count == 0 then
    return
  end
  local goR = instantiate(self._mapNode.coinItem, self._mapNode.CoinListRoot)
  goR.gameObject:SetActive(true)
  local txt_name = goR:Find("txt_name"):GetComponent("TMP_Text")
  local txRefreshCount = goR:Find("txRefreshCount"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_name, ConfigTable.GetUIText(languageId))
  NovaAPI.SetTMPText(txRefreshCount, count)
end

function SoldierBattleResultCtrl:SetSoldierDamageItem(id, damageData, maxDamage)
  local goR = instantiate(self._mapNode.soldierDamageItem, self._mapNode.gosoldierItemRoot)
  goR.gameObject:SetActive(true)
  local imgNumLine = goR:Find("imgNumLine"):GetComponent("RectTransform")
  local txDamageCount = goR:Find("imgNumLine/goNumLayout/txDamageCount"):GetComponent("TMP_Text")
  local objSoldier = goR:Find("tc_char_small").gameObject
  local cData = ConfigTable.GetData("SoldierCharacter", id)
  local cSkin = ConfigTable.GetData("SoldierSkin", id)
  local ctrl = self:BindCtrlByNode(objSoldier, "Game.UI.Soldier.Template.SoldierCharGridCtrl")
  ctrl:SetItem(cData.Rarity, 0, cSkin.Icon .. AllEnum.SoldierChessIconSurfix.S, damageData.nStar)
  self.tbSoldierGridCtrl[id] = ctrl
  local ratio = 0
  if maxDamage and 0 < maxDamage then
    ratio = damageData.nDamage / maxDamage
  end
  imgNumLine.sizeDelta = Vector2(20, 76 * ratio)
  NovaAPI.SetTMPText(txDamageCount, damageData.nDamage)
end

function SoldierBattleResultCtrl:SetGoBattleExpansionMsg()
  local tbSettle = self.mapData.tbSettle or {}
  local nPassedNode = tbSettle.nPassedNode or 0
  local nRemainingHp = tbSettle.nRemainingHp or 0
  local nCheckStageDps = tbSettle.nCheckStageDps or 0
  local nCheckStageTime = tbSettle.nCheckStageTime or 0
  local nChessTotalCost = tbSettle.nChessTotalCost or 0
  local nTotalScore = nPassedNode + nRemainingHp + nCheckStageDps + nCheckStageTime + nChessTotalCost
  if 0 < nTotalScore then
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_result_countPoint")
  end
  self:RefreshScoreDigits(nTotalScore)
  local tbListNum = {
    nPassedNode + nRemainingHp,
    nChessTotalCost,
    nCheckStageDps + nCheckStageTime
  }
  for i = 1, 3 do
    NovaAPI.SetTMPText(self._mapNode.txtListNum[i], "+" .. tostring(tbListNum[i]))
  end
  local tbRewardCfg = {
    {
      nValue = tbSettle.nGetSchedule or 0,
      sLangId = "SoldierResult_RewardTitle_Progress"
    },
    {
      nValue = tbSettle.nGetTechPoint or 0,
      sLangId = "SoldierResult_RewardTitle_Technology"
    },
    {
      nValue = tbSettle.nGetGradeExp or 0,
      sLangId = "SoldierResult_RewardTitle_Grade"
    }
  }
  local nRewardCount = 0
  for i = 1, 3 do
    local goReward = self._mapNode.goReward[i]
    local nValue = tbRewardCfg[i].nValue
    if nValue == 0 then
      goReward.gameObject:SetActive(false)
    else
      nRewardCount = nRewardCount + 1
      goReward.gameObject:SetActive(true)
      local txtTitle = goReward:Find("txtIntegralTitle"):GetComponent("TMP_Text")
      local txtNum = goReward:Find("txtIntegralNum"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtTitle, ConfigTable.GetUIText(tbRewardCfg[i].sLangId))
      NovaAPI.SetTMPText(txtNum, tostring(nValue))
    end
  end
  self._mapNode.txtAwardTitle.gameObject:SetActive(0 < nRewardCount)
end

function SoldierBattleResultCtrl:RefreshScoreDigits(nTotalScore)
  local trLayout = self._mapNode.NumLayout
  local goTemplate = self._mapNode.NumRootItem
  if trLayout == nil or goTemplate == nil then
    return
  end
  goTemplate.gameObject:SetActive(false)
  if self.tbScoreDigitTweeners ~= nil then
    for _, tw in ipairs(self.tbScoreDigitTweeners) do
      if tw ~= nil then
        tw:Kill()
      end
    end
  end
  self.tbScoreDigitTweeners = {}
  local sScore = tostring(math.max(0, math.floor(nTotalScore or 0)))
  local nLen = #sScore
  local fBaseDur = 0.6
  local fStepDur = 0.15
  local fAnimStepDelay = 0.08
  local nLoops = 3
  for i = 1, nLen do
    local nDigit = tonumber(string.sub(sScore, i, i)) or 0
    local goItem = instantiate(goTemplate, trLayout)
    local animator = goItem:GetComponent("Animator")
    if animator ~= nil then
      local fDelay = fAnimStepDelay * (nLen - i)
      if fDelay <= 0 then
        goItem.gameObject:SetActive(true)
        animator:Play("NumPos")
      else
        local delayedCall = CS.DG.Tweening.DOVirtual.DelayedCall(fDelay, function()
          if animator ~= nil then
            goItem.gameObject:SetActive(true)
            animator:Play("NumPos")
          end
        end, false)
        delayedCall:SetUpdate(true)
        table.insert(self.tbScoreDigitTweeners, delayedCall)
      end
    end
    local txt = goItem:Find("txtNum"):GetComponent("TMP_Text")
    if txt ~= nil then
      NovaAPI.SetTMPColor(txt, self.challengeColor)
      NovaAPI.SetTMPText(txt, "0")
      local fEnd = nLoops * 10 + nDigit
      local fDur = fBaseDur + fStepDur * (nLen - i)
      local fCurValue = 0
      local nLastShown = -1
      local tweener = DOTween.To(function()
        return fCurValue
      end, function(value)
        fCurValue = value
        local nShown = math.floor(value) % 10
        if nShown ~= nLastShown then
          nLastShown = nShown
          NovaAPI.SetTMPText(txt, tostring(nShown))
        end
      end, fEnd, fDur):SetEase(CS.DG.Tweening.Ease.OutCubic):SetUpdate(true)
      tweener:OnComplete(function()
        NovaAPI.SetTMPText(txt, tostring(nDigit))
      end)
      table.insert(self.tbScoreDigitTweeners, tweener)
    end
    if i == 1 then
      do
        local objLine = goItem:Find("imgLine").gameObject
        objLine:SetActive(false)
      end
    end
  end
end

return SoldierBattleResultCtrl
