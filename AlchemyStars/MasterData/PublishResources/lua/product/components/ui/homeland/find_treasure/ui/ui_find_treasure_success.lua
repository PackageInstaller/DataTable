_class("UIFindTreasureSuccess", UIController)
UIFindTreasureSuccess = UIFindTreasureSuccess

function UIFindTreasureSuccess:OnShow(uiParams)
  self:SetForbiddenMove(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayerControllerUIStatus, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetMinimapStatus, false)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  self._findTreasureManager = homelandClient:FindTreasureManager()
  self._gameData = uiParams[1]
  self._tipsPanel = self:GetGameObject("TipsPanel")
  self._resultPanel = self:GetGameObject("ResultPanel")
  self._timeLabel = self:GetUIComponent("UILocalizedTMP", "Time")
  self._specialSingleLabel = self:GetUIComponent("UILocalizationText", "SpecialSingle")
  self._normalSingleLabel = self:GetUIComponent("UILocalizationText", "NormalSingle")
  self._rewardPanel = self:GetGameObject("RewardPanel")
  self._normalIconGo = self:GetGameObject("NormalIcon")
  self._specialIconGo = self:GetGameObject("SpecialIcon")
  self._rewardLoader = self:GetUIComponent("UISelectObjectPath", "Rewards")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._EMIMatResRequest, self._EMIMat = self:ChangeFontMat("SuccessTips", "uieff_n17_find_treasure_success_tips.mat")
  self._TitleMatResRequest, self._MatResRequestMat = self:ChangeFontMat("Title", "uieff_n17_find_treasure_success_tips.mat")
  self._TitleMatResRequest2, self._MatResRequestMat2 = self:ChangeFontMat("Title2", "uieff_n17_find_treasure_success_tips.mat")
  self._timeeMatResRequest, self._timetResRequestMat = self:ChangeFontMat("Time", "uieff_n17_find_treasure_success_time.mat")
  self._tipsPanel:SetActive(false)
  self._resultPanel:SetActive(false)
  self:StartTask(self.PlayAnim, self)
end

function UIFindTreasureSuccess:SetForbiddenMove(status)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(status)
end

function UIFindTreasureSuccess:GetPlayerTransform()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterManager = homelandClient:CharacterManager()
  return characterManager:GetCharacterTransform()
end

function UIFindTreasureSuccess:SetAnimatorBool(triggerName, triggerValue)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetAnimatorBool(triggerName, triggerValue)
end

function UIFindTreasureSuccess:SetRotation()
  local findTreasure = self._findTreasureManager:GetFindTreasure()
  local pos = findTreasure:GetTreasurePosition()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local tr = homelandClient:CharacterManager():GetCharacterTransform()
  local trPos = tr.position
  local dir = pos - trPos
  local rot = Quaternion.LookRotation(Vector3(dir.x, 0, dir.z), Vector3(0, 1, 0))
  tr.rotation = rot
end

function UIFindTreasureSuccess:Forcus(focus, time)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local cameraMgr = homelandClient:CameraManager()
  local followCameraController = cameraMgr:FollowCameraController()
  if not focus then
    followCameraController:LeaveFocus(0, function()
    end)
  else
    local characterController = homelandClient:CharacterManager():MainCharacterController()
    local tran = characterController:Transform()
    local cameraTran = tran:Find("FindTreasureSuccess")
    if cameraTran then
      followCameraController:Focus(cameraTran, time)
    end
  end
end

function UIFindTreasureSuccess:ChangeFontMat(fontName, matName)
  local label = self:GetUIComponent("UILocalizedTMP", fontName)
  local matResRequest = ResourceManager:GetInstance():SyncLoadAsset(matName, LoadType.Mat)
  local matObj = matResRequest.Obj
  local mat = label.fontMaterial
  label.fontMaterial = matObj
  label.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
  return matResRequest, matObj
end

function UIFindTreasureSuccess:OnHide()
  self._EMIMatResRequest = nil
  self._EMIMat = nil
  self._TitleMatResRequest = nil
  self._MatResRequestMat = nil
  self._TitleMatResRequest2 = nil
  self._MatResRequestMat2 = nil
  self._timeeMatResRequest = nil
  self._timetResRequestMat = nil
  GameGlobal.GetUIModule(HomelandModule):GetClient():PlayHomelandBgm()
end

function UIFindTreasureSuccess:PlayAnim(TT)
  self:Lock("UIFindTreasureSuccess_PlayAnim")
  GameGlobal.UIStateManager():CloseDialog("UIFindTreasureMain")
  self:SetRotation()
  self:SetAnimatorBool("FindTreasureSuccess", true)
  self:CreateEffect()
  local effName, attachPath = HomelandFindTreasureConst.GetToolPrefabAndPath()
  self._toolModel = ResourceManager:GetInstance():SyncLoadAsset(effName, LoadType.GameObject)
  if self._toolModel then
    local go = self._toolModel.Obj
    go:SetActive(true)
    local charTrans = self:GetPlayerTransform()
    local parent = charTrans:Find(attachPath)
    local modelTrans = go.transform
    modelTrans:SetParent(parent, false)
  end
  YIELD(TT, 500)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioShowTreaseure)
  YIELD(TT, 2500)
  if self._toolModel then
    self._toolModel:Dispose()
    self._toolModel = nil
  end
  YIELD(TT, 1300)
  self._tipsPanel:SetActive(true)
  self._anim:Play("uieffanim_n17_UIFindTreasureSuccess_in")
  YIELD(TT, 1000)
  self._anim:Play("uieffanim_n17_UIFindTreasureSuccess_black")
  YIELD(TT, 400)
  self:Forcus(true, 0)
  YIELD(TT, 866)
  self._anim:Play("uieffanim_n17_UIFindTreasureSuccess")
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
        exploreMinigameComponent:HandleExploredReceiveReward(TT, res)
        self._isActiveEnd = false
      end
    end
  end
  if not self._isActiveEnd then
    self:RequestSingleData(TT)
  end
  self:RefreshUI()
  self:UnLock("UIFindTreasureSuccess_PlayAnim")
end

function UIFindTreasureSuccess:CreateEffect()
  local rewards = self._gameData:GetRewards()
  local isSpecialSingle = false
  if rewards == nil or #rewards <= 0 then
    isSpecialSingle = false
  else
    isSpecialSingle = self._gameData:IsSpecialSingle()
  end
  local effName, attachPath
  if isSpecialSingle then
    effName, attachPath = HomelandFindTreasureConst.GetSpecialEffectPrefabAndPath()
  else
    effName, attachPath = HomelandFindTreasureConst.GetNormalEffectPrefabAndPath()
  end
  self._effectModel = ResourceManager:GetInstance():SyncLoadAsset(effName, LoadType.GameObject)
  if self._effectModel then
    local go = self._effectModel.Obj
    go:SetActive(true)
    local charTrans = self:GetPlayerTransform()
    local parent = charTrans:Find(attachPath)
    local modelTrans = go.transform
    modelTrans:SetParent(parent, false)
  end
  self._toolEffectModel = ResourceManager:GetInstance():SyncLoadAsset("eff_cllect_treasure_dug.prefab", LoadType.GameObject)
  if self._toolEffectModel then
    local go = self._toolEffectModel.Obj
    go:SetActive(true)
    local modelTrans = go.transform
    local findTreasure = self._findTreasureManager:GetFindTreasure()
    if findTreasure then
      modelTrans.position = findTreasure:GetTreasurePosition()
    end
  end
end

function UIFindTreasureSuccess:RequestSingleData(TT)
  self._singleDatas = HomelandFindTreasureConst.GetFindTreasureSingleDatas(TT)
end

function UIFindTreasureSuccess:RefreshUI()
  self:GetGameObject():SetActive(true)
  self._resultPanel:SetActive(true)
  self._tipsPanel:SetActive(false)
  if self._isActiveEnd then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_find_treasure_game_active_end"))
    self._specialSingleLabel:SetText("-")
    self._normalSingleLabel:SetText("-")
  else
    self._specialSingleLabel:SetText(self._singleDatas:GetSpecialSingleCount())
    self._normalSingleLabel:SetText(self._singleDatas:GetNormalSingleCount())
  end
  self._timeLabel:SetText(self:GetTimeRemainStr(self._gameData:GetGameTime()))
  local rewards = self._gameData:GetRewards()
  if rewards == nil or #rewards <= 0 then
    self._rewardPanel:SetActive(false)
  else
    self._rewardPanel:SetActive(true)
    local isSpecialSingle = self._gameData:IsSpecialSingle()
    self._normalIconGo:SetActive(not isSpecialSingle)
    self._specialIconGo:SetActive(isSpecialSingle)
    local rewards = self._gameData:GetRewards()
    local count = #rewards
    self._rewardLoader:SpawnObjects("UIFindTreasureSuccessRewardItem", count)
    local items = self._rewardLoader:GetAllSpawnList()
    for i = 1, count do
      items[i]:Refresh(rewards[i], function(id, go)
        self:ShowItemTips(id, go)
      end)
    end
  end
end

function UIFindTreasureSuccess:ShowItemTips(id, go)
  self:ShowDialog("UIItemTipsHomeland", id, go)
end

function UIFindTreasureSuccess:GetTimeRemainStr(time)
  local timeStr = ""
  local min = math.floor(time / 60)
  if 0 <= min and min < 10 then
    timeStr = timeStr .. "0" .. min
  elseif 10 <= min then
    timeStr = timeStr .. min
  end
  timeStr = timeStr .. ":"
  local seconds = math.floor(time - min * 60)
  if seconds < 0 then
    seconds = 0
  end
  if 0 <= seconds and seconds < 10 then
    timeStr = timeStr .. "0" .. seconds
  elseif 10 <= seconds then
    timeStr = timeStr .. seconds
  end
  return timeStr
end

function UIFindTreasureSuccess:BtnRestartOnClick()
  self:StartTask(self.RequestData, self)
end

function UIFindTreasureSuccess:RequestData(TT)
  self:Lock("UIFindTreasureFailure_RequestData")
  local singleDatas = HomelandFindTreasureConst.GetFindTreasureSingleDatas(TT)
  HomelandFindTreasureConst.StartGame(TT, singleDatas, function()
    self:Close(false)
    return 800
  end, true)
  self:UnLock("UIFindTreasureFailure_RequestData")
end

function UIFindTreasureSuccess:BtnReturnOnClick()
  self:Close(true)
end

function UIFindTreasureSuccess:Close(isReturn)
  self:StartTask(self.CloseCoro, self, isReturn)
end

function UIFindTreasureSuccess:CloseCoro(TT, isReturn)
  self:Lock("UIFindTreasureSuccess_CloseCoro")
  self._anim:Play("uieffanim_n17_UIFindTreasureSuccess_out")
  YIELD(TT, 667)
  if isReturn then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayerControllerUIStatus, true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetMinimapStatus, true)
  end
  self:SetForbiddenMove(false)
  self:SetAnimatorBool("FindTreasureSuccess", false)
  self:Forcus(false)
  self._findTreasureManager:ExitFindTreasure()
  if self._effectModel then
    self._effectModel:Dispose()
    self._effectModel = nil
  end
  if self._toolEffectModel then
    self._toolEffectModel:Dispose()
    self._toolEffectModel = nil
  end
  if isReturn then
    YIELD(TT, 1000)
    self:CloseDialog()
  else
    local state = self._anim:get_Item("uieffanim_n17_UIFindTreasureSuccess_out")
    state.speed = 0
    YIELD(TT, 300)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetMinimapStatus, true)
    self:CloseDialog()
  end
  self:UnLock("UIFindTreasureSuccess_CloseCoro")
end
