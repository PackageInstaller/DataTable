_class("UIFunctionLockButton", UICustomWidget)
local ButtonLockType = {
  OnlyTips = 1,
  Hide = 2,
  MaskAndTips = 3
}
_enum("ButtonLockType", ButtonLockType)
local MaskShowType = {
  Small = 1,
  Big = 2,
  Middle = 3
}
_enum("MaskShowType", MaskShowType)

function UIFunctionLockButton:OnShow(uiParams)
  self._maskGo = self:GetGameObject("Mask")
  self._unLockIconTrans = self:GetUIComponent("Transform", "Mask")
  self._functionButtonGo = self:GetGameObject("FunctionButton")
  self._sallGo = self:GetGameObject("Small")
  self._bigGo = self:GetGameObject("Big")
  self._middleGo = self:GetGameObject("Middle")
  self._smallLogoGo = self:GetGameObject("SmallLogo")
  self._smallLogoPressGo = self:GetGameObject("SmallLogoPress")
  self._animation = self:GetUIComponent("Animation", "Anim")
  self:AttachEvent(GameEventType.FunctionUnLock, self._HandleFunctionUnLockEvent)
  self:AttachEvent(GameEventType.GuideUnLock, self._PlayUnlockAnim)
  local etl = UICustomUIEventListener.Get(self._functionButtonGo)
  self:AddUICustomEventListener(etl, UIEvent.Press, function(go)
    self:_ButtonPress()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    self:_ButtonUp()
  end)
  self._unLockAnimName = {
    [MaskShowType.Small] = {Name = "", WaitTime = 0},
    [MaskShowType.Big] = {
      Name = "UIFunctionLockButton_xiaoshi",
      WaitTime = 2050
    },
    [MaskShowType.Middle] = {Name = "", WaitTime = 0}
  }
  self._pressUnLockAnimName = {
    [MaskShowType.Small] = {Name = "", WaitTime = 0},
    [MaskShowType.Big] = {
      Name = "UIFunctionLockButton_dianji",
      WaitTime = 0
    },
    [MaskShowType.Middle] = {Name = "", WaitTime = 0}
  }
end

function UIFunctionLockButton:OnHide()
  self:DetachEvent(GameEventType.FunctionUnLock, self._HandleFunctionUnLockEvent)
  self:DetachEvent(GameEventType.GuideUnLock, self._PlayUnlockAnim)
end

function UIFunctionLockButton:_HandleFunctionUnLockEvent(functionId)
  if self._functionId ~= functionId then
    return
  end
  self:_RefreshLockStatus()
end

function UIFunctionLockButton:SetFunctionType(functionId, buttonLockType, parentButton, maskShowType, locakCall, unLockCall)
  self._functionId = functionId
  self._buttonLockType = buttonLockType
  self._parentButton = parentButton
  self._maskShowType = maskShowType
  self._locakCall = locakCall
  self._unLockCall = unLockCall
  self:_RefreshLockStatus()
end

function UIFunctionLockButton:_PlayUnlockAnim(functionId, type)
  if functionId ~= self._functionId then
    return
  end
  if type == 0 then
    self:Refresh()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.UnLock)
  elseif type == 1 then
    self:StartTask(function(TT)
      self:Lock("GuideUnLock")
      if self._unLockCall then
        self._unLockCall(self._parentButton, function()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.UnLock)
          self:UnLock("GuideUnLock")
        end)
      end
      if self._buttonLockType == ButtonLockType.Hide or self._buttonLockType == ButtonLockType.OnlyTips then
        if self._parentButton then
          self._parentButton:SetActive(true)
        end
        self._maskGo:SetActive(false)
        self._functionButtonGo:SetActive(false)
      elseif self._buttonLockType == ButtonLockType.MaskAndTips then
        self._maskGo:SetActive(true)
        AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundBtnUnLock)
        local unLockAnimInfo = self._unLockAnimName[self._maskShowType]
        local animName = unLockAnimInfo.Name
        if animName and animName ~= "" then
          self._animation:Play(animName)
          YIELD(TT, unLockAnimInfo.WaitTime)
        end
        self._maskGo:SetActive(false)
      end
      self._functionButtonGo:SetActive(false)
      if not self._unLockCall then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.UnLock)
        self:UnLock("GuideUnLock")
      end
    end)
  end
end

function UIFunctionLockButton:_RefreshLockStatus()
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(self._functionId)
  if not isLock then
    local uiModule = self:GetUIModule(RoleModule)
    local isFirsUnLock = uiModule:GetFirstUnLockFunctionArr(self._functionId)
    if self._functionId == GameModuleID.MD_WorldBoss then
      self:_CheckEntryShow(true)
    elseif self._parentButton then
      self._parentButton:SetActive(true)
    end
    self._maskGo:SetActive(false)
    self._functionButtonGo:SetActive(false)
    return
  end
  self:Refresh()
end

function UIFunctionLockButton:Refresh()
  if self._buttonLockType == ButtonLockType.OnlyTips then
    if self._parentButton then
      self._parentButton:SetActive(true)
    end
    self._maskGo:SetActive(false)
    self._functionButtonGo:SetActive(true)
  elseif self._buttonLockType == ButtonLockType.Hide then
    if self._parentButton then
      self._parentButton:SetActive(false)
    end
    self._maskGo:SetActive(false)
    self._functionButtonGo:SetActive(false)
  elseif self._buttonLockType == ButtonLockType.MaskAndTips then
    if self._parentButton then
      self._parentButton:SetActive(true)
    end
    self._maskGo:SetActive(true)
    if self._maskShowType == MaskShowType.Small then
      self._sallGo:SetActive(true)
      self._bigGo:SetActive(false)
      self._middleGo:SetActive(false)
    elseif self._maskShowType == MaskShowType.Big then
      self._sallGo:SetActive(false)
      self._bigGo:SetActive(true)
      self._middleGo:SetActive(false)
    elseif self._maskShowType == MaskShowType.Middle then
      self._middleGo:SetActive(true)
      self._sallGo:SetActive(false)
      self._bigGo:SetActive(false)
    end
    self._functionButtonGo:SetActive(true)
  end
  if self._locakCall then
    self._locakCall()
  end
end

function UIFunctionLockButton:FunctionButtonOnClick(go)
  if not self._functionId then
    return
  end
  local functionLockCfg = Cfg.cfg_module_unlock[self._functionId]
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

function UIFunctionLockButton:_ButtonPress()
  self._smallLogoGo:SetActive(false)
  self._smallLogoPressGo:SetActive(true)
  if self._buttonLockType == ButtonLockType.MaskAndTips then
    local unLockAnimInfo = self._pressUnLockAnimName[self._maskShowType]
    local animName = unLockAnimInfo.Name
    if animName and animName ~= "" then
      self._animation:Play(animName)
    end
  end
end

function UIFunctionLockButton:_ButtonUp()
  self._smallLogoGo:SetActive(true)
  self._smallLogoPressGo:SetActive(false)
end

function UIFunctionLockButton:_CheckEntryShow(show)
  self:Lock("UIFunctionLockButton:_CheckEntryShow")
  self:StartTask(function(TT)
    local worldBossModule = self:GetModule(WorldBossModule)
    local res, data = worldBossModule:ReqWorldBossData(TT)
    if not res:GetSucc() or data == nil or data.boss_mission_id <= 0 then
      show = false
    end
    if self._parentButton then
      self._parentButton:SetActive(show)
    end
    self:UnLock("UIFunctionLockButton:_CheckEntryShow")
  end, self)
end
