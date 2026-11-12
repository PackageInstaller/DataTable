local TemplateTopEnergyCtrl = class("TemplateTopEnergyCtrl", BaseCtrl)
TemplateTopEnergyCtrl._mapNodeConfig = {
  imgBar = {sComponentName = "Image"},
  txtCount = {sComponentName = "TMP_Text"},
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddEnergy"
  }
}
TemplateTopEnergyCtrl._mapEventConfig = {
  [EventId.UpdateEnergy] = "Refresh",
  [EventId.UpdateWorldClass] = "Refresh"
}

function TemplateTopEnergyCtrl:Refresh()
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit")
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.txtCount, nCurEnergy .. "/" .. nMaxEnergy)
  NovaAPI.SetImageFillAmount(self._mapNode.imgBar, nMaxEnergy < nCurEnergy and 1 or nCurEnergy / nMaxEnergy)
end

function TemplateTopEnergyCtrl:AddCallBack(callback)
  self.callBack = callback
end

function TemplateTopEnergyCtrl:OnBtnClick_AddEnergy(btn)
  self._panel._nFadeInType = 2
  
  local function callback()
    EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
    if self.callBack ~= nil then
      self.callBack()
    end
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy, AllEnum.EnergyPanelType.Main, {}, true, callback)
end

return TemplateTopEnergyCtrl
