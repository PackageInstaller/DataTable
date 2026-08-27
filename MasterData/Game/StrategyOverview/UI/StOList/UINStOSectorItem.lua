local UINStOSectorItem = class("UINStOSectorItem", UIBaseNode)
local base = UIBaseNode

function UINStOSectorItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStOSectorItem:InitStOSectorItem(sectorId, resLoader)
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg == nil then
    error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
    return
  end
  self.ui.tex_Affiliation.text = LanguageUtil.GetLocaleText(sectorCfg.type_name)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(sectorCfg.name)
  local path = PathConsts:GetSectorStrategyOverviewBgPath(sectorCfg.pic_stratery_overview)
  self.ui.img_Pic.enabled = false
  resLoader:LoadABAssetAsync(path, function(texture)
    if texture == nil then
      return
    end
    self.ui.img_Pic.texture = texture
    self.ui.img_Pic.enabled = true
  end)
end

function UINStOSectorItem:SetBgImageColor(active)
  self.ui.img_Adapter.color = active == true and Color.New(1, 1, 1, 0.1) or Color.New(0, 0, 0, 0.2)
end

function UINStOSectorItem:OnDelete()
  base.OnDelete(self)
end

return UINStOSectorItem
