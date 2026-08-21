_class("UIBuildRaiseFish", UIController)
UIBuildRaiseFish = UIBuildRaiseFish

function UIBuildRaiseFish:LoadDataOnEnter(TT, res, uiParams)
  self._raiseFishDatas = UIBuildRaiseFishDatas:New()
end

function UIBuildRaiseFish:OnShow(uiParams)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, false)
  self._fishLoader = self:GetUIComponent("UISelectObjectPath", "FishList")
  self._raiseFishLoader = self:GetUIComponent("UISelectObjectPath", "RaiseFishList")
  self._fishCountLabel = self:GetUIComponent("UILocalizationText", "FishCount")
  self._btnOpenFish = self:GetGameObject("BtnOpenFish")
  self._btnCloseFish = self:GetGameObject("BtnCloseFish")
  self._bottomTran = self:GetUIComponent("RectTransform", "Bottom")
  self._btnOpenFish:SetActive(true)
  self._btnCloseFish:SetActive(false)
  self:RefreshUI()
  self._isChange = false
  GameGlobal.EventDispatcher():Dispatch(GameEventType.EnterFindTreasure)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideHomelandMainUI, false, true)
end

function UIBuildRaiseFish:OnHide()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  if not homelandClient then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideHomelandMainUI, true, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshInteractUI)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, true)
  if self._isChange then
    HomelandWishingConst.ForceUpdateRaiseFishData()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.WishingRefreshFish)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ExitFindTreasure)
  local cameraMgr = homelandClient:CameraManager()
  local followCameraController = cameraMgr:FollowCameraController()
  followCameraController:LeaveFocus()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(false)
end

function UIBuildRaiseFish:RefreshUI()
  local remainFishs = self._raiseFishDatas:GetRemainFish()
  local count = #remainFishs
  self._fishLoader:SpawnObjects("UIBuildRaiseFishItem", count)
  local items = self._fishLoader:GetAllSpawnList()
  for i = 1, count do
    items[i]:Refresh(self, remainFishs[i])
  end
  local raiseFishs = self._raiseFishDatas:GetRaiseFish()
  count = #raiseFishs
  local maxCount = HomelandWishingConst.GetMaxRaiseFishCount()
  self._raiseFishLoader:SpawnObjects("UIBuildRaiseFishWishFishItem", maxCount)
  local items = self._raiseFishLoader:GetAllSpawnList()
  for i = 1, maxCount do
    if i <= table.count(raiseFishs) then
      items[i]:Refresh(self, raiseFishs[i])
    else
      items[i]:ShowBackGround(true)
    end
  end
  self._fishCountLabel:SetText(StringTable.Get("str_homeland_raise_fish_count_tips", self._raiseFishDatas:GetRaiseFishCount(), HomelandWishingConst.GetMaxRaiseFishCount()))
end

function UIBuildRaiseFish:RaiseFish(raiseFishData)
  if self._raiseFishDatas:GetRaiseFishCount() >= HomelandWishingConst.GetMaxRaiseFishCount() then
    return
  end
  local fishData = self._raiseFishDatas:RaiseFish(raiseFishData)
  self:RefreshUI()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WishingAddFish, fishData:GetId(), fishData:GetInstanceId())
  self._isChange = true
end

function UIBuildRaiseFish:UnRaiseFish(raiseFishData)
  self._raiseFishDatas:UnRaiseFish(raiseFishData)
  self:RefreshUI()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.WishingRemoveFish, raiseFishData:GetInstanceId())
  self._isChange = true
end

function UIBuildRaiseFish:BtnCloseOnClick(go)
  self:CloseDialog()
end

function UIBuildRaiseFish:BtnRaiseOnClick(go)
  GameGlobal.TaskManager():StartTask(self.UpdateWishingFish, self)
end

function UIBuildRaiseFish:UpdateWishingFish(TT)
  self:Lock("UIBuildRaiseFish_UpdateWishingFish")
  local homelandModlue = GameGlobal.GetModule(HomelandModule)
  local fishTable = {}
  local raiseFishs = self._raiseFishDatas:GetRaiseFish()
  for i = 1, #raiseFishs do
    local raiseData = raiseFishs[i]
    local id = raiseData:GetId()
    if not fishTable[id] then
      fishTable[id] = 1
    else
      fishTable[id] = fishTable[id] + 1
    end
  end
  local ret = homelandModlue:ApplyUpdateWishingPoolAllFish(TT, fishTable)
  if ret:GetSucc() then
    if table.count(fishTable) <= 0 then
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_raise_fish_empty"))
    else
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_raise_success"))
    end
    self._isChange = false
  else
    Log.error("养鱼错误")
  end
  self:UnLock("UIBuildRaiseFish_UpdateWishingFish")
end

function UIBuildRaiseFish:BtnCloseFishOnClick()
  self:SetPanelStatus(true)
end

function UIBuildRaiseFish:BtnOpenFishOnClick()
  self:SetPanelStatus(false)
end

function UIBuildRaiseFish:SetPanelStatus(status)
  self._btnCloseFish:SetActive(not status)
  self._btnOpenFish:SetActive(status)
  if status then
    local pos = Vector2(0, 0)
    self._bottomTran.anchoredPosition = pos
  else
    local pos = Vector2(0, -292)
    self._bottomTran.anchoredPosition = pos
  end
end
