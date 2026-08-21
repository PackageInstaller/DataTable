local var_0_0 = class("IslandCommodity", import("model.vo.BaseVO"))

var_0_0.TAG = {
	HOT = 4,
	NEW = 3,
	TIME = 2,
	NONE = 1
}

local var_0_1 = pg.pay_data_display

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_1.id
	arg_1_0.purchasedNum = arg_1_1.num
	arg_1_0.shopId = arg_1_2

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_shop_goods
end

function var_0_0.SetCfgSortIdx(arg_3_0, arg_3_1)
	arg_3_0.cfgSortIdx = arg_3_1

	return
end

function var_0_0.GetCfgSortIdx(arg_4_0)
	return arg_4_0.cfgSortIdx or arg_4_0.id
end

function var_0_0.GetName(arg_5_0)
	return arg_5_0:getConfig("goods_name")
end

function var_0_0.GetDescription(arg_6_0)
	return arg_6_0:getConfig("desc")
end

function var_0_0.GetIcon(arg_7_0)
	return "island/" .. arg_7_0:getConfig("icon")
end

function var_0_0.GetResourceConsume(arg_8_0)
	return arg_8_0:getConfig("resource_consume")
end

function var_0_0.GetItems(arg_9_0)
	return arg_9_0:getConfig("items")
end

function var_0_0.GetDisplayItems(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0:GetItems()) do
		if not var_0_0.IsHideCommondity(iter_10_1) then
			table.insert({}, iter_10_1)
		end
	end

	return {}
end

function var_0_0.GetItemsWithPt(arg_11_0)
	local var_11_0 = arg_11_0:getConfig("pt_award")
	local var_11_1 = Clone(arg_11_0:GetItems())

	if var_11_0 > 0 then
		table.insert(var_11_1, {
			VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT,
			0,
			var_11_0
		})
	end

	return var_11_1
end

function var_0_0.GetPayId(arg_12_0)
	return arg_12_0:getConfig("pay_id")
end

function var_0_0.GetMaxNum(arg_13_0)
	return arg_13_0:getConfig("limited_num")
end

function var_0_0.IsShowPurchaseLimit(arg_14_0)
	return arg_14_0:getConfig("limited_show") == 1
end

function var_0_0.IsShowSellOut(arg_15_0)
	return arg_15_0:getConfig("remian_show") == 1
end

function var_0_0.IsShowHave(arg_16_0)
	return arg_16_0:getConfig("goods_have") == 1 and #arg_16_0:GetItems() == 1
end

function var_0_0.IsShowHold(arg_17_0)
	return arg_17_0:getConfig("have_show") == 1
end

function var_0_0.GetDiscount(arg_18_0)
	local var_18_0 = 0

	if pg.TimeMgr.GetInstance():inTime(arg_18_0:getConfig("discount_time")) then
		var_18_0 = arg_18_0:getConfig("discount")
	end

	return var_18_0
end

function var_0_0.GetCommodityShowType(arg_19_0)
	return arg_19_0:getConfig("goods_detail_type")
end

function var_0_0.GetPacketItemsShowTypes(arg_20_0)
	return arg_20_0:getConfig("groups_detail_type")
end

function var_0_0.GetModel(arg_21_0)
	return arg_21_0:getConfig("items_model")
end

function var_0_0.GetModelParam(arg_22_0)
	return arg_22_0:getConfig("model_param")
end

function var_0_0.UpdateNum(arg_23_0, arg_23_1)
	arg_23_0.purchasedNum = arg_23_1

	return
end

function var_0_0.AddNum(arg_24_0, arg_24_1)
	arg_24_0.purchasedNum = arg_24_0.purchasedNum + arg_24_1

	return
end

function var_0_0.GetPayConfig(arg_25_0)
	return var_0_1[arg_25_0:GetPayId()]
end

function var_0_0.GetTag(arg_26_0)
	local var_26_0 = arg_26_0:getConfig("tag") or 0

	return switch(var_26_0, {
		[0] = function()
			if arg_26_0:IsTimeLimitCommodity() then
				return var_0_0.TAG.TIME or var_0_0.TAG.NONE
			end
		end,
		function()
			return var_0_0.TAG.NEW
		end,
		function()
			return var_0_0.TAG.HOT
		end
	}, function()
		return var_0_0.TAG.NONE
	end)
end

function var_0_0.IsTimeLimitCommodity(arg_31_0)
	if type((arg_31_0:getConfig("time"))) == "table" then
		return true
	end

	return false
end

function var_0_0.IsCharacterInviteItemHold(arg_32_0)
	local var_32_0 = arg_32_0:GetItems()

	for iter_32_0, iter_32_1 in ipairs(pg.island_chara_template.all) do
		table.insert({}, pg.island_chara_template[iter_32_1].invite_item)
	end

	if #var_32_0 ~= 1 or not table.contains({}, var_32_0[1][2]) then
		return false
	end

	return getProxy(IslandProxy):GetIsland():GetCharacterAgency():HasInvite(pg.island_chara_template.all[table.indexof({}, var_32_0[1][2])])
end

function var_0_0.GetDressType(arg_33_0)
	local var_33_0 = arg_33_0:GetItems()

	if not var_33_0[1] or var_33_0[1][1] ~= DROP_TYPE_ISLAND_DRESS then
		return nil
	end

	local var_33_1 = pg.island_dress_template[var_33_0[1][2]]

	if not pg.island_dress_template[var_33_0[1][2]] then
		return nil
	end

	return var_33_1.type
end

function var_0_0.IsHideCommondity(arg_34_0)
	local var_34_0 = arg_34_0.type or arg_34_0[1]
	local var_34_1 = arg_34_0.id or arg_34_0[2]

	if var_34_0 == DROP_TYPE_ISLAND_DRESS then
		if pg.island_dress_template[var_34_1] and pg.island_dress_template[var_34_1].is_hide == 1 then
			return true
		end
	end

	return false
end

return var_0_0
