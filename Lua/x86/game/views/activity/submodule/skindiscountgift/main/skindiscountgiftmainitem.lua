local var_0_0 = class("SkinDiscountGiftMainItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.controllerEx_:GetController("state")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		if SkinDiscountGiftTools.GetRemainCount(arg_3_0.id_) <= 0 then
			ShowTips("SELL_OUT")

			return
		elseif SkinDiscountGiftTools.HasAllGoodsSkin(arg_3_0.id_) then
			ShowTips("SKIN_DISCOUNT_GIFT_CANNOT_BUY_TIPS")

			return
		else
			local var_4_0 = ActivitySkinDiscountCfg[arg_3_0.id_]

			if not ActivityData:GetActivityIsOpen(var_4_0.activity_id) then
				ShopTips("TIME_OVER")

				return
			end

			SkinDiscountGiftData:ClearGoodsIDList()
			arg_3_0:Go("/skinDiscountGiftShop", {
				giftID = arg_3_0.id_
			})
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id_ = arg_5_1

	local var_5_0 = SkinDiscountGiftTools.GetRemainCount(arg_5_1)
	local var_5_1 = ActivitySkinDiscountCfg[arg_5_1]

	arg_5_0.titleText_.text = var_5_1.goods_name
	arg_5_0.discountText_.text = string.format("%.1f%s", var_5_1.discount / 10, GetI18NText(GetTips("LABEL_DISCOUNT")))
	arg_5_0.numText_.text = var_5_0

	if var_5_0 <= 0 then
		arg_5_0.stateController_:SetSelectedState("state1")
	elseif SkinDiscountGiftTools.HasAllGoodsSkin(arg_5_1) then
		arg_5_0.stateController_:SetSelectedState("state2")
	else
		arg_5_0.stateController_:SetSelectedState("state0")
	end
end

return var_0_0
