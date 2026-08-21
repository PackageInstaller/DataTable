local var_0_0 = class("IslandPlayer", import("model.vo.PlayerAttire"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1.id

	arg_1_0:Flush(arg_1_1)

	arg_1_0.position = Vector3.zero
	arg_1_0.rotation = Vector3.zero

	arg_1_0:InitDressupData(arg_1_1)

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	var_0_0.super.Flush(arg_2_0, arg_2_1)

	arg_2_0.name = arg_2_1.name
	arg_2_0.level = arg_2_1.level
	arg_2_0.mapId = arg_2_1.map_id

	return
end

function var_0_0.GetModelId(arg_3_0)
	return 0
end

function var_0_0.GetDressByType(arg_4_0, arg_4_1)
	return arg_4_0.currentDressTypeDic[arg_4_1] or 0
end

function var_0_0.GetCurrentColorByDressId(arg_5_0, arg_5_1)
	return arg_5_0.dressColorDic[arg_5_1] or 0
end

function var_0_0.GetHairFaceBodyDress(arg_6_0)
	return arg_6_0:GetDressByType(IslandShipDressHelperNew.DressType.Hair), arg_6_0:GetDressByType(IslandShipDressHelperNew.DressType.Face), (arg_6_0:GetDressByType(IslandShipDressHelperNew.DressType.Body))
end

function var_0_0.GetCurCommderId(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = arg_7_0:GetHairFaceBodyDress()

	return (IslandShipDressHelper.GetCurCommanderId(var_7_0, var_7_1, var_7_2))
end

function var_0_0.IsSelf(arg_8_0)
	local var_8_0 = getProxy(PlayerProxy)

	return arg_8_0.id == var_8_0:getRawData().id
end

function var_0_0.GetName(arg_9_0)
	return arg_9_0.name
end

function var_0_0.GetLevel(arg_10_0)
	return arg_10_0.level
end

function var_0_0.GetIcon(arg_11_0)
	return pg.ship_skin_template[arg_11_0.character].painting
end

function var_0_0.GetLoaction(arg_12_0)
	if not arg_12_0.mapId or not pg.island_map[arg_12_0.mapId] then
		return ""
	end

	return pg.island_map[arg_12_0.mapId].name
end

function var_0_0.SetPosition(arg_13_0, arg_13_1)
	arg_13_0.position = arg_13_1

	return
end

function var_0_0.SetRotation(arg_14_0, arg_14_1)
	arg_14_0.rotation = arg_14_1

	return
end

function var_0_0.UpdateName(arg_15_0, arg_15_1)
	arg_15_0.name = arg_15_1

	return
end

function var_0_0.InitDressupData(arg_16_0, arg_16_1)
	arg_16_0.currentDressTypeDic = {}

	local var_16_0 = arg_16_1.cur_dress or {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		arg_16_0.currentDressTypeDic[iter_16_1.type] = iter_16_1.id
	end

	arg_16_0.dressColorDic = {}

	local var_16_1 = arg_16_1.dress_color or {}

	for iter_16_2, iter_16_3 in ipairs(var_16_1) do
		arg_16_0.dressColorDic[iter_16_3.id] = iter_16_3.color
	end

	return
end

function var_0_0.ChangeDressupData(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.currentDressTypeDic = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1 or {}) do
		arg_17_0.currentDressTypeDic[iter_17_1.type] = iter_17_1.id
	end

	arg_17_0.dressColorDic = {}

	for iter_17_2, iter_17_3 in ipairs(arg_17_2 or {}) do
		arg_17_0.dressColorDic[iter_17_3.id] = iter_17_3.color
	end

	return
end

function var_0_0.IsInMap(arg_18_0, arg_18_1)
	return arg_18_0.mapId == arg_18_1
end

return var_0_0
