_class("UIFindTreasureDetail", UIController)
UIFindTreasureDetail = UIFindTreasureDetail

function UIFindTreasureDetail:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = uiParams[2]
  local componentType = uiParams[3]
  if HomelandFindTreasureConst.InitHomelandFindTreausreData(TT, campaignType, componentType) == false then
    res:SetSucc(false)
    return
  end
  self._campaign = HomelandFindTreasureConst.GetActivityCampaign()
  self._singleDatas = HomelandFindTreasureConst.GetFindTreasureSingleDatas(TT)
  self._gameData = HomelandFindTreasureConst.GetGameData()
end

function UIFindTreasureDetail:OnShow(uiParams)
  self._onlyShow = uiParams[1] and true
  self._noSingle = self:GetGameObject("NoSingle")
  self._haveSingle = self:GetGameObject("HaveSingle")
  self._normalSingle = self:GetGameObject("NormalSingle")
  self._specialSingle = self:GetGameObject("SpecialSingle")
  self._btnStart = self:GetGameObject("BtnStart")
  self._btnGoto = self:GetGameObject("BtnGoto")
  self._singleTimeLabel = self:GetUIComponent("UILocalizationText", "SingleTime")
  self._normalSingleCountLabel = self:GetUIComponent("UILocalizationText", "NormalSingleCount")
  self._specialSingleCountLabel = self:GetUIComponent("UILocalizationText", "SpecialSingleCount")
  self._rewardLoader = self:GetUIComponent("UISelectObjectPath", "Rewards")
  if self._onlyShow then
    self._btnStart:SetActive(false)
    self._btnGoto:SetActive(true)
  else
    self._btnStart:SetActive(true)
    self._btnGoto:SetActive(false)
    local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
    local homelandClient = homeLandModule:GetClient()
    local characterController = homelandClient:CharacterManager():MainCharacterController()
    local tran = characterController:Transform()
    local originalPosition = tran.position
    local originalRotation = tran.rotation
    HomelandFindTreasureConst.SetOriginalPosition(originalPosition)
    HomelandFindTreasureConst.SetOriginalRotation(originalRotation)
  end
  if not self._singleDatas:IsSingleFull() then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:Timer()
    end)
  end
  self:RefreshUI()
  if not N18Data.HasPrefsMiniGame() then
    N18Data.SetPrefsMiniGame()
  end
  local localProcess = self._campaign:GetLocalProcess()
  if localProcess.OnOpenWeiSiExplore then
    localProcess:OnOpenWeiSiExplore()
  end
end

function UIFindTreasureDetail:RefreshUI()
  local canUseSingleData = self._singleDatas:GetCanUseSingleData()
  if canUseSingleData == nil then
    self._noSingle:SetActive(true)
    self._haveSingle:SetActive(false)
  else
    self._noSingle:SetActive(false)
    self._haveSingle:SetActive(true)
    if canUseSingleData:IsSpecialSingle() then
      self._normalSingle:SetActive(false)
      self._specialSingle:SetActive(true)
    else
      self._normalSingle:SetActive(true)
      self._specialSingle:SetActive(false)
    end
    local rewards = self._gameData:GetRewards()
    local count = #rewards
    self._rewardLoader:SpawnObjects("UIFindTreasureDetailRewardItem", count)
    local items = self._rewardLoader:GetAllSpawnList()
    for i = 1, count do
      items[i]:Refresh(rewards[i], function(id, go)
        self:ShowItemTips(id, go)
      end)
    end
  end
  self._normalSingleCountLabel:SetText(self._singleDatas:GetNormalSingleCount())
  self._specialSingleCountLabel:SetText(self._singleDatas:GetSpecialSingleCount())
  self._singleTimeLabel:SetText(self._singleDatas:GetSingleTimeStr())
end

function UIFindTreasureDetail:Timer()
  self._singleTimeLabel:SetText(self._singleDatas:GetSingleTimeStr())
  if self._singleDatas:GetNextSingleTime() <= 0 then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    GameGlobal.TaskManager():StartTask(self.RequestSingleData, self)
  end
end

function UIFindTreasureDetail:RequestSingleData(TT)
  self:Lock("UIFindTreasureDetail_RequestSingleData")
  Log.error("请求数据")
  self._singleDatas = HomelandFindTreasureConst.GetFindTreasureSingleDatas(TT)
  self._gameData = HomelandFindTreasureConst.GetGameData()
  self:RefreshUI()
  if not self._singleDatas:IsSingleFull() then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:Timer()
    end)
  end
  self:UnLock("UIFindTreasureDetail_RequestSingleData")
end

function UIFindTreasureDetail:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIFindTreasureDetail:ShowItemTips(id, go)
  self:ShowDialog("UIItemTipsHomeland", id, go)
end

function UIFindTreasureDetail:BtnCloseOnClick()
  if not self._onlyShow then
    local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
    local homelandClient = homeLandModule:GetClient()
    local characterController = homelandClient:CharacterManager():MainCharacterController()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, true)
  self:_CloseDialogWithAnim()
end

function UIFindTreasureDetail:BtnPlotOnClick()
  self:ShowDialog("UIStoryController", HomelandFindTreasureConst.GetPlotId())
end

function UIFindTreasureDetail:BtnInfoOnClick()
  self:ShowDialog("UIHomeHelpController", "UIFindTreasureDetail")
end

function UIFindTreasureDetail:BtnStartOnClick()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  if characterController:IsInteracting() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_invite_role_cannot_teleport_interact"))
    return
  end
  if characterController:IsWearingSwimsuit() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_invite_role_cannot_teleport_swimsuit"))
    return
  end
  self:StartTask(self.OnStartBattle, self)
end

function UIFindTreasureDetail:BtnGotoOnClick()
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_HomeLand)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_homeland_function_lock_tips"))
    return
  end
  GameGlobal.GetModule(HomelandModule):GetUIModule():LoadHomeland()
end

function UIFindTreasureDetail:OnStartBattle(TT)
  HomelandFindTreasureConst.StartGame(TT, self._singleDatas, function()
    self:_CloseDialogWithAnim()
  end, false)
end

function UIFindTreasureDetail:_CloseDialogWithAnim()
  UIWidgetHelper.PlayAnimation(self, "_anim", "UIFindTreasureDetail_anim2", 667, function()
    self:CloseDialog()
    if self._onlyShow then
      HomelandFindTreasureConst.Destroy()
    end
  end)
end
