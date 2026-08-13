class = var_0_10000

local var_0_0 = "IslandPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.PlayerAttire"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1.id

	arg_1_0:Flush(arg_1_1)

	Vector3 = var_2
	arg_1_0.position = var_2.zero
	Vector3 = var_2
	arg_1_0.rotation = var_2.zero

	arg_1_0:InitDressupData(arg_1_1)

	return
end

function var_0_1.Flush(arg_2_0, arg_2_1)
	var_0_1.super.Flush(arg_2_0, arg_2_1)

	arg_2_0.name = arg_2_1.name
	arg_2_0.level = arg_2_1.level
	arg_2_0.mapId = arg_2_1.map_id

	return
end

function var_0_1.GetModelId(arg_3_0)
	return 0
end

function var_0_1.GetDressByType(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.currentDressTypeDic[arg_4_1] then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_1.GetCurrentColorByDressId(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_0.dressColorDic[arg_5_1] then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_1.GetHairFaceBodyDress(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetDressByType

	IslandShipDressHelperNew = var_1_10003

	local var_6_2 = var_6_1(var_6_0, var_1_10003.DressType.Hair)
	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.GetDressByType

	IslandShipDressHelperNew = var_1_10004

	local var_6_5 = var_6_4(var_6_3, var_1_10004.DressType.Face)
	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.GetDressByType

	IslandShipDressHelperNew = var_1_10005

	local var_6_8 = var_6_7(var_6_6, var_1_10005.DressType.Body)

	return var_6_2, var_6_5, var_6_8
end

function var_0_1.GetCurCommderId(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = arg_7_0:GetHairFaceBodyDress()

	IslandShipDressHelper = var_1_10004

	return (var_1_10004.GetCurCommanderId(var_7_0, var_7_1, var_7_2))
end

function var_0_1.IsSelf(arg_8_0)
	local var_8_0 = arg_8_0.id

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_8_1 = var_1_10002(var_1_10003)

	return var_8_0 == var_2.getRawData(var_8_1).id
end

function var_0_1.GetName(arg_9_0)
	return arg_9_0.name
end

function var_0_1.GetLevel(arg_10_0)
	return arg_10_0.level
end

function var_0_1.GetIcon(arg_11_0)
	pg = var_1_10001

	return var_1_10001.ship_skin_template[arg_11_0.character].painting
end

function var_0_1.GetLoaction(arg_12_0)
	if arg_12_0.mapId then
		pg = var_1

		if not var_1.island_map[arg_12_0.mapId] then
			return ""
		end

		pg = var_1

		return var_1.island_map[arg_12_0.mapId].name
	end
end

function var_0_1.SetPosition(arg_13_0, arg_13_1)
	arg_13_0.position = arg_13_1

	return
end

function var_0_1.SetRotation(arg_14_0, arg_14_1)
	arg_14_0.rotation = arg_14_1

	return
end

function var_0_1.UpdateName(arg_15_0, arg_15_1)
	arg_15_0.name = arg_15_1

	return
end

function var_0_1.InitDressupData(arg_16_0, arg_16_1)
	arg_16_0.currentDressTypeDic = {}
	ipairs = var_2

	local var_16_0

	if not arg_16_1.cur_dress then
		var_16_0 = {}
	end

	for iter_16_0, iter_16_1 in var_2(var_16_0) do
		arg_16_0.currentDressTypeDic[iter_16_1.type] = iter_16_1.id
	end

	arg_16_0.dressColorDic = {}
	ipairs = var_2

	local var_16_1

	if not arg_16_1.dress_color then
		var_16_1 = {}
	end

	for iter_16_2, iter_16_3 in var_2(var_16_1) do
		arg_16_0.dressColorDic[iter_16_3.id] = iter_16_3.color
	end

	return
end

function var_0_1.ChangeDressupData(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.currentDressTypeDic = {}
	ipairs = var_3

	for iter_17_0, iter_17_1 in var_3(arg_17_1 or {}) do
		arg_17_0.currentDressTypeDic[iter_17_1.type] = iter_17_1.id
	end

	arg_17_0.dressColorDic = {}
	ipairs = var_3

	for iter_17_2, iter_17_3 in var_3(arg_17_2 or {}) do
		arg_17_0.dressColorDic[iter_17_3.id] = iter_17_3.color
	end

	return
end

function var_0_1.IsInMap(arg_18_0, arg_18_1)
	return arg_18_0.mapId == arg_18_1
end

return var_0_1
