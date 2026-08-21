CommonItemView = import("game.views.common.CommonItemView")

local var_0_0 = class("SkinDiscountGiftShopCommonItem", CommonItemView)

function var_0_0.InitUI(arg_1_0, ...)
	var_0_0.super.InitUI(arg_1_0, ...)

	arg_1_0.skinGiftStateController_ = arg_1_0.controllerExCollection_:GetController("fetchstate")
end

function var_0_0.RefreshUI(arg_2_0)
	arg_2_0:RefreshSkinGiftState()
	var_0_0.super.RefreshUI(arg_2_0)
end

function var_0_0.RefreshSkinGiftState(arg_3_0)
	if arg_3_0.info_ == nil then
		arg_3_0.skinGiftStateController_:SetSelectedState("state0")

		return
	end

	if arg_3_0.info_.skinGiftSelect then
		arg_3_0.skinGiftStateController_:SetSelectedState("state2")
	else
		arg_3_0.skinGiftStateController_:SetSelectedState("state0")
	end
end

return var_0_0
