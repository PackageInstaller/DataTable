local UINHeroResultInfo = class("UINHeroResultInfo", UIBaseNode)
local base = UIBaseNode

function UINHeroResultInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.chipItem:SetActive(false)
end

function UINHeroResultInfo:InitHeroInfo(heroInfo, resloader)
  self.ui.img_Pic.texture = resloader:LoadABAsset(PathConsts:GetCharacterPicPath(heroInfo:GetResPicName()))
  self.ui.tex_Damage.text = tostring(heroInfo.totalDamage)
end

function UINHeroResultInfo:OnDelete()
  base.OnDelete(self)
end

return UINHeroResultInfo
