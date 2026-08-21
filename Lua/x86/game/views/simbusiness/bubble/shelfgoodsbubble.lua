local var_0_0 = require("game.views.simBusiness.bubble.EntityBubbleBase")
local var_0_1 = class("ShelfGoodsBubble", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/item/PropBubble"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0.goodsItem = SimBusinessGoodsItem.New(arg_2_0.goodsItem_)
end

function var_0_1.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.focus = arg_3_1

	arg_3_0:SetFollowEntity(arg_3_1, "gua_bubble")

	local var_3_0 = DormUtils.GetEntityData(arg_3_1)
	local var_3_1 = arg_3_2 or var_3_0.goods

	arg_3_0.goodsItem:RefreshData(var_3_1)
	arg_3_0.goodsItem:RegisterClick(function()
		manager.notify:Invoke("ON_FURNITURE_CLICKED", arg_3_1)
	end)

	local var_3_2 = var_3_0.cfgID

	arg_3_0.info_.text = SimBusinessTools.GetSellAbilityTextShort(var_3_2, var_3_1)
end

function var_0_1.Refresh(arg_5_0)
	local var_5_0 = DormUtils.GetEntityData(arg_5_0.focus)
	local var_5_1 = var_5_0.cfgID
	local var_5_2 = var_5_0.goods

	arg_5_0.info_.text = SimBusinessTools.GetSellAbilityTextShort(var_5_1, var_5_2)
end

function var_0_1.OnSetGoods(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == arg_6_0.focus then
		arg_6_0:SetData(arg_6_1, arg_6_2)
	else
		arg_6_0:Refresh()
	end
end

function var_0_1.RegisterEvents(arg_7_0)
	arg_7_0:RegistEventListener("SIM_BUSINESS_SET_GOODS", handler(arg_7_0, arg_7_0.OnSetGoods))
end

function var_0_1.Dispose(arg_8_0)
	arg_8_0.goodsItem:Dispose()
	var_0_1.super.Dispose(arg_8_0)
end

return var_0_1
