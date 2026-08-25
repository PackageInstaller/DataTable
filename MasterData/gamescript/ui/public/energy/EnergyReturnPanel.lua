local EnergyReturnPanel, Super = System.NewClass("EnergyReturnPanel", UIBasePanel)
EnergyReturnPanel.uiResCls = Func_MainScene_ReturnVitResource

function EnergyReturnPanel:ctor(confirmCb, cancelCb)
  Super.ctor(self)
  self.showVal = Vue.ref(DataCenter.copiesData.copiesSettleData.retEnergy)
  self.confirmCb = confirmCb
  self.cancelCb = cancelCb
end

function EnergyReturnPanel:OnBind(binder)
  Logger.Debug("EnergyReturnPanel:OnBind(), 创建 UI")
  binder:BindToText(self.ui.Text_Num, function()
    return self.showVal.value
  end)
  self.timer = TimerManager.Instance:CreateTimer(1, 1, nil, function()
    TimerManager.Instance:StopTimer(self.timer)
    self.timer = nil
    self:Close()
  end)
end

return EnergyReturnPanel
