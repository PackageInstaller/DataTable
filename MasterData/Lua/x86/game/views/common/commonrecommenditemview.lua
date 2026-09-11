CommonItemView = import("game.views.common.CommonItemView")

local CommonRecommendItemView = class("CommonRecommendItemView", CommonItemView)

function CommonRecommendItemView:RefreshRecommend()
	self.recommendController_ = self.recommendController_ or self.controllerExCollection_:GetController("recommend")

	local var_1_0 = false

	if ItemCfg[self.info_.id] and ItemCfg[self.info_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_1_1 = 0

		if WeaponServantCfg[self.info_.id].effect[1] > 0 then
			var_1_1 = WeaponEffectCfg[WeaponServantCfg[self.info_.id].effect[1]].spec_char[1]
		end

		if var_1_1 ~= nil and var_1_1 > 0 then
			self.heroImg_.sprite = HeroTools.GetSmallHeadSprite(var_1_1)
			var_1_0 = true
		end
	end

	self.recommendController_:SetSelectedState(var_1_0 and "show" or "none")
end

return CommonRecommendItemView
