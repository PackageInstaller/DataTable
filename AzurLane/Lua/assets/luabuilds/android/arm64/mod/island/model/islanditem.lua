local var_0_0 = class("IslandItem", import("model.vo.BaseVO"))

var_0_0.TYPE_MATERIAL = 1
var_0_0.TYPE_PROP = 2
var_0_0.TYPE_SPECIAL_PROP = 3
var_0_0.TYPE_SHIP_EXP_BOOK = 5
var_0_0.GOLD_ID = 1
var_0_0.PEARL_ID = 9900

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_1.num or arg_1_1.number or arg_1_1.count or 1
	arg_1_0.time = arg_1_1.time or 0

	return
end

function var_0_0.GetNumberOfSlotsOccupied(arg_2_0)
	if not arg_2_0:IsMaterial() then
		return 0
	end

	if arg_2_0.count <= 0 then
		return 0
	end

	local var_2_0 = arg_2_0:getConfig("group_max")

	if var_2_0 == 0 then
		return 1
	else
		return math.ceil(arg_2_0.count / var_2_0)
	end

	return
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.island_item_data_template
end

function var_0_0.GetCount(arg_4_0)
	return arg_4_0.count
end

function var_0_0.CanRemove(arg_5_0, arg_5_1)
	return arg_5_1 <= arg_5_0:GetCount()
end

function var_0_0.ReduceCount(arg_6_0, arg_6_1)
	arg_6_0.count = arg_6_0.count - arg_6_1

	return
end

function var_0_0.IncreaseCount(arg_7_0, arg_7_1)
	arg_7_0.count = arg_7_0.count + arg_7_1

	return
end

function var_0_0.IsNotOwned(arg_8_0)
	return arg_8_0.count <= 0
end

function var_0_0.IsInvitationLetter(arg_9_0)
	return var_0_0.StaticGetUsageType(arg_9_0.configId) == IslandItemUsage.usage_island_invitation
end

function var_0_0.GetName(arg_10_0)
	return arg_10_0:getConfig("name")
end

function var_0_0.GetType(arg_11_0)
	return arg_11_0:getConfig("type")
end

function var_0_0.GetRarity(arg_12_0)
	return arg_12_0:getConfig("rarity")
end

function var_0_0.GetDesc(arg_13_0)
	return arg_13_0:getConfig("desc")
end

function var_0_0.GetIcon(arg_14_0)
	return arg_14_0:getConfig("icon")
end

function var_0_0.GetUseArg(arg_15_0)
	return var_0_0.StaticGetUsageArg(arg_15_0.configId)
end

function var_0_0.GetOwnTime(arg_16_0)
	return arg_16_0.time
end

function var_0_0.IsMaterial(arg_17_0)
	return arg_17_0:GetType() == var_0_0.TYPE_MATERIAL
end

function var_0_0.IsProp(arg_18_0)
	return arg_18_0:GetType() == var_0_0.TYPE_PROP or arg_18_0:GetType() == var_0_0.TYPE_SHIP_EXP_BOOK
end

function var_0_0.IsSpecialProp(arg_19_0)
	return arg_19_0:GetType() == var_0_0.TYPE_SPECIAL_PROP
end

function var_0_0.IsFishingProp(arg_20_0)
	return var_0_0.StaticGetUsageType(arg_20_0.configId) == IslandItemUsage.usage_fishing
end

function var_0_0.GetMaterialFacility(arg_21_0)
	if not arg_21_0:IsMaterial() then
		return ""
	end

	return ""
end

function var_0_0.CanConvert(arg_22_0)
	return arg_22_0:getConfig("convert") == 1
end

function var_0_0.GetConvertPt(arg_23_0)
	return arg_23_0:getConfig("pt_num")
end

function var_0_0.StaticGetMapUsageList(arg_24_0)
	return pg.island_item_data_template.get_id_list_by_usage[arg_24_0] or {}
end

function var_0_0.StaticGetUsageArg(arg_25_0)
	return pg.island_item_data_template[arg_25_0].usage_arg
end

function var_0_0.StaticGetUsageType(arg_26_0)
	return pg.island_item_data_template[arg_26_0].usage
end

function var_0_0.GetAcquiringWay(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(pg.island_item_data_template[arg_27_0.configId].jump_page) do
		table.insert({}, iter_27_1)
	end

	return {}
end

return var_0_0
