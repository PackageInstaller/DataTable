local var_0_0 = class("WorldAtlas", import("...BaseEntity"))

var_0_0.Fields = {
	config = "table",
	sairenEntranceList = "table",
	replaceDic = "table",
	entranceDic = "table",
	costMapDic = "table",
	mapDic = "table",
	achEntranceList = "table",
	markPortDic = "table",
	pressingMapList = "table",
	nShopGoodsDic = "table",
	portEntranceList = "table",
	activeMapId = "number",
	taskMarkDic = "table",
	pressingUnlcokCount = "number",
	world = "table",
	transportDic = "table",
	treasureMarkDic = "table",
	id = "number",
	activeEntranceId = "number",
	areaEntranceList = "table",
	mapEntrance = "table"
}
var_0_0.EventUpdateProgress = "WorldAtlas.EventUpdateProgress"
var_0_0.EventUpdateActiveEntrance = "WorldAtlas.EventUpdateActiveEntrance"
var_0_0.EventUpdateActiveMap = "WorldAtlas.EventUpdateActiveMap"
var_0_0.EventAddPressingMap = "WorldAtlas.EventAddPressingMap"
var_0_0.EventAddPressingEntrance = "WorldAtlas.EventAddPressingEntrance"
var_0_0.EventUpdatePortMark = "WorldAtlas.EventUpdatePortMark"
var_0_0.EventUpdateNGoodsCount = "WorldAtlas.EventUpdateNGoodsCount"
var_0_0.ScaleShrink = 1
var_0_0.ScaleFull = 2
var_0_0.ScaleExpand = 3
var_0_0.ScaleHalf = 4
var_0_0.Scales = {
	var_0_0.ScaleShrink,
	var_0_0.ScaleHalf,
	var_0_0.ScaleFull
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.id = arg_1_1

	assert(pg.world_expedition_data_by_map[arg_1_0.id], "world_expedition_data_by_map missing: " .. arg_1_0.id)

	arg_1_0.config = pg.world_expedition_data_by_map[arg_1_0.id]

	arg_1_0:BuildEntranceDic()

	return
end

function var_0_0.Build(arg_2_0)
	arg_2_0.entranceDic = {}
	arg_2_0.mapDic = {}
	arg_2_0.taskMarkDic = {}
	arg_2_0.treasureMarkDic = {}
	arg_2_0.sairenEntranceList = {}
	arg_2_0.costMapDic = {}
	arg_2_0.pressingMapList = {}
	arg_2_0.transportDic = {}
	arg_2_0.markPortDic = {}

	return
end

function var_0_0.Dispose(arg_3_0)
	WPool:ReturnMap(arg_3_0.entranceDic)
	WPool:ReturnMap(arg_3_0.mapDic)
	arg_3_0:Clear()

	return
end

function var_0_0.NewEntrance(arg_4_0, arg_4_1)
	local var_4_0 = WPool:Get(WorldEntrance)

	var_4_0:Setup(arg_4_1, arg_4_0)

	arg_4_0.entranceDic[arg_4_1] = var_4_0

	return var_4_0
end

function var_0_0.NewMap(arg_5_0, arg_5_1)
	local var_5_0 = WPool:Get(WorldMap)

	var_5_0:Setup(arg_5_1)

	arg_5_0.mapDic[arg_5_1] = var_5_0

	return var_5_0
end

function var_0_0.BuildEntranceDic(arg_6_0)
	local var_6_0 = {
		{
			name = "step",
			field = "stage_chapter"
		},
		{
			name = "task",
			field = "task_chapter"
		},
		{
			name = "treasure",
			field = "teasure_chapter"
		}
	}

	arg_6_0.mapEntrance = {}
	arg_6_0.areaEntranceList = {}
	arg_6_0.portEntranceList = {}
	arg_6_0.achEntranceList = {}
	arg_6_0.replaceDic = {
		step = {},
		task = {},
		treasure = {},
		open = {
			{},
			{}
		}
	}

	_.each(pg.world_chapter_colormask.all, function(arg_7_0)
		local var_7_0 = pg.world_chapter_colormask[arg_7_0]

		if pg.world_chapter_colormask[arg_7_0].world ~= arg_6_0.id then
			return
		end

		local var_7_1 = arg_6_0:NewEntrance(arg_7_0)
		local var_7_2 = var_7_1:GetAreaId()

		arg_6_0.areaEntranceList[var_7_2] = arg_6_0.areaEntranceList[var_7_2] or {}

		table.insert(arg_6_0.areaEntranceList[var_7_2], arg_7_0)

		if var_7_1:HasPort() then
			local var_7_3 = var_7_1:GetPortId()

			arg_6_0.portEntranceList[var_7_3] = arg_6_0.portEntranceList[var_7_3] or {}

			table.insert(arg_6_0.portEntranceList[var_7_3], arg_7_0)
		end

		for iter_7_0, iter_7_1 in ipairs(var_6_0) do
			for iter_7_2, iter_7_3 in ipairs(var_7_1.config[iter_7_1.field]) do
				if iter_7_1.name == "step" then
					for iter_7_4 = iter_7_3[1], iter_7_3[2] do
						arg_6_0.replaceDic[iter_7_1.name][iter_7_4] = arg_6_0.replaceDic[iter_7_1.name][iter_7_4] or {}
						arg_6_0.replaceDic[iter_7_1.name][iter_7_4][arg_7_0] = var_7_1
					end
				else
					local var_7_4 = arg_6_0.replaceDic[iter_7_1.name]

					var_7_4[iter_7_3[1]] = arg_6_0.replaceDic[iter_7_1.name][iter_7_3[1]] or {}
					arg_6_0.replaceDic[iter_7_1.name][iter_7_3[1]][arg_7_0] = var_7_1
				end
			end
		end

		local var_7_5

		if #var_7_1.config.normal_target > 0 or #var_7_1.config.cryptic_target > 0 then
			table.insert(arg_6_0.achEntranceList, var_7_1)

			var_7_5 = arg_6_0:NewMap(var_7_0.chapter)
		end

		arg_6_0.mapEntrance[var_7_0.chapter] = var_7_1
		arg_6_0.replaceDic.open[1][var_7_5.config.open_stage[1]] = arg_6_0.replaceDic.open[1][var_7_5.config.open_stage[1]] or {}
		arg_6_0.replaceDic.open[1][var_7_5.config.open_stage[1]][arg_7_0] = 1
		arg_6_0.replaceDic.open[2][var_7_5.config.open_stage[2]] = arg_6_0.replaceDic.open[2][var_7_5.config.open_stage[2]] or {}
		arg_6_0.replaceDic.open[2][var_7_5.config.open_stage[2]][arg_7_0] = 1

		return
	end)

	return
end

function var_0_0.GetEntrance(arg_8_0, arg_8_1)
	return arg_8_0.entranceDic[arg_8_1]
end

function var_0_0.SetActiveEntrance(arg_9_0, arg_9_1)
	if arg_9_0.activeEntranceId ~= arg_9_1.id then
		arg_9_0.activeEntranceId = arg_9_1.id

		arg_9_0:DispatchEvent(var_0_0.EventUpdateActiveEntrance, arg_9_1)
	end

	return
end

function var_0_0.GetActiveEntrance(arg_10_0)
	return arg_10_0.activeEntranceId and arg_10_0:GetEntrance(arg_10_0.activeEntranceId)
end

function var_0_0.GetMap(arg_11_0, arg_11_1)
	if not arg_11_0.mapDic[arg_11_1] then
		arg_11_0:NewMap(arg_11_1)
	end

	return arg_11_0.mapDic[arg_11_1]
end

function var_0_0.SetActiveMap(arg_12_0, arg_12_1)
	if arg_12_0.activeMapId ~= arg_12_1.id then
		arg_12_0.activeMapId = arg_12_1.id

		arg_12_0:DispatchEvent(var_0_0.EventUpdateActiveMap, arg_12_1)
	end

	return
end

function var_0_0.GetActiveMap(arg_13_0)
	return arg_13_0.activeMapId and arg_13_0:GetMap(arg_13_0.activeMapId)
end

function var_0_0.GetDiscoverRate(arg_14_0)
	return 0
end

function var_0_0.CheckMapActive(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetMap(arg_15_1)

	assert(var_15_0, "map not exist: " .. arg_15_1)

	return var_15_0.active or _.any(_.values(arg_15_0:GetPartMaps(arg_15_1)), function(arg_16_0)
		return arg_16_0.active
	end)
end

function var_0_0.GetAtlasPixelSize(arg_17_0)
	return Vector2(arg_17_0.config.size[1], arg_17_0.config.size[2])
end

function var_0_0.GetAchEntranceList(arg_18_0)
	return arg_18_0.achEntranceList
end

function var_0_0.GetOpenEntranceDic(arg_19_0, arg_19_1)
	return arg_19_0.replaceDic.open[nowWorld():GetRealm()][arg_19_1] or {}
end

function var_0_0.GetStepDic(arg_20_0, arg_20_1)
	return arg_20_0.replaceDic.step[arg_20_1] or {}
end

function var_0_0.GetTaskDic(arg_21_0, arg_21_1)
	return arg_21_0.replaceDic.task[arg_21_1] or {}
end

function var_0_0.GetTreasureDic(arg_22_0, arg_22_1)
	return arg_22_0.replaceDic.treasure[arg_22_1] or {}
end

function var_0_0.UpdateProgress(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0 = arg_23_1 + 1, arg_23_2 do
		for iter_23_1 in pairs(arg_23_0:GetOpenEntranceDic(iter_23_0)) do
			({})[iter_23_1] = 1
		end
	end

	arg_23_0:DispatchEvent(var_0_0.EventUpdateProgress, {})

	for iter_23_2 in pairs(arg_23_0:GetStepDic(arg_23_2)) do
		({})[iter_23_2] = 1
	end

	for iter_23_3 in pairs(arg_23_0:GetStepDic(arg_23_1)) do
		local var_23_0 = ({})[iter_23_3]

		if not ({})[iter_23_3] then
			var_23_0 = 0
		end

		;({})[iter_23_3] = var_23_0 - 1
	end

	for iter_23_4, iter_23_5 in pairs({}) do
		if iter_23_5 ~= 0 then
			arg_23_0.entranceDic[iter_23_4]:UpdateDisplayMarks("step", iter_23_5 > 0)
		end
	end

	return
end

function var_0_0.UpdateTask(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:isAlive()
	local var_24_1 = (var_24_0 and 1 or 0) - (arg_24_0.taskMarkDic[arg_24_1.id] and 1 or 0)

	arg_24_0.taskMarkDic[arg_24_1.id] = var_24_0

	if var_24_1 == 0 then
		return
	end

	local var_24_2 = false

	for iter_24_0 in pairs(arg_24_0:GetTaskDic(arg_24_1.id)) do
		var_24_2 = true

		if arg_24_1.config.type == 0 then
			arg_24_0.entranceDic[iter_24_0]:UpdateDisplayMarks("task_main", var_24_1 > 0)
		elseif arg_24_1.config.type == 6 then
			arg_24_0.entranceDic[iter_24_0]:UpdateDisplayMarks("task_collecktion", var_24_1 > 0)
		else
			arg_24_0.entranceDic[iter_24_0]:UpdateDisplayMarks("task", var_24_1 > 0)
		end
	end

	local var_24_3 = arg_24_1:GetFollowingEntrance()

	if var_24_3 and not var_24_2 then
		if arg_24_1.config.type == 0 then
			arg_24_0.entranceDic[var_24_3]:UpdateDisplayMarks("task_following_main", var_24_1 > 0)
		elseif arg_24_1.config.type == 7 then
			arg_24_0.entranceDic[var_24_3]:UpdateDisplayMarks("task_following_boss", var_24_1 > 0)
		else
			arg_24_0.entranceDic[var_24_3]:UpdateDisplayMarks("task_following", var_24_1 > 0)
		end
	end

	return
end

function var_0_0.UpdateTreasure(arg_25_0, arg_25_1)
	local var_25_0 = nowWorld()
	local var_25_1 = var_25_0:GetInventoryProxy():GetItemCount(arg_25_1)
	local var_25_2 = (var_25_1 > 0 and 1 or 0) - (arg_25_0.treasureMarkDic[arg_25_1] and 1 or 0)

	arg_25_0.treasureMarkDic[arg_25_1] = var_25_1 > 0

	if var_25_2 ~= 0 then
		local var_25_3 = var_25_0:FindTreasureEntrance(arg_25_1)

		if pg.world_item_data_template[arg_25_1].usage_arg[1] == 1 then
			var_25_3:UpdateDisplayMarks("treasure_sairen", var_25_2 > 0)
		else
			var_25_3:UpdateDisplayMarks("treasure", var_25_2 > 0)
		end
	end

	return
end

function var_0_0.SetPressingMarkList(arg_26_0, arg_26_1)
	_.each(arg_26_0.pressingMapList, function(arg_27_0)
		arg_26_0:GetMap(arg_27_0):UpdatePressingMark(false)

		return
	end)

	local var_26_0 = 0

	arg_26_0.pressingMapList = arg_26_1

	_.each(arg_26_0.pressingMapList, function(arg_28_0)
		arg_26_0:GetMap(arg_28_0):UpdatePressingMark(true)

		if arg_26_0.mapEntrance[arg_28_0] and not arg_26_0.mapEntrance[arg_28_0]:HasPort() then
			var_26_0 = var_26_0 + 1
		end

		return
	end)

	arg_26_0.pressingUnlcokCount = 0

	arg_26_0:BuildTransportDic()

	return
end

function var_0_0.BuildTransportDic(arg_29_0)
	arg_29_0.transportDic = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0.entranceDic) do
		if iter_29_1:IsPressing() then
			arg_29_0.transportDic[iter_29_0] = true

			for iter_29_2 in pairs(iter_29_1.transportDic) do
				arg_29_0.transportDic[iter_29_2] = true
			end
		end
	end

	if nowWorld():IsReseted() then
		arg_29_0:AddPortTransportDic()
	end

	return
end

function var_0_0.AddPortTransportDic(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.portEntranceList) do
		for iter_30_2, iter_30_3 in ipairs(iter_30_1) do
			arg_30_0.transportDic[iter_30_3] = true
		end
	end

	return
end

function var_0_0.MarkMapTransport(arg_31_0, arg_31_1)
	if arg_31_0.mapEntrance[arg_31_1] then
		arg_31_0.transportDic[arg_31_0.mapEntrance[arg_31_1].id] = true
	end

	return
end

function var_0_0.AddPressingMap(arg_32_0, arg_32_1)
	if _.any(arg_32_0.pressingMapList, function(arg_33_0)
		return arg_33_0 == arg_32_1
	end) then
		return
	else
		arg_32_0:GetMap(arg_32_1):UpdatePressingMark(true)
		table.insert(arg_32_0.pressingMapList, arg_32_1)

		if arg_32_0.mapEntrance[arg_32_1] then
			arg_32_0.transportDic[arg_32_0.mapEntrance[arg_32_1].id] = true
			;({})[arg_32_0.mapEntrance[arg_32_1].id] = true

			for iter_32_0 in pairs(arg_32_0.mapEntrance[arg_32_1].transportDic) do
				if not arg_32_0.transportDic[iter_32_0] then
					arg_32_0.transportDic[iter_32_0] = true
					;({})[iter_32_0] = true
				end
			end

			arg_32_0:DispatchEvent(var_0_0.EventAddPressingEntrance, {})

			if not arg_32_0.mapEntrance[arg_32_1]:HasPort() then
				arg_32_0.pressingUnlcokCount = arg_32_0.pressingUnlcokCount + 1

				arg_32_0:UpdateUnlockCountPortMark()
			end
		end

		arg_32_0:DispatchEvent(var_0_0.EventAddPressingMap, arg_32_1)
	end

	return
end

function var_0_0.GetPressingUnlockCount(arg_34_0)
	return arg_34_0.pressingUnlcokCount
end

function var_0_0.GetPressingUnlockRecordCount(arg_35_0, arg_35_1)
	return PlayerPrefs.GetInt(string.format("world_new_shop_unlock_count_in_port_%d_%d_%d", getProxy(PlayerProxy):getRawData().id, nowWorld().activateCount, arg_35_1), -1)
end

function var_0_0.SetPressingUnlockRecordCount(arg_36_0, arg_36_1, arg_36_2)
	return PlayerPrefs.SetInt(string.format("world_new_shop_unlock_count_in_port_%d_%d_%d", getProxy(PlayerProxy):getRawData().id, nowWorld().activateCount, arg_36_1), arg_36_2)
end

function var_0_0.SetSairenEntranceList(arg_37_0, arg_37_1)
	_.each(arg_37_0.sairenEntranceList, function(arg_38_0)
		local var_38_0 = arg_37_0:GetEntrance(arg_38_0)

		var_38_0:UpdateSairenMark(false)
		var_38_0:UpdateDisplayMarks("sairen", false)

		return
	end)

	arg_37_0.sairenEntranceList = arg_37_1

	_.each(arg_37_0.sairenEntranceList, function(arg_39_0)
		local var_39_0 = arg_37_0:GetEntrance(arg_39_0)

		var_39_0:UpdateSairenMark(true)
		var_39_0:UpdateDisplayMarks("sairen", true)

		return
	end)

	return
end

function var_0_0.RemoveSairenEntrance(arg_40_0, arg_40_1)
	local var_40_0 = table.indexof(arg_40_0.sairenEntranceList, arg_40_1.id)

	if var_40_0 then
		table.remove(arg_40_0.sairenEntranceList, var_40_0)
		arg_40_1:UpdateSairenMark(false)
		arg_40_1:UpdateDisplayMarks("sairen", false)
	end

	return
end

function var_0_0.SetCostMapList(arg_41_0, arg_41_1)
	for iter_41_0 in pairs(arg_41_0.costMapDic) do
		arg_41_0:GetMap(iter_41_0).isCost = false
	end

	arg_41_0.costMapDic = {}

	_.each(arg_41_1, function(arg_42_0)
		arg_41_0.costMapDic[arg_42_0.random_id] = true
		arg_41_0:GetMap(arg_42_0.random_id).isCost = true

		return
	end)

	return
end

function var_0_0.UpdateCostMap(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0.costMapDic[arg_43_1] and arg_43_2 then
		nowWorld():ClearAllFleetDefeatEnemies()
	end

	arg_43_0.costMapDic[arg_43_1] = arg_43_2

	return
end

function var_0_0.SetPortMarkList(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0.markPortDic.goods = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		arg_44_0.markPortDic.goods[iter_44_1] = true
	end

	arg_44_0.markPortDic.new = {}

	for iter_44_2, iter_44_3 in ipairs(arg_44_2) do
		arg_44_0.markPortDic.new[iter_44_3] = true
	end

	return
end

function var_0_0.UpdatePortMark(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	if not arg_45_0.portEntranceList[arg_45_1] then
		return
	end

	local var_45_0

	if arg_45_2 ~= nil and tobool(arg_45_0.markPortDic.goods[arg_45_1]) ~= arg_45_2 then
		arg_45_0.markPortDic.goods[arg_45_1] = arg_45_2
		var_45_0 = var_45_0 or {}

		for iter_45_0, iter_45_1 in ipairs(arg_45_0.portEntranceList[arg_45_1]) do
			var_45_0[iter_45_1] = true
		end
	end

	if arg_45_3 ~= nil and tobool(arg_45_0.markPortDic.new[arg_45_1]) ~= arg_45_3 then
		arg_45_0.markPortDic.new[arg_45_1] = arg_45_3
		var_45_0 = var_45_0 or {}

		for iter_45_2, iter_45_3 in ipairs(arg_45_0.portEntranceList[arg_45_1]) do
			var_45_0[iter_45_3] = true
		end
	end

	if var_45_0 then
		if not nowWorld():UsePortNShop() then
			arg_45_0:DispatchEvent(var_0_0.EventUpdatePortMark, var_45_0)
		end
	end

	return
end

function var_0_0.InitPortMarkNShopList(arg_46_0)
	local var_46_0 = arg_46_0:GetPressingUnlockCount()

	arg_46_0.markPortDic.newGoods = {}

	for iter_46_0, iter_46_1 in pairs(arg_46_0.nShopGoodsDic) do
		local var_46_1 = Goods.Create({
			id = iter_46_0,
			count = iter_46_1
		}, Goods.TYPE_WORLD_NSHOP)
		local var_46_2 = var_46_1:getConfig("port_id")
		local var_46_3 = var_46_1:getConfig("unlock_num")
		local var_46_4 = arg_46_0:GetPressingUnlockRecordCount(var_46_2)

		if var_46_1:canPurchase() and var_46_4 < var_46_3 and var_46_3 <= var_46_0 then
			arg_46_0.markPortDic.newGoods[var_46_2] = true
		end
	end

	return
end

function var_0_0.UpdateUnlockCountPortMark(arg_47_0)
	if not nowWorld():UsePortNShop() then
		return
	end

	local var_47_0 = arg_47_0.markPortDic.newGoods

	arg_47_0:InitPortMarkNShopList()

	for iter_47_0, iter_47_1 in ipairs(underscore.keys(arg_47_0.portEntranceList)) do
		if tobool(var_47_0[iter_47_1]) ~= tobool(arg_47_0.markPortDic.newGoods[iter_47_1]) then
			for iter_47_2, iter_47_3 in ipairs(arg_47_0.portEntranceList[iter_47_1]) do
				({})[iter_47_3] = true
			end
		end
	end

	if changeDic then
		arg_47_0:DispatchEvent(var_0_0.EventUpdatePortMark, changeDic)
	end

	return
end

function var_0_0.UpdatePortMarkNShop(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_0.portEntranceList[arg_48_1] then
		return
	end

	if tobool(arg_48_0.markPortDic.newGoods[arg_48_1]) ~= arg_48_2 then
		arg_48_0.markPortDic.newGoods[arg_48_1] = arg_48_2

		if nowWorld():UsePortNShop() then
			for iter_48_0, iter_48_1 in ipairs(arg_48_0.portEntranceList[arg_48_1]) do
				({})[iter_48_1] = true
			end

			arg_48_0:DispatchEvent(var_0_0.EventUpdatePortMark, {})
		end
	end

	return
end

function var_0_0.GetAnyPortMarkNShop(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.markPortDic.newGoods) do
		if iter_49_1 then
			return true
		end
	end

	return false
end

function var_0_0.InitWorldNShopGoods(arg_50_0, arg_50_1)
	arg_50_0.nShopGoodsDic = {}

	for iter_50_0, iter_50_1 in ipairs(pg.world_newshop_data.all) do
		arg_50_0.nShopGoodsDic[iter_50_1] = 0
	end

	for iter_50_2, iter_50_3 in ipairs(arg_50_1) do
		assert(arg_50_0.nShopGoodsDic[iter_50_3.goods_id], "without this good in id " .. iter_50_3.goods_id)

		arg_50_0.nShopGoodsDic[iter_50_3.goods_id] = arg_50_0.nShopGoodsDic[iter_50_3.goods_id] + iter_50_3.count
	end

	return
end

function var_0_0.UpdateNShopGoodsCount(arg_51_0, arg_51_1, arg_51_2)
	assert(arg_51_0.nShopGoodsDic[arg_51_1], "without this goods:" .. arg_51_1)

	if arg_51_2 ~= 0 then
		arg_51_0.nShopGoodsDic[arg_51_1] = arg_51_0.nShopGoodsDic[arg_51_1] + arg_51_2

		arg_51_0:DispatchEvent(var_0_0.EventUpdateNGoodsCount, arg_51_1, arg_51_0.nShopGoodsDic[arg_51_1])
	end

	return
end

function var_0_0.GetEntrancePortInfo(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:GetEntrance(arg_52_1)
	local var_52_1 = var_52_0:GetPortId()

	if nowWorld():UsePortNShop() then
		return arg_52_0.transportDic[var_52_0.id], arg_52_0.markPortDic.newGoods[var_52_1], arg_52_0.markPortDic.newGoods[var_52_1]
	else
		return arg_52_0.transportDic[var_52_0.id], arg_52_0.markPortDic.goods[var_52_1], arg_52_0.markPortDic.new[var_52_1]
	end

	return
end

return var_0_0
