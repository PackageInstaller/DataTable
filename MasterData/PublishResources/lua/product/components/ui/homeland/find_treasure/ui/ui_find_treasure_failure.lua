_class("UIFindTreasureFailure", UIController)
UIFindTreasureFailure = UIFindTreasureFailure

function UIFindTreasureFailure:LoadDataOnEnter(TT, res, uiParams)
  self:RequestSingleData(TT)
end

function UIFindTreasureFailure:OnShow(uiParams)
  self._gameData = uiParams[1]
  self:SetForbiddenMove(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayerControllerUIStatus, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetMinimapStatus, false)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  self._findTreasureManager = homelandClient:FindTreasureManager()
  self._specialSingleLabel = self:GetUIComponent("UILocalizationText", "SpecialSingleCount")
  self._normalSingleLabel = self:GetUIComponent("UILocalizationText", "NormalSingleCount")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self:RefreshUI()
  self._title1MatRequest, self._title1Mat = self:ChangeFontMat("Title1", "uieff_n17_find_treasure_failure_tips1.mat")
  self._title2MatRequest, self._title2Mat = self:ChangeFontMat("Title2", "uieff_n17_find_treasure_failure_tips.mat")
  self:StartTask(self.PlayAnim, self)
end

function UIFindTreasureFailure:OnHide()
  self._title1MatRequest = nil
  self._title1Mat = nil
  self._title2MatRequest = nil
  self._title2Mat = nil
  GameGlobal.GetUIModule(HomelandModule):GetClient():PlayHomelandBgm()
end

function UIFindTreasureFailure:RefreshUI()
  if self._isActiveEnd then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_find_treasure_game_active_end"))
    self._specialSingleLabel:SetText("-")
    self._normalSingleLabel:SetText("-")
  else
    self._specialSingleLabel:SetText(self._singleDatas:GetSpecialSingleCount())
    self._normalSingleLabel:SetText(self._singleDatas:GetNormalSingleCount())
  end
end

function UIFindTreasureFailure:SetForbiddenMove(status)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(status)
end

function UIFindTreasureFailure:SetAnimatorBool(triggerName, triggerValue)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetAnimatorBool(triggerName, triggerValue)
end

function UIFindTreasureFailure:Forcus(focus, time)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local cameraMgr = homelandClient:CameraManager()
  local followCameraController = cameraMgr:FollowCameraController()
  if not focus then
    followCameraController:LeaveFocus(0)
  else
    local characterController = homelandClient:CharacterManager():MainCharacterController()
    local tran = characterController:Transform()
    local cameraTran = tran:Find("FindTreasureSuccess")
    if cameraTran then
      followCameraController:Focus(cameraTran, time)
    end
  end
end

function UIFindTreasureFailure:ChangeFontMat(fontName, matName)
  local label = self:GetUIComponent("UILocalizedTMP", fontName)
  local matResRequest = ResourceManager:GetInstance():SyncLoadAsset(matName, LoadType.Mat)
  local matObj = matResRequest.Obj
  local mat = label.fontMaterial
  label.fontMaterial = matObj
  label.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
  return matResRequest, matObj
end

function UIFindTreasureFailure:PlayAnim(TT)
  self:Lock("UIFindTreasureFailure_PlayAnim")
  self:SetAnimatorBool("FindTreasureFailure", true)
  YIELD(TT, 2000)
  self._anim:Play("uieffanim_n17_UIFindTreasureFailure")
  YIELD(TT, 667)
  GameGlobal.UIStateManager():CloseDialog("UIFindTreasureMain")
  self:Forcus(true, 0)
  self._isActiveEnd = true
  local campaign = UIActivityCampaign:New()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  campaign:LoadCampaignInfo(TT, res, HomelandFindTreasureConst.GetCampaignType(), HomelandFindTreasureConst.GetComponentType())
  if res:GetSucc() then
    local localProcess = campaign:GetLocalProcess()
    if localProcess then
      local exploreMinigameComponent = localProcess:GetComponent(HomelandFindTreasureConst.GetComponentType())
      if exploreMinigameComponent and exploreMinigameComponent:ComponentIsOpen() then
        self._isActiveEnd = false
      end
    end
  end
  if not self._isActiveEnd then
    self:RequestSingleData(TT)
  end
  self:RefreshUI()
  self:UnLock("UIFindTreasureFailure_PlayAnim")
end

function UIFindTreasureFailure:RequestSingleData(TT)
  self._singleDatas = HomelandFindTreasureConst.GetFindTreasureSingleDatas(TT)
end

function UIFindTreasureFailure:BtnRestartOnClick()
  self:StartTask(self.RequestData, self)
end

function UIFindTreasureFailure:RequestData(TT)
  self:Lock("UIFindTreasureFailure_RequestData")
  local singleDatas = HomelandFindTreasureConst.GetFindTreasureSingleDatas(TT)
  HomelandFindTreasureConst.StartGame(TT, singleDatas, function()
    self:Close(false)
    return 800
  end, true)
  self:UnLock("UIFindTreasureFailure_RequestData")
end

function UIFindTreasureFailure:BtnReturnOnClick()
  self:Close(true)
end

function UIFindTreasureFailure:Close(isReturn)
  self:StartTask(self.CloseCoro, self, isReturn)
end

function UIFindTreasureFailure:CloseCoro(TT, isReturn)
  self:Lock("UIFindTreasureFailure_CloseCoro")
  self._anim:Play("uieffanim_n17_UIFindTreasureFailure_out")
  YIELD(TT, 667)
  if isReturn then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayerControllerUIStatus, true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetMinimapStatus, true)
  end
  self:SetForbiddenMove(false)
  self:SetAnimatorBool("FindTreasureFailure", false)
  self:Forcus(false)
  self._findTreasureManager:ExitFindTreasure()
  if isReturn then
    YIELD(TT, 1000)
    self:CloseDialog()
  else
    local state = self._anim:get_Item("uieffanim_n17_UIFindTreasureFailure_out")
    state.speed = 0
    YIELD(TT, 300)
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetMinimapStatus, true)
  end
  self:UnLock("UIFindTreasureFailure_CloseCoro")
end
