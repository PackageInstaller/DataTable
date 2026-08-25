local BattleAssistAwakerIcon, Super = System.NewComponent("BattleAssistAwakerIcon")

function BattleAssistAwakerIcon:ctor(obj, awakerId)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_List_2Resource(obj)
  self.awakerId = awakerId
end

function BattleAssistAwakerIcon:OnBind(binder)
  binder:BindToImage(self.ui.Image_Awaker, function()
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, self.awakerId
  end)
  binder:BindToImage(self.ui.Image_D_Quality_Color, function()
    do return AwakerDataUtils.GetAwakerQualityColor end
    return AwakerDataUtils.GetAwakerQualityColor, self.awakerId
  end)
  binder:BindToImage(self.ui.Image_Career_Icon, function()
    local cfg = AwakerDataUtils.GetAwakerConfig(self.awakerId)
    local iconPath = AwakerDataUtils.GetSchoolIcon(cfg.School)
    return iconPath
  end)
end

return BattleAssistAwakerIcon
