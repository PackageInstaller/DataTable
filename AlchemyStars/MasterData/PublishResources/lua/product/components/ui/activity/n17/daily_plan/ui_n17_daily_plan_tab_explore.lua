_class("UIN17DailyPlanTabExplore", UICustomWidget)
UIN17DailyPlanTabExplore = UIN17DailyPlanTabExplore

function UIN17DailyPlanTabExplore:OnShow(uiParams)
  self._isOpen = true
end

function UIN17DailyPlanTabExplore:OnHide()
  self._isOpen = false
end

function UIN17DailyPlanTabExplore:SetData(component, inHome, closeCallback)
  self._inHome = inHome
  self._closeCallback = closeCallback
  local component_cfg_id = component:GetComponentCfgId()
  local cfg = Cfg.cfg_component_power2item[component_cfg_id]
  if cfg then
    UIWidgetHelper.SetItemIcon(self, cfg.ItemID, "_icon2")
    UIWidgetHelper.SetLocalizationText(self, "_txt2", cfg.Ratio)
  end
end

function UIN17DailyPlanTabExplore:BtnOnClick()
  if self._inHome then
  else
    self:SwitchState(UIStateType.UIDiscovery)
  end
end
