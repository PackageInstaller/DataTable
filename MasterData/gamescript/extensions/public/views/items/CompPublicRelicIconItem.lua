local CompPublicRelicIconItem, Super = NewViewComponent("CompPublicRelicIconItem")

function CompPublicRelicIconItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Award_CreationResource(uiNode)
  self.data = data
end

function CompPublicRelicIconItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Image_icon, System.fn(self, self._OnClick))
end

function CompPublicRelicIconItem:OnEnterComponent()
  self:RefreshUI()
end

function CompPublicRelicIconItem:RefreshUI()
  self.ui.Image:SetActive(not self.data.hideName)
  self.ui.Relic_Name:SetActive(not self.data.hideName)
  local config = DT.RelicConfig[self.data.relicTid]
  if not config then
    Logger.Error("造物配置没找到,Id为:" .. self.data.relicTid)
    return
  end
  local enchantTypeMap = CommonDefine.GetEnchantTypeNameMap()
  self:SetImage(self.ui.Image_icon, config.Icon)
  self:SetImage(self.ui.Image_Quality, DT.ItemQuality[config.Quality].ItemQualityFrame)
  self:SetText(self.ui.Relic_Name, config.Name)
  self:SetText(self.ui.Text_Creation_Name, enchantTypeMap[config.Quality])
end

function CompPublicRelicIconItem:_OnClick()
  if self.data and self.data.onClick then
    self.data.onClick(self.data.relicTid, self.data.stageId)
  end
end

function CompPublicRelicIconItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicRelicIconItem
