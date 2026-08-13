class = var_0_10000

local var_0_0 = "ActivitySelectableShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ActivityShopPage"))

function var_0_1.CustomInit(arg_1_0)
	ActivityShopPurchasePanel = var_1_10001
	arg_1_0.purchaseWindow = var_1_10001.New(arg_1_0._tf, arg_1_0.event)

	arg_1_0:SetPurchaseConfirmCb()

	return
end

function var_0_1.UpdateShop(arg_2_0, ...)
	var_0_1.super.UpdateShop(arg_2_0, ...)

	local var_2_0 = arg_2_0.purchaseWindow

	if var_1.isShowing(var_2_0) then
		local var_2_1 = arg_2_0.purchaseWindow

		var_1.ExecuteAction(var_2_1, "Hide")
	end

	return
end

function var_0_1.SetPurchaseConfirmCb(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002("false", "请参考MetaShopPage实现该方法")

	return
end

function var_0_1.OnInitItem(arg_4_0, arg_4_1)
	ActivityGoodsCard = var_1_10002

	local var_4_0 = var_1_10002.New(arg_4_1)

	onButton = var_1_10003

	local var_4_1 = arg_4_0
	local var_4_2 = var_4_0.tf

	local function var_4_3()
		local var_5_0 = var_4_0.goodsVO

		if var_0.Selectable(var_5_0) then
			local var_5_1 = arg_4_0.purchaseWindow
			local var_5_2 = var_0.ExecuteAction
			local var_5_3 = "Show"
			local var_5_4 = {
				icon = "props/21000",
				id = var_4_0.goodsVO.id
			}
			local var_5_5 = var_4_0.goodsVO

			var_5_4.count = var_5.getConfig(var_5_5, "num_limit")

			local var_5_6 = var_4_0.goodsVO

			var_5_4.type = var_5.getConfig(var_5_6, "commodity_type")

			local var_5_7 = var_4_0.goodsVO

			var_5_4.price = var_5.getConfig(var_5_7, "resource_num")

			local var_5_8 = var_4_0.goodsVO

			var_5_4.displays = var_5.getConfig(var_5_8, "commodity_id_list")

			local var_5_9 = var_4_0.goodsVO

			var_5_4.num = var_5.getConfig(var_5_9, "num")

			var_5_2(var_5_1, var_5_3, var_5_4)
		else
			local var_5_10 = arg_4_0

			var_0.OnClickCommodity(var_5_10, var_4_0.goodsVO, function(arg_6_0, arg_6_1)
				local var_6_0 = arg_4_0

				var_2.OnPurchase(var_6_0, arg_6_0, arg_6_1)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_4_1, var_4_2, var_4_3, var_1_10008)

	arg_4_0.cards[arg_4_1] = var_4_0

	return
end

function var_0_1.OnDestroy(arg_7_0)
	var_0_1.super.OnDestroy(arg_7_0)

	local var_7_0 = arg_7_0.purchaseWindow

	var_1.Destroy(var_7_0)

	return
end

return var_0_1
