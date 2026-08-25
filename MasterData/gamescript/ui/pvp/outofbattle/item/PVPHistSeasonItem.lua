local PVPHistSeasonItem, Super = System.NewComponent("PVPHistSeasonItem")

function PVPHistSeasonItem:ctor(obj, seasonCfg, clickFunc)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_SeasonResource(obj)
  self.seasonCfg = seasonCfg
  self.clickFunc = clickFunc
end

function PVPHistSeasonItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Label_Season, LT.Text(self.seasonCfg.Name))
  binder:BindButtonClick(self.ui.Btn_Select, function()
    if self.clickFunc then
      self.clickFunc(self.seasonCfg)
    end
  end)
end

return PVPHistSeasonItem
