local TaweiStateCounterItem, Super = System.NewComponent("TaweiStateCounterItem")

function TaweiStateCounterItem:ctor(uiNode, stateId, maxLayer)
  Super.ctor(self)
  self.ui = Item_Battle_BossFusionTankResource(uiNode)
  self.stateId = stateId
  self.maxLayer = maxLayer
  self.layer = Vue.ref(0)
  self.stateClient = nil
end

function TaweiStateCounterItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.ShowTips))
  binder:BindToImageFillAmount(self.ui.Image_Buff, function()
    return self.layer.value / self.maxLayer
  end)
  binder:BindToRaw(function(_, percent)
    binder:SetImageFillAmount(self.ui.Image_Buff, percent)
    self.ui.handle.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, -360 * percent)
  end, function()
    return self.layer.value / self.maxLayer
  end)
  binder:BindToText(self.ui.Text_BuffLayer, function()
    return self.layer.value
  end)
end

function TaweiStateCounterItem:OnUnbind()
  Super.OnUnbind(self)
  self.stateClient = nil
end

function TaweiStateCounterItem:ShowTips()
  if not self.stateClient then
    return
  end
  UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {
    title = self.stateClient:GetBuffName(),
    desc = self.stateClient:GetDesc()
  }, self.ui.uiNode)
end

function TaweiStateCounterItem:UpdateLayer(layer, state)
  self.layer.value = layer
  if state then
    if not self.stateClient or self.stateClient.state ~= state then
      self.stateClient = BattleStateDataClient(state)
    end
  elseif self.stateClient then
    bg.battleDataCenter.stateData:SetStateLayer(self.stateClient.state, layer)
  end
end

return TaweiStateCounterItem
