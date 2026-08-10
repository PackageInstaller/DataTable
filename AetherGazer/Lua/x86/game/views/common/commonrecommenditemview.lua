CommonItemView = import("game.views.common.CommonItemView")

local var_0_0 = class("CommonRecommendItemView", CommonItemView)

function var_0_0.RefreshRecommend(arg_1_0)
	if not arg_1_0.recommendController_ then
		arg_1_0.recommendController_ = arg_1_0.controllerExCollection_:GetController("recommend")
	end

	local var_1_0 = false
	local var_1_1 = ItemCfg[arg_1_0.info_.id]

	if var_1_1 and var_1_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_1_2 = WeaponServantCfg[arg_1_0.info_.id].effect[1]
		local var_1_3 = 0

		if var_1_2 > 0 then
			var_1_3 = WeaponEffectCfg[var_1_2].spec_char[1]
		end

		if var_1_3 ~= nil and var_1_3 > 0 then
			arg_1_0.heroImg_.sprite = HeroTools.GetSmallHeadSprite(var_1_3)
			var_1_0 = true
		end
	end

	arg_1_0.recommendController_:SetSelectedState(var_1_0 and "show" or "none")
end

return var_0_0
