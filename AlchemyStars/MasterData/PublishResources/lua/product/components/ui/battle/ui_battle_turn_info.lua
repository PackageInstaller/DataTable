_class("UIBattleTurnInfo", UICustomWidget)
UIBattleTurnInfo = UIBattleTurnInfo

function UIBattleTurnInfo:OnShow()
  self._leftTurnNormalGO = self:GetGameObject("Normal")
  self._leftTurnNum = self:GetUIComponent("UILocalizationText", "txtTurnCount")
  self._leftTurnLittleNum = self:GetUIComponent("UILocalizationText", "txtLittleTurnCount")
  self._leftTurnWarningGO = self:GetGameObject("Warning")
  self._leftTurnWarningNum = self:GetUIComponent("UILocalizationText", "warningtxtTurnCount")
  self._leftTurnWarningNumBG = self:GetUIComponent("UILocalizationText", "warningtxtTurnCountBG")
  self._leftTurnWarningLittleNum = self:GetUIComponent("UILocalizationText", "warningtxtLittleTurnCount")
  self._leftTurnWarningOutLineNum = self:GetUIComponent("Outline", "warningtxtTurnCount")
  self._roundDescText = self:GetUIComponent("UILocalizationText", "text")
  self._outOfOrderGO = self:GetGameObject("OutOfOrder")
  self._damagePercentText = self:GetUIComponent("UILocalizationText", "damagePercent")
  self._warningRoundCount = Cfg.cfg_global.inner_game_warning_round_count.IntValue
  self._warningRoundState = false
  self._doTweenSequence = nil
  self._roundWarningTaskID = nil
  local tranUpEff = self:GetGameObject("UP_Eff").transform
  self._arrAnimEffUp = {}
  self._arrTextEffUp = {}
  self._effArrLen = 5
  for i = 1, self._effArrLen do
    local goAnimEffUp = UIHelper.GetGameObject("UIEff_TurnInfo_tiaodong.prefab")
    goAnimEffUp.transform:SetParent(tranUpEff, false)
    goAnimEffUp:SetActive(false)
    local anim = goAnimEffUp:GetComponent("Animation")
    local txt = goAnimEffUp.transform:Find("number"):GetComponent("UILocalizationText")
    table.insert(self._arrAnimEffUp, anim)
    table.insert(self._arrTextEffUp, txt)
  end
  self:Init()
  self:AttachEvent(GameEventType.InitRoundCount, self.InitRoundCount)
  self:AttachEvent(GameEventType.UpdateRoundCount, self.UpdateLeftTurnNum)
  self:AttachEvent(GameEventType.UpdateRoundCountByDiff, self.UpdateLeftTurnNumByDiff)
  self:AttachEvent(GameEventType.UpdateOutOfRoundPunish, self.UpdateOutOfRoundPunish)
  self:AttachEvent(GameEventType.RemainRoundCount2Power, self.PlayRemainRoundCount2Power)
end

function UIBattleTurnInfo:OnHide()
  self._arrAnimEffUp = nil
  self._arrTextEffUp = nil
  self:DetachEvent(GameEventType.InitRoundCount, self.InitRoundCount)
  self:DetachEvent(GameEventType.UpdateRoundCount, self.UpdateLeftTurnNum)
  self:DetachEvent(GameEventType.UpdateRoundCountByDiff, self.UpdateLeftTurnNumByDiff)
  self:DetachEvent(GameEventType.UpdateOutOfRoundPunish, self.UpdateOutOfRoundPunish)
  self:DetachEvent(GameEventType.RemainRoundCount2Power, self.PlayRemainRoundCount2Power)
end

function UIBattleTurnInfo:Dispose()
  if self._roundWarningTaskID then
    GameGlobal.TaskManager():KillTask(self._roundWarningTaskID)
  end
end

function UIBattleTurnInfo:Init()
  self._leftTurnWarningGO:SetActive(false)
end

function UIBattleTurnInfo:InitRoundCount(turnCount)
  self._outOfRoundType = BattleStatHelper.GetLevelOutOfRoundType()
  self:CancelRoundWarningState()
  self:SetRoundCount(turnCount)
  self:UpdateLeftTurnNum(turnCount)
end

function UIBattleTurnInfo:SetRoundCount(turnCount)
  self._recordLeftTurnCount = turnCount
  self._leftTurnNum:SetText(tostring(turnCount))
  self._leftTurnLittleNum:SetText(tostring(turnCount))
  self._leftTurnWarningNum:SetText(tostring(turnCount))
  self._leftTurnWarningLittleNum:SetText(tostring(turnCount))
  self._leftTurnWarningNumBG:SetText(tostring(turnCount))
end

function UIBattleTurnInfo:UpdateLeftTurnNum(leftTurnNum)
  if leftTurnNum > self._warningRoundCount and self._warningRoundState then
    self:CancelRoundWarningState()
  elseif leftTurnNum <= self._warningRoundCount and not self._warningRoundState then
    self:_DoRoundWarning()
  end
  if self._outOfRoundType == 0 then
    self:SetRoundCount(leftTurnNum)
  elseif 0 < leftTurnNum then
    self:SetRoundCount(leftTurnNum)
  end
end

function UIBattleTurnInfo:UpdateLeftTurnNumByDiff(leftTurnNumDiff)
  local curUiRecordTurn = self._recordLeftTurnCount
  if not curUiRecordTurn then
    return
  end
  local leftTurnNum = curUiRecordTurn + leftTurnNumDiff
  self:UpdateLeftTurnNum(leftTurnNum)
end

function UIBattleTurnInfo:UpdateOutOfRoundPunish(isPreview)
  if self._outOfRoundType == 0 then
    return
  end
  self._roundDescText.gameObject:SetActive(false)
  self._leftTurnNormalGO:SetActive(false)
  self._leftTurnWarningGO:SetActive(false)
  self._outOfOrderGO:SetActive(true)
  local percent = BattleStatHelper.GetOutOfRoundPunishHPPercent(isPreview)
  self._damagePercentText:SetText(table.concat({
    math.floor(percent * 100),
    "%"
  }))
end

function UIBattleTurnInfo:CancelRoundWarningState()
  self._warningRoundState = false
  self._leftTurnNormalGO:SetActive(true)
  self._leftTurnWarningGO:SetActive(false)
end

function UIBattleTurnInfo:_DoRoundWarning()
  self._warningRoundState = true
  self._leftTurnNormalGO:SetActive(false)
  self._leftTurnWarningGO:SetActive(true)
  self._roundWarningTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoLeftTurnWarningAnimation, self)
end

function UIBattleTurnInfo:_DoLeftTurnWarningAnimation(TT)
  self._DoTweenSequence = DG.Tweening.DOTween.Sequence()
  local sss = self:GetGameObject("warningtxtTurnCountBG")
  while self._warningRoundState do
    sss.transform:DOScale(Vector3(1.3, 1.3, 1), 0.2)
    self._leftTurnWarningNumBG:DOFade(0, 0.1)
    if not self._warningRoundState then
      return
    end
    YIELD(TT, 200)
    local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
    if coreGameStateID == GameStateID.Invalid then
      Log.notice("quit game already")
      break
    end
    if not self._warningRoundState then
      return
    end
    self._leftTurnWarningNumBG:DOFade(255, 0)
    sss.transform.localScale = Vector3(1, 1, 1)
  end
end

function UIBattleTurnInfo:PlayRemainRoundCount2Power(energyNum, curRemainRound)
  if curRemainRound <= 0 then
    return
  end
  local matchType = GameGlobal:GetInstance().GetModule(MatchModule):GetMatchType()
  if matchType == MatchType.MT_Maze or matchType == MatchType.MT_SeasonMaze then
    return
  end
  self:StartTask(function(TT)
    local perEnergy = energyNum / curRemainRound
    for i = curRemainRound, 1, -1 do
      local idx = i % self._effArrLen + 1
      self._arrAnimEffUp[idx].gameObject:SetActive(true)
      self._arrAnimEffUp[idx]:Play()
      self._arrTextEffUp[idx].text = tostring(i)
      self:SetRoundCount(i - 1)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.RemainRoundCount2PowerPet, perEnergy)
      YIELD(TT, 100)
      if not self._arrAnimEffUp then
        return
      end
      self._arrAnimEffUp[idx].gameObject:SetActive(false)
    end
  end, self)
end
