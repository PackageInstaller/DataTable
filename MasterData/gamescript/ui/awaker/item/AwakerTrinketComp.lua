local AwakerPage = CommonDefine.AwakerPage
local AwakerTrinketComp, Super = System.NewComponent("AwakerTrinketComp")

function AwakerTrinketComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_MainResource(uiNode)
  self.model = model
end

function AwakerTrinketComp:OnBind(binder)
  self.trinketModel = binder:createModel(AwakerTrinketModel, self.model)
  self.attrModel = binder:createModel(AwakerAttrModel, self.model)
  binder:BindComponent(AwakerTrinketSuitInfoComp(self.ui.UI_Awaker_Item_Trinket_Change, self.model, self.trinketModel, self.attrModel))
  binder:BindComponent(AwakerTrinkReplaceComp(self.ui.UI_Awaker_Popup_Trinket_Replace, self.model, self.trinketModel))
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.model:GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.model.selectAwakerId
    do return self.model.GetAwakerName, self.model end
    return self.model.GetAwakerName, self.model, tid
  end)
end

function AwakerTrinketComp:OnUnbind()
  Super.OnUnbind(self)
end

return AwakerTrinketComp
