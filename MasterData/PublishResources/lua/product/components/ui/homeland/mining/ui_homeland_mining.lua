_class("UIHomelandMining", UICustomWidget)
UIHomelandMining = UIHomelandMining

function UIHomelandMining:OnShow()
  self._btn = self:GetGameObject("MineBtn")
  self._btn:SetActive(false)
  self._curOre = nil
  self._doMining = false
  self._miningTaskID = nil
  self._minCutTriggerTime = 100
  self._homelandMiningManager = GameGlobal.GetUIModule(HomelandModule):GetClient():HomelandMiningManager()
  local etl = UICustomUIEventListener.Get(self._btn)
  self:AddUICustomEventListener(etl, UIEvent.Press, function(go)
    self:OnPress()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    self:OnRelease()
  end)
  self:AttachEvent(GameEventType.EnterBuildInteract, self.EnterBuildInteractEventHandle)
  self:AttachEvent(GameEventType.LeaveBuildInteract, self.LeaveBuildInteractEventHandle)
end

function UIHomelandMining:OnHide()
  self._doMining = false
end

function UIHomelandMining:OnPress()
  self._doMining = true
  self._btn.transform.localScale = Vector3(0.95, 0.95, 0.95)
  if not GameGlobal.TaskManager():FindTask(self._miningTaskID) then
    self._miningTaskID = self:StartTask(UIHomelandMining.MiningTask, self)
  end
end

function UIHomelandMining:OnRelease()
  self._doMining = false
  self._btn.transform.localScale = Vector3(1.0, 1.0, 1.0)
end

function UIHomelandMining:MiningTask(TT)
  while self._doMining and self._curOre do
    if not self._homelandMiningManager:IsCutting() then
      self._homelandMiningManager:CutOre(self._curOre)
    end
    YIELD(TT, self._minCutTriggerTime)
  end
end

function UIHomelandMining:EnterBuildInteractEventHandle(interactPoint)
  if interactPoint:GetPointType() == InteractPointType.Mining then
    if not GameGlobal.GetModule(HomelandModule):CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_MINING_UI) then
      return
    end
    if not self._homelandMiningManager:HavePickAxe() then
      return
    end
    local ore = self._homelandMiningManager:GetNearestOreCanCut()
    if not ore then
      return
    end
    if ore == self._curOre then
      return
    end
    self._curOre = ore
    self._curOre:EnterInteractScope()
    self._btn:SetActive(true)
    self:_CheckGuide()
  end
end

function UIHomelandMining:LeaveBuildInteractEventHandle(interactPoint)
  if interactPoint:GetPointType() == InteractPointType.Mining then
    if not GameGlobal.GetModule(HomelandModule):CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_MINING_UI) then
      return
    end
    if not self._homelandMiningManager:HavePickAxe() then
      return
    end
    self._btn:SetActive(false)
    if self._curOre then
      self._curOre:LeaveInteractScope()
      self._curOre = nil
    else
      Log.fatal("[Homeland] UIHomelandMining cur Ore is nil")
    end
  end
end

function UIHomelandMining:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIHomelandMining)
end
