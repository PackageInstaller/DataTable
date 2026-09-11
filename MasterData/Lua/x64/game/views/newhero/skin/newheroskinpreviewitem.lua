local NewHeroSkinPreviewItem = class("NewHeroSkinPreviewItem", NewHeroSkinItem)

function NewHeroSkinPreviewItem:SkinState()
	if self:isUnlock(self.skinID_) then
		if HeroTools.GetHeroIsUnlock(SkinCfg[self.skinID_].hero) == false and self.skinID_ == SkinCfg[self.skinID_].hero then
			return 7
		end

		return 8
	else
		if HeroTools.CanChangeSkin(self.skinID_) then
			return 8
		end

		if HeroTools.IsSkinOutOfDate(self.skinID_) then
			return 4
		end

		if ShopTools.IsPC() and ShopTools.IsRMB((HeroTools.GetShopIdBySkinId(self.skinID_))) then
			return 12
		end

		return 3
	end
end

return NewHeroSkinPreviewItem
