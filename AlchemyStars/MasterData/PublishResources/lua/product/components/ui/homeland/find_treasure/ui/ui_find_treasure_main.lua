_class("UIFindTreasureMain", UIController)
UIFindTreasureMain = UIFindTreasureMain

function UIFindTreasureMain:OnShow(uiParams)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayerControllerUIStatus, true)
  self._maskBGCanvas = self:GetGameObject().transform.parent.parent:Find("BGMaskCanvas").gameObject
  if self._maskBGCanvas then
    self._maskBGCanvas:SetActive(false)
  end
  self._cdPanel = self:GetGameObject("CDPanel")
  self._cdPanelImg = self:GetUIComponent("Image", "CDPanel")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._cdLabel = self:GetUIComponent("UILocalizationText", "CD")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self.SkillGo = self:GetGameObject("Skill")
  self.BtnReturnGo = self:GetGameObject("BtnReturn")
  self._isPlayTimeAnim = false
  self:AttachEvent(GameEventType.FindTreasureFailure, self.OnFindTreasureFailure)
  self:AttachEvent(GameEventType.FindTreasureSuccess, self.OnFindTreasureSuccess)
  self:AttachEvent(GameEventType.MinimapSwitch, self.MinimapSwitch)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterManager = homelandClient:CharacterManager()
  if characterManager then
    self._playerTran = characterManager:GetCharacterTransform()
  end
  self._findTreasureManager = homelandClient:FindTreasureManager()
  self._gameData = self._findTreasureManager:StartFindTreasure()
  self._time = self._gameData:GetGameTotalTime()
  self._halfTime = self._time / 2
  self._lastTime = 30
  self._cdTime = 0
  self._skills = {}
  self._pause = false
end

function UIFindTreasureMain:MinimapSwitch(status)
  if status == MinimapStatus.Big then
    self.SkillGo:SetActive(false)
    self.BtnReturnGo:SetActive(false)
  else
    self.SkillGo:SetActive(true)
    self.BtnReturnGo:SetActive(true)
  end
end

function UIFindTreasureMain:OnHide()
  if self._maskBGCanvas then
    self._maskBGCanvas:SetActive(true)
  end
  for i = 1, #self._skills do
    self._skills[i]:Destroy()
  end
end

function UIFindTreasureMain:OnUpdate(deltaTimeMS)
  if self._time == nil then
    return
  end
  if self._time <= 0 then
    return
  end
  if self._pause then
    return
  end
  self._time = self._time - deltaTimeMS / 1000
  if self._time <= 0 then
    self._time = 0
  end
  self:RefreshGameTimeUI()
  if 0 < self._cdTime then
    self._cdTime = self._cdTime - deltaTimeMS / 1000
  else
    self._cdTime = 0
  end
  self:RefreshCDUI()
end

function UIFindTreasureMain:RefreshGameTimeUI()
  self._timeLabel:SetText(self:GetTimeRemainStr())
end

function UIFindTreasureMain:GetTimeRemainStr()
  local timeStr = ""
  local min = math.floor(self._time / 60)
  if 0 <= min and min < 10 then
    timeStr = timeStr .. "0" .. min
  elseif 10 <= min then
    timeStr = timeStr .. min
  end
  timeStr = timeStr .. ":"
  local seconds = math.floor(self._time - min * 60)
  if seconds < 0 then
    seconds = 0
  end
  if seconds == 0 and min == 0 then
    return "<color=#ECECEC>" .. StringTable.Get("str_homeland_find_treasure_time_reach_tips") .. "</color>"
  end
  if 0 <= seconds and seconds < 10 then
    timeStr = timeStr .. "0" .. seconds
  elseif 10 <= seconds then
    timeStr = timeStr .. seconds
  end
  if self._time <= 0 then
    return "<color=#ECECEC>" .. StringTable.Get("str_homeland_find_treasure_time_reach_tips") .. "</color>"
  end
  if self._time <= self._lastTime then
    timeStr = "<color=#FE5D5D>" .. timeStr .. "</color>"
    if self._isPlayTimeAnim == false then
      self._anim:Play("uieffanim_N17_UIFindTreasureMain")
      self._isPlayTimeAnim = true
    end
  elseif self._time <= self._halfTime then
    timeStr = "<color=#F4E035>" .. timeStr .. "</color>"
  else
    timeStr = "<color=#ECECEC>" .. timeStr .. "</color>"
  end
  return timeStr
end

function UIFindTreasureMain:RefreshCDUI()
  if self._cdTime > 0 then
    self._cdPanel:SetActive(true)
    self._cdLabel:SetText(self:GetCDTimeStr())
    self._cdPanelImg.fillAmount = self._cdTime / self._gameData:SkillCD()
  else
    self._cdPanel:SetActive(false)
  end
end

function UIFindTreasureMain:GetCDTimeStr()
  return string.format("%.1f", self._cdTime)
end

function UIFindTreasureMain:ReleaseSkill()
  if self._cdTime > 0 then
    return
  end
  self._cdTime = self._gameData:SkillCD()
  local skill = FindTreasureSkill:New()
  local findTreasure = self._findTreasureManager:GetFindTreasure()
  if findTreasure then
    local targetPos = findTreasure:GetTreasurePosition()
    skill:ReleaseSkill(self._playerTran, targetPos)
    self._skills[#self._skills + 1] = skill
  end
end

function UIFindTreasureMain:SkillBtnOnClick()
  self:ReleaseSkill()
end

function UIFindTreasureMain:ExitGame()
  self._findTreasureManager:ExitFindTreasure()
end

function UIFindTreasureMain:BtnReturnOnClick()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(true)
  local btn1Data = {
    StringTable.Get("str_homeland_find_treasure_cancel_btn"),
    function(param)
      characterController:SetForbiddenMove(false)
    end
  }
  local btn2Data = {
    StringTable.Get("str_homeland_find_treasure_confirm_btn"),
    function(param)
      self:CloseDialog()
      self:ExitGame()
      GameGlobal.GetUIModule(HomelandModule):GetClient():PlayHomelandBgm()
      characterController:SetForbiddenMove(false)
    end
  }
  self:ShowDialog("UIHomelandMessageBox", nil, StringTable.Get("str_homeland_find_treasure_giveup_game_tips"), btn1Data, btn2Data, true)
end

function UIFindTreasureMain:OnFindTreasureFailure()
  GameGlobal.UIStateManager():CloseDialog("UIHomelandMessageBox")
  self:StartTask(self.FindTreasureFailureAnim, self)
end

function UIFindTreasureMain:FindTreasureFailureAnim(TT)
  self:Lock("UIFindTreasureMain_FindTreasureFailureAnim")
  self:ShowDialog("UIFindTreasureFailure", self._gameData)
  self:UnLock("UIFindTreasureMain_FindTreasureFailureAnim")
end

function UIFindTreasureMain:OnFindTreasureSuccess()
  GameGlobal.UIStateManager():CloseDialog("UIHomelandMessageBox")
  self:ShowDialog("UIFindTreasureSuccess", self._gameData)
end
