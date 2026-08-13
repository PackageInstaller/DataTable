class = var_0_10000

local var_0_0 = "IslandCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TAG = {
	HOT = 4,
	NEW = 3,
	TIME = 2,
	NONE = 1
}
pg = var_1

local var_0_2 = var_1.pay_data_display

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_1.id
	arg_1_0.purchasedNum = arg_1_1.num
	arg_1_0.shopId = arg_1_2

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_shop_goods
end

function var_0_1.SetCfgSortIdx(arg_3_0, arg_3_1)
	arg_3_0.cfgSortIdx = arg_3_1

	return
end

function var_0_1.GetCfgSortIdx(arg_4_0)
	local var_4_0

	if not arg_4_0.cfgSortIdx then
		var_4_0 = arg_4_0.id
	end

	return var_4_0
end

function var_0_1.GetName(arg_5_0)
	return arg_5_0:getConfig("goods_name")
end

function var_0_1.GetDescription(arg_6_0)
	return arg_6_0:getConfig("desc")
end

function var_0_1.GetIcon(arg_7_0)
	return "island/" .. arg_7_0:getConfig("icon")
end

function var_0_1.GetResourceConsume(arg_8_0)
	return arg_8_0:getConfig("resource_consume")
end

function var_0_1.GetItems(arg_9_0)
	return arg_9_0:getConfig("items")
end

function var_0_1.GetDisplayItems(arg_10_0)
	local var_10_0 = {}

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0:GetItems()) do
		if not var_0_1.IsHideCommondity(iter_10_1) then
			table = var_7

			var_7.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_1.GetItemsWithPt(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.getConfig(var_11_0, "pt_award")

	Clone = var_11_0

	local var_11_2 = var_11_0(arg_11_0:GetItems())

	if 0 < var_11_1 then
		table = var_3

		local var_11_3 = var_3.insert
		local var_11_4 = var_11_2
		local var_11_5 = {
			nil,
			0
		}

		VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_1_10006
		var_11_5[1] = var_1_10006
		var_11_5[3] = var_11_1

		var_11_3(var_11_4, var_11_5)
	end

	return var_11_2
end

function var_0_1.GetPayId(arg_12_0)
	return arg_12_0:getConfig("pay_id")
end

function var_0_1.GetMaxNum(arg_13_0)
	return arg_13_0:getConfig("limited_num")
end

function var_0_1.IsShowPurchaseLimit(arg_14_0)
	return arg_14_0:getConfig("limited_show") == 1
end

function var_0_1.IsShowSellOut(arg_15_0)
	return arg_15_0:getConfig("remian_show") == 1
end

function var_0_1.IsShowHave(arg_16_0)
	return arg_16_0:getConfig("goods_have") == 1 and #arg_16_0:GetItems() == 1
end

function var_0_1.IsShowHold(arg_17_0)
	return arg_17_0:getConfig("have_show") == 1
end

function var_0_1.GetDiscount(arg_18_0)
	local var_18_0 = 0

	pg = var_1_10002

	local var_18_1 = var_1_10002.TimeMgr.GetInstance()

	if var_2.inTime(var_18_1, arg_18_0:getConfig("discount_time")) then
		var_18_0 = arg_18_0:getConfig("discount")
	end

	return var_18_0
end

function var_0_1.GetCommodityShowType(arg_19_0)
	return arg_19_0:getConfig("goods_detail_type")
end

function var_0_1.GetPacketItemsShowTypes(arg_20_0)
	return arg_20_0:getConfig("groups_detail_type")
end

function var_0_1.GetModel(arg_21_0)
	return arg_21_0:getConfig("items_model")
end

function var_0_1.GetModelParam(arg_22_0)
	return arg_22_0:getConfig("model_param")
end

function var_0_1.UpdateNum(arg_23_0, arg_23_1)
	arg_23_0.purchasedNum = arg_23_1

	return
end

function var_0_1.AddNum(arg_24_0, arg_24_1)
	arg_24_0.purchasedNum = arg_24_0.purchasedNum + arg_24_1

	return
end

function var_0_1.GetPayConfig(arg_25_0)
	return var_0_2[arg_25_0:GetPayId()]
end

function var_0_1.GetTag(arg_26_0)
	local var_26_0 = arg_26_0
	local var_26_1

	if not arg_26_0.getConfig(var_26_0, "tag") then
		var_26_1 = 0
	end

	switch = var_26_0

	return var_26_0(var_26_1, {
		[0] = function()
			local var_27_0 = arg_26_0
			local var_27_1

			if not var_0.IsTimeLimitCommodity(var_27_0) or not var_0_1.TAG.TIME then
				var_27_1 = var_0_1.TAG.NONE
			end

			return var_27_1
		end,
		function()
			return var_0_1.TAG.NEW
		end,
		function()
			return var_0_1.TAG.HOT
		end
	}, function()
		return var_0_1.TAG.NONE
	end)
end

function var_0_1.IsTimeLimitCommodity(arg_31_0)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.getConfig(var_31_0, "time")

	type = var_31_0

	if var_31_0(var_31_1) == "table" then
		return true
	end

	return false
end

function var_0_1.IsCharacterInviteItemHold(arg_32_0)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.GetItems(var_32_0)

	pg = var_32_0

	local var_32_2 = var_32_0.island_chara_template.all
	local var_32_3 = {}

	ipairs = var_1_10004
	pg = var_1_10005

	for iter_32_0, iter_32_1 in var_1_10004(var_1_10005.island_chara_template.all) do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_32_4 = var_32_3

		pg = var_1_10011

		var_1_10009(var_32_4, var_1_10011.island_chara_template[iter_32_1].invite_item)
	end

	if #var_32_1 == 1 then
		table = var_4

		if not var_4.contains(var_32_3, var_32_1[1][2]) then
			return false
		end

		table = var_4

		local var_32_5 = var_32_2[var_4.indexof(var_32_3, var_32_1[1][2])]

		getProxy = var_5
		IslandProxy = var_6

		local var_32_6 = var_5(var_6)
		local var_32_7 = var_5.GetIsland(var_32_6)
		local var_32_8 = var_5.GetCharacterAgency(var_32_7)

		return var_5.HasInvite(var_32_8, var_32_5)
	end
end

function var_0_1.GetDressType(arg_33_0)
	if arg_33_0:GetItems()[1] then
		local var_33_0 = var_1[1][1]

		DROP_TYPE_ISLAND_DRESS = var_1_10003

		if var_33_0 ~= var_1_10003 then
			return nil
		end

		pg = var_33_0

		if not var_33_0.island_dress_template[var_1[1][2]] then
			return nil
		end

		return var_2.type
	end
end

function var_0_1.IsHideCommondity(arg_34_0)
	local var_34_0

	if not arg_34_0.type then
		var_34_0 = arg_34_0[1]
	end

	local var_34_1

	if not arg_34_0.id then
		var_34_1 = arg_34_0[2]
	end

	DROP_TYPE_ISLAND_DRESS = var_1_10003

	if var_34_0 == var_1_10003 then
		pg = var_1_10003

		if var_1_10003.island_dress_template[var_34_1] and var_3.is_hide == 1 then
			return true
		end
	end

	return false
end

return var_0_1
