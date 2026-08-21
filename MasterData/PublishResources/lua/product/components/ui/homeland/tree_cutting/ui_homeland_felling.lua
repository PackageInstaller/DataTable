_class("UIHomelandFelling", UICustomWidget)
UIHomelandFelling = UIHomelandFelling

function UIHomelandFelling:OnShow()
  self._btn = self:GetGameObject("FellBtn")
  self._btn:SetActive(false)
  self._curTree = nil
  self._doFelling = false
  self._fellTaskID = nil
  self._minCutTriggerTime = 100
  self._uiHomelandModule = GameGlobal.GetUIModule(HomelandModule)
  self._homelandTreeCuttingManager = self._uiHomelandModule:GetClient():TreeCuttingManager()
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

function UIHomelandFelling:OnHide()
  self._doFelling = false
end

function UIHomelandFelling:OnPress()
  self._doFelling = true
  self._btn.transform.localScale = Vector3(0.95, 0.95, 0.95)
  if not GameGlobal.TaskManager():FindTask(self._fellTaskID) then
    self._fellTaskID = self:StartTask(UIHomelandFelling.FellTask, self)
  end
end

function UIHomelandFelling:OnRelease()
  self._doFelling = false
  self._btn.transform.localScale = Vector3(1.0, 1.0, 1.0)
end

function UIHomelandFelling:FellTask(TT)
  while self._doFelling and self._curTree do
    if self._uiHomelandModule:IsRunning() and not self._homelandTreeCuttingManager:IsCutting() then
      self._homelandTreeCuttingManager:CutTree(self._curTree)
    end
    YIELD(TT, self._minCutTriggerTime)
  end
end

function UIHomelandFelling:EnterBuildInteractEventHandle(interactPoint)
  if interactPoint:GetPointType() == InteractPointType.CutTree then
    if not GameGlobal.GetModule(HomelandModule):CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_FELL_UI) then
      return
    end
    if not self._homelandTreeCuttingManager:HaveAxe() then
      return
    end
    local tree = interactPoint:GetBuild()
    if tree == self._curTree then
      return
    end
    if self._curTree then
      self._curTree:LeaveInteractScope()
    end
    self._curTree = interactPoint:GetBuild()
    self._curTree:EnterInteractScope()
    self._btn:SetActive(true)
    self:_CheckGuide()
  end
end

function UIHomelandFelling:LeaveBuildInteractEventHandle(interactPoint)
  if interactPoint:GetPointType() == InteractPointType.CutTree then
    if not GameGlobal.GetModule(HomelandModule):CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_FELL_UI) then
      return
    end
    if not self._homelandTreeCuttingManager:HaveAxe() then
      return
    end
    self._btn:SetActive(false)
    if self._curTree then
      self._curTree:LeaveInteractScope()
      self._curTree = nil
    else
      Log.fatal("[Homeland] UIHomelandFelling cur tree is nil")
    end
  end
end

function UIHomelandFelling:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIHomelandFelling)
end
