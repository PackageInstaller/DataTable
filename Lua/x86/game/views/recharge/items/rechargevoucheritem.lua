local var_0_0 = import("game.views.shop.base.ShopItemBase")
local var_0_1 = class("RechargeVoucherItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.buyBtn_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_ticket = arg_2_0.goodID
		})
		JumpTools.OpenPopUp("rechargeDiamondExchange", {
			defaultNum = 0,
			getBaseNum = 1,
			useBaseNum = arg_2_0.shopCfg.cost,
			useId = arg_2_0.shopCfg.cost_id,
			getId = arg_2_0.itemCfg.id,
			exchangeId = arg_2_0.goodID,
			buy_source = PayConst.BUY_SOURCE_DRAW_SHOP
		}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
	end)
end

function var_0_1.UpdateView(arg_4_0)
	arg_4_0.nameLabel_.text = ItemTools.getItemName(arg_4_0.itemCfg.id)
	arg_4_0.image_.sprite = ItemTools.getItemSprite(arg_4_0.itemCfg.id)
	arg_4_0.costIcon_.sprite = ItemTools.getItemLittleSprite(arg_4_0.shopCfg.cost_id)
	arg_4_0.costLabel_.text = arg_4_0.shopCfg.cost
end

return var_0_1
