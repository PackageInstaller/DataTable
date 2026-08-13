class = var_0_10000

local var_0_0 = "Item"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.REVERT_EQUIPMENT_ID = 15007
var_0_1.COMMANDER_QUICKLY_TOOL_ID = 20010
var_0_1.QUICK_TASK_PASS_TICKET_ID = 15013
var_0_1.DOA_SELECT_CHAR_ID = 0
var_0_1.INVISIBLE_TYPE = {
	[0] = true,
	[true] = 9
}
var_0_1.PUZZLA_TYPE = 0
var_0_1.EQUIPMENT_BOX_TYPE_5 = 5
var_0_1.DESIGN_TYPE = 9
var_0_1.LESSON_TYPE = 10
var_0_1.EQUIPMENT_SKIN_BOX = 11
var_0_1.BLUEPRINT_TYPE = 12
var_0_1.ASSIGNED_TYPE = 13
var_0_1.GOLD_BOX_TYPE = 14
var_0_1.OIL_BOX_TYPE = 15
var_0_1.EQUIPMENT_ASSIGNED_TYPE = 16
var_0_1.GIFT_BOX = 17
var_0_1.TEC_SPEEDUP_TYPE = 18
var_0_1.SPECIAL_OPERATION_TICKET = 19
var_0_1.GUILD_OPENABLE = 20
var_0_1.INVITATION_TYPE = 21
var_0_1.EXP_BOOK_TYPE = 22
var_0_1.LOVE_LETTER_TYPE = 23
var_0_1.SPWEAPON_MATERIAL_TYPE = 24
var_0_1.METALESSON_TYPE = 25
var_0_1.SKIN_ASSIGNED_TYPE = 26
var_0_1.SHIP_GIFT = 50

function var_0_1.Ctor(arg_1_0, arg_1_1)
	assert = var_1_10002

	local var_1_2

	if arg_1_1.type then
		local var_1_0 = arg_1_1.type

		DROP_TYPE_VITEM = var_1_10005

		if var_1_0 ~= var_1_10005 then
			local var_1_1 = arg_1_1.type

			DROP_TYPE_ITEM = var_1_10005

			if var_1_1 ~= var_1_10005 then
				var_1_2 = false

				goto label_1_0
			end
		end
	end

	var_1_2 = true

	::label_1_0::

	var_1_10002(var_1_2)

	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_1.count
	arg_1_0.name = arg_1_1.name
	arg_1_0.extra = arg_1_1.extra

	arg_1_0:InitConfig()

	return
end

function var_0_1.CanOpen(arg_2_0)
	return arg_2_0:getConfig("type") == var_0_1.EQUIPMENT_BOX_TYPE_5 or var_1 == var_0_1.EQUIPMENT_SKIN_BOX or var_1 == var_0_1.GOLD_BOX_TYPE or var_1 == var_0_1.OIL_BOX_TYPE or var_1 == var_0_1.GIFT_BOX or var_1 == var_0_1.GUILD_OPENABLE
end

function var_0_1.IsShipExpType(arg_3_0)
	return arg_3_0:getConfig("type") == var_0_1.EXP_BOOK_TYPE
end

function var_0_1.getConfigData(arg_4_0)
	local var_4_0 = {}

	pg = var_1_10002
	var_4_0[1] = var_1_10002.item_virtual_data_statistics
	pg = var_2
	var_4_0[2] = var_2.item_data_statistics

	local var_4_1

	underscore = var_1_10003

	if var_1_10003.any(var_4_0, function(arg_5_0)
		return arg_5_0[arg_4_0] ~= nil
	end) then
		setmetatable = var_3
		var_4_1 = var_3({}, {
			__index = function(arg_6_0, arg_6_1)
				ipairs = var_2_10002

				for iter_6_0, iter_6_1 in var_2_10002(var_4_0) do
					if iter_6_1[arg_4_0] and iter_6_1[arg_4_0][arg_6_1] ~= nil then
						arg_6_0[arg_6_1] = iter_6_1[arg_4_0][arg_6_1]

						return arg_6_0[arg_6_1]
					end
				end

				return
			end
		})
	end

	return var_4_1
end

function var_0_1.InitConfig(arg_7_0)
	arg_7_0.cfg = var_0_1.getConfigData(arg_7_0.configId)
	assert = var_1

	local var_7_0 = arg_7_0.cfg

	string = var_1_10004

	var_1(var_7_0, var_1_10004.format("without item config from id_%d", arg_7_0.id))

	return
end

function var_0_1.getConfigTable(arg_8_0)
	return arg_8_0.cfg
end

function var_0_1.CanInBag(arg_9_0)
	tobool = var_1_10001
	pg = var_1_10003

	return var_1_10001(var_1_10003.item_data_statistics[arg_9_0])
end

function var_0_1.couldSell(arg_10_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_10_0:getConfig("price")) > 0
end

function var_0_1.GetPrice(arg_11_0)
	if arg_11_0:couldSell() then
		return arg_11_0:getConfig("price")
	else
		return nil
	end

	return
end

function var_0_1.isEnough(arg_12_0, arg_12_1)
	return arg_12_1 <= arg_12_0.count
end

function var_0_1.consume(arg_13_0, arg_13_1)
	arg_13_0.count = arg_13_0.count - arg_13_1

	return
end

function var_0_1.isDesignDrawing(arg_14_0)
	return arg_14_0:getConfig("type") == 9
end

function var_0_1.isVirtualItem(arg_15_0)
	return arg_15_0:getConfig("type") == 0
end

function var_0_1.isEquipmentSkinBox(arg_16_0)
	return arg_16_0:getConfig("type") == var_0_1.EQUIPMENT_SKIN_BOX
end

function var_0_1.isBluePrintType(arg_17_0)
	return arg_17_0:getConfig("type") == var_0_1.BLUEPRINT_TYPE
end

function var_0_1.isTecSpeedUpType(arg_18_0)
	return arg_18_0:getConfig("type") == var_0_1.TEC_SPEEDUP_TYPE
end

function var_0_1.IsMaxCnt(arg_19_0)
	return arg_19_0:getConfig("max_num") <= arg_19_0.count
end

function var_0_1.IsDoaSelectCharItem(arg_20_0)
	return arg_20_0.id == var_0_1.DOA_SELECT_CHAR_ID
end

function var_0_1.getConfig(arg_21_0, arg_21_1)
	if arg_21_1 == "display" and var_0_1.super.getConfig(arg_21_0, "combination_display") and #var_2 > 0 then
		return arg_21_0:CombinationDisplay(var_2)
	end

	return var_0_1.super.getConfig(arg_21_0, arg_21_1)
end

function var_0_1.StaticCombinationDisplay(arg_22_0)
	_ = var_1_10001

	local var_22_0 = var_1_10001.map(arg_22_0, function(arg_23_0)
		string = var_2_10001

		local var_23_0 = var_2_10001.format("%0.2f", arg_23_0[2] / 100)

		ShipSkin = var_2_10002

		local var_23_1 = var_2_10002.New({
			id = arg_23_0[1]
		})
		local var_23_2 = {}

		ipairs = var_4
		getGameset = var_2_10006

		for iter_23_0, iter_23_1 in var_4(var_2_10006("random_skin_tag")[2]) do
			var_23_2[iter_23_1[1]] = iter_23_1[2]
		end

		underscore = var_4

		local var_23_3 = var_23_1
		local var_23_4 = var_4(var_23_1.getConfig(var_23_3, "tag"))
		local var_23_5 = var_4.chain(var_23_4)
		local var_23_6 = var_4.filter(var_23_5, function(arg_24_0)
			return var_23_2[arg_24_0]
		end)
		local var_23_7 = var_4.map(var_23_6, function(arg_25_0)
			return var_23_2[arg_25_0]
		end)
		local var_23_8 = #var_4.value(var_23_7)

		if 0 < var_23_8 then
			string = var_23_8

			local var_23_9 = var_23_8.format
			local var_23_10 = "（<color=#92fc63>%s</color>）"

			table = var_23_3

			local var_23_11

			if not var_23_9(var_23_10, var_23_3.concat(var_4, " ")) then
				var_23_11 = ""
			end

			i18n = var_6

			local var_23_12 = var_6("random_skin_list_item_desc_label")
			local var_23_13 = ""

			if var_23_1:ExistReward() then
				i18n = var_8
				var_23_13 = var_8("word_show_extra_reward_at_fudai_dialog", var_23_1:GetRewardListDesc())
			end

			return "\n（<color=#92fc63>" .. var_23_0 .. "%%</color>）" .. var_23_1.shipName .. var_23_12 .. var_23_1.skinName .. var_23_11 .. var_23_13
		end
	end)

	table = var_1_10002

	local var_22_1 = var_1_10002.concat(var_22_0, ";")

	i18n = var_3

	return var_3("skin_gift_desc", var_22_1)
end

function var_0_1.CombinationDisplay(arg_26_0, arg_26_1)
	return var_0_1.StaticCombinationDisplay(arg_26_1)
end

function var_0_1.InTimeLimitSkinAssigned(arg_27_0)
	if var_0_1.getConfigData(arg_27_0).type ~= var_0_1.SKIN_ASSIGNED_TYPE then
		return false
	end

	local var_27_0 = var_1.usage_arg[1]

	getProxy = var_3
	ActivityProxy = var_1_10005

	local var_27_1 = var_3(var_1_10005)

	return var_3.IsActivityNotEnd(var_27_1, var_27_0)
end

function var_0_1.GetValidSkinList(arg_28_0)
	assert = var_1_10001

	var_1_10001(arg_28_0:getConfig("type") == var_0_1.SKIN_ASSIGNED_TYPE)

	local var_28_0 = arg_28_0:getConfig("usage_arg")

	Item = var_1_10002

	if var_1_10002.InTimeLimitSkinAssigned(arg_28_0.id) then
		table = var_2

		return var_2.mergeArray(var_28_0[2], var_28_0[3], true)
	else
		underscore = var_2

		return var_2.rest(var_28_0[3], 1)
	end

	return
end

function var_0_1.IsAllSkinOwner(arg_29_0)
	assert = var_1_10001

	var_1_10001(arg_29_0:getConfig("type") == var_0_1.SKIN_ASSIGNED_TYPE)

	getProxy = var_1_10001
	ShipSkinProxy = var_3

	local var_29_0 = var_1_10001(var_3)

	underscore = var_1_10002

	return var_1_10002.all(arg_29_0:GetValidSkinList(), function(arg_30_0)
		local var_30_0 = var_29_0

		return var_1.hasNonLimitSkin(var_30_0, arg_30_0)
	end)
end

function var_0_1.GetOverflowCheckItems(arg_31_0, arg_31_1)
	arg_31_1 = arg_31_1 or 1

	local var_31_0 = {}
	local var_31_1 = arg_31_0:getConfig("usage")

	ItemUsage = var_1_10004

	if var_31_1 == var_1_10004.DROP_TEMPLATE then
		unpack = var_31_1

		local var_31_2, var_31_3

		var_31_1, var_31_2, var_31_3 = var_31_1(arg_31_0:getConfig("usage_arg"))

		if 0 < var_31_2 then
			table = var_6

			local var_31_4 = var_6.insert
			local var_31_5 = var_31_0
			local var_31_6 = {}

			DROP_TYPE_RESOURCE = var_1_10010
			var_31_6.type = var_1_10010
			PlayerConst = var_1_10010
			var_31_6.id = var_1_10010.ResGold
			var_31_6.count = var_31_2 * arg_31_1

			var_31_4(var_31_5, var_31_6)
		end

		if 0 < var_31_3 then
			table = var_6

			local var_31_7 = var_6.insert
			local var_31_8 = var_31_0
			local var_31_9 = {}

			DROP_TYPE_RESOURCE = var_1_10010
			var_31_9.type = var_1_10010
			PlayerConst = var_1_10010
			var_31_9.id = var_1_10010.ResOil
			var_31_9.count = var_31_3 * arg_31_1

			var_31_7(var_31_8, var_31_9)
		end
	end

	switch = var_31_1

	local var_31_10 = arg_31_0
	local var_31_11 = arg_31_0.getConfig(var_31_10, "type")
	local var_31_12 = {}

	Item = var_31_10
	var_31_12[var_31_10.EQUIPMENT_BOX_TYPE_5] = function()
		table = var_2_10000

		local var_32_0 = var_2_10000.insert
		local var_32_1 = var_31_0
		local var_32_2 = {}

		DROP_TYPE_EQUIP = var_2_10004
		var_32_2.type = var_2_10004
		EQUIP_OCCUPATION_ID = var_2_10004
		var_32_2.id = var_2_10004
		var_32_2.count = arg_31_1

		var_32_0(var_32_1, var_32_2)

		return
	end
	Item = var_7
	var_31_12[var_7.EQUIPMENT_ASSIGNED_TYPE] = function()
		table = var_2_10000

		local var_33_0 = var_2_10000.insert
		local var_33_1 = var_31_0
		local var_33_2 = {}

		DROP_TYPE_EQUIP = var_2_10004
		var_33_2.type = var_2_10004
		EQUIP_OCCUPATION_ID = var_2_10004
		var_33_2.id = var_2_10004
		var_33_2.count = arg_31_1

		var_33_0(var_33_1, var_33_2)

		return
	end

	var_31_1(var_31_11, var_31_12)

	underscore = var_31_1

	var_31_1.map(var_31_0, function(arg_34_0)
		Drop = var_2_10001

		return var_2_10001.New(arg_34_0)
	end)

	return var_31_0
end

function var_0_1.IsSkinShopDiscountType(arg_35_0)
	local var_35_0 = arg_35_0:getConfig("usage")

	ItemUsage = var_1_10002

	return var_35_0 == var_1_10002.SKIN_SHOP_DISCOUNT
end

function var_0_1.IsExclusiveDiscountType(arg_36_0)
	local var_36_0 = arg_36_0:getConfig("usage")

	ItemUsage = var_1_10002

	return var_36_0 == var_1_10002.USAGE_SHOP_DISCOUNT
end

function var_0_1.IsSkinExperienceType(arg_37_0)
	local var_37_0 = arg_37_0:getConfig("usage")

	ItemUsage = var_1_10002

	return var_37_0 == var_1_10002.USAGE_SKIN_EXP
end

function var_0_1.CanUseForShop(arg_38_0, arg_38_1)
	if arg_38_0:IsSkinShopDiscountType() then
		if arg_38_0:getConfig("usage_arg") then
			type = var_1_10003

			if var_1_10003(var_2) ~= "table" then
				return false
			end

			if not var_2[1] then
				var_1_10003 = {}
			end

			local var_38_0

			if #var_1_10003 ~= 1 or var_1_10003[1] ~= 0 then
				table = var_4
				var_38_0 = var_4.contains(var_1_10003, arg_38_1)

				if false then
					var_38_0 = false
				end
			else
				var_38_0 = true
			end

			do return var_38_0 end

			goto label_38_0

			if arg_38_0:IsSkinExperienceType() then
				if arg_38_0:getConfig("usage_arg") then
					type = var_1_10003

					if var_1_10003(var_2) ~= "table" then
						return false
					end

					if not var_2[1] then
						var_1_10003 = -1
					end

					do return var_1_10003 == arg_38_1 end

					goto label_38_0

					if arg_38_0:IsExclusiveDiscountType() then
						if arg_38_0:getConfig("usage_arg")[1] then
							type = var_1_10003

							if var_1_10003(var_2) ~= "table" then
								return false
							end

							do
								local var_38_1

								if not var_2[1] then
									var_38_1 = -1
								end

								return var_38_1 == arg_38_1
							end

							::label_38_0::

							return false
						end
					end
				end
			end
		end
	end
end

function var_0_1.GetConsumeForSkinShopDiscount(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0

	if not arg_39_0.IsSkinShopDiscountType(var_39_0) then
		var_39_0 = arg_39_0

		if arg_39_0.IsExclusiveDiscountType(var_39_0) then
			var_39_0 = arg_39_0

			if arg_39_0.CanUseForShop(var_39_0, arg_39_1) then
				pg = var_2

				local var_39_1

				if not var_2.item_data_statistics[arg_39_0.configId].usage_arg[2] then
					var_39_1 = 0
				end

				Goods = var_39_0

				local var_39_2 = var_39_0.Create
				local var_39_3 = {
					shop_id = arg_39_1
				}

				Goods = var_1_10007

				local var_39_4 = var_39_2(var_39_3, var_1_10007.TYPE_SKIN)

				math = var_1_10005

				local var_39_5 = var_1_10005.max(0, var_39_4:GetPrice() - var_39_1)
				local var_39_6 = var_39_4:getConfig("resource_type")

				do return end

				goto label_39_0
			end
		end

		do return 0 end

		::label_39_0::

		return
	end
end

function var_0_1.getName(arg_40_0)
	local var_40_0

	if not arg_40_0.name then
		var_40_0 = arg_40_0:getConfig("name")
	end

	return var_40_0
end

function var_0_1.getIcon(arg_41_0)
	return arg_41_0:getConfig("Icon")
end

local var_0_2

function var_0_1.IsLoveLetterCheckItem(arg_42_0)
	if not var_0_2 then
		var_0_2 = {}
		ipairs = var_1
		getGameset = var_1_10003

		for iter_42_0, iter_42_1 in var_1(var_1_10003("loveletter_item_old_year")[2]) do
			unpack = var_1_10006

			local var_42_0

			var_1_10006, var_42_0 = var_1_10006(iter_42_1)
			var_1_10008 = var_0_2
			underscore = var_1_10009
			var_1_10008[var_1_10006] = var_1_10009.flatten({
				var_42_0
			})
		end

		ipairs = var_1
		pg = var_3

		for iter_42_2, iter_42_3 in var_1(var_3.loveletter_2018_2021.all) do
			local var_42_1 = var_0_2
			local var_42_2 = {}

			pg = var_1_10008
			var_42_2[1] = var_1_10008.loveletter_2018_2021[iter_42_3].year
			var_42_1[iter_42_3] = var_42_2
		end
	end

	return var_0_2[arg_42_0]
end

function var_0_1.IsRepairLoveLetterItem(arg_43_0)
	ipairs = var_1_10001
	getGameset = var_1_10003

	for iter_43_0, iter_43_1 in var_1_10001(var_1_10003("loveletter2018_item")[2]) do
		if arg_43_0.id == iter_43_1 then
			return true
		end
	end

	return false
end

return var_0_1
