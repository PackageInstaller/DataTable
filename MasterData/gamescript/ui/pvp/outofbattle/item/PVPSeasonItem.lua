local PVPSeasonItem, Super = System.NewComponent("PVPSeasonItem")

function PVPSeasonItem:ctor(obj, seasonCfg, clickCallback)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_SeasonResource(obj)
  self.seasonCfg = seasonCfg
  self.clickCallback = clickCallback
end

function PVPSeasonItem:OnBind(binder)
  binder:SetText(self.ui.Label_Season, LT.Text(self.seasonCfg.Name))
  binder:BindButtonClick(self.ui.Btn_Select, function()
    self.clickCallback()
  end)
end

return PVPSeasonItem
