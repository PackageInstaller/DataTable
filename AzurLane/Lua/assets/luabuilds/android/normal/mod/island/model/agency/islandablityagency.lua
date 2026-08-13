class = var_0_10000

local var_0_0 = "IslandAblityAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.UNLOCK_SYSTEM = "IslandAblityAgency:UNLOCK_SYSTEM"
var_0_1.TYPE_SYSTEM = 1
var_0_1.TYPE_PLACE = 2
var_0_1.TYPE_FORMULA = 3
var_0_1.TYPE_SHOP_NORMAL = 4
var_0_1.TYPE_INVENTORY_MAXCNT = 6
var_0_1.TYPE_SHOP_TEMPORARY = 7
var_0_1.TYPE_ORDER = 8
var_0_1.TYPE_SLOT = 9
var_0_1.TYPE_MAP = 11
var_0_1.TYPE_ANIMAL = 15
var_0_1.TYPE_RESTAURANT = 17
var_0_1.TYPE_ASSISTANT = 18
var_0_1.TYPE_COLLECT_TOOL = 19
var_0_1.TYPE_ORDER_DAILY_CNT = 20
var_0_1.TYPE_SIGN_GIFT_CNT = 21
var_0_1.TYPE_RECOVER_CAMP = 22
var_0_1.TYPE_RECOVER_ORE = 23
var_0_1.TYPE_SECOND_PRODUCT = 24
var_0_1.TYPE_PRODUCT_FELLING = 26
var_0_1.TYPE_PRODUCT_MINING = 27
var_0_1.TYPE_ORDER_EXP = 31
var_0_1.TYPE_POST_MANAGE = 37
var_0_1.TYPE_PRODUCT_FARM = 38
var_0_1.TYPE_PRODUCT_ORCHARD = 39
var_0_1.TYPE_PRODUCT_GARDEN = 40
var_0_1.TYPE_FISHING_ROD = 41
var_0_1.TYPE_PRODUCT_FISH = 42
var_0_1.ANIMATION_OP_ID = 40
var_0_1.SET_MEAL_ID = 29001

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.abilitys = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.ability_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.abilitys, iter_1_1)
	end

	return
end

function var_0_1.AddAblity(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(arg_2_0.abilitys, arg_2_1)

	if var_0_1.GetAblityType(arg_2_1) == var_0_1.TYPE_SYSTEM then
		arg_2_0:DispatchEvent(var_0_1.UNLOCK_SYSTEM, arg_2_1)
	end

	if var_0_1.IsMapType(arg_2_1) then
		pg = var_2

		local var_2_0 = var_2.GameTrackerMgr.GetInstance()
		local var_2_1 = var_2.Record

		GameTrackerBuilder = var_4

		var_2_1(var_2_0, var_4.BuildIslandUnlockMap(var_0_1.GetEffect(arg_2_1)))

		getProxy = var_2_1
		IslandProxy = var_2_0

		local var_2_2 = var_2_1(var_2_0)
		local var_2_3 = var_2.GetIsland(var_2_2)
		local var_2_4 = var_2.GetTechnologyAgency(var_2_3)

		var_2.TryAutoUnlock(var_2_4)
	end

	return
end

function var_0_1.IsUnlockOrderExp(arg_3_0)
	_ = var_1_10001

	return var_1_10001.any(arg_3_0.abilitys, function(arg_4_0)
		return var_0_1.IsOrderExpType(arg_4_0)
	end)
end

function var_0_1.IsUnlockPostManage(arg_5_0)
	_ = var_1_10001

	return var_1_10001.any(arg_5_0.abilitys, function(arg_6_0)
		return var_0_1.GetAblityType(arg_6_0) == var_0_1.TYPE_POST_MANAGE
	end)
end

function var_0_1.IsUnlockMap(arg_7_0, arg_7_1)
	_ = var_1_10002

	return var_1_10002.any(arg_7_0.abilitys, function(arg_8_0)
		local var_8_0

		if var_0_1.IsMapType(arg_8_0) then
			var_8_0 = var_0_1.GetEffect(arg_8_0) == arg_7_1
		end

		return var_8_0
	end)
end

function var_0_1.IsUnlockShipOrder(arg_9_0, arg_9_1)
	_ = var_1_10002

	return var_1_10002.any(arg_9_0.abilitys, function(arg_10_0)
		local var_10_0

		if var_0_1.IsOrderType(arg_10_0) then
			var_10_0 = var_0_1.GetEffect(arg_10_0) == arg_9_1
		end

		return var_10_0
	end)
end

function var_0_1.IsUnlockFormuate(arg_11_0, arg_11_1)
	_ = var_1_10002

	return var_1_10002.any(arg_11_0.abilitys, function(arg_12_0)
		local var_12_0

		if var_0_1.IsFormuateType(arg_12_0) then
			var_12_0 = var_0_1.GetEffect(arg_12_0) == arg_11_1
		end

		return var_12_0
	end)
end

function var_0_1.IsUnlcokSecondProduct(arg_13_0, arg_13_1)
	_ = var_1_10002

	return var_1_10002.any(arg_13_0.abilitys, function(arg_14_0)
		local var_14_0

		if var_0_1.IsSecondProductType(arg_14_0) then
			var_14_0 = var_0_1.GetEffect(arg_14_0) == arg_13_1
		end

		return var_14_0
	end)
end

function var_0_1.IsUnlockCollectTool(arg_15_0, arg_15_1)
	_ = var_1_10002

	return var_1_10002.any(arg_15_0.abilitys, function(arg_16_0)
		local var_16_0

		if var_0_1.IsCollectToolType(arg_16_0) then
			var_16_0 = var_0_1.GetEffect(arg_16_0) == arg_15_1
		end

		return var_16_0
	end)
end

function var_0_1.IsUnlockAreaPlant(arg_17_0)
	_ = var_1_10001

	return var_1_10001.any(arg_17_0.abilitys, function(arg_18_0)
		return var_0_1.GetAblityType(arg_18_0) == var_0_1.TYPE_SYSTEM and var_0_1.GetEffect(arg_18_0) == 17
	end)
end

function var_0_1.IsUnlockFishing(arg_19_0)
	_ = var_1_10001

	return var_1_10001.any(arg_19_0.abilitys, function(arg_20_0)
		return var_0_1.GetAblityType(arg_20_0) == var_0_1.TYPE_SYSTEM and var_0_1.GetEffect(arg_20_0) == 25
	end)
end

function var_0_1.HasAbility(arg_21_0, arg_21_1)
	if arg_21_1 == 0 then
		return true
	end

	_ = var_1_10002

	return var_1_10002.any(arg_21_0.abilitys, function(arg_22_0)
		return arg_21_1 == arg_22_0
	end)
end

function var_0_1.GetOrderDailyCntAddition(arg_23_0)
	local var_23_0 = 0

	ipairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.abilitys) do
		if var_0_1.IsOrderDailyCntType(iter_23_1) then
			pg = var_7
			var_23_0 = var_23_0 + var_7.island_ability_template[iter_23_1].effect
		end
	end

	return var_23_0
end

function var_0_1.GetProductAdditionSpeedByAblityType(arg_24_0, arg_24_1)
	local var_24_0 = 0

	ipairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0.abilitys) do
		pg = var_1_10008

		if var_1_10008.island_ability_template[iter_24_1].type == arg_24_1 then
			var_24_0 = var_24_0 + var_1_10008.effect
		end
	end

	return var_24_0
end

function var_0_1.GetAdditionEffectByAblityType(arg_25_0, arg_25_1)
	local var_25_0 = 0

	ipairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_0.abilitys) do
		pg = var_1_10008

		if var_1_10008.island_ability_template[iter_25_1].type == arg_25_1 then
			var_25_0 = var_25_0 + var_1_10008.effect
		end
	end

	return var_25_0
end

function var_0_1.GetSignInGiftAddition(arg_26_0)
	local var_26_0 = 0

	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.abilitys) do
		if var_0_1.IsSignInGiftType(iter_26_1) then
			pg = var_7
			var_26_0 = var_26_0 + var_7.island_ability_template[iter_26_1].effect
		end
	end

	return var_26_0
end

function var_0_1.GetInventoryMaxCntAddition(arg_27_0)
	local var_27_0 = 0

	ipairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0.abilitys) do
		if var_0_1.IsInventoryMaxCntType(iter_27_1) then
			pg = var_7
			var_27_0 = var_27_0 + var_7.island_ability_template[iter_27_1].effect
		end
	end

	return var_27_0
end

function var_0_1.IsInventoryMaxCntType(arg_28_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_28_0].type == var_0_1.TYPE_INVENTORY_MAXCNT
end

function var_0_1.IsSignInGiftType(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.island_ability_template[arg_29_0]

	assert = var_1_10002

	var_1_10002(var_29_0, "island_ability_template" .. arg_29_0)

	return var_29_0.type == var_0_1.TYPE_SIGN_GIFT_CNT
end

function var_0_1.IsOrderDailyCntType(arg_30_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_30_0].type == var_0_1.TYPE_ORDER_DAILY_CNT
end

function var_0_1.IsMapType(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.island_ability_template[arg_31_0]

	assert = var_1_10002

	var_1_10002(var_31_0, "island_ability_template >>>>" .. arg_31_0)

	return var_31_0.type == var_0_1.TYPE_MAP
end

function var_0_1.IsOrderType(arg_32_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_32_0].type == var_0_1.TYPE_ORDER
end

function var_0_1.IsShopTypeNormal(arg_33_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_33_0].type == var_0_1.TYPE_SHOP_NORMAL
end

function var_0_1.IsShopTypeTemporary(arg_34_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_34_0].type == var_0_1.TYPE_SHOP_TEMPORARY
end

function var_0_1.IsCommodityType(arg_35_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_35_0].type == var_0_1.TYPE_COMMODITY
end

function var_0_1.IsFormuateType(arg_36_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_36_0].type == var_0_1.TYPE_FORMULA
end

function var_0_1.IsSecondProductType(arg_37_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_37_0].type == var_0_1.TYPE_SECOND_PRODUCT
end

function var_0_1.IsCollectToolType(arg_38_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_38_0].type == var_0_1.TYPE_COLLECT_TOOL
end

function var_0_1.GetAblityType(arg_39_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_39_0].type
end

function var_0_1.GetEffect(arg_40_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_40_0].effect
end

function var_0_1.IsOrderExpType(arg_41_0)
	pg = var_1_10001

	return var_1_10001.island_ability_template[arg_41_0].type == var_0_1.TYPE_ORDER_EXP
end

return var_0_1
