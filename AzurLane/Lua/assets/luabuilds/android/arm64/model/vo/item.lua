local var_0_0 = class("Item", import(".BaseVO"))

var_0_0.REVERT_EQUIPMENT_ID = 15007
var_0_0.COMMANDER_QUICKLY_TOOL_ID = 20010
var_0_0.QUICK_TASK_PASS_TICKET_ID = 15013
var_0_0.DOA_SELECT_CHAR_ID = 0
var_0_0.INVISIBLE_TYPE = {
	[0] = true,
	[true] = 9
}
var_0_0.PUZZLA_TYPE = 0
var_0_0.EQUIPMENT_BOX_TYPE_5 = 5
var_0_0.DESIGN_TYPE = 9
var_0_0.LESSON_TYPE = 10
var_0_0.EQUIPMENT_SKIN_BOX = 11
var_0_0.BLUEPRINT_TYPE = 12
var_0_0.ASSIGNED_TYPE = 13
var_0_0.GOLD_BOX_TYPE = 14
var_0_0.OIL_BOX_TYPE = 15
var_0_0.EQUIPMENT_ASSIGNED_TYPE = 16
var_0_0.GIFT_BOX = 17
var_0_0.TEC_SPEEDUP_TYPE = 18
var_0_0.SPECIAL_OPERATION_TICKET = 19
var_0_0.GUILD_OPENABLE = 20
var_0_0.INVITATION_TYPE = 21
var_0_0.EXP_BOOK_TYPE = 22
var_0_0.LOVE_LETTER_TYPE = 23
var_0_0.SPWEAPON_MATERIAL_TYPE = 24
var_0_0.METALESSON_TYPE = 25
var_0_0.SKIN_ASSIGNED_TYPE = 26
var_0_0.SHIP_GIFT = 50

function var_0_0.Ctor(arg_1_0, arg_1_1)
	assert(not arg_1_1.type or arg_1_1.type == DROP_TYPE_VITEM or arg_1_1.type == DROP_TYPE_ITEM)

	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_1.count
	arg_1_0.name = arg_1_1.name
	arg_1_0.extra = arg_1_1.extra

	arg_1_0:InitConfig()

	return
end

function var_0_0.CanOpen(arg_2_0)
	local var_2_0 = arg_2_0:getConfig("type")

	return var_2_0 == var_0_0.EQUIPMENT_BOX_TYPE_5 or var_2_0 == var_0_0.EQUIPMENT_SKIN_BOX or var_2_0 == var_0_0.GOLD_BOX_TYPE or var_2_0 == var_0_0.OIL_BOX_TYPE or var_2_0 == var_0_0.GIFT_BOX or var_2_0 == var_0_0.GUILD_OPENABLE
end

function var_0_0.IsShipExpType(arg_3_0)
	return arg_3_0:getConfig("type") == var_0_0.EXP_BOOK_TYPE
end

function var_0_0.getConfigData(arg_4_0)
	local var_4_0

	if underscore.any({
		pg.item_virtual_data_statistics,
		pg.item_data_statistics
	}, function(arg_5_0)
		return arg_5_0[arg_4_0] ~= nil
	end) then
		var_4_0 = setmetatable({}, {
			__index = function(arg_6_0, arg_6_1)
				for iter_6_0, iter_6_1 in ipairs(var_0) do
					if iter_6_1[arg_4_0] and iter_6_1[arg_4_0][arg_6_1] ~= nil then
						arg_6_0[arg_6_1] = iter_6_1[arg_4_0][arg_6_1]

						return arg_6_0[arg_6_1]
					end
				end

				return
			end
		})
	end

	return var_4_0
end

function var_0_0.InitConfig(arg_7_0)
	arg_7_0.cfg = var_0_0.getConfigData(arg_7_0.configId)

	assert(arg_7_0.cfg, string.format("without item config from id_%d", arg_7_0.id))

	return
end

function var_0_0.getConfigTable(arg_8_0)
	return arg_8_0.cfg
end

function var_0_0.CanInBag(arg_9_0)
	return tobool(pg.item_data_statistics[arg_9_0])
end

function var_0_0.couldSell(arg_10_0)
	return table.getCount(arg_10_0:getConfig("price")) > 0
end

function var_0_0.GetPrice(arg_11_0)
	if arg_11_0:couldSell() then
		return arg_11_0:getConfig("price")
	else
		return nil
	end

	return
end

function var_0_0.isEnough(arg_12_0, arg_12_1)
	return arg_12_1 <= arg_12_0.count
end

function var_0_0.consume(arg_13_0, arg_13_1)
	arg_13_0.count = arg_13_0.count - arg_13_1

	return
end

function var_0_0.isDesignDrawing(arg_14_0)
	return arg_14_0:getConfig("type") == 9
end

function var_0_0.isVirtualItem(arg_15_0)
	return arg_15_0:getConfig("type") == 0
end

function var_0_0.isEquipmentSkinBox(arg_16_0)
	return arg_16_0:getConfig("type") == var_0_0.EQUIPMENT_SKIN_BOX
end

function var_0_0.isBluePrintType(arg_17_0)
	return arg_17_0:getConfig("type") == var_0_0.BLUEPRINT_TYPE
end

function var_0_0.isTecSpeedUpType(arg_18_0)
	return arg_18_0:getConfig("type") == var_0_0.TEC_SPEEDUP_TYPE
end

function var_0_0.IsMaxCnt(arg_19_0)
	return arg_19_0:getConfig("max_num") <= arg_19_0.count
end

function var_0_0.IsDoaSelectCharItem(arg_20_0)
	return arg_20_0.id == var_0_0.DOA_SELECT_CHAR_ID
end

function var_0_0.getConfig(arg_21_0, arg_21_1)
	if arg_21_1 == "display" then
		local var_21_0 = var_0_0.super.getConfig(arg_21_0, "combination_display")

		if var_21_0 and #var_21_0 > 0 then
			return arg_21_0:CombinationDisplay(var_21_0)
		end
	end

	return var_0_0.super.getConfig(arg_21_0, arg_21_1)
end

function var_0_0.StaticCombinationDisplay(arg_22_0)
	return i18n("skin_gift_desc", (table.concat(_.map(arg_22_0, function(arg_23_0)
		local var_23_0 = string.format("%0.2f", arg_23_0[2] / 100)
		local var_23_1 = ShipSkin.New({
			id = arg_23_0[1]
		})
		local var_23_2 = {}

		for iter_23_0, iter_23_1 in ipairs(getGameset("random_skin_tag")[2]) do
			({})[iter_23_1[1]] = iter_23_1[2]
		end

		local var_23_3 = underscore(var_23_1:getConfig("tag")):chain():filter(function(arg_24_0)
			return var_23_2[arg_24_0]
		end):map(function(arg_25_0)
			return var_23_2[arg_25_0]
		end):value()
		local var_23_4 = #var_23_3 > 0 and string.format("（<color=#92fc63>%s</color>）", table.concat(var_23_3, " ")) or ""
		local var_23_5 = i18n("random_skin_list_item_desc_label")
		local var_23_6 = ""

		if var_23_1:ExistReward() then
			var_23_6 = i18n("word_show_extra_reward_at_fudai_dialog", var_23_1:GetRewardListDesc())
		end

		return "\n（<color=#92fc63>" .. var_23_0 .. "%%</color>）" .. var_23_1.shipName .. var_23_5 .. var_23_1.skinName .. var_23_4 .. var_23_6
	end), ";")))
end

function var_0_0.CombinationDisplay(arg_26_0, arg_26_1)
	return var_0_0.StaticCombinationDisplay(arg_26_1)
end

function var_0_0.InTimeLimitSkinAssigned(arg_27_0)
	local var_27_0 = var_0_0.getConfigData(arg_27_0)

	if var_27_0.type ~= var_0_0.SKIN_ASSIGNED_TYPE then
		return false
	end

	return getProxy(ActivityProxy):IsActivityNotEnd(var_27_0.usage_arg[1])
end

function var_0_0.GetValidSkinList(arg_28_0)
	assert(arg_28_0:getConfig("type") == var_0_0.SKIN_ASSIGNED_TYPE)

	local var_28_0 = arg_28_0:getConfig("usage_arg")

	if Item.InTimeLimitSkinAssigned(arg_28_0.id) then
		return table.mergeArray(var_28_0[2], var_28_0[3], true)
	else
		return underscore.rest(var_28_0[3], 1)
	end

	return
end

function var_0_0.IsAllSkinOwner(arg_29_0)
	assert(arg_29_0:getConfig("type") == var_0_0.SKIN_ASSIGNED_TYPE)

	local var_29_0 = getProxy(ShipSkinProxy)

	return underscore.all(arg_29_0:GetValidSkinList(), function(arg_30_0)
		return var_29_0:hasNonLimitSkin(arg_30_0)
	end)
end

function var_0_0.GetOverflowCheckItems(arg_31_0, arg_31_1)
	arg_31_1 = arg_31_1 or 1

	local var_31_0 = {}

	if arg_31_0:getConfig("usage") == ItemUsage.DROP_TEMPLATE then
		local var_31_1, var_31_2, var_31_3 = unpack(arg_31_0:getConfig("usage_arg"))

		if var_31_2 > 0 then
			table.insert(var_31_0, {
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGold,
				count = var_31_2 * arg_31_1
			})
		end

		if var_31_3 > 0 then
			table.insert(var_31_0, {
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResOil,
				count = var_31_3 * arg_31_1
			})
		end
	end

	switch(arg_31_0:getConfig("type"), {
		[Item.EQUIPMENT_BOX_TYPE_5] = function()
			table.insert(var_31_0, {
				type = DROP_TYPE_EQUIP,
				id = EQUIP_OCCUPATION_ID,
				count = arg_31_1
			})

			return
		end,
		[Item.EQUIPMENT_ASSIGNED_TYPE] = function()
			table.insert(var_31_0, {
				type = DROP_TYPE_EQUIP,
				id = EQUIP_OCCUPATION_ID,
				count = arg_31_1
			})

			return
		end
	})
	underscore.map(var_31_0, function(arg_34_0)
		return Drop.New(arg_34_0)
	end)

	return var_31_0
end

function var_0_0.IsSkinShopDiscountType(arg_35_0)
	return arg_35_0:getConfig("usage") == ItemUsage.SKIN_SHOP_DISCOUNT
end

function var_0_0.IsExclusiveDiscountType(arg_36_0)
	return arg_36_0:getConfig("usage") == ItemUsage.USAGE_SHOP_DISCOUNT
end

function var_0_0.IsSkinExperienceType(arg_37_0)
	return arg_37_0:getConfig("usage") == ItemUsage.USAGE_SKIN_EXP
end

function var_0_0.CanUseForShop(arg_38_0, arg_38_1)
	if arg_38_0:IsSkinShopDiscountType() then
		local var_38_0 = arg_38_0:getConfig("usage_arg")

		if not var_38_0 or type(var_38_0) ~= "table" then
			return false
		end

		local var_38_1 = var_38_0[1] or {}

		return #var_38_1 == 1 and var_38_1[1] == 0 or table.contains(var_38_1, arg_38_1)
	elseif arg_38_0:IsSkinExperienceType() then
		local var_38_2 = arg_38_0:getConfig("usage_arg")

		if not var_38_2 or type(var_38_2) ~= "table" then
			return false
		end

		local var_38_3 = var_38_2[1] or -1

		return var_38_3 == arg_38_1
	elseif arg_38_0:IsExclusiveDiscountType() then
		local var_38_4 = arg_38_0:getConfig("usage_arg")[1]

		if not var_38_4 or type(var_38_4) ~= "table" then
			return false
		end

		local var_38_5 = var_38_4[1] or -1

		return var_38_5 == arg_38_1
	end

	return false
end

function var_0_0.GetConsumeForSkinShopDiscount(arg_39_0, arg_39_1)
	if arg_39_0:IsSkinShopDiscountType() or arg_39_0:IsExclusiveDiscountType() and arg_39_0:CanUseForShop(arg_39_1) then
		local var_39_0 = pg.item_data_statistics[arg_39_0.configId].usage_arg[2] or 0
		local var_39_1 = Goods.Create({
			shop_id = arg_39_1
		}, Goods.TYPE_SKIN)
		local var_39_2 = math.max(0, var_39_1:GetPrice() - var_39_0)
		local var_39_3 = var_39_1:getConfig("resource_type")

		return
	else
		return 0
	end

	return
end

function var_0_0.getName(arg_40_0)
	return arg_40_0.name or arg_40_0:getConfig("name")
end

function var_0_0.getIcon(arg_41_0)
	return arg_41_0:getConfig("Icon")
end

local var_0_1

function var_0_0.IsLoveLetterCheckItem(arg_42_0)
	if not var_0_1 then
		var_0_1 = {}

		for iter_42_0, iter_42_1 in ipairs(getGameset("loveletter_item_old_year")[2]) do
			local var_42_0, var_42_1 = unpack(iter_42_1)

			var_0_1[var_42_0] = underscore.flatten({
				var_42_1
			})
		end

		for iter_42_2, iter_42_3 in ipairs(pg.loveletter_2018_2021.all) do
			var_0_1[iter_42_3] = {
				pg.loveletter_2018_2021[iter_42_3].year
			}
		end
	end

	return var_0_1[arg_42_0]
end

function var_0_0.IsRepairLoveLetterItem(arg_43_0)
	for iter_43_0, iter_43_1 in ipairs(getGameset("loveletter2018_item")[2]) do
		if arg_43_0.id == iter_43_1 then
			return true
		end
	end

	return false
end

return var_0_0
