class = var_0_10000

local var_0_0 = "WorldAtlas"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
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
var_0_1.EventUpdateProgress = "WorldAtlas.EventUpdateProgress"
var_0_1.EventUpdateActiveEntrance = "WorldAtlas.EventUpdateActiveEntrance"
var_0_1.EventUpdateActiveMap = "WorldAtlas.EventUpdateActiveMap"
var_0_1.EventAddPressingMap = "WorldAtlas.EventAddPressingMap"
var_0_1.EventAddPressingEntrance = "WorldAtlas.EventAddPressingEntrance"
var_0_1.EventUpdatePortMark = "WorldAtlas.EventUpdatePortMark"
var_0_1.EventUpdateNGoodsCount = "WorldAtlas.EventUpdateNGoodsCount"
var_0_1.ScaleShrink = 1
var_0_1.ScaleFull = 2
var_0_1.ScaleExpand = 3
var_0_1.ScaleHalf = 4
var_0_1.Scales = {
	var_0_1.ScaleShrink,
	var_0_1.ScaleHalf,
	var_0_1.ScaleFull
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	assert = var_2
	pg = var_3

	var_2(var_3.world_expedition_data_by_map[arg_1_0.id], "world_expedition_data_by_map missing: " .. arg_1_0.id)

	pg = var_2
	arg_1_0.config = var_2.world_expedition_data_by_map[arg_1_0.id]

	arg_1_0:BuildEntranceDic()

	return
end

function var_0_1.Build(arg_2_0)
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

function var_0_1.Dispose(arg_3_0)
	WPool = var_1_10001

	var_1_10001:ReturnMap(arg_3_0.entranceDic)

	WPool = var_1

	var_1:ReturnMap(arg_3_0.mapDic)
	arg_3_0:Clear()

	return
end

function var_0_1.NewEntrance(arg_4_0, arg_4_1)
	WPool = var_1_10002

	local var_4_0 = var_1_10002
	local var_4_1 = var_1_10002.Get

	WorldEntrance = var_1_10004

	local var_4_2 = var_4_1(var_4_0, var_1_10004)

	var_2.Setup(var_4_2, arg_4_1, arg_4_0)

	arg_4_0.entranceDic[arg_4_1] = var_2

	return var_2
end

function var_0_1.NewMap(arg_5_0, arg_5_1)
	WPool = var_1_10002

	local var_5_0 = var_1_10002
	local var_5_1 = var_1_10002.Get

	WorldMap = var_1_10004

	local var_5_2 = var_5_1(var_5_0, var_1_10004)

	var_2.Setup(var_5_2, arg_5_1)

	arg_5_0.mapDic[arg_5_1] = var_2

	return var_2
end

function var_0_1.BuildEntranceDic(arg_6_0)
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
	_ = var_2

	local var_6_1 = var_2.each

	pg = var_3

	var_6_1(var_3.world_chapter_colormask.all, function(arg_7_0)
		pg = var_2_10001

		if var_2_10001.world_chapter_colormask[arg_7_0].world ~= arg_6_0.id then
			return
		end

		local var_7_0 = arg_6_0
		local var_7_1 = var_2.NewEntrance(var_7_0, arg_7_0)
		local var_7_2 = var_2.GetAreaId(var_7_1)
		local var_7_3 = arg_6_0.areaEntranceList
		local var_7_4

		if not arg_6_0.areaEntranceList[var_7_2] then
			var_7_4 = {}
		end

		var_7_3[var_7_2] = var_7_4
		table = var_7_3

		var_7_3.insert(arg_6_0.areaEntranceList[var_7_2], arg_7_0)

		local var_7_5

		if var_2:HasPort() then
			var_7_5 = var_2:GetPortId()

			local var_7_6 = arg_6_0.portEntranceList
			local var_7_7

			if not arg_6_0.portEntranceList[var_7_5] then
				var_7_7 = {}
			end

			var_7_6[var_7_5] = var_7_7
			table = var_7_6

			var_7_6.insert(arg_6_0.portEntranceList[var_7_5], arg_7_0)
		end

		ipairs = var_7_5

		for iter_7_0, iter_7_1 in var_7_5(var_6_0) do
			ipairs = var_2_10009

			for iter_7_2, iter_7_3 in var_2_10009(var_2.config[iter_7_1.field]) do
				if iter_7_1.name == "step" then
					for iter_7_4 = iter_7_3[1], iter_7_3[2] do
						local var_7_8 = arg_6_0.replaceDic[iter_7_1.name]
						local var_7_9

						if not arg_6_0.replaceDic[iter_7_1.name][iter_7_4] then
							var_7_9 = {}
						end

						var_7_8[iter_7_4] = var_7_9
						arg_6_0.replaceDic[iter_7_1.name][iter_7_4][arg_7_0] = var_2
					end
				else
					local var_7_10 = arg_6_0.replaceDic[iter_7_1.name]
					local var_7_11 = iter_7_3[1]
					local var_7_12

					if not arg_6_0.replaceDic[iter_7_1.name][iter_7_3[1]] then
						var_7_12 = {}
					end

					var_7_10[var_7_11] = var_7_12
					arg_6_0.replaceDic[iter_7_1.name][iter_7_3[1]][arg_7_0] = var_2
				end
			end
		end

		if #var_2.config.normal_target > 0 or #var_2.config.cryptic_target > 0 then
			table = var_4

			var_4.insert(arg_6_0.achEntranceList, var_2)
		end

		local var_7_13 = var_1.chapter
		local var_7_14 = arg_6_0
		local var_7_15 = var_5.NewMap(var_7_14, var_7_13)

		arg_6_0.mapEntrance[var_7_13] = var_2

		local var_7_16 = arg_6_0.replaceDic.open[1]
		local var_7_17 = var_7_15.config.open_stage[1]
		local var_7_18

		if not arg_6_0.replaceDic.open[1][var_7_15.config.open_stage[1]] then
			var_7_18 = {}
		end

		var_7_16[var_7_17] = var_7_18
		arg_6_0.replaceDic.open[1][var_7_15.config.open_stage[1]][arg_7_0] = 1

		local var_7_19 = arg_6_0.replaceDic.open[2]
		local var_7_20 = var_7_15.config.open_stage[2]
		local var_7_21

		if not arg_6_0.replaceDic.open[2][var_7_15.config.open_stage[2]] then
			var_7_21 = {}
		end

		var_7_19[var_7_20] = var_7_21
		arg_6_0.replaceDic.open[2][var_7_15.config.open_stage[2]][arg_7_0] = 1

		return
	end)

	return
end

function var_0_1.GetEntrance(arg_8_0, arg_8_1)
	return arg_8_0.entranceDic[arg_8_1]
end

function var_0_1.SetActiveEntrance(arg_9_0, arg_9_1)
	if arg_9_0.activeEntranceId ~= arg_9_1.id then
		arg_9_0.activeEntranceId = arg_9_1.id

		arg_9_0:DispatchEvent(var_0_1.EventUpdateActiveEntrance, arg_9_1)
	end

	return
end

function var_0_1.GetActiveEntrance(arg_10_0)
	local var_10_0

	if arg_10_0.activeEntranceId then
		var_10_0 = arg_10_0:GetEntrance(arg_10_0.activeEntranceId)
	end

	return var_10_0
end

function var_0_1.GetMap(arg_11_0, arg_11_1)
	if not arg_11_0.mapDic[arg_11_1] then
		arg_11_0:NewMap(arg_11_1)
	end

	return arg_11_0.mapDic[arg_11_1]
end

function var_0_1.SetActiveMap(arg_12_0, arg_12_1)
	if arg_12_0.activeMapId ~= arg_12_1.id then
		arg_12_0.activeMapId = arg_12_1.id

		arg_12_0:DispatchEvent(var_0_1.EventUpdateActiveMap, arg_12_1)
	end

	return
end

function var_0_1.GetActiveMap(arg_13_0)
	local var_13_0

	if arg_13_0.activeMapId then
		var_13_0 = arg_13_0:GetMap(arg_13_0.activeMapId)
	end

	return var_13_0
end

function var_0_1.GetDiscoverRate(arg_14_0)
	return 0
end

function var_0_1.CheckMapActive(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetMap(var_15_0, arg_15_1)

	assert = var_15_0

	var_15_0(var_15_1, "map not exist: " .. arg_15_1)

	local var_15_2

	if not var_15_1.active then
		_ = var_15_2
		var_15_2 = var_15_2.any
		_ = var_4
		var_15_2 = var_15_2(var_4.values(arg_15_0:GetPartMaps(arg_15_1)), function(arg_16_0)
			return arg_16_0.active
		end)
	end

	return var_15_2
end

function var_0_1.GetAtlasPixelSize(arg_17_0)
	Vector2 = var_1_10001

	return var_1_10001(arg_17_0.config.size[1], arg_17_0.config.size[2])
end

function var_0_1.GetAchEntranceList(arg_18_0)
	return arg_18_0.achEntranceList
end

function var_0_1.GetOpenEntranceDic(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.replaceDic.open

	nowWorld = var_1_10003

	local var_19_1 = var_1_10003()
	local var_19_2

	if not var_19_0[var_3.GetRealm(var_19_1)][arg_19_1] then
		var_19_2 = {}
	end

	return var_19_2
end

function var_0_1.GetStepDic(arg_20_0, arg_20_1)
	local var_20_0

	if not arg_20_0.replaceDic.step[arg_20_1] then
		var_20_0 = {}
	end

	return var_20_0
end

function var_0_1.GetTaskDic(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_0.replaceDic.task[arg_21_1] then
		var_21_0 = {}
	end

	return var_21_0
end

function var_0_1.GetTreasureDic(arg_22_0, arg_22_1)
	local var_22_0

	if not arg_22_0.replaceDic.treasure[arg_22_1] then
		var_22_0 = {}
	end

	return var_22_0
end

function var_0_1.UpdateProgress(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {}

	for iter_23_0 = arg_23_1 + 1, arg_23_2 do
		pairs = var_1_10008

		for iter_23_1 in var_1_10008(arg_23_0:GetOpenEntranceDic(iter_23_0)) do
			var_23_0[iter_23_1] = 1
		end
	end

	arg_23_0:DispatchEvent(var_0_1.EventUpdateProgress, var_23_0)

	local var_23_1 = {}

	pairs = var_4

	for iter_23_2 in var_4(arg_23_0:GetStepDic(arg_23_2)) do
		var_23_1[iter_23_2] = 1
	end

	pairs = var_4

	for iter_23_3 in var_4(arg_23_0:GetStepDic(arg_23_1)) do
		local var_23_2

		if not var_23_1[iter_23_3] then
			var_23_2 = 0
		end

		var_23_1[iter_23_3] = var_23_2 - 1
	end

	pairs = var_4

	for iter_23_4, iter_23_5 in var_4(var_23_1) do
		if iter_23_5 ~= 0 then
			local var_23_3 = arg_23_0.entranceDic[iter_23_4]

			var_9.UpdateDisplayMarks(var_23_3, "step", iter_23_5 > 0)
		end
	end

	return
end

function var_0_1.UpdateTask(arg_24_0, arg_24_1)
	local var_24_0 = (arg_24_1:isAlive() and 1 or 0) - (arg_24_0.taskMarkDic[arg_24_1.id] and 1 or 0)

	arg_24_0.taskMarkDic[arg_24_1.id] = var_2

	if var_24_0 == 0 then
		return
	end

	local var_24_1 = false

	pairs = var_5

	for iter_24_0 in var_5(arg_24_0:GetTaskDic(arg_24_1.id)) do
		var_24_1 = true

		if arg_24_1.config.type == 0 then
			local var_24_2 = arg_24_0.entranceDic[iter_24_0]

			var_9.UpdateDisplayMarks(var_24_2, "task_main", var_24_0 > 0)
		elseif arg_24_1.config.type == 6 then
			local var_24_3 = arg_24_0.entranceDic[iter_24_0]

			var_9.UpdateDisplayMarks(var_24_3, "task_collecktion", var_24_0 > 0)
		else
			local var_24_4 = arg_24_0.entranceDic[iter_24_0]

			var_9.UpdateDisplayMarks(var_24_4, "task", var_24_0 > 0)
		end
	end

	if arg_24_1:GetFollowingEntrance() and not var_24_1 then
		if arg_24_1.config.type == 0 then
			local var_24_5 = arg_24_0.entranceDic[var_5]

			var_6.UpdateDisplayMarks(var_24_5, "task_following_main", var_24_0 > 0)
		elseif arg_24_1.config.type == 7 then
			local var_24_6 = arg_24_0.entranceDic[var_5]

			var_6.UpdateDisplayMarks(var_24_6, "task_following_boss", var_24_0 > 0)
		else
			local var_24_7 = arg_24_0.entranceDic[var_5]

			var_6.UpdateDisplayMarks(var_24_7, "task_following", var_24_0 > 0)
		end
	end

	return
end

function var_0_1.UpdateTreasure(arg_25_0, arg_25_1)
	nowWorld = var_1_10002

	local var_25_0 = var_1_10002()
	local var_25_1 = var_2.GetInventoryProxy(var_25_0)
	local var_25_2 = (var_3.GetItemCount(var_25_1, arg_25_1) > 0 and 1 or 0) - (arg_25_0.treasureMarkDic[arg_25_1] and 1 or 0)

	arg_25_0.treasureMarkDic[arg_25_1] = var_4 > 0

	if var_25_2 ~= 0 then
		local var_25_3 = var_2
		local var_25_4 = var_2.FindTreasureEntrance(var_25_3, arg_25_1)

		pg = var_25_3

		if var_25_3.world_item_data_template[arg_25_1].usage_arg[1] == 1 then
			var_25_4:UpdateDisplayMarks("treasure_sairen", var_25_2 > 0)
		else
			var_25_4:UpdateDisplayMarks("treasure", var_25_2 > 0)
		end
	end

	return
end

function var_0_1.SetPressingMarkList(arg_26_0, arg_26_1)
	_ = var_1_10002

	var_1_10002.each(arg_26_0.pressingMapList, function(arg_27_0)
		local var_27_0 = arg_26_0
		local var_27_1 = var_1.GetMap(var_27_0, arg_27_0)

		var_1.UpdatePressingMark(var_27_1, false)

		return
	end)

	local var_26_0 = 0

	arg_26_0.pressingMapList = arg_26_1
	_ = var_3

	var_3.each(arg_26_0.pressingMapList, function(arg_28_0)
		local var_28_0 = arg_26_0
		local var_28_1 = var_1.GetMap(var_28_0, arg_28_0)

		var_1.UpdatePressingMark(var_28_1, true)

		if arg_26_0.mapEntrance[arg_28_0] and not var_1:HasPort() then
			var_26_0 = var_26_0 + 1
		end

		return
	end)

	arg_26_0.pressingUnlcokCount = var_26_0

	arg_26_0:BuildTransportDic()

	return
end

function var_0_1.BuildTransportDic(arg_29_0)
	arg_29_0.transportDic = {}
	pairs = var_1

	for iter_29_0, iter_29_1 in var_1(arg_29_0.entranceDic) do
		if iter_29_1:IsPressing() then
			local var_29_0 = arg_29_0.transportDic

			var_29_0[iter_29_0] = true
			pairs = var_29_0

			for iter_29_2 in var_29_0(iter_29_1.transportDic) do
				arg_29_0.transportDic[iter_29_2] = true
			end
		end
	end

	nowWorld = var_1

	local var_29_1 = var_1()

	if var_1.IsReseted(var_29_1) then
		arg_29_0:AddPortTransportDic()
	end

	return
end

function var_0_1.AddPortTransportDic(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.portEntranceList) do
		ipairs = var_1_10006

		for iter_30_2, iter_30_3 in var_1_10006(iter_30_1) do
			arg_30_0.transportDic[iter_30_3] = true
		end
	end

	return
end

function var_0_1.MarkMapTransport(arg_31_0, arg_31_1)
	if arg_31_0.mapEntrance[arg_31_1] then
		arg_31_0.transportDic[var_2.id] = true
	end

	return
end

function var_0_1.AddPressingMap(arg_32_0, arg_32_1)
	_ = var_1_10002

	if var_1_10002.any(arg_32_0.pressingMapList, function(arg_33_0)
		return arg_33_0 == arg_32_1
	end) then
		return
	else
		local var_32_0 = arg_32_0:GetMap(arg_32_1)

		var_2.UpdatePressingMark(var_32_0, true)

		table = var_2

		var_2.insert(arg_32_0.pressingMapList, arg_32_1)

		if arg_32_0.mapEntrance[arg_32_1] then
			local var_32_1 = {}

			arg_32_0.transportDic[var_2.id] = true
			var_32_1[var_2.id] = true
			pairs = var_4

			for iter_32_0 in var_4(var_2.transportDic) do
				if not arg_32_0.transportDic[iter_32_0] then
					arg_32_0.transportDic[iter_32_0] = true
					var_32_1[iter_32_0] = true
				end
			end

			arg_32_0:DispatchEvent(var_0_1.EventAddPressingEntrance, var_32_1)

			if not var_2:HasPort() then
				arg_32_0.pressingUnlcokCount = arg_32_0.pressingUnlcokCount + 1

				arg_32_0:UpdateUnlockCountPortMark()
			end
		end

		arg_32_0:DispatchEvent(var_0_1.EventAddPressingMap, arg_32_1)
	end

	return
end

function var_0_1.GetPressingUnlockCount(arg_34_0)
	return arg_34_0.pressingUnlcokCount
end

function var_0_1.GetPressingUnlockRecordCount(arg_35_0, arg_35_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_35_0 = var_1_10002(var_1_10003)
	local var_35_1 = var_2.getRawData(var_35_0).id

	nowWorld = var_35_0

	local var_35_2 = var_35_0().activateCount

	PlayerPrefs = var_1_10004

	local var_35_3 = var_1_10004.GetInt

	string = var_1_10005

	return var_35_3(var_1_10005.format("world_new_shop_unlock_count_in_port_%d_%d_%d", var_35_1, var_35_2, arg_35_1), -1)
end

function var_0_1.SetPressingUnlockRecordCount(arg_36_0, arg_36_1, arg_36_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_36_0 = var_1_10003(var_1_10004)
	local var_36_1 = var_3.getRawData(var_36_0).id

	nowWorld = var_36_0

	local var_36_2 = var_36_0().activateCount

	PlayerPrefs = var_1_10005

	local var_36_3 = var_1_10005.SetInt

	string = var_1_10006

	return var_36_3(var_1_10006.format("world_new_shop_unlock_count_in_port_%d_%d_%d", var_36_1, var_36_2, arg_36_1), arg_36_2)
end

function var_0_1.SetSairenEntranceList(arg_37_0, arg_37_1)
	_ = var_1_10002

	var_1_10002.each(arg_37_0.sairenEntranceList, function(arg_38_0)
		local var_38_0 = arg_37_0
		local var_38_1 = var_1.GetEntrance(var_38_0, arg_38_0)

		var_1.UpdateSairenMark(var_38_1, false)
		var_1:UpdateDisplayMarks("sairen", false)

		return
	end)

	arg_37_0.sairenEntranceList = arg_37_1
	_ = var_2

	var_2.each(arg_37_0.sairenEntranceList, function(arg_39_0)
		local var_39_0 = arg_37_0
		local var_39_1 = var_1.GetEntrance(var_39_0, arg_39_0)

		var_1.UpdateSairenMark(var_39_1, true)
		var_1:UpdateDisplayMarks("sairen", true)

		return
	end)

	return
end

function var_0_1.RemoveSairenEntrance(arg_40_0, arg_40_1)
	table = var_1_10002

	if var_1_10002.indexof(arg_40_0.sairenEntranceList, arg_40_1.id) then
		table = var_3

		var_3.remove(arg_40_0.sairenEntranceList, var_2)
		arg_40_1:UpdateSairenMark(false)
		arg_40_1:UpdateDisplayMarks("sairen", false)
	end

	return
end

function var_0_1.SetCostMapList(arg_41_0, arg_41_1)
	pairs = var_1_10002

	for iter_41_0 in var_1_10002(arg_41_0.costMapDic) do
		arg_41_0:GetMap(iter_41_0).isCost = false
	end

	arg_41_0.costMapDic = {}
	_ = var_2

	var_2.each(arg_41_1, function(arg_42_0)
		arg_41_0.costMapDic[arg_42_0.random_id] = true

		local var_42_0 = arg_41_0

		var_1.GetMap(var_42_0, arg_42_0.random_id).isCost = true

		return
	end)

	return
end

function var_0_1.UpdateCostMap(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0.costMapDic[arg_43_1] and arg_43_2 then
		nowWorld = var_3

		local var_43_0 = var_3()

		var_3.ClearAllFleetDefeatEnemies(var_43_0)
	end

	arg_43_0.costMapDic[arg_43_1] = arg_43_2

	return
end

function var_0_1.SetPortMarkList(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.markPortDic

	var_44_0.goods = {}
	ipairs = var_44_0

	for iter_44_0, iter_44_1 in var_44_0(arg_44_1) do
		arg_44_0.markPortDic.goods[iter_44_1] = true
	end

	local var_44_1 = arg_44_0.markPortDic

	var_44_1.new = {}
	ipairs = var_44_1

	for iter_44_2, iter_44_3 in var_44_1(arg_44_2) do
		arg_44_0.markPortDic.new[iter_44_3] = true
	end

	return
end

function var_0_1.UpdatePortMark(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	if not arg_45_0.portEntranceList[arg_45_1] then
		return
	end

	local var_45_0

	if arg_45_2 ~= nil then
		tobool = var_1_10005

		if var_1_10005(arg_45_0.markPortDic.goods[arg_45_1]) ~= arg_45_2 then
			var_1_10005 = arg_45_0.markPortDic.goods
			var_1_10005[arg_45_1] = arg_45_2
			var_45_0 = var_45_0 or {}
			ipairs = var_1_10005

			for iter_45_0, iter_45_1 in var_1_10005(arg_45_0.portEntranceList[arg_45_1]) do
				var_45_0[iter_45_1] = true
			end
		end
	end

	if arg_45_3 ~= nil then
		tobool = var_1_10005

		if var_1_10005(arg_45_0.markPortDic.new[arg_45_1]) ~= arg_45_3 then
			var_1_10005 = arg_45_0.markPortDic.new
			var_1_10005[arg_45_1] = arg_45_3
			var_45_0 = var_45_0 or {}
			ipairs = var_1_10005

			for iter_45_2, iter_45_3 in var_1_10005(arg_45_0.portEntranceList[arg_45_1]) do
				var_45_0[iter_45_3] = true
			end
		end
	end

	if var_45_0 then
		nowWorld = var_1_10005

		local var_45_1 = var_1_10005()

		if not var_5.UsePortNShop(var_45_1) then
			arg_45_0:DispatchEvent(var_0_1.EventUpdatePortMark, var_45_0)
		end
	end

	return
end

function var_0_1.InitPortMarkNShopList(arg_46_0)
	local var_46_0 = arg_46_0:GetPressingUnlockCount()
	local var_46_1 = arg_46_0.markPortDic

	var_46_1.newGoods = {}
	pairs = var_46_1

	for iter_46_0, iter_46_1 in var_46_1(arg_46_0.nShopGoodsDic) do
		Goods = var_1_10007
		var_1_10007 = var_1_10007.Create

		local var_46_2 = {
			id = iter_46_0,
			count = iter_46_1
		}

		Goods = var_1_10009
		var_1_10009 = var_1_10007(var_46_2, var_1_10009.TYPE_WORLD_NSHOP)

		local var_46_3 = var_1_10007.getConfig(var_1_10009, "port_id")

		var_1_10009 = var_1_10007:getConfig("unlock_num")

		local var_46_4 = arg_46_0:GetPressingUnlockRecordCount(var_46_3)

		if var_1_10007:canPurchase() and var_46_4 < var_1_10009 and var_1_10009 <= var_46_0 then
			arg_46_0.markPortDic.newGoods[var_46_3] = true
		end
	end

	return
end

function var_0_1.UpdateUnlockCountPortMark(arg_47_0)
	nowWorld = var_1_10001

	local var_47_0 = var_1_10001()

	if not var_1.UsePortNShop(var_47_0) then
		return
	end

	local var_47_1 = arg_47_0.markPortDic.newGoods
	local var_47_2 = arg_47_0

	arg_47_0.InitPortMarkNShopList(var_47_2)

	ipairs = var_2
	underscore = var_47_2

	for iter_47_0, iter_47_1 in var_2(var_47_2.keys(arg_47_0.portEntranceList)) do
		tobool = var_1_10007
		var_1_10007 = var_1_10007(var_47_1[iter_47_1])
		tobool = var_8

		if var_1_10007 ~= var_8(arg_47_0.markPortDic.newGoods[iter_47_1]) then
			var_1_10007 = {}
			ipairs = var_8

			for iter_47_2, iter_47_3 in var_8(arg_47_0.portEntranceList[iter_47_1]) do
				var_1_10007[iter_47_3] = true
			end
		end
	end

	changeDic = var_2

	if var_2 then
		local var_47_3 = arg_47_0
		local var_47_4 = arg_47_0.DispatchEvent
		local var_47_5 = var_0_1.EventUpdatePortMark

		changeDic = iter_47_0

		var_47_4(var_47_3, var_47_5, iter_47_0)
	end

	return
end

function var_0_1.UpdatePortMarkNShop(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_0.portEntranceList[arg_48_1] then
		return
	end

	tobool = var_3

	if var_3(arg_48_0.markPortDic.newGoods[arg_48_1]) ~= arg_48_2 then
		local var_48_0 = arg_48_0.markPortDic.newGoods

		var_48_0[arg_48_1] = arg_48_2
		nowWorld = var_48_0

		local var_48_1 = var_48_0()

		if var_3.UsePortNShop(var_48_1) then
			local var_48_2 = {}

			ipairs = var_48_1

			for iter_48_0, iter_48_1 in var_48_1(arg_48_0.portEntranceList[arg_48_1]) do
				var_48_2[iter_48_1] = true
			end

			arg_48_0:DispatchEvent(var_0_1.EventUpdatePortMark, var_48_2)
		end
	end

	return
end

function var_0_1.GetAnyPortMarkNShop(arg_49_0)
	pairs = var_1_10001

	for iter_49_0, iter_49_1 in var_1_10001(arg_49_0.markPortDic.newGoods) do
		if iter_49_1 then
			return true
		end
	end

	return false
end

function var_0_1.InitWorldNShopGoods(arg_50_0, arg_50_1)
	arg_50_0.nShopGoodsDic = {}
	ipairs = var_2
	pg = var_1_10003

	for iter_50_0, iter_50_1 in var_2(var_1_10003.world_newshop_data.all) do
		var_1_10007 = arg_50_0.nShopGoodsDic
		var_1_10007[iter_50_1] = 0
	end

	ipairs = var_2

	for iter_50_2, iter_50_3 in var_2(arg_50_1) do
		assert = var_1_10007

		var_1_10007(arg_50_0.nShopGoodsDic[iter_50_3.goods_id], "without this good in id " .. iter_50_3.goods_id)

		var_1_10007 = arg_50_0.nShopGoodsDic
		var_1_10007[iter_50_3.goods_id] = arg_50_0.nShopGoodsDic[iter_50_3.goods_id] + iter_50_3.count
	end

	return
end

function var_0_1.UpdateNShopGoodsCount(arg_51_0, arg_51_1, arg_51_2)
	assert = var_1_10003

	var_1_10003(arg_51_0.nShopGoodsDic[arg_51_1], "without this goods:" .. arg_51_1)

	if arg_51_2 ~= 0 then
		arg_51_0.nShopGoodsDic[arg_51_1] = arg_51_0.nShopGoodsDic[arg_51_1] + arg_51_2

		arg_51_0:DispatchEvent(var_0_1.EventUpdateNGoodsCount, arg_51_1, arg_51_0.nShopGoodsDic[arg_51_1])
	end

	return
end

function var_0_1.GetEntrancePortInfo(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:GetEntrance(arg_52_1)
	local var_52_1 = var_2.GetPortId(var_52_0)

	nowWorld = var_52_0

	local var_52_2 = var_52_0()

	if var_4.UsePortNShop(var_52_2) then
		return arg_52_0.transportDic[var_2.id], arg_52_0.markPortDic.newGoods[var_52_1], arg_52_0.markPortDic.newGoods[var_52_1]
	else
		return arg_52_0.transportDic[var_2.id], arg_52_0.markPortDic.goods[var_52_1], arg_52_0.markPortDic.new[var_52_1]
	end

	return
end

return var_0_1
