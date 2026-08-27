local UIEpSettlementSkadaItem = class("UIEpSettlementSkadaItem", UIBaseNode)
local base = UIBaseNode

function UIEpSettlementSkadaItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIEpSettlementSkadaItem:InitSettlementSkadaItem(heroInfo, process, resloader)
  self.ui.img_Pic.texture = resloader:LoadABAsset(PathConsts:GetCharacterPicPath(heroInfo:GetResPicName()))
  self.ui.tex_Damage.text = tostring(heroInfo.totalDamage)
  self.ui.slider.value = process
end

function UIEpSettlementSkadaItem:OnDelete()
  base.OnDelete(self)
end

return UIEpSettlementSkadaItem
