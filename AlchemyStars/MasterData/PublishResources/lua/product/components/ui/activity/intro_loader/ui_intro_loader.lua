_class("UIIntroLoader", UIController)
UIIntroLoader = UIIntroLoader

function UIIntroLoader:Constructor(ui_root_transform)
  self._redefBlurMask = false
end

function UIIntroLoader:LoadDataOnEnter(TT, res, uiParams)
  if uiParams[2] ~= nil then
    self.maskType = uiParams[2]
    self._redefBlurMask = self.maskType == MaskType.MT_BlurMask
  end
end

function UIIntroLoader:UpdateUIOnEnter()
  if self._redefBlurMask then
    local uiStateManager = GameGlobal.UIStateManager()
    local uiControllerManager = uiStateManager.uiControllerManager
    local layerManager = uiControllerManager.layerManager
    local regInfo = uiStateManager:GetUIRegisterInfo(self.name)
    local savedMaskType = regInfo.maskType
    regInfo.maskType = self.maskType
    layerManager:CheckUpdateBlurMask()
    regInfo.maskType = savedMaskType
  end
end

function UIIntroLoader:OnShow(uiParams)
  local cfgId = uiParams[1] or ""
  self._cfg = Cfg.cfg_intro_loader[cfgId]
  if self._cfg then
    local obj = UIWidgetHelper.SpawnObject(self, "_pool", self._cfg.ClassName, self._cfg.PrefabName)
    obj:SetData(self, cfgId)
  else
    Log.exception("UIIntroLoader:OnShow() cfg_intro_loader[", cfgId, "] error")
    self:CloseDialog()
  end
  local animName = self._cfg and self._cfg.ShowAnim
  local duration = self._cfg and self._cfg.ShowAnimTime or 0
  self:_PlayAnimation(animName, duration, nil)
end

function UIIntroLoader:CloseDialogWithAnimation()
  local animName = self._cfg and self._cfg.HideAnim
  local duration = self._cfg and self._cfg.HideAnimTime or 0
  self:_PlayAnimation(animName, duration, function()
    self:CloseDialog()
  end)
end

function UIIntroLoader:_PlayAnimation(animName, duration, callback)
  if not string.isnullorempty(animName) then
    UIWidgetHelper.PlayAnimation(self, "_root", animName, duration, callback)
  elseif callback then
    callback()
  end
end
