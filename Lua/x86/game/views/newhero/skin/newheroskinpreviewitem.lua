local var_0_0 = class("NewHeroSkinPreviewItem", NewHeroSkinItem)

function var_0_0.SkinState(arg_1_0)
	if arg_1_0:isUnlock(arg_1_0.skinID_) then
		if HeroTools.GetHeroIsUnlock(SkinCfg[arg_1_0.skinID_].hero) == false and arg_1_0.skinID_ == SkinCfg[arg_1_0.skinID_].hero then
			return 7
		end

		return 8
	else
		if HeroTools.CanChangeSkin(arg_1_0.skinID_) then
			return 8
		end

		if HeroTools.IsSkinOutOfDate(arg_1_0.skinID_) then
			return 4
		end

		if ShopTools.IsPC() then
			local var_1_0 = HeroTools.GetShopIdBySkinId(arg_1_0.skinID_)

			if ShopTools.IsRMB(var_1_0) then
				return 12
			end
		end

		return 3
	end
end

return var_0_0
