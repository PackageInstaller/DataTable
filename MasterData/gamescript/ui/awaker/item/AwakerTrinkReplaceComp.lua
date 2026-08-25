local AwakerTrinkReplaceComp, Super = System.NewComponent("AwakerTrinkReplaceComp")
local AwakerPage = CommonDefine.AwakerPage

function AwakerTrinkReplaceComp:ctor(uiNode, model, trinketModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_ReplaceResource(uiNode)
  self.model = model
  self.trinketModel = trinketModel
end

function AwakerTrinkReplaceComp:OnBind(binder)
  binder:BindToVisible(self.ui.uiNode, function()
    return self.model.page == AwakerPage.TrinketChange
  end)
  binder:BindToVisible(self.ui.Image_Empty, function()
    return not self.trinketModel.selectTrinketUid or 0 == self.trinketModel.selectTrinketUid
  end)
  binder:BindToText(self.ui.Text_C_Empty, function()
    local isSelectEquipping = self.trinketModel.equippedTrinketUid == self.trinketModel.selectTrinketUid
    do return LT.Text end
    return LT.Text, "TrinketPlsSelect"
  end)
  self.trinksListComp = AwakerTrinketListComp(self.ui, self.model, self.trinketModel)
  self.trinksListComp:OnBind(binder)
  binder:BindComponent(AwakerTrinketDetailComp(self.ui.UI_Awaker_Trinket_Detail, self.model, self.trinketModel))
end

function AwakerTrinkReplaceComp:OnUnbind()
  if self.trinksListComp then
    self.trinksListComp:OnUnbind()
    self.trinksListComp = nil
  end
  Super.OnUnbind(self)
end

return AwakerTrinkReplaceComp
