class = var_0_10000

local var_0_0 = "IslandItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TYPE_MATERIAL = 1
var_0_1.TYPE_PROP = 2
var_0_1.TYPE_SPECIAL_PROP = 3
var_0_1.TYPE_SHIP_EXP_BOOK = 5
var_0_1.GOLD_ID = 1
var_0_1.PEARL_ID = 9900

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.num and not arg_1_1.number and not arg_1_1.count then
		var_1_0 = 1
	end

	arg_1_0.count = var_1_0

	local var_1_1

	if not arg_1_1.time then
		var_1_1 = 0
	end

	arg_1_0.time = var_1_1

	return
end

function var_0_1.GetNumberOfSlotsOccupied(arg_2_0)
	if not arg_2_0:IsMaterial() then
		return 0
	end

	if arg_2_0.count <= 0 then
		return 0
	end

	local var_2_0 = arg_2_0

	if arg_2_0.getConfig(var_2_0, "group_max") == 0 then
		return 1
	else
		math = var_2_0

		return var_2_0.ceil(arg_2_0.count / var_1)
	end

	return
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.island_item_data_template
end

function var_0_1.GetCount(arg_4_0)
	return arg_4_0.count
end

function var_0_1.CanRemove(arg_5_0, arg_5_1)
	return arg_5_1 <= arg_5_0:GetCount()
end

function var_0_1.ReduceCount(arg_6_0, arg_6_1)
	arg_6_0.count = arg_6_0.count - arg_6_1

	return
end

function var_0_1.IncreaseCount(arg_7_0, arg_7_1)
	arg_7_0.count = arg_7_0.count + arg_7_1

	return
end

function var_0_1.IsNotOwned(arg_8_0)
	return arg_8_0.count <= 0
end

function var_0_1.IsInvitationLetter(arg_9_0)
	local var_9_0 = var_0_1.StaticGetUsageType(arg_9_0.configId)

	IslandItemUsage = var_2

	return var_9_0 == var_2.usage_island_invitation
end

function var_0_1.GetName(arg_10_0)
	return arg_10_0:getConfig("name")
end

function var_0_1.GetType(arg_11_0)
	return arg_11_0:getConfig("type")
end

function var_0_1.GetRarity(arg_12_0)
	return arg_12_0:getConfig("rarity")
end

function var_0_1.GetDesc(arg_13_0)
	return arg_13_0:getConfig("desc")
end

function var_0_1.GetIcon(arg_14_0)
	return arg_14_0:getConfig("icon")
end

function var_0_1.GetUseArg(arg_15_0)
	return var_0_1.StaticGetUsageArg(arg_15_0.configId)
end

function var_0_1.GetOwnTime(arg_16_0)
	return arg_16_0.time
end

function var_0_1.IsMaterial(arg_17_0)
	return arg_17_0:GetType() == var_0_1.TYPE_MATERIAL
end

function var_0_1.IsProp(arg_18_0)
	return arg_18_0:GetType() == var_0_1.TYPE_PROP or arg_18_0:GetType() == var_0_1.TYPE_SHIP_EXP_BOOK
end

function var_0_1.IsSpecialProp(arg_19_0)
	return arg_19_0:GetType() == var_0_1.TYPE_SPECIAL_PROP
end

function var_0_1.IsFishingProp(arg_20_0)
	local var_20_0 = var_0_1.StaticGetUsageType(arg_20_0.configId)

	IslandItemUsage = var_2

	return var_20_0 == var_2.usage_fishing
end

function var_0_1.GetMaterialFacility(arg_21_0)
	if not arg_21_0:IsMaterial() then
		return ""
	end

	return ""
end

function var_0_1.CanConvert(arg_22_0)
	return arg_22_0:getConfig("convert") == 1
end

function var_0_1.GetConvertPt(arg_23_0)
	return arg_23_0:getConfig("pt_num")
end

function var_0_1.StaticGetMapUsageList(arg_24_0)
	pg = var_1_10001

	local var_24_0

	if not var_1_10001.island_item_data_template.get_id_list_by_usage[arg_24_0] then
		var_24_0 = {}
	end

	return var_24_0
end

function var_0_1.StaticGetUsageArg(arg_25_0)
	pg = var_1_10001

	return var_1_10001.island_item_data_template[arg_25_0].usage_arg
end

function var_0_1.StaticGetUsageType(arg_26_0)
	pg = var_1_10001

	return var_1_10001.island_item_data_template[arg_26_0].usage
end

function var_0_1.GetAcquiringWay(arg_27_0)
	local var_27_0 = {}

	pg = var_1_10002

	local var_27_1 = var_1_10002.island_item_data_template[arg_27_0.configId]

	ipairs = var_3

	for iter_27_0, iter_27_1 in var_3(var_27_1.jump_page) do
		table = var_1_10008

		var_1_10008.insert(var_27_0, iter_27_1)
	end

	return var_27_0
end

return var_0_1
