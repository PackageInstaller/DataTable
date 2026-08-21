_class("UIFunctionLockTipsController", UIController)

function UIFunctionLockTipsController:OnShow(uiParams)
  local functionId = uiParams[1]
  if functionId == nil then
    return
  end
  local functionLockCfg = Cfg.cfg_module_unlock[functionId]
  if not functionLockCfg then
    return
  end
  self._functionIconImgLoader = self:GetUIComponent("RawImageLoader", "FunctionIcon")
  self._parentFunctionIconImgLoader = self:GetUIComponent("RawImageLoader", "ParentFunctionIcon")
  self._functionIconNameLabel = self:GetUIComponent("UILocalizationText", "FunctionIconName")
  self._parentFunctionIconNameLabel = self:GetUIComponent("UILocalizationText", "ParentFunctionIconName")
  self._functionNameLabel = self:GetUIComponent("UILocalizationText", "FunctionName")
  self._simpleDesLabel = self:GetUIComponent("UILocalizationText", "SimpleDes")
  self._coreDesLabel = self:GetUIComponent("UILocalizationText", "CoreDes")
  self._remainTimeLabel = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._functionNameLabel.text = StringTable.Get(functionLockCfg.Name)
  self._simpleDesLabel.text = StringTable.Get(functionLockCfg.SimpleDes)
  self._coreDesLabel.text = StringTable.Get(functionLockCfg.CoreDes)
  self._functionIconNameLabel.text = StringTable.Get(functionLockCfg.FunctionName)
  self._parentFunctionIconNameLabel.text = StringTable.Get(functionLockCfg.ParentFunctionName)
  self._functionIconImgLoader:LoadImage(functionLockCfg.icon)
  self._parentFunctionIconImgLoader:LoadImage(functionLockCfg.ParentIcon)
  self._timer = 0
  self._hasClosed = false
  self._remaindTime = 10
  self._remainTimeLabel.text = string.format(StringTable.Get("str_function_lock_remaind_time"), self._remaindTime)
end

function UIFunctionLockTipsController:OnUpdate(deltaTimeMS)
  if self._hasClosed == false then
    if self._remaindTime > 0 then
      self._timer = self._timer + deltaTimeMS
      if self._timer >= 1000 then
        self._timer = self._timer - 1000
        self._remaindTime = self._remaindTime - 1
        self._remainTimeLabel.text = string.format(StringTable.Get("str_function_lock_remaind_time"), self._remaindTime)
      end
    else
      self:_Close()
    end
  end
end

function UIFunctionLockTipsController:ButtonBackgroundOnClick(go)
  self:_Close()
end

function UIFunctionLockTipsController:_Close()
  if self._hasClosed then
    return
  end
  self._hasClosed = true
  self:CloseDialog()
  local uiModule = self:GetUIModule(RoleModule)
  uiModule:ShowUIComplete()
end
