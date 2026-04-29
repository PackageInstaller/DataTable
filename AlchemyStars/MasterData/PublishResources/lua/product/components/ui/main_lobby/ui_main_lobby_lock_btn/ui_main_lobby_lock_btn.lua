_class("UIMainLobbyLockBtn", UICustomWidget)
UIMainLobbyLockBtn = UIMainLobbyLockBtn

function UIMainLobbyLockBtn:OnShow()
  self._unlock = nil
  self:AttachEvent(GameEventType.FunctionUnLock, self._HandleFunctionUnLockEvent)
  self:AttachEvent(GameEventType.GuideUnLock, self._PlayUnlockAnim)
end

function UIMainLobbyLockBtn:_PlayUnlockAnim(gameModuleID, type)
  Log.debug("###[UIMainLobbyLockBtn] _PlayUnlockAnim,gameModuleID:", gameModuleID, "|type:", type)
  if gameModuleID ~= self.gameModuleID then
    return
  end
  if type == 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.UnLock)
    self._go = self:GetGameObject("go")
    self._go:SetActive(true)
    if self._lockCB then
      self._lockCB()
    end
  elseif type == 1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.UnLock)
    self._go:SetActive(true)
    local anim = self:GetUIComponent("Animation", "anim")
    anim:Play("uieff_UIMainLobbyLockBtn_open")
    self:Lock("UIMainLobbyLockBtn:PlayUnLockAnim")
    self._event = GameGlobal.Timer():AddEvent(2000, function()
      self:UnLock("UIMainLobbyLockBtn:PlayUnLockAnim")
      self:_RefreshLockStatus()
      if self._unlockCB then
        self._unlockCB()
      end
    end)
  end
  Log.debug("###[UIMainLobbyLockBtn] _PlayUnlockAnim type:", type)
end

function UIMainLobbyLockBtn:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
  self:UnLock("UIMainLobbyLockBtn:PlayUnLockAnim")
end

function UIMainLobbyLockBtn:_HandleFunctionUnLockEvent(gameModuleID)
  if self.gameModuleID ~= gameModuleID then
    return
  end
  self:_RefreshLockStatus()
end

function UIMainLobbyLockBtn:_RefreshLockStatus()
  local module = GameGlobal.GetModule(RoleModule)
  self._unlock = module:CheckModuleUnlock(self.gameModuleID)
  self._go = self:GetGameObject("go")
  self._go:SetActive(not self._unlock)
end

function UIMainLobbyLockBtn:BtnOnClick(go)
  local functionLockCfg = Cfg.cfg_module_unlock[self.gameModuleID]
  if not functionLockCfg then
    Log.debug("don't have function config")
    return
  end
  if functionLockCfg.isNolockType == 0 then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUnlockModule)
    ToastManager.ShowToast(StringTable.Get(functionLockCfg.Tips))
  else
    ToastManager.ShowLockTip()
  end
end

function UIMainLobbyLockBtn:SetFunctionType(gameModuleID)
  self.gameModuleID = gameModuleID
  local module = GameGlobal.GetModule(RoleModule)
  self._unlock = module:CheckModuleUnlock(gameModuleID)
  self._go = self:GetGameObject("go")
  self._go:SetActive(not self._unlock)
end

function UIMainLobbyLockBtn:SetColorImage(img, useColor)
  if self._unlock == nil then
    self:SetFunctionType(self.gameModuleID)
  end
  local color
  if self._unlock then
    color = Color(1, 1, 1, 1)
  elseif useColor then
    color = useColor
  else
    color = Color(0.09019607843137255, 0.09803921568627451, 0.10980392156862745, 0.7843137254901961)
  end
  img.color = color
end

function UIMainLobbyLockBtn:SetLockViewCallback(lockCB, unlockCB)
  self._lockCB = lockCB
  self._unlockCB = unlockCB
end
