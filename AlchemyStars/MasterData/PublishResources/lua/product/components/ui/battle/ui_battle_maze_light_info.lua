_class("UIBattleMazeLightInfo", UICustomWidget)
UIBattleMazeLightInfo = UIBattleMazeLightInfo

function UIBattleMazeLightInfo:OnShow()
  self._leftTurnNormalGO = self:GetGameObject("Normal")
  self._leftTurnNum = self:GetUIComponent("UILocalizationText", "txtTurnCount")
  self._leftTurnLittleNum = self:GetUIComponent("UILocalizationText", "txtLittleTurnCount")
  self._text = self:GetUIComponent("UILocalizationText", "text")
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  if matchEnterData:GetMatchType() == MatchType.MT_Maze then
    self._text.text = StringTable.Get("str_battle_light_count")
  elseif matchEnterData:GetMatchType() == MatchType.MT_SeasonMaze then
    self._text.text = StringTable.Get("str_season_maze_battle_round")
  end
  self._leftTurnWarningGO = self:GetGameObject("Warning")
  self._leftTurnWarningNum = self:GetUIComponent("UILocalizationText", "warningtxtTurnCount")
  self._leftTurnWarningNumBG = self:GetUIComponent("UILocalizationText", "warningtxtTurnCountBG")
  self._leftTurnWarningLittleNum = self:GetUIComponent("UILocalizationText", "warningtxtLittleTurnCount")
  self._leftTurnWarningOutLineNum = self:GetUIComponent("Outline", "warningtxtTurnCount")
  self._warningRoundCount = Cfg.cfg_global.inner_game_warning_round_count_maze.IntValue
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
end

function UIBattleMazeLightInfo:OnHide()
  self._arrAnimEffUp = nil
  self._arrTextEffUp = nil
  self:DetachEvent(GameEventType.InitRoundCount, self.InitRoundCount)
  self:DetachEvent(GameEventType.UpdateRoundCount, self.UpdateLeftTurnNum)
end

function UIBattleMazeLightInfo:Init()
  self._leftTurnWarningGO:SetActive(false)
end

function UIBattleMazeLightInfo:InitRoundCount(turnCount)
  self:CancelRoundWarningState()
  self:SetRoundCount(turnCount)
  self:UpdateLeftTurnNum(turnCount)
end

function UIBattleMazeLightInfo:SetRoundCount(turnCount)
  if 999 < turnCount then
    turnCount = "999+"
  end
  self._leftTurnNum:SetText(turnCount)
  self._leftTurnLittleNum:SetText(turnCount)
  self._leftTurnWarningNum:SetText(turnCount)
  self._leftTurnWarningLittleNum:SetText(turnCount)
  self._leftTurnWarningNumBG:SetText(turnCount)
end

function UIBattleMazeLightInfo:UpdateLeftTurnNum(leftTurnNum)
  if leftTurnNum > self._warningRoundCount and self._warningRoundState then
    self:CancelRoundWarningState()
  elseif leftTurnNum <= self._warningRoundCount and not self._warningRoundState then
    self:_DoRoundWarning()
  end
  self:SetRoundCount(leftTurnNum)
end

function UIBattleMazeLightInfo:CancelRoundWarningState()
  self._warningRoundState = false
  self._leftTurnNormalGO:SetActive(true)
  self._leftTurnWarningGO:SetActive(false)
end

function UIBattleMazeLightInfo:_DoRoundWarning()
  self._warningRoundState = true
  self._leftTurnNormalGO:SetActive(false)
  self._leftTurnWarningGO:SetActive(true)
  self._roundWarningTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoLeftTurnWarningAnimation, self)
end

function UIBattleMazeLightInfo:_DoLeftTurnWarningAnimation(TT)
  self._DoTweenSequence = DG.Tweening.DOTween.Sequence()
  local sss = self:GetGameObject("warningtxtTurnCountBG")
  while self._warningRoundState do
    if sss and tostring(sss) ~= "null" then
      sss.transform:DOScale(Vector3(1.3, 1.3, 1), 0.2)
    end
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
    if sss and tostring(sss) ~= "null" then
      sss.transform.localScale = Vector3(1, 1, 1)
    end
  end
end

function UIBattleMazeLightInfo:PlayRemainRoundCount2Power(energyNum, curRemainRound)
  if curRemainRound <= 0 then
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
