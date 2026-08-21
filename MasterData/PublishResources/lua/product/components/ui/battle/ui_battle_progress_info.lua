local UICollectDropType = {Base = 1}
_enum("UICollectDropType", UICollectDropType)
_class("UIBattleProgressInfo", UICustomWidget)
UIBattleProgressInfo = UIBattleProgressInfo
local commonWaveFormatter = "<color=#FFFFFF>%d</color><color=#E68812>/</color><color=#E68812>%d</color>"
local lastWaveFormatter = "<color=#E68812>%d</color><color=#E68812>/</color><color=#E68812>%d</color>"
local dropNumColorValR = 0.9019607843137255
local dropNumColorValG = 0.5333333333333333
local dropNumColorValB = 0.07058823529411765
local dropNumColorStr = "E68812"

function UIBattleProgressInfo:OnShow()
  self._areaText = self:GetUIComponent("UILocalizationText", "AreaNumTxt")
  self._collectInfoPanel = self:GetGameObject("CollectDropInfo")
  self._collectInfoPanel:SetActive(false)
  self._collectInfoAnim = self:GetUIComponent("Animation", "CollectDropInfo")
  self._collectInfoState = self._collectInfoAnim:get_Item("UIEff_CollectDropInfo_Tiaodong")
  self._collectDropText = self:GetUIComponent("UILocalizationText", "CollectText")
  self._collectDropText1 = self:GetUIComponent("UILocalizationText", "CollectText1")
  self._collectDropText:SetText(StringTable.Get("str_battle_drop_collect"))
  self._collectDropText1:SetText(StringTable.Get("str_battle_drop_collect"))
  self._collectDropNum = self:GetUIComponent("UILocalizationText", "CurCollectNum")
  self._collectDropNum:SetText("0")
  self._curCollectCount = 0
  self._collectDropTaskNum = self:GetUIComponent("UILocalizationText", "TotalNum")
  self._collectDropTaskNum:SetText("15")
  self._collectEffHolder = self:GetGameObject("CollectEffHolder")
  self._collectDropIconArea = self:GetGameObject("CollectDropIconArea")
  self._collectDropIcon = self:GetUIComponent("Image", "CollectDropIcon")
  self._collectCautionEffGo = self:GetGameObject("CollectCautionEff")
  self._collectLayout = self:GetUIComponent("HorizontalLayoutGroup", "CollectDropInfo")
  self._exit = self:GetGameObject("Exit")
  self._exit:SetActive(false)
  self._collectCoinPanel = self:GetGameObject("CollectDropCoin")
  self._collectDropCoinNumText = self:GetUIComponent("UILocalizationText", "CurCollectCoinNum")
  self._collectDropCoinNumText:SetText("0")
  self._collectCoinPanel:SetActive(false)
  self._collectMazeCoinPanel = self:GetGameObject("CollectDropMazeCoin")
  self._collectDropMazeCoinNumText = self:GetUIComponent("UILocalizationText", "CurCollectMazeCoinNum")
  self._collectDropMazeCoinNumText:SetText("0")
  self._collectMazeCoinPanel:SetActive(false)
  self._limitRoundPanel = self:GetGameObject("LimitRound")
  self._limitRoundText = self:GetUIComponent("UILocalizationText", "LimitRoundText")
  self._combinedCompleteCondition = self:GetGameObject("CombinedCompleteCondition")
  self._combinedCompleteConditionText1 = self:GetUIComponent("UILocalizationText", "condition1")
  self._combinedCompleteConditionText2 = self:GetUIComponent("UILocalizationText", "condition2")
  self._combinedCompleteConditionTitle = self:GetUIComponent("UILocalizationText", "combinedTitle")
  self._score = self:GetGameObject("Score")
  self._numberImageObjectList = {}
  for i = 1, 6 do
    self._numberImageObjectList[i] = self:GetUIComponent("Image", "Number" .. i)
  end
  self._number2Image = {}
  for i = 1, 9 do
    self._number2Image[i] = "n5_home_timenum_" .. i
  end
  self._scoreNumber = 0
  self._score:SetActive(false)
  self._monsterEscapeInfoPanel = self:GetGameObject("EscapeMonsterInfo")
  self._monsterEscapeInfoPanel:SetActive(false)
  self._monsterEscapeNum = self:GetUIComponent("UILocalizationText", "CurEscapeNum")
  self._monsterEscapeNum:SetText("0")
  self._curMonsterEscapeCount = 0
  self._limitMonsterEscapeCount = 15
  self._limitMonsterEscapeNum = self:GetUIComponent("UILocalizationText", "LimitEscapeNum")
  self._limitMonsterEscapeNum:SetText("15")
  self._chessEscapeInfoPanel = self:GetGameObject("EscapeChessInfo")
  self._chessEscapeInfoPanel:SetActive(false)
  self._chessEscapeText = self:GetUIComponent("UILocalizationText", "EscapeChessText")
  self._chessEscapeNum = self:GetUIComponent("UILocalizationText", "CurEscapeChessNum")
  self._chessEscapeNum:SetText("0")
  self._curChessEscapeCount = 0
  self._limitChessEscapeCount = 15
  self._limitChessEscapeNum = self:GetUIComponent("UILocalizationText", "LimitEscapeChessNum")
  self._limitChessEscapeNum:SetText("15")
  self._bossCastSkillTipPanel = self:GetGameObject("BossCastSkillTipInfo")
  self._bossCastSkillTipPanel:SetActive(false)
  self._txtCurTrapNum = self:GetUIComponent("UILocalizationText", "txtCurTrapNum")
  self._txtCurTrapNum:SetText("0")
  self._curTrapNum = 0
  self._txtTotalTrapNum = self:GetUIComponent("UILocalizationText", "txtTotalTrapNum")
  self._txtTotalTrapNum:SetText("30")
  self._maxTrapNum = 30
  self._txtBossCaskSkillTip = self:GetUIComponent("UILocalizationText", "txtBossCaskSkillTip")
  self._txtBossCaskSkillTip:SetText(StringTable.Get("str_battle_boss_cast_skill_tip"))
  self._globalBuffLayerTipInfo = self:GetGameObject("GlobalBuffLayerTipInfo")
  self._globalBuffLayerTipInfo:SetActive(false)
  self._textGlobalBuffLayerTipCurrent = self:GetUIComponent("UILocalizationText", "currrentLayer")
  self._textGlobalBuffLayerTipMax = self:GetUIComponent("UILocalizationText", "maxLayer")
  self._textGlobalBuffLayerTipDesc = self:GetUIComponent("UILocalizationText", "layerTip")
  self._popStarProScorePanel = self:GetGameObject("PopStarProScore")
  self._popStarProScoreRT = self:GetUIComponent("RectTransform", "PopStarProScore")
  self._txtPopStarProScore = self:GetUIComponent("UILocalizationText", "PopStarProScoreNum")
  self._txtPopStarProScore:SetText("0")
  self._popStarProScorePanel:SetActive(false)
  self._killMoreThanPanel = self:GetGameObject("KillMoreThanPetMonster")
  self._killMoreThanPanel:SetActive(false)
  self._killMoreThanText1 = self:GetUIComponent("UILocalizationText", "KillMoreThanText1")
  self._killMoreThanText2 = self:GetUIComponent("UILocalizationText", "KillMoreThanText2")
  self._featureStepPoint = self:GetGameObject("FeatureStepPoint")
  self._featureStepPointRT = self:GetUIComponent("RectTransform", "FeatureStepPoint")
  if not self._featureStepPointWidget then
    local featureStepPointSop = self:GetUIComponent("UISelectObjectPath", "FeatureStepPoint")
    if featureStepPointSop then
      self._featureStepPointWidget = featureStepPointSop:SpawnObject("UIWidgetFeatureStepPoint")
    end
  end
  self._featureStepPoint:SetActive(false)
  self._curWaveCompleteType = nil
  self._initMonsterDeadCount = 0
  self._initSpecificMonsterDeadCount = 0
  self:RefreshWaveInfo()
  self:AttachEvent(GameEventType.ShowCollectDropInfo, self.ShowCollectDropInfo)
  self:AttachEvent(GameEventType.RefreshWaveInfo, self.RefreshWaveInfo)
  self:AttachEvent(GameEventType.ShowDropCoinInfo, self.ShowDropCoinInfo)
  self:AttachEvent(GameEventType.ShowDropMazeCoinInfo, self.ShowDropMazeCoinInfo)
  self:AttachEvent(GameEventType.ShowDropCoinInfoActive, self.ShowDropCoinInfoActive)
  self:AttachEvent(GameEventType.UIMonsterDeadCountUpdate, self._UpdateKillMonsterCount)
  self:AttachEvent(GameEventType.UIInternalRefreshMonster, self._UpdateLeftInternalMonsterWave)
  self:AttachEvent(GameEventType.UIInitMonsterDeadCount, self._UIInitMonsterDeadCount)
  self:AttachEvent(GameEventType.UIInitN5Score, self._UIInitN5Score)
  self:AttachEvent(GameEventType.UIN5UpdateScore, self._N5UpdateScore)
  self:AttachEvent(GameEventType.BattleUIRefreshCombinedWaveInfoOnRoundResult, self._OnBattleUIRefreshWaveInfoOnRoundResult)
  self:AttachEvent(GameEventType.UIUpdateEscapeMonsterCount, self._UpdateEscapeMonsterCount)
  self:AttachEvent(GameEventType.UIUpdateChessEscape, self._UpdateChessEscape)
  self:AttachEvent(GameEventType.UIInitBossCastSkillTipInfo, self._InitBossCastSkillTipInfo)
  self:AttachEvent(GameEventType.UIUpdateBossCastSkillTipInfo, self._UpdateBossCastSkillTipInfo)
  self:AttachEvent(GameEventType.UIInitGlobalLayerTipInfo, self._InitGlobalLayerTipInfo)
  self:AttachEvent(GameEventType.UIUpdateGlobalLayerTipInfo, self._UpdateGlobalLayerTipInfo)
  self:AttachEvent(GameEventType.UIHideGlobalLayerTipInfo, self._HideGlobalLayerTipInfo)
  self:AttachEvent(GameEventType.PopStarProScoreChange, self._UpdatePopStarProScore)
  self:AttachEvent(GameEventType.UIInitSpecificMonsterDeadCount, self._UIInitSpecificMonsterDeadCount)
  self:AttachEvent(GameEventType.UISpecificMonsterDeadCountUpdate, self._UpdateKillSpecificMonsterCount)
  self:AttachEvent(GameEventType.UIUpdateKillMoreThanPetMonster, self._UpdateKillMoreThanPetMonster)
end

function UIBattleProgressInfo:OnHide()
  self:DetachEvent(GameEventType.ShowCollectDropInfo, self.ShowCollectDropInfo)
  self:DetachEvent(GameEventType.RefreshWaveInfo, self.RefreshWaveInfo)
  self:DetachEvent(GameEventType.ShowDropCoinInfo, self.ShowDropCoinInfo)
  self:DetachEvent(GameEventType.UpdateRoundCount, self._ShowRoundCountLimit)
  self:DetachEvent(GameEventType.ShowDropMazeCoinInfo, self.ShowDropMazeCoinInfo)
  self:DetachEvent(GameEventType.ShowDropCoinInfoActive, self.ShowDropCoinInfoActive)
  self:DetachEvent(GameEventType.UIMonsterDeadCountUpdate, self._UpdateKillMonsterCount)
  self:DetachEvent(GameEventType.UIInternalRefreshMonster, self._UpdateLeftInternalMonsterWave)
  self:DetachEvent(GameEventType.UIInitMonsterDeadCount, self._UIInitMonsterDeadCount)
  self:DetachEvent(GameEventType.UIInitN5Score, self._InitN5Score)
  self:DetachEvent(GameEventType.UIN5UpdateScore, self._N5UpdateScore)
  self:DetachEvent(GameEventType.BattleUIRefreshCombinedWaveInfoOnRoundResult, self._OnBattleUIRefreshWaveInfoOnRoundResult)
  self:DetachEvent(GameEventType.UIUpdateEscapeMonsterCount, self._UpdateEscapeMonsterCount)
  self:DetachEvent(GameEventType.UIUpdateChessEscape, self._UpdateChessEscape)
  self:DetachEvent(GameEventType.UIInitBossCastSkillTipInfo, self._InitBossCastSkillTipInfo)
  self:DetachEvent(GameEventType.UIUpdateBossCastSkillTipInfo, self._UpdateBossCastSkillTipInfo)
  self:DetachEvent(GameEventType.UIInitGlobalLayerTipInfo, self._InitGlobalLayerTipInfo)
  self:DetachEvent(GameEventType.UIUpdateGlobalLayerTipInfo, self._UpdateGlobalLayerTipInfo)
  self:DetachEvent(GameEventType.UIHideGlobalLayerTipInfo, self._HideGlobalLayerTipInfo)
  self:DetachEvent(GameEventType.PopStarProScoreChange, self._UpdatePopStarProScore)
  self:DetachEvent(GameEventType.UIInitSpecificMonsterDeadCount, self._UIInitSpecificMonsterDeadCount)
  self:DetachEvent(GameEventType.UISpecificMonsterDeadCountUpdate, self._UpdateKillSpecificMonsterCount)
  self:DetachEvent(GameEventType.UIUpdateKillMoreThanPetMonster, self._UpdateKillMoreThanPetMonster)
end

function UIBattleProgressInfo:OnUpdate(deltaMS)
  if self._time and self._time > 0 then
    self._time = self._time - deltaMS
    if self._time <= 0 then
      self._time = 0
      self:_ClearEffects()
    end
  end
end

function UIBattleProgressInfo:OnHide()
  self:_ClearEffects()
  self._growEffList = nil
  self._flyEffList = nil
end

function UIBattleProgressInfo:ShowCollectDropInfo(dropUIWorldPos)
  if not self._flyEffList then
    self._flyEffList = ArrayList:New()
  end
  if not self._growEffList then
    self._growEffList = ArrayList:New()
  end
  self:_ShowCollectTask(dropUIWorldPos)
end

function UIBattleProgressInfo:_ShowCollectDropBaseInfo(curCollectCount)
  if curCollectCount and self._curCollectCount and curCollectCount == 0 and self._curCollectCount ~= 0 then
    curCollectCount = self._curCollectCount
  end
  curCollectCount = curCollectCount or self._curCollectCount
  local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
  local maxCollect = levelConfigData:GetLevelCollectItem()
  self._collectDropTaskNum:SetText(maxCollect)
  self._collectDropNum:SetText(tostring(curCollectCount))
  if curCollectCount < maxCollect then
    self._collectDropNum.color = Color.white
  else
    self._collectDropNum.color = Color(dropNumColorValR, dropNumColorValG, dropNumColorValB, 1)
  end
  self._collectDropMax = maxCollect
  return maxCollect
end

function UIBattleProgressInfo:_ShowCollectTask(dropUIWorldPos)
  self._time = 0
  self:_PlayGrowEff(dropUIWorldPos)
  self:_PlayCollectPathEff(dropUIWorldPos)
  if self._isCombinedCompleteCondition then
  end
end

function UIBattleProgressInfo:_CreateGrowEffTimerIndex(index)
  return function()
    index = index + 1
    return index
  end
end

function UIBattleProgressInfo:_PlayGrowEff(uiPos)
  local growEff = self._growEffList:PopBack()
  if not growEff then
    local effRes = "UIEff_CollectDropInfo_Glow.prefab"
    local collectCfg = Cfg.cfg_level_complete_condition_collect_drop[self._collectDropType]
    if collectCfg then
      if collectCfg.GrowEffect then
        effRes = collectCfg.GrowEffect
      else
        return
      end
    else
      return
    end
    growEff = self:_CreateEffect(effRes, uiPos)
  else
    self:_RefreshEffect(growEff, uiPos)
    growEff:SetActive(true)
  end
  if not self.f then
    self.f = self:_CreateGrowEffTimerIndex(0)
  end
  if not self.growEffTimerEvents then
    self.growEffTimerEvents = {}
  end
  local index = self:f()
  local event = GameGlobal.Timer():AddEvent(1000, UIBattleProgressInfo._OnTimerOver, self, growEff, index)
  self.growEffTimerEvents[index] = event
end

function UIBattleProgressInfo:_OnTimerOver(growEff, index)
  if growEff then
    growEff:SetActive(false)
    self._growEffList:PushBack(growEff)
    GameGlobal.Timer():CancelEvent(self.growEffTimerEvents[index])
    self.growEffTimerEvents[index] = nil
  end
end

function UIBattleProgressInfo:Circle(x, y, r, angle)
  local tmpX = x + r * math.cos(angle * 3.14 / 180)
  local tmpY = y + r * math.sin(angle * 3.14 / 180)
  return tmpX, tmpY
end

function UIBattleProgressInfo:_PlayCollectPathEff(startPos)
  self._curCollectCount = self._curCollectCount + 1
  local flyEff = self._flyEffList:PopBack()
  if not flyEff then
    local effRes = "UIEff_CollectDropInfo_Trail.prefab"
    local collectCfg = Cfg.cfg_level_complete_condition_collect_drop[self._collectDropType]
    if collectCfg then
      if collectCfg.PathEffect then
        effRes = collectCfg.PathEffect
      else
        local maxCollect = self:_ShowCollectDropBaseInfo(self._curCollectCount)
        if maxCollect <= self._curCollectCount then
          GameGlobal.TaskManager():CoreGameStartTask(self._OnCollectPanelAnimEnd, self)
        end
        return
      end
    else
      local maxCollect = self:_ShowCollectDropBaseInfo(self._curCollectCount)
      if maxCollect <= self._curCollectCount then
        GameGlobal.TaskManager():CoreGameStartTask(self._OnCollectPanelAnimEnd, self)
      end
      return
    end
    flyEff = self:_CreateEffect(effRes, startPos)
  else
    self:_RefreshEffect(flyEff, startPos)
    flyEff:SetActive(true)
  end
  local x = flyEff.transform.localPosition.x
  local y = flyEff.transform.localPosition.y
  local targetPos = self._collectEffHolder.transform:InverseTransformPoint(self._collectInfoPanel.transform.position)
  local index = 1
  local path = {}
  local r = 150
  for i = -90, 90, 10 do
    local pathX, pathY = self:Circle(x, y + r, r, i)
    path[index] = Vector3(pathX, pathY, 0)
    index = index + 1
  end
  path[index] = Vector3(targetPos.x, targetPos.y, 0)
  flyEff.transform:DOLocalPath(path, 0.5):SetEase(DG.Tweening.Ease.InCubic):OnComplete(function()
    flyEff:SetActive(false)
    self._flyEffList:PushBack(flyEff)
    self._collectInfoState.normalizedTime = 0
    self._collectInfoAnim:Play()
    local startPos = self._collectInfoPanel.transform.position
    self:_PlayGrowEff(startPos)
    local maxCollect = self:_ShowCollectDropBaseInfo(self._curCollectCount)
    if maxCollect <= self._curCollectCount then
      GameGlobal.TaskManager():CoreGameStartTask(self._OnCollectPanelAnimEnd, self)
    end
    self._time = 10000
  end)
end

function UIBattleProgressInfo:_OnCollectPanelAnimEnd(TT)
  YIELD(TT, 800)
  self._collectInfoState.normalizedTime = 0
  self._collectInfoAnim.enabled = false
  self._collectDropNum.color = Color(1.0, 0.3058823529411765, 0, 1)
end

function UIBattleProgressInfo:_CreateEffect(path, startPos)
  local e = UIHelper.GetGameObject(path)
  e.transform:SetParent(self._collectEffHolder.transform)
  e.transform.localScale = Vector3.one
  self:_RefreshEffect(e, startPos)
  return e
end

function UIBattleProgressInfo:_RefreshEffect(e, startPos)
  if not e then
    return
  end
  e.transform.position = startPos
end

function UIBattleProgressInfo:_ClearEffects()
  if self._growEffList then
    for i = self._growEffList:Size(), 1, -1 do
      local go = self._growEffList:GetAt(i)
      UIHelper.DestroyGameObject(go)
    end
    self._growEffList:Clear()
  end
  if self._flyEffList then
    for i = self._flyEffList:Size(), 1, -1 do
      local go = self._flyEffList:GetAt(i)
      UIHelper.DestroyGameObject(go)
    end
    self._flyEffList:Clear()
  end
end

function UIBattleProgressInfo:_SetWaveText(curWaveIndex, totalWaveCount)
  local text
  if totalWaveCount <= curWaveIndex then
    text = string.format(lastWaveFormatter, curWaveIndex, totalWaveCount)
  else
    text = string.format(commonWaveFormatter, curWaveIndex, totalWaveCount)
  end
  self._areaText:SetText(text)
end

function UIBattleProgressInfo:RefreshWaveInfo()
  local curWaveIndex = BattleStatHelper.GetCurWaveIndex() or 1
  local totalWaveCount = BattleStatHelper.GetTotalWaveCount() or 1
  self:RefreshWaveText(curWaveIndex, totalWaveCount)
  self:RefreshWaveCompleteCondition(curWaveIndex)
end

function UIBattleProgressInfo:_OnBattleUIRefreshWaveInfoOnRoundResult()
  self:_RefreshCombinedCompleteWaveInfo()
end

function UIBattleProgressInfo:_RefreshCombinedCompleteWaveInfo()
  local curWaveIndex = BattleStatHelper.GetCurWaveIndex() or 1
  local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
  local cfgWave = levelConfigData:GetWaveConfig(curWaveIndex)
  local waveCompleteType = cfgWave:GetCompleteConditionType()
  if waveCompleteType == CompleteConditionType.CombinedCompleteCondition then
    self:_UpdateCombinedConditionText(cfgWave)
  end
end

function UIBattleProgressInfo:RefreshWaveText(curWaveIndex, totalWaveCount)
  self:_SetWaveText(curWaveIndex, totalWaveCount)
end

function UIBattleProgressInfo:ResetWaveCompleteCondition()
  self._collectInfoPanel:SetActive(false)
  self._exit:SetActive(false)
  self._limitRoundPanel:SetActive(false)
  self._combinedCompleteCondition:SetActive(false)
  self._collectMazeCoinPanel:SetActive(false)
  self._popStarProScorePanel:SetActive(false)
  self._featureStepPoint:SetActive(false)
end

function UIBattleProgressInfo:RefreshWaveCompleteCondition(curWaveIndex)
  self:ResetWaveCompleteCondition()
  self._popStarProScoreY = PopStarConst.PopStarProScorePosYList[2]
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
  local cfgWave = levelConfigData:GetWaveConfig(curWaveIndex)
  local waveCompleteType = cfgWave:GetCompleteConditionType()
  local waveCompleteParam = cfgWave:GetCompleteConditionParam()
  self._curWaveCompleteType = waveCompleteType
  self._curWaveIndex = curWaveIndex
  if waveCompleteType == CompleteConditionType.CombinedCompleteCondition then
    self._combinedCompleteConditionArgs = cfgWave:GetCombinedCompleteConditionArguments()
    self._curCombinedConditionTypeA = self._combinedCompleteConditionArgs.conditionA
    self._curCombinedConditionTypeB = self._combinedCompleteConditionArgs.conditionB
    self:_InitCombinedConditionText(cfgWave)
    self:_UpdateCombinedConditionText(cfgWave)
    self._popStarProScoreY = PopStarConst.PopStarProScorePosYList[3]
  else
    self:_InitSimpleCompleteConditionData(waveCompleteType, waveCompleteParam)
  end
  if matchEnterData:GetMatchType() == MatchType.MT_PopStarPro then
    self:_ShowPopStarProScore()
  end
  if matchEnterData:GetLinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    self:_ShowFeatureStepPoint()
  end
end

function UIBattleProgressInfo:_ShowPopStarProScore()
  local x = self._popStarProScoreRT.anchoredPosition.x
  self._popStarProScoreRT.anchoredPosition = Vector2(x, self._popStarProScoreY)
  self._popStarProScorePanel:SetActive(true)
end

function UIBattleProgressInfo:_UpdatePopStarProScore(scoreNum)
  self._txtPopStarProScore:SetText(tostring(scoreNum))
end

function UIBattleProgressInfo:_ShowFeatureStepPoint()
  local x = self._featureStepPointRT.anchoredPosition.x
  self._featureStepPointRT.anchoredPosition = Vector2(x, self._popStarProScoreY)
  self._featureStepPoint:SetActive(true)
end

function UIBattleProgressInfo:ShowDropCoinInfoActive()
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  if matchEnterData:GetMatchType() == MatchType.MT_ResDungeon then
    local createData = matchEnterData:GetResDungeonInfo()
    local module = self:GetModule(ResDungeonModule)
    if DungeonType.DungeonType_Coin == module:GetTypeById(createData.res_dungeon_id) then
      self._collectCoinPanel:SetActive(true)
    end
  end
end

function UIBattleProgressInfo:ShowDropCoinInfo(coinCount)
  local oldCoinCount = tostring(self._collectDropCoinNumText.text)
  oldCoinCount = math.floor(oldCoinCount + coinCount)
  self._collectDropCoinNumText:SetText(tostring(oldCoinCount))
end

function UIBattleProgressInfo:ShowDropMazeCoinInfo()
  if not self._collectMazeCoinPanel then
    return
  end
  self._collectMazeCoinPanel:SetActive(true)
  local totalDropCoin = BattleStatHelper.GetTotalDropMazeCoin()
  self._collectDropMazeCoinNumText:SetText(tostring(totalDropCoin))
end

function UIBattleProgressInfo:_ShowRoundCountLimit()
  if not self._limitRoundPanel then
    return
  end
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.RoundCountLimit) then
    return
  end
  if self._curWaveCompleteType == CompleteConditionType.CombinedCompleteCondition then
    self:_RefreshCombinedCompleteWaveInfo()
    return
  end
  self._limitRoundPanel:SetActive(true)
  local str = self:_GetConditionTextByType(CompleteConditionType.RoundCountLimit)
  self._limitRoundText:SetText(str)
end

function UIBattleProgressInfo:_ShowCompareMonsterNumber(waveCompleteParam)
  if not self._limitRoundPanel then
    return
  end
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.CompareMonsterNumber) then
    return
  end
  if self._curWaveCompleteType == CompleteConditionType.CombinedCompleteCondition then
    self:_RefreshCombinedCompleteWaveInfo()
    return
  end
  self._limitRoundPanel:SetActive(true)
  local str = self:_GetConditionTextByType(CompleteConditionType.CompareMonsterNumber, waveCompleteParam)
  self._limitRoundText:SetText(str)
end

function UIBattleProgressInfo:_ShowAllRefreshMonsterDead(waveCompleteParam)
  if not self._limitRoundPanel then
    return
  end
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.AllRefreshMonsterDead) and not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.AllRefreshMonsterDeadOrRoundCountLimit) then
    return
  end
  if waveCompleteParam[1] and waveCompleteParam[1] == 0 then
    return
  end
  self._trapProtectedData = nil
  local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
  local traps = levelConfigData:GetLevelAllWaveTraps()
  for _, trapTransformParam in ipairs(traps) do
    local trapID = trapTransformParam:GetTrapID()
    local trapData = Cfg.cfg_trap[trapID]
    if trapData.TrapType == TrapType.Protected then
      self._trapProtectedData = trapData
      break
    end
  end
  if self._trapProtectedData then
    self._limitRoundPanel:SetActive(true)
    local str = self:_GetConditionTextByType(self._curWaveCompleteType)
    self._limitRoundText:SetText(str)
  end
end

function UIBattleProgressInfo:_UpdateKillMonsterCount()
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.KillAnyMonsterCount) then
    return
  end
  if self._curWaveCompleteType == CompleteConditionType.CombinedCompleteCondition then
    self:_RefreshCombinedCompleteWaveInfo()
    return
  end
  self._killMonsterCount = self._killMonsterCount + 1
  if self._killMonsterCount then
    self._limitRoundPanel:SetActive(true)
    local str = self:_GetConditionTextByType(self._curWaveCompleteType)
    self._limitRoundText:SetText(str)
  end
end

function UIBattleProgressInfo:_UpdateKillSpecificMonsterCount(monsterID)
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.KillSpecificMonsterCount) then
    return
  end
  if self._countCheckSpecificMonsterID and monsterID and self._countCheckSpecificMonsterID == monsterID then
    self._killSpecificMonsterCount = self._killSpecificMonsterCount + 1
    if self._curWaveCompleteType == CompleteConditionType.CombinedCompleteCondition then
      self:_RefreshCombinedCompleteWaveInfo()
      return
    end
    if self._killSpecificMonsterCount then
      self._limitRoundPanel:SetActive(true)
      local str = self:_GetConditionTextByType(self._curWaveCompleteType)
      self._limitRoundText:SetText(str)
    end
  end
end

function UIBattleProgressInfo:_UpdateKillMoreThanPetMonster(entityID)
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.KillMoreThanPetMonster) then
    return
  end
  if self._curWaveCompleteType == CompleteConditionType.CombinedCompleteCondition then
    self:_RefreshCombinedCompleteWaveInfo()
    return
  end
  local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
  local cfgWave = levelConfigData:GetWaveConfig(1)
  local waveCompleteType = cfgWave:GetCompleteConditionType()
  local waveCompleteParam = cfgWave:GetCompleteConditionParam()
  local monsterKilledCountAll = InnerGameHelperRender.GetMonsterKilledCount()
  local monsterID = waveCompleteParam[1][1]
  local monsterKilledCountMonster = InnerGameHelperRender.GetMonsterKilledCountByMonsterID(monsterID)
  local monsterKilledCountPet = monsterKilledCountAll - monsterKilledCountMonster
  self._killMoreThanText1:SetText(StringTable.Get("str_battle_ystw_num", self._killMoreThanMonsterName, monsterKilledCountMonster))
  self._killMoreThanText2:SetText(StringTable.Get("str_battle_player_num", monsterKilledCountPet))
end

function UIBattleProgressInfo:_CheckIsCorrectWaveCompleteType(type)
  if self._curWaveCompleteType == CompleteConditionType.CombinedCompleteCondition then
    return self._curCombinedConditionTypeA == type or self._curCombinedConditionTypeB == type
  else
    return self._curWaveCompleteType == type
  end
end

function UIBattleProgressInfo:_UpdateLeftInternalMonsterWave()
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.UpHoldAndKillAllInternalRefreshMonster) then
    return
  end
  if self._curWaveCompleteType == CompleteConditionType.CombinedCompleteCondition then
    self:_RefreshCombinedCompleteWaveInfo()
    return
  end
  self._leftInternalMonsterWaveCount = self._leftInternalMonsterWaveCount - 1
  if self._leftInternalMonsterWaveCount then
    self._limitRoundPanel:SetActive(true)
    local str = self:_GetConditionTextByType(self._curWaveCompleteType)
    self._limitRoundText:SetText(str)
  end
end

function UIBattleProgressInfo:_InitSimpleCompleteConditionData(type, param, isCombinedCondition)
  if type == CompleteConditionType.CollectItems or type == CompleteConditionType.AllMonsterDeadOrCollectItems then
    self._collectDropMax = param[1]
    self._collectInfoPanel:SetActive(true)
    self._collectDropType = param[1][3] or UICollectDropType.Base
    self:_InitCollectDropUI(self._collectDropType)
    self:_ShowCollectDropBaseInfo(0)
  elseif type == CompleteConditionType.ArriveAtPos then
    if not isCombinedCondition then
      self._exit:SetActive(true)
    end
  elseif type == CompleteConditionType.RoundCountLimit then
    if not isCombinedCondition then
      self._limitRoundPanel:SetActive(true)
      local str = self:_GetConditionTextByType(CompleteConditionType.RoundCountLimit)
      self._limitRoundText:SetText(str)
    end
    self:AttachEvent(GameEventType.UpdateRoundCount, self._ShowRoundCountLimit)
  elseif type == CompleteConditionType.AllRefreshMonsterDead then
    self:_ShowAllRefreshMonsterDead(param)
  elseif type == CompleteConditionType.AllRefreshMonsterDeadOrRoundCountLimit then
    local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
    if matchEnterData:GetMatchType() == MatchType.MT_Maze then
      self:ShowDropMazeCoinInfo()
    else
      self:_ShowAllRefreshMonsterDead(param)
    end
  elseif type == CompleteConditionType.KillAnyMonsterCount then
    self._killMonsterCount = 0
    if not isCombinedCondition then
      self._limitRoundPanel:SetActive(true)
      local str = self:_GetConditionTextByType(self._curWaveCompleteType)
      self._limitRoundText:SetText(str)
    end
  elseif type == CompleteConditionType.UpHoldAndKillAllInternalRefreshMonster then
    local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
    local monsterWaveParam = levelConfigData:GetWaveConfig(self._curWaveIndex)
    local count = monsterWaveParam:GetWaveInternalRefreshCount()
    self._allInternalMonsterWaveCount = count
    self._leftInternalMonsterWaveCount = count
    self:_UpdateLeftInternalMonsterWave()
  elseif type == CompleteConditionType.RoundCountLimitAndCheckMonsterEscape then
    self._monsterEscapeInfoPanel:SetActive(true)
    self._curMonsterEscapeCount = 0
    local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
    local limitEsacpeCount = levelConfigData:GetLevelMonsterEscapeLimit()
    self._limitMonsterEscapeCount = tonumber(limitEsacpeCount)
    self._limitMonsterEscapeNum:SetText(tostring(self._limitMonsterEscapeCount))
    self:_UpdateEscapeMonsterCount()
  elseif type == CompleteConditionType.ChessEscape then
    self._chessEscapeInfoPanel:SetActive(true)
    self._curChessEscapeCount = 0
    local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
    local curWaveIndex = BattleStatHelper.GetCurWaveIndex() or 1
    local cfgWave = levelConfigData:GetWaveConfig(curWaveIndex)
    local waveCompleteType = cfgWave:GetCompleteConditionType()
    local paramList = levelConfigData:GetLevelCompleteConditionParamList(waveCompleteType)
    local curConditionParam = paramList[curWaveIndex]
    local limitCount = curConditionParam[1]
    local targetChessClassID = curConditionParam[2] or 0
    self._limitChessEscapeCount = tonumber(limitCount)
    local text = "str_level_complete_condition_" .. tostring(waveCompleteType)
    self._chessEscapeText:SetText(StringTable.Get(text, self._eventCount))
    self:_UpdateChessEscape()
  elseif type == CompleteConditionType.SelectChessEscape then
    self._chessEscapeInfoPanel:SetActive(true)
    self._curChessEscapeCount = 0
    local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
    local curWaveIndex = BattleStatHelper.GetCurWaveIndex() or 1
    local cfgWave = levelConfigData:GetWaveConfig(curWaveIndex)
    local waveCompleteType = cfgWave:GetCompleteConditionType()
    local paramList = levelConfigData:GetLevelCompleteConditionParamList(waveCompleteType)
    local curConditionParam = paramList[curWaveIndex]
    local limitCount = curConditionParam[1]
    local targetChessClassID = curConditionParam[2] or 0
    self._limitChessEscapeCount = tonumber(limitCount)
    local text = "str_level_complete_condition_" .. tostring(waveCompleteType)
    self._chessEscapeText:SetText(StringTable.Get(text, self._eventCount))
    self:_UpdateChessEscape()
  elseif type == CompleteConditionType.CompareMonsterNumber then
    self:_ShowCompareMonsterNumber(param)
  elseif type == CompleteConditionType.KillSpecificMonsterCount then
    self._initSpecificMonsterDeadCount = param[1][2]
    self._killSpecificMonsterCount = 0
    self._countCheckSpecificMonsterID = param[1][1]
    if not isCombinedCondition then
      self._limitRoundPanel:SetActive(true)
      local str = self:_GetConditionTextByType(self._curWaveCompleteType)
      self._limitRoundText:SetText(str)
    end
  elseif type == CompleteConditionType.KillMoreThanPetMonster then
    local monsterID = param[1][1]
    local monsterConfigData = ConfigServiceHelper.GetMonsterConfigData()
    local monsterName = StringTable.Get(monsterConfigData:GetMonsterName(monsterID))
    self._killMoreThanMonsterName = monsterName
    self._killMoreThanPanel:SetActive(true)
    self:_UpdateKillMoreThanPetMonster()
  else
    self._popStarProScoreY = PopStarConst.PopStarProScorePosYList[1]
  end
end

function UIBattleProgressInfo:_UpdateCombinedConditionText(waveConfig)
  local completeType = waveConfig:GetCompleteConditionType()
  local completeParam = waveConfig:GetCompleteConditionParam()
  local completeCombinedArguments = waveConfig:GetCombinedCompleteConditionArguments()
  self._combinedCompleteConditionArgs = waveConfig:GetCombinedCompleteConditionArguments()
  local typeA = self._combinedCompleteConditionArgs.conditionA
  local typeB = self._combinedCompleteConditionArgs.conditionB
  local paramA = self._combinedCompleteConditionArgs.conditionParamA
  local paramB = self._combinedCompleteConditionArgs.conditionParamB
  self:_InitSimpleCompleteConditionData(typeA, paramA, true)
  self:_InitSimpleCompleteConditionData(typeB, paramB, true)
  local _, textParamA, textParamB = InnerGameHelperRender.IsDoneCompleteCondition(completeType, completeParam, completeCombinedArguments)
  self._combinedCompleteCondition:SetActive(true)
  local strA = self:_GetCompleteConditionTextByType(typeA, textParamA)
  local strB = self:_GetCompleteConditionTextByType(typeB, textParamB)
  self._combinedCompleteConditionText1:SetText(strA)
  self._combinedCompleteConditionText2:SetText(strB)
  if self._combinedMode == CombinedCompleteConditionMode.And then
    self._combinedCompleteConditionTitle:SetText(StringTable.Get("str_battle_complete_all_condition"))
  else
    self._combinedCompleteConditionTitle:SetText(StringTable.Get("str_battle_complete_any_condition"))
  end
end

function UIBattleProgressInfo:_UpdateEscapeMonsterCount(addNum)
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.RoundCountLimitAndCheckMonsterEscape) then
    return
  end
  local addCount = addNum or 0
  self._curMonsterEscapeCount = self._curMonsterEscapeCount + addCount
  if self._curMonsterEscapeCount then
    self._monsterEscapeNum:SetText(tostring(self._curMonsterEscapeCount))
    if self._curMonsterEscapeCount < self._limitMonsterEscapeCount then
      self._limitMonsterEscapeNum.color = Color.white
    else
      self._limitMonsterEscapeNum.color = Color(dropNumColorValR, dropNumColorValG, dropNumColorValB, 1)
    end
  end
end

function UIBattleProgressInfo:_UpdateChessEscape(addNum)
  if not self:_CheckIsCorrectWaveCompleteType(CompleteConditionType.ChessEscape) then
    return
  end
  local addCount = addNum or 1
  self._curChessEscapeCount = self._curChessEscapeCount + addCount
  if self._curChessEscapeCount then
    self._monsterEscapeNum:SetText(tostring(self._curChessEscapeCount))
    if self._curChessEscapeCount < self._limitChessEscapeCount then
      self._limitChessEscapeNum.color = Color.white
    else
      self._limitChessEscapeNum.color = Color(dropNumColorValR, dropNumColorValG, dropNumColorValB, 1)
    end
  end
end

local finishedProgressFormatter = "(<color=#e68812>%d/%d</color>)"

local function getUnfinishedProgressText(text, current, full)
  if not current or not full then
    return text
  end
  return table.concat({
    text,
    " (",
    current,
    "<color=#e68812>/",
    full,
    "</color>)"
  })
end

local function getFinishedProgressText(text, current, full)
  if not current or not full then
    return text
  end
  return table.concat({
    text,
    " (<color=#e68812>",
    current,
    "/",
    full,
    "</color>)"
  })
end

function UIBattleProgressInfo:_GetCompleteConditionTextByType(type, param)
  local textStr = StringTable.Get(Cfg.cfg_level_complete_condition[type].ConditionStr) or ""
  local current, full
  if param then
    current = param.current
    full = param.full
  end
  if type == CompleteConditionType.RoundCountLimit then
    return StringTable.Get("str_battle_limit_round", current, full)
  elseif type == CompleteConditionType.KillAnyMonsterCount then
    return StringTable.Get("str_battle_kill_any_monster_count", current, full)
  elseif type == CompleteConditionType.KillSpecificMonsterCount then
    local monsterNameStr = ""
    local monsterID = self._countCheckSpecificMonsterID
    if monsterID then
      local monsterCfg = Cfg.cfg_monster[monsterID]
      if monsterCfg then
        local monsterClassCfg = Cfg.cfg_monster_class[monsterCfg.ClassID]
        if monsterClassCfg then
          monsterNameStr = StringTable.Get(monsterClassCfg.Name)
        end
      end
    end
    local textStr = StringTable.Get("str_level_complete_condition_29", self._initSpecificMonsterDeadCount, monsterNameStr)
    if param.isCompleted then
      return getFinishedProgressText(textStr, current, full)
    else
      return getUnfinishedProgressText(textStr, current, full)
    end
  elseif param.isCompleted then
    return getFinishedProgressText(textStr, current, full)
  else
    return getUnfinishedProgressText(textStr, current, full)
  end
end

function UIBattleProgressInfo:_InitCombinedConditionText(waveConfig)
  self._isCombinedCompleteCondition = true
  self._combinedMode = waveConfig:GetCompleteConditionParam()[1][1]
end

function UIBattleProgressInfo:_UIInitMonsterDeadCount(count)
  self._initMonsterDeadCount = count
  self._killMonsterCount = 0
  self:_UpdateKillMonsterCount()
end

function UIBattleProgressInfo:_UIInitSpecificMonsterDeadCount(monsterID, count)
  self._initSpecificMonsterDeadCount = count
  self._killSpecificMonsterCount = 0
  self._countCheckSpecificMonsterID = monsterID
  self:_UpdateKillSpecificMonsterCount(monsterID)
end

function UIBattleProgressInfo:UpdateScoreText()
  local tmpScoreNumber = self._scoreNumber
  local index = 1
  while tmpScoreNumber ~= 0 and index < 6 do
    local num = tmpScoreNumber % 10
    tmpScoreNumber = tmpScoreNumber / 10
    tmpScoreNumber = math.modf(tmpScoreNumber)
    local imageName = self:N5ScoreGetImageNameByNumber(num)
    self._numberImageObjectList[index].sprite = InnerGameHelperRender:GetInstance():GetImageFromInnerUI(imageName)
    index = index + 1
  end
end

function UIBattleProgressInfo:N5ScoreGetImageNameByNumber(num)
  if num == 0 then
    return "n5_home_timenum_0"
  else
    return self._number2Image[num]
  end
end

function UIBattleProgressInfo:_UIInitN5Score()
  self._score:SetActive(true)
  self._scoreNumber = 0
  self:UpdateScoreText()
end

function UIBattleProgressInfo:_N5UpdateScore(addValue)
  self._scoreNumber = self._scoreNumber + addValue
  self:UpdateScoreText()
end

function UIBattleProgressInfo:_GetConditionTextByType(completeType, param)
  if completeType == CompleteConditionType.CollectItems or completeType == CompleteConditionType.AllMonsterDeadOrCollectItems then
    return string.format("%s<color=#%s>%s</color><color=#%s>%s</color>", StringTable.Get("str_battle_drop_collect"), self._curCollectCount < self._collectDropMax and "000000" or dropNumColorStr, tostring(self._curCollectCount), dropNumColorStr, tostring(self._collectDropMax))
  elseif completeType == CompleteConditionType.ArriveAtPos then
    return StringTable.Get("str_battle_go_to_exit_soon")
  elseif completeType == CompleteConditionType.RoundCountLimit then
    local levelTotalRoundCount = BattleStatHelper.GetLevelTotalRoundCount()
    local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
    local levelRoundCount = levelConfigData:GetLevelRoundCount()
    return StringTable.Get("str_battle_limit_round", levelTotalRoundCount - 1, levelRoundCount)
  elseif completeType == CompleteConditionType.AllRefreshMonsterDead then
    if not self._trapProtectedData then
      return StringTable.Get("str_level_complete_condition_10")
    else
      local trapName = StringTable.Get(self._trapProtectedData.NameStr)
      return StringTable.Get("str_battle_limit_round_protect", trapName)
    end
  elseif completeType == CompleteConditionType.AllRefreshMonsterDeadOrRoundCountLimit then
    if not self._trapProtectedData then
      return StringTable.Get("str_level_complete_condition_11")
    else
      local trapName = StringTable.Get(self._trapProtectedData.NameStr)
      return StringTable.Get("str_battle_limit_round_protect", trapName)
    end
  elseif completeType == CompleteConditionType.KillAnyMonsterCount then
    return StringTable.Get("str_battle_kill_any_monster_count", self._killMonsterCount, self._initMonsterDeadCount)
  elseif completeType == CompleteConditionType.UpHoldAndKillAllInternalRefreshMonster then
    return StringTable.Get("str_battle_holdup_monster_wave", self._leftInternalMonsterWaveCount)
  elseif completeType == CompleteConditionType.CompareMonsterNumber then
    local type = param[1][1] or ConditionCompareType.Equal
    local count = param[1][2] or 0
    local strPre = ""
    if type == ConditionCompareType.Equal then
      strPre = StringTable.Get("str_battle_condition_compare_equal", count)
    elseif type == ConditionCompareType.NotEqual then
      strPre = StringTable.Get("str_battle_condition_compare_not_equal", count)
    elseif type == ConditionCompareType.Greater then
      strPre = StringTable.Get("str_battle_condition_compare_greater", count)
    elseif type == ConditionCompareType.NotLess then
      strPre = StringTable.Get("str_battle_condition_compare_not_Less", count)
    elseif type == ConditionCompareType.Less then
      strPre = StringTable.Get("str_battle_condition_compare_less", count)
    elseif type == ConditionCompareType.NotGreater then
      strPre = StringTable.Get("str_battle_condition_compare_not_greater", count)
    end
    return strPre
  elseif completeType == CompleteConditionType.KillSpecificMonsterCount then
    local monsterNameStr = ""
    local monsterID = self._countCheckSpecificMonsterID
    if monsterID then
      local monsterCfg = Cfg.cfg_monster[monsterID]
      if monsterCfg then
        local monsterClassCfg = Cfg.cfg_monster_class[monsterCfg.ClassID]
        if monsterClassCfg then
          monsterNameStr = StringTable.Get(monsterClassCfg.Name)
        end
      end
    end
    return StringTable.Get("str_battle_condition_kill_specific_monster_count", monsterNameStr, self._killSpecificMonsterCount, self._initSpecificMonsterDeadCount)
  end
  return ""
end

function UIBattleProgressInfo:_RefreshBossCastSkillTipInfo(curNum)
  self._txtCurTrapNum:SetText(tostring(curNum))
  if curNum < self._maxTrapNum then
    self._txtCurTrapNum.color = Color.white
  else
    self._txtCurTrapNum.color = Color(dropNumColorValR, dropNumColorValG, dropNumColorValB, 1)
  end
end

function UIBattleProgressInfo:_InitBossCastSkillTipInfo(totalNum)
  self._bossCastSkillTipPanel:SetActive(true)
  self._curTrapNum = 0
  self._maxTrapNum = totalNum
  self._txtTotalTrapNum:SetText(tostring(self._maxTrapNum))
  self:_RefreshBossCastSkillTipInfo(self._curTrapNum)
end

function UIBattleProgressInfo:_UpdateBossCastSkillTipInfo(addNum)
  self._curTrapNum = self._curTrapNum + addNum
  self:_RefreshBossCastSkillTipInfo(self._curTrapNum)
end

function UIBattleProgressInfo:_InitGlobalLayerTipInfo(data)
  self._textGlobalBuffLayerTipDesc:SetText(StringTable.Get(data.tipKey))
  self:_RefreshGlobalLayerTipInfo(data)
  self._globalBuffLayerTipInfo:SetActive(true)
end

function UIBattleProgressInfo:_UpdateGlobalLayerTipInfo(data)
  self:_RefreshGlobalLayerTipInfo(data)
end

function UIBattleProgressInfo:_RefreshGlobalLayerTipInfo(data)
  self._textGlobalBuffLayerTipCurrent:SetText(tostring(data.count))
  self._textGlobalBuffLayerTipMax:SetText(tostring(data.max))
  if data.count < data.max then
    self._textGlobalBuffLayerTipCurrent.color = Color.white
  else
    self._textGlobalBuffLayerTipCurrent.color = Color(dropNumColorValR, dropNumColorValG, dropNumColorValB, 1)
  end
end

function UIBattleProgressInfo:_HideGlobalLayerTipInfo()
  self._globalBuffLayerTipInfo:SetActive(false)
end

function UIBattleProgressInfo:_InitCollectDropUI()
  if not self._collectDropUIInited then
    self._collectDropUIInited = true
  else
    return
  end
  local collectCfg = Cfg.cfg_level_complete_condition_collect_drop[self._collectDropType]
  if collectCfg then
    local icon = collectCfg.DropIconImg
    local iconAtlasName = collectCfg.DropIconAtlas
    local name = collectCfg.DropName
    local condtionStr = collectCfg.ConditionStr
    if name then
      self._collectDropText:SetText(StringTable.Get(condtionStr, StringTable.Get(name)))
      self._collectDropText1:SetText(StringTable.Get(condtionStr, StringTable.Get(name)))
    else
      self._collectDropText:SetText(StringTable.Get(condtionStr))
      self._collectDropText1:SetText(StringTable.Get(condtionStr))
    end
    if icon then
      self._collectIconAtlas = self:GetAsset(collectCfg.DropIconAtlas, LoadType.SpriteAtlas)
      self._collectDropIconArea:SetActive(true)
      self._collectDropIcon.sprite = self._collectIconAtlas:GetSprite(icon)
      if self._collectLayout then
        self._collectLayout.padding.left = 5
      end
      if self._collectCautionEffGo then
        self._collectCautionEffGo:SetActive(false)
      end
    else
      self._collectDropIconArea:SetActive(false)
    end
  end
end
