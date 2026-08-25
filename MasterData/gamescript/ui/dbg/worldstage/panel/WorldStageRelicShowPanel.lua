local WorldStageRelicShowPanel, Super = System.NewClass("WorldStageRelicShowPanel", WorldStageShopConfirmPanel)

function WorldStageRelicShowPanel:ctor(relic, ...)
  Super.ctor(self, relic, ...)
end

function WorldStageRelicShowPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self.ui.Btn_Cancel:SetActive(false)
  self.ui.Btn_Sure:SetActive(false)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindTimer(3, 0, nil, function()
    self:Close()
  end)
end

return WorldStageRelicShowPanel
