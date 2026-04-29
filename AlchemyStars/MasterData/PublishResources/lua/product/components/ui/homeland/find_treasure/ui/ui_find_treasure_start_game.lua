_class("UIFindTreasureStartGame", UIController)
UIFindTreasureStartGame = UIFindTreasureStartGame

function UIFindTreasureStartGame:OnShow(uiParams)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  self._findTreasureManager = homelandClient:FindTreasureManager()
  self._findTreasureManager:EnterFindTreasure(uiParams[1])
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayerControllerUIStatus, false)
  self._isReplay = uiParams[2]
  self._timerLabel = self:GetUIComponent("UILocalizedTMP", "Timer")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("uieff_n17_start_game_timedown.mat", LoadType.Mat)
  self._EMIMat = self._EMIMatResRequest.Obj
  local mat = self._timerLabel.fontMaterial
  self._timerLabel.fontMaterial = self._EMIMat
  self._timerLabel.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
  self:StartTask(self.TimerDown, self)
end

function UIFindTreasureStartGame:OnHide()
  self._EMIMatResRequest = nil
  self._EMIMat = nil
end

function UIFindTreasureStartGame:TimerDown(TT)
  self:Lock("UIFindTreasureStartGame_TimerDown")
  self._findTreasureManager:AttachModel()
  if self._isReplay then
    self._anim:Play("uieffanim_N17_UIFindTreasureStartGame3")
    self:Start()
    YIELD(TT, 1000)
  else
    self._anim:Play("uieffanim_N17_UIFindTreasureStartGame2")
    YIELD(TT, 667)
    self:Start()
    YIELD(TT, 1400)
  end
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMMiniGame, AudioConstValue.BGMCrossFadeTime)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameStart)
  local time = 3
  while 1 <= time do
    self._anim:Stop()
    self._anim:Play("uieffanim_N17_UIFindTreasureStartGame")
    self._timerLabel:SetText(time .. "")
    YIELD(TT, 1000)
    time = time - 1
  end
  self._anim:Stop()
  self._anim:Play("uieffanim_N17_UIFindTreasureStartGame")
  self._timerLabel:SetText(StringTable.Get("str_homeland_find_treasure_game_go"))
  YIELD(TT, 1000)
  self:CloseDialog()
  self:ShowDialog("UIFindTreasureMain")
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(false)
  self:UnLock("UIFindTreasureStartGame_TimerDown")
end

function UIFindTreasureStartGame:Start()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(true)
  local tran = characterController:Transform()
  characterController:SetLocation(HomelandFindTreasureConst.GetStartPosition(), Quaternion.LookRotation(HomelandFindTreasureConst.GetStartDirection()))
  local angleX, angleY, scale = HomelandFindTreasureConst.GetStartCamera()
  local cameraMgr = homelandClient:CameraManager()
  local followCameraController = cameraMgr:FollowCameraController()
  followCameraController:SetCamLocation(angleX, angleY, scale)
  followCameraController:UpdatePos(tran.position)
end
