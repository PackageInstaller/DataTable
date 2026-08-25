local PvpCollectionPotencyPanel, Super = System.NewClass("PvpCollectionPotencyPanel", UIBasePanel)
PvpCollectionPotencyPanel.uiResCls = UI_Pvp_Popup_Enlightenment_TipsResource

function PvpCollectionPotencyPanel:ctor(_)
  Super.ctor(self)
end

function PvpCollectionPotencyPanel:OnBind(binder)
  self.binder = binder
end

function PvpCollectionPotencyPanel:Close()
  Super.Close(self)
end

return PvpCollectionPotencyPanel
