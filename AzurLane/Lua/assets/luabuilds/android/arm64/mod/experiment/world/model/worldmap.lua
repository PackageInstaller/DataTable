class = var_0_10000

local var_0_0 = "WorldMap"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	config = "table",
	valid = "boolean",
	gid = "number",
	cells = "table",
	active = "boolean",
	findex = "number",
	top = "number",
	phaseDisplayList = "table",
	salvageAutoResult = "boolean",
	isPressing = "boolean",
	visionFlag = "boolean",
	isLoss = "boolean",
	bottom = "number",
	centerCellFOV = "table",
	typeAttachments = "table",
	isCost = "boolean",
	theme = "table",
	fleets = "table",
	left = "number",
	factionBuffs = "table",
	ports = "table",
	id = "number",
	clearFlag = "boolean",
	right = "number"
}
var_0_1.Listeners = {
	onUpdateAttachmentExist = "OnUpdateAttachmentExist"
}
var_0_1.EventUpdateActive = "WorldMap.EventUpdateActive"
var_0_1.EventUpdateFIndex = "WorldMap.EventUpdateFIndex"
var_0_1.EventUpdateMapBuff = "WorldMap.EventUpdateMapBuff"
var_0_1.EventUpdateFleetFOV = "WorldMap.EventUpdateFleetFOV"
var_0_1.EventUpdateMoveSpeed = "WorldMap.EventUpdateMoveSpeed"

function var_0_1.DebugPrint(arg_1_0)
	string = var_1_10001

	local var_1_0 = var_1_10001.format
	local var_1_1 = "地图 [%s] [id: %s] [gid: %s] [危险度: %s] [是否压制：%s]"
	local var_1_2 = arg_1_0.config.name
	local var_1_3 = arg_1_0.id

	tostring = var_1_10006

	return var_1_0(var_1_1, var_1_2, var_1_3, var_1_10006(arg_1_0.gid), arg_1_0:GetDanger(), arg_1_0.isPressing)
end

function var_0_1.Build(arg_2_0)
	arg_2_0.cells = {}
	arg_2_0.ports = {}
	arg_2_0.phaseDisplayList = {}

	return
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0:UnbindFleets()
	arg_3_0:DisposeTheme()
	arg_3_0:DisposeGrid()
	arg_3_0:DisposePort()
	arg_3_0:Clear()

	return
end

function var_0_1.Setup(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1
	assert = var_1_10002
	pg = var_1_10004

	local var_4_0 = var_1_10004.world_chapter_random[arg_4_0.id]
	local var_4_1 = "world_chapter_random not exist: "

	tostring = var_1_10006

	var_1_10002(var_4_0, var_4_1 .. var_1_10006(arg_4_0.id))

	setmetatable = var_1_10002
	arg_4_0.config = var_1_10002({}, {
		__index = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_4_0

			return var_2.GetConfig(var_5_0, arg_5_1)
		end
	})

	return
end

function var_0_1.GetName(arg_6_0, arg_6_1)
	local var_6_0

	if arg_6_1 then
		::label_6_0::

		World = var_6_0
		var_6_0 = var_6_0.ReplacementMapType(arg_6_1, arg_6_0)
	end

	if var_6_0 == "sairen_chapter" or var_6_0 == "teasure_chapter" then
		local var_6_1 = arg_6_1:GetBaseMap()

		return var_3.GetName(var_6_1) .. "-" .. arg_6_0.config.name
	else
		return arg_6_0.config.name
	end

	return
end

function var_0_1.GetConfig(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.world_chapter_random[arg_7_0.id]

	pg = var_3

	local var_7_1 = var_3.world_chapter_template[arg_7_0.gid]
	local var_7_2

	if (not var_7_0 or not var_7_0[arg_7_1]) and (not var_7_1 or not var_7_1[arg_7_1]) then
		var_7_2 = nil
	end

	assert = var_1_10005

	var_1_10005(var_7_2 ~= nil, "can not find " .. arg_7_1 .. " in WorldMap " .. arg_7_0.id)

	return var_7_2
end

var_0_1.FactionSelf = 0
var_0_1.FactionEnemy = 1

function var_0_1.UpdateGridId(arg_8_0, arg_8_1)
	arg_8_0.gid = arg_8_1
	assert = var_1_10002
	pg = var_1_10004

	local var_8_0 = var_1_10004.world_chapter_template[arg_8_0.gid]
	local var_8_1 = "world_chapter_template not exist: "

	tostring = var_1_10006

	var_1_10002(var_8_0, var_8_1 .. var_1_10006(arg_8_0.gid))
	arg_8_0:DisposeTheme()
	arg_8_0:DisposeGrid()
	arg_8_0:DisposePort()

	arg_8_0.factionBuffs = {
		[var_0_1.FactionSelf] = {},
		[var_0_1.FactionEnemy] = {}
	}
	ipairs = var_2

	for iter_8_0, iter_8_1 in var_2(arg_8_0.config.world_chapter_buff) do
		unpack = var_1_10007

		local var_8_2, var_8_3

		var_1_10007, var_8_2, var_8_3 = var_1_10007(iter_8_1)

		arg_8_0:AddBuff(var_1_10007, var_8_2, var_8_3)
	end

	arg_8_0:SetupTheme()
	arg_8_0:SetupGrid()
	arg_8_0:SetupPort()

	return
end

function var_0_1.SetupTheme(arg_9_0)
	WPool = var_1_10001

	local var_9_0 = var_1_10001
	local var_9_1 = var_1_10001.Get

	WorldMapTheme = var_1_10004

	local var_9_2 = var_9_1(var_9_0, var_1_10004)

	var_1.Setup(var_9_2, arg_9_0.config.theme)

	arg_9_0.theme = var_1

	return
end

function var_0_1.DisposeTheme(arg_10_0)
	if arg_10_0.theme then
		WPool = var_1

		var_1:Return(arg_10_0.theme)

		arg_10_0.theme = nil
	end

	return
end

function var_0_1.SetupGrid(arg_11_0, arg_11_1)
	_ = var_1_10002

	var_1_10002.each(arg_11_0.config.grids, function(arg_12_0)
		WPool = var_2_10001

		local var_12_0 = var_2_10001
		local var_12_1 = var_2_10001.Get

		WorldMapCell = var_2_10004

		local var_12_2 = var_12_1(var_12_0, var_2_10004)

		var_1.Setup(var_12_2, arg_12_0)

		local var_12_3 = arg_11_0
		local var_12_4

		if var_2.AlwaysInFOV(var_12_3) then
			bit = var_12_4
			var_12_4 = var_12_4.bor

			local var_12_5 = var_1.infov

			WorldConst = var_5
			var_1.infov = var_12_4(var_12_5, var_5.FOVMapSight)
		end

		WorldMapCell = var_12_4

		local var_12_6 = var_12_4.GetName(var_1.row, var_1.column)

		arg_11_0.cells[var_12_6] = var_1

		if not arg_11_1 then
			local var_12_7 = var_1
			local var_12_8 = var_1.AddListener

			WorldMapCell = var_2_10006

			var_12_8(var_12_7, var_2_10006.EventAddAttachment, arg_11_0.onUpdateAttachmentExist)

			local var_12_9 = var_1
			local var_12_10 = var_1.AddListener

			WorldMapCell = var_6

			var_12_10(var_12_9, var_6.EventRemoveAttachment, arg_11_0.onUpdateAttachmentExist)
		end

		return
	end)

	arg_11_0.left, arg_11_0.right = 999999, 0
	arg_11_0.top, arg_11_0.bottom = 999999, 0

	local var_11_0 = 0

	WorldConst = var_3

	for iter_11_0 = var_11_0, var_3.MaxRow do
		local var_11_1
		local var_11_2
		local var_11_3 = 0

		WorldConst = var_1_10009

		for iter_11_1 = var_11_3, var_1_10009.MaxColumn do
			if arg_11_0:GetCell(iter_11_0, iter_11_1) then
				if not var_11_1 then
					var_11_1 = iter_11_1
					bit = var_1_10013
					var_1_10013 = var_1_10013.bor
					var_1_10015 = var_12.dir
					bit = var_16

					local var_11_4 = var_16.lshift
					local var_11_5 = 1

					WorldConst = var_1_10019
					var_12.dir = var_1_10013(var_1_10015, var_11_4(var_11_5, var_1_10019.DirLeft))
				end

				var_11_2 = iter_11_1
			end
		end

		if var_11_2 then
			var_11_3 = arg_11_0:GetCell(iter_11_0, var_11_2)
			bit = var_1_10009
			var_1_10009 = var_1_10009.bor

			local var_11_6 = var_11_3.dir

			bit = var_12

			local var_11_7 = var_12.lshift
			local var_11_8 = 1

			WorldConst = var_1_10015
			var_11_3.dir = var_1_10009(var_11_6, var_11_7(var_11_8, var_1_10015.DirRight))
		end

		if var_11_1 then
			math = var_11_3
			arg_11_0.left = var_11_3.min(arg_11_0.left, var_11_1)
		end

		if var_11_2 then
			math = var_11_3
			arg_11_0.right = var_11_3.max(arg_11_0.right, var_11_2)
		end
	end

	local var_11_9 = 0

	WorldConst = var_3

	for iter_11_2 = var_11_9, var_3.MaxColumn do
		local var_11_10
		local var_11_11
		local var_11_12 = 0

		WorldConst = var_1_10009

		for iter_11_3 = var_11_12, var_1_10009.MaxRow do
			if arg_11_0:GetCell(iter_11_3, iter_11_2) then
				if not var_11_10 then
					var_11_10 = iter_11_3
					bit = var_1_10013
					var_1_10013 = var_1_10013.bor
					var_1_10015 = var_12.dir
					bit = var_16

					local var_11_13 = var_16.lshift
					local var_11_14 = 1

					WorldConst = var_1_10019
					var_12.dir = var_1_10013(var_1_10015, var_11_13(var_11_14, var_1_10019.DirUp))
				end

				var_11_11 = iter_11_3
			end
		end

		if var_11_11 then
			var_11_12 = arg_11_0:GetCell(var_11_11, iter_11_2)
			bit = var_1_10009
			var_1_10009 = var_1_10009.bor

			local var_11_15 = var_11_12.dir

			bit = var_12

			local var_11_16 = var_12.lshift
			local var_11_17 = 1

			WorldConst = var_1_10015
			var_11_12.dir = var_1_10009(var_11_15, var_11_16(var_11_17, var_1_10015.DirDown))
		end

		if var_11_10 then
			math = var_11_12
			arg_11_0.top = var_11_12.min(arg_11_0.top, var_11_10)
		end

		if var_11_11 then
			math = var_11_12
			arg_11_0.bottom = var_11_12.max(arg_11_0.bottom, var_11_11)
		end
	end

	return
end

function var_0_1.DisposeGrid(arg_13_0, arg_13_1)
	if not arg_13_1 then
		pairs = var_1_10002

		for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.cells) do
			local var_13_0 = iter_13_1
			local var_13_1 = iter_13_1.RemoveListener

			WorldMapCell = var_1_10010

			var_13_1(var_13_0, var_1_10010.EventAddAttachment, arg_13_0.onUpdateAttachmentExist)

			local var_13_2 = iter_13_1
			local var_13_3 = iter_13_1.RemoveListener

			WorldMapCell = var_1_10010

			var_13_3(var_13_2, var_1_10010.EventRemoveAttachment, arg_13_0.onUpdateAttachmentExist)
		end
	end

	WPool = var_1_10002

	var_1_10002:ReturnMap(arg_13_0.cells)

	arg_13_0.cells = {}
	arg_13_0.typeAttachments = {}
	arg_13_0.left = nil
	arg_13_0.top = nil
	arg_13_0.right = nil
	arg_13_0.bottom = nil

	return
end

function var_0_1.SetupPort(arg_14_0)
	if #arg_14_0.config.port_id > 0 then
		WPool = var_1

		local var_14_0 = var_1
		local var_14_1 = var_1.Get

		WorldMapPort = var_1_10004

		local var_14_2 = var_14_1(var_14_0, var_1_10004)

		var_1.Setup(var_14_2, arg_14_0.config.port_id[1])

		unpack = var_2

		local var_14_3, var_14_4 = var_2(arg_14_0.config.port_id[2])

		for iter_14_0 = var_14_3 - 1, var_14_3 + 1 do
			for iter_14_1 = var_14_4 - 1, var_14_4 + 1 do
				if (iter_14_0 ~= var_14_3 or iter_14_1 ~= var_14_4) and arg_14_0:GetCell(iter_14_0, iter_14_1) then
					local var_14_5 = var_12
					local var_14_6 = var_12.AddAttachment

					WorldMapAttachment = var_16

					var_14_6(var_14_5, var_16.MakeFakePort(iter_14_0, iter_14_1, var_1.id))
				end
			end
		end

		table = var_4

		var_4.insert(arg_14_0.ports, var_1)
	end

	return
end

function var_0_1.DisposePort(arg_15_0)
	WPool = var_1_10001

	var_1_10001:ReturnArray(arg_15_0.ports)

	arg_15_0.ports = {}

	return
end

function var_0_1.IsValid(arg_16_0)
	return arg_16_0.valid
end

function var_0_1.SetValid(arg_17_0, arg_17_1)
	arg_17_0.valid = arg_17_1

	if arg_17_1 and arg_17_0.fleets then
		ipairs = var_2

		for iter_17_0, iter_17_1 in var_2(arg_17_0:GetNormalFleets()) do
			arg_17_0.centerCellFOV = {
				row = iter_17_1.row,
				column = iter_17_1.column
			}

			local var_17_0 = arg_17_0
			local var_17_1 = arg_17_0.GetFleetTerrain(var_17_0, iter_17_1)

			WorldMapCell = var_8

			if var_17_1 ~= var_8.TerrainFog then
				WorldConst = var_17_1

				var_17_1.RangeCheck(iter_17_1, arg_17_0:GetFOVRange(iter_17_1), function(arg_18_0, arg_18_1)
					local var_18_0 = arg_17_0.cells

					WorldMapCell = var_2_10003

					if var_18_0[var_2_10003.GetName(arg_18_0, arg_18_1)] then
						var_2:ChangeInLight(true)
					end

					return
				end)
			elseif arg_17_0.findex == iter_17_0 then
				local var_17_2 = {}

				WorldConst = var_8

				var_8.RangeCheck(iter_17_1, arg_17_0:GetFOVRange(iter_17_1), function(arg_19_0, arg_19_1)
					WorldMapCell = var_2_10002

					local var_19_0 = var_2_10002.GetName(arg_19_0, arg_19_1)

					if arg_17_0.cells[var_19_0] then
						var_17_2[var_19_0] = true
					end

					return
				end)

				local var_17_3 = arg_17_0:IsFleetTerrainSairenFog(iter_17_1)

				pairs = var_17_0

				for iter_17_2, iter_17_3 in var_17_0(arg_17_0.cells) do
					iter_17_3:UpdateFog(true, var_17_2[iter_17_2], var_17_3)
				end
			end
		end
	end

	return
end

function var_0_1.IsMapOpen(arg_20_0)
	nowWorld = var_1_10001

	local var_20_0 = var_1_10001()

	return var_1.GetProgress(var_20_0) >= arg_20_0:GetOpenProgress()
end

function var_0_1.GetOpenProgress(arg_21_0)
	nowWorld = var_1_10001

	local var_21_0 = var_1_10001()
	local var_21_1

	if not (var_1.GetRealm(var_21_0) > 0) or not arg_21_0.config.open_stage[var_1] then
		var_21_1 = 9999
	end

	return var_21_1
end

function var_0_1.RemoveAllCellDiscovered(arg_22_0)
	pairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.cells) do
		iter_22_1:UpdateDiscovered(false)
	end

	return
end

function var_0_1.GetDanger(arg_23_0)
	return arg_23_0.config.hazard_level
end

function var_0_1.BindFleets(arg_24_0, arg_24_1)
	arg_24_0.fleets = arg_24_1

	return
end

function var_0_1.UnbindFleets(arg_25_0)
	arg_25_0.fleets = nil

	return
end

function var_0_1.GetFleets(arg_26_0)
	_ = var_1_10001

	return var_1_10001.rest(arg_26_0.fleets, 1)
end

function var_0_1.GetFleet(arg_27_0, arg_27_1)
	if arg_27_1 then
		_ = var_1_10002

		local var_27_0

		if not var_1_10002.detect(arg_27_0.fleets, function(arg_28_0)
			return arg_28_0.id == arg_27_1
		end) then
			var_27_0 = arg_27_0.fleets[arg_27_0.findex]
		end

		return var_27_0
	end
end

function var_0_1.GetNormalFleets(arg_29_0)
	_ = var_1_10001

	return var_1_10001.filter(arg_29_0.fleets, function(arg_30_0)
		local var_30_0 = arg_30_0:GetFleetType()

		FleetType = var_2_10002

		return var_30_0 == var_2_10002.Normal
	end)
end

function var_0_1.GetSubmarineFleet(arg_31_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_31_0.fleets, function(arg_32_0)
		local var_32_0 = arg_32_0:GetFleetType()

		FleetType = var_2_10002

		return var_32_0 == var_2_10002.Submarine
	end)
end

function var_0_1.FindFleet(arg_33_0, arg_33_1, arg_33_2)
	_ = var_1_10003

	return var_1_10003.detect(arg_33_0.fleets, function(arg_34_0)
		return arg_34_0.row == arg_33_1 and arg_34_0.column == arg_33_2
	end)
end

function var_0_1.CheckFleetMovable(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:GetCell(arg_35_1.row, arg_35_1.column)

	return var_2.CanLeave(var_35_0)
end

function var_0_1.GetFleetTerrain(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:GetCell(arg_36_1.row, arg_36_1.column)

	return var_2.GetTerrain(var_36_0)
end

function var_0_1.IsFleetTerrainSairenFog(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetCell(arg_37_1.row, arg_37_1.column)

	return var_2.IsTerrainSairenFog(var_37_0)
end

function var_0_1.RemoveFleetsCarries(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or arg_38_0.fleets
	_ = var_1_10002

	var_1_10002.each(arg_38_1, function(arg_39_0)
		arg_39_0:RemoveAllCarries()

		return
	end)

	return
end

function var_0_1.UpdateFleetIndex(arg_40_0, arg_40_1)
	if arg_40_0.findex ~= arg_40_1 then
		arg_40_0:CheckSelectFleetUpdateFog(function()
			arg_40_0.findex = arg_40_1

			return
		end)
		arg_40_0:DispatchEvent(var_0_1.EventUpdateFIndex)
	end

	return
end

function var_0_1.UpdateActive(arg_42_0, arg_42_1)
	nowWorld = var_1_10002

	local var_42_0 = var_1_10002()
	local var_42_1 = var_2.GetAtlas(var_42_0)

	if arg_42_0.active ~= arg_42_1 then
		arg_42_0.active = arg_42_1

		if arg_42_1 then
			arg_42_0:SetValid(false)
			var_42_1:SetActiveMap(arg_42_0)

			arg_42_0.isCost = true

			var_42_1:UpdateCostMap(arg_42_0.id, arg_42_0.isCost)
		elseif arg_42_0:NeedClear() then
			arg_42_0:RemoveAllCellDiscovered()

			arg_42_0.clearFlag = false
			arg_42_0.isCost = false

			var_42_1:UpdateCostMap(arg_42_0.id, arg_42_0.isCost)
		end

		arg_42_0:DispatchEvent(var_0_1.EventUpdateActive)
	end

	return
end

function var_0_1.InPort(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0:GetPort() or arg_43_2 and var_3.config.port_camp ~= arg_43_2 then
		return false
	end

	local var_43_0 = arg_43_0
	local var_43_1 = arg_43_0.GetFleet(var_43_0, arg_43_1)
	local var_43_2 = var_4.GetFleetType(var_43_1)

	FleetType = var_43_0

	if var_43_2 == var_43_0.Submarine then
		return var_3.id
	else
		local var_43_3 = arg_43_0:GetCell(var_4.row, var_4.column)

		if var_5.GetAliveAttachment(var_43_3) then
			local var_43_4 = var_6.type

			WorldMapAttachment = var_43_3

			if var_43_4 == var_43_3.TypePort then
				return var_6.id
			end
		end
	end

	return false
end

function var_0_1.canExit(arg_44_0)
	local var_44_0

	if arg_44_0.gid then
		pg = var_44_0
		var_44_0 = var_44_0.world_chapter_template_reset[arg_44_0.gid] ~= nil
	end

	return var_44_0
end

function var_0_1.CheckAttachmentTransport(arg_45_0)
	WorldConst = var_1_10001

	local var_45_0 = var_1_10001.GetTransportBlockEvent()
	local var_45_1 = arg_45_0
	local var_45_2 = arg_45_0.FindAttachments

	WorldMapAttachment = var_1_10005

	local var_45_3 = var_45_2(var_45_1, var_1_10005.TypeEvent)

	ipairs = var_1_10003

	for iter_45_0, iter_45_1 in var_1_10003(var_45_3) do
		if iter_45_1:IsAlive() and var_45_0[iter_45_1.id] then
			return "block"
		end
	end

	WorldConst = var_3

	local var_45_4 = var_3.GetTransportStoryEvent()

	ipairs = var_4

	for iter_45_2, iter_45_3 in var_4(var_45_3) do
		if iter_45_3:IsAlive() and var_45_4[iter_45_3.id] then
			return "story"
		end
	end

	return
end

function var_0_1.GetPort(arg_46_0, arg_46_1)
	if arg_46_1 then
		_ = var_1_10002

		local var_46_0

		if not var_1_10002.detect(arg_46_0.ports, function(arg_47_0)
			return arg_47_0.id == arg_46_1
		end) then
			var_46_0 = arg_46_0.ports[1]
		end

		return var_46_0
	end
end

function var_0_1.GetCell(arg_48_0, arg_48_1, arg_48_2)
	WorldMapCell = var_1_10003

	local var_48_0 = var_1_10003.GetName(arg_48_1, arg_48_2)

	return arg_48_0.cells[var_48_0]
end

function var_0_1.CalcTransportPos(arg_49_0, arg_49_1, arg_49_2)
	calcPositionAngle = var_1_10003

	local var_49_0 = var_1_10003(arg_49_1.config.area_pos[1] - arg_49_2.config.area_pos[1], arg_49_1.config.area_pos[2] - arg_49_2.config.area_pos[2])
	local var_49_1 = false

	if not arg_49_0.gid then
		var_49_1 = true
		arg_49_0.gid = arg_49_0.config.template_id[1][1]

		arg_49_0:SetupGrid(var_49_1)
	end

	local var_49_2 = {
		row = (arg_49_0.top + arg_49_0.bottom) / 2,
		column = (arg_49_0.left + arg_49_0.right) / 2
	}
	local var_49_3
	local var_49_4 = 4294967295
	local var_49_5

	for iter_49_0 = arg_49_0.left + 1, arg_49_0.right - 1 do
		math = var_1_10013
		var_1_10013 = var_1_10013.abs
		calcPositionAngle = var_1_10015

		if var_1_10013(var_1_10015(iter_49_0 - var_49_2.column, var_49_2.row - arg_49_0.top) - var_49_0) < var_49_4 then
			var_49_3 = {
				row = arg_49_0.top,
				column = iter_49_0
			}
			var_49_4 = var_8
		end

		math = var_1_10013
		var_1_10013 = var_1_10013.abs
		calcPositionAngle = var_1_10015

		if var_1_10013(var_1_10015(iter_49_0 - var_49_2.column, var_49_2.row - arg_49_0.bottom) - var_49_0) < var_49_4 then
			var_49_3 = {
				row = arg_49_0.bottom,
				column = iter_49_0
			}
			var_49_4 = var_8
		end
	end

	for iter_49_1 = arg_49_0.top + 1, arg_49_0.bottom - 1 do
		math = var_1_10013
		var_1_10013 = var_1_10013.abs
		calcPositionAngle = var_1_10015

		if var_1_10013(var_1_10015(arg_49_0.left - var_49_2.column, var_49_2.row - iter_49_1) - var_49_0) < var_49_4 then
			var_49_3 = {
				row = iter_49_1,
				column = arg_49_0.left
			}
			var_49_4 = var_8
		end

		math = var_1_10013
		var_1_10013 = var_1_10013.abs
		calcPositionAngle = var_1_10015

		if var_1_10013(var_1_10015(arg_49_0.right - var_49_2.column, var_49_2.row - iter_49_1) - var_49_0) < var_49_4 then
			var_49_3 = {
				row = iter_49_1,
				column = arg_49_0.right
			}
			var_49_4 = var_8
		end
	end

	if var_49_1 then
		arg_49_0:DisposeGrid(var_49_1)

		arg_49_0.gid = nil
	end

	return var_49_3
end

function var_0_1.AnyFleetInEdge(arg_50_0)
	local var_50_0

	if arg_50_0.active then
		_ = var_50_0
		var_50_0 = var_50_0.any(arg_50_0:GetNormalFleets(), function(arg_51_0)
			return arg_51_0.row == arg_50_0.top or arg_51_0.row == arg_50_0.bottom or arg_51_0.column == arg_50_0.left or arg_51_0.column == arg_50_0.right
		end)
	end

	return var_50_0
end

function var_0_1.CheckInteractive(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0
	local var_52_1 = arg_52_0.FindAttachments

	WorldMapAttachment = var_1_10005

	local var_52_2 = var_52_1(var_52_0, var_1_10005.TypeEvent)

	ipairs = var_1_10003

	for iter_52_0, iter_52_1 in var_1_10003(var_52_2) do
		var_1_10010 = iter_52_1

		if iter_52_1.RemainOpEffect(var_1_10010) then
			return iter_52_1
		end
	end

	ipairs = var_3

	for iter_52_2, iter_52_3 in var_3(var_52_2) do
		var_1_10010 = iter_52_3

		if iter_52_3.IsAlive(var_1_10010) then
			var_1_10010 = iter_52_3

			if iter_52_3.GetEventEffect(var_1_10010) then
				local var_52_3 = var_8.autoactivate

				if 0 < var_52_3 then
					return iter_52_3
				end
			end
		end
	end

	arg_52_1 = arg_52_1 or arg_52_0:GetFleet()

	local var_52_4 = arg_52_0

	if arg_52_0.GetCell(var_52_4, arg_52_1.row, arg_52_1.column).discovered then
		local var_52_5 = var_3:GetAliveAttachments()

		ipairs = var_52_4

		for iter_52_4, iter_52_5 in var_52_4(var_52_5) do
			WorldMapAttachment = var_1_10010

			if var_1_10010.IsInteractiveType(iter_52_5.type) and not iter_52_5:IsTriggered() then
				if iter_52_5:IsSign() then
					return nil
				else
					var_1_10010 = iter_52_5.type
					WorldMapAttachment = var_1_10011

					if var_1_10010 == var_1_10011.TypeEvent then
						if iter_52_5:GetEventEffect() and (var_1_10010.effective_num <= 1 or arg_52_0:CountEventEffectKeys(var_1_10010) >= var_1_10010.effective_num) then
							return iter_52_5
						end
					else
						return iter_52_5
					end
				end
			end
		end
	end

	return
end

function var_0_1.CheckDiscover(arg_53_0)
	local var_53_0 = {}
	local var_53_1 = arg_53_0.theme

	pairs = var_1_10003

	for iter_53_0, iter_53_1 in var_1_10003(arg_53_0.cells) do
		if not iter_53_1.discovered and iter_53_1:GetInFOV() then
			table = var_8

			var_8.insert(var_53_0, {
				row = iter_53_1.row,
				column = iter_53_1.column
			})
		end
	end

	return var_53_0
end

function var_0_1.CheckDisplay(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_1.type

	WorldMapAttachment = var_1_10003

	if var_54_0 == var_1_10003.TypeTrap then
		return true
	end

	local var_54_1 = arg_54_0:GetCell(arg_54_1.row, arg_54_1.column)

	return var_2.GetDisplayAttachment(var_54_1) == arg_54_1
end

function var_0_1.GetFOVRange(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	arg_55_2 = arg_55_2 or arg_55_1.row
	arg_55_3 = arg_55_3 or arg_55_1.column

	local var_55_0 = arg_55_0
	local var_55_1 = arg_55_0.GetCell(var_55_0, arg_55_2, arg_55_3)
	local var_55_2 = var_4.GetTerrain(var_55_1)

	WorldMapCell = var_55_0

	local var_55_3

	if var_55_2 ~= var_55_0.TerrainFog or not var_4.terrainStrong then
		var_55_3 = arg_55_1:GetFOVRange()
	end

	return var_55_3
end

function var_0_1.UpdateVisionFlag(arg_56_0, arg_56_1)
	arg_56_0.visionFlag = arg_56_1

	arg_56_0:OrderAROpenFOV(arg_56_0.visionFlag)

	return
end

function var_0_1.UpdatePressingMark(arg_57_0, arg_57_1)
	tobool = var_1_10002

	local var_57_0 = var_1_10002(arg_57_0.isPressing)

	tobool = var_1_10003

	if var_57_0 ~= var_1_10003(arg_57_1) then
		arg_57_0.isPressing = arg_57_1
		nowWorld = var_57_0

		local var_57_1 = var_57_0()
		local var_57_2 = var_2.GetTaskProxy(var_57_1)

		var_2.doUpdateTaskByMap(var_57_2, arg_57_0.id, arg_57_1)
	end

	return
end

function var_0_1.ExistAny(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0:GetCell(arg_58_1, arg_58_2)
	local var_58_1

	if not var_3.GetAliveAttachment(var_58_0) then
		var_58_1 = arg_58_0:ExistFleet(arg_58_1, arg_58_2)
	end

	return var_58_1
end

function var_0_1.ExistFleet(arg_59_0, arg_59_1, arg_59_2)
	tobool = var_1_10003

	return var_1_10003(arg_59_0:FindFleet(arg_59_1, arg_59_2))
end

function var_0_1.CalcFleetSpeed(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_1:GetSpeed()
	local var_60_1 = arg_60_0
	local var_60_2 = arg_60_0.GetCell(var_60_1, arg_60_1.row, arg_60_1.column)
	local var_60_3 = var_3.GetTerrain(var_60_2)

	WorldMapCell = var_60_1

	if var_60_3 == var_60_1.TerrainFog then
		math = var_60_3
		var_60_0 = var_60_3.min(var_60_0, 1)
	end

	return var_60_0
end

function var_0_1.FindPath(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	local var_61_2

	if not var_0_1.pathFinder then
		PathFinding = var_1_10005

		local var_61_0 = var_1_10005.New

		var_1_10007 = {}
		WorldConst = var_1_10008

		local var_61_1 = var_1_10008.MaxRow

		WorldConst = var_1_10009
		var_61_2 = var_61_0(var_1_10007, var_61_1, var_1_10009.MaxColumn)
		var_0_1.pathFinder = var_61_2
	end

	local var_61_3 = {}
	local var_61_4 = 0

	WorldConst = var_1_10007

	for iter_61_0 = var_61_4, var_1_10007.MaxRow - 1 do
		if not var_61_3[iter_61_0] then
			var_61_3[iter_61_0] = {}
		end

		local var_61_5 = 0

		WorldConst = var_1_10011

		for iter_61_1 = var_61_5, var_1_10011.MaxColumn - 1 do
			PathFinding = var_1_10014
			var_1_10014 = var_1_10014.PrioForbidden

			if arg_61_0:IsWalkable(iter_61_0, iter_61_1) then
				if arg_61_3 then
					local var_61_6 = arg_61_0:GetCell(iter_61_0, iter_61_1)

					if var_15.GetInFOV(var_61_6) then
						PathFinding = var_15
						var_1_10014 = var_15.PrioNormal

						if iter_61_0 == arg_61_2.row and iter_61_1 == arg_61_2.column then
							if not arg_61_0:IsStayPoint(iter_61_0, iter_61_1) then
								PathFinding = var_15
								var_1_10014 = var_15.PrioObstacle
							end
						elseif arg_61_0:IsObstacle(iter_61_0, iter_61_1) then
							PathFinding = var_15
							var_1_10014 = var_15.PrioObstacle
						end
					end

					var_61_3[iter_61_0][iter_61_1] = var_1_10014
				end
			end
		end
	end

	var_61_2.cells = var_61_3

	return var_61_2:Find(arg_61_1, arg_61_2)
end

function var_0_1.FindAIPath(arg_62_0, arg_62_1, arg_62_2)
	local var_62_2

	if not var_0_1.pathFinder then
		PathFinding = var_1_10004

		local var_62_0 = var_1_10004.New

		var_1_10006 = {}
		WorldConst = var_1_10007

		local var_62_1 = var_1_10007.MaxRow

		WorldConst = var_1_10008
		var_62_2 = var_62_0(var_1_10006, var_62_1, var_1_10008.MaxColumn)
		var_0_1.pathFinder = var_62_2
	end

	local var_62_3 = {}
	local var_62_4 = 0

	WorldConst = var_1_10006

	for iter_62_0 = var_62_4, var_1_10006.MaxRow - 1 do
		if not var_62_3[iter_62_0] then
			var_62_3[iter_62_0] = {}
		end

		local var_62_5 = 0

		WorldConst = var_1_10010

		for iter_62_1 = var_62_5, var_1_10010.MaxColumn - 1 do
			PathFinding = var_1_10013
			var_1_10013 = var_1_10013.PrioForbidden

			if arg_62_0:IsWalkable(iter_62_0, iter_62_1) then
				PathFinding = var_14
				var_1_10013 = var_14.PrioNormal

				if (iter_62_0 ~= arg_62_2.row or iter_62_1 ~= arg_62_2.column) and arg_62_0:ExistFleet(iter_62_0, iter_62_1) then
					PathFinding = var_14
					var_1_10013 = var_14.PrioObstacle
				end
			end

			var_62_3[iter_62_0][iter_62_1] = var_1_10013
		end
	end

	var_62_2.cells = var_62_3

	return var_62_2:Find(arg_62_1, arg_62_2)
end

function var_0_1.GetMoveRange(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_1.row
	local var_63_1 = arg_63_1.column
	local var_63_2 = arg_63_0:CalcFleetSpeed(arg_63_1)
	local var_63_3 = {}
	local var_63_4 = 0

	WorldConst = var_7

	for iter_63_0 = var_63_4, var_7.MaxRow - 1 do
		if not var_63_3[iter_63_0] then
			var_63_3[iter_63_0] = {}
		end

		local var_63_5 = 0

		WorldConst = var_1_10011

		for iter_63_1 = var_63_5, var_1_10011.MaxColumn - 1 do
			var_63_3[iter_63_0][iter_63_1] = arg_63_0:IsWalkable(iter_63_0, iter_63_1)
		end
	end

	local var_63_6 = {}
	local var_63_7 = {
		{
			step = 0,
			row = var_63_0,
			column = var_63_1
		}
	}

	var_63_3[var_63_0][var_63_1] = false

	::label_63_0::

	local var_63_8 = #var_63_7

	if 0 < var_63_8 then
		repeat
			table = var_63_8
			var_63_8 = var_63_8.remove(var_63_7, 1)
			table = var_63_9

			var_63_9.insert(var_63_6, var_63_8)

			local var_63_9 = {
				{
					row = 1,
					column = 0
				},
				{
					row = -1,
					column = 0
				},
				{
					row = 0,
					column = 1
				},
				{
					row = 0,
					column = -1
				}
			}

			_ = var_10

			var_10.each(var_63_9, function(arg_64_0)
				arg_64_0.row = var_63_8.row + arg_64_0.row
				arg_64_0.column = var_63_8.column + arg_64_0.column
				arg_64_0.step = var_63_8.step + 1

				local var_64_0 = arg_64_0.row

				if 0 <= var_64_0 then
					local var_64_1 = arg_64_0.row

					WorldConst = var_2

					if var_64_1 < var_2.MaxRow then
						local var_64_2 = arg_64_0.column

						if 0 <= var_64_2 then
							local var_64_3 = arg_64_0.column

							WorldConst = var_2

							if var_64_3 < var_2.MaxColumn and arg_64_0.step <= var_63_2 and var_63_3[arg_64_0.row][arg_64_0.column] then
								var_63_3[arg_64_0.row][arg_64_0.column] = false

								local var_64_4 = arg_63_0

								if var_1.IsObstacle(var_64_4, arg_64_0.row, arg_64_0.column) then
									table = var_1

									var_1.insert(var_63_6, arg_64_0)
								else
									table = var_1

									var_1.insert(var_63_7, arg_64_0)
								end
							end
						end
					end
				end

				return
			end)

			goto label_63_0
		until true
	end

	_ = var_63_8

	return (var_63_8.filter(var_63_6, function(arg_65_0)
		local var_65_0 = arg_63_0

		return var_1.IsStayPoint(var_65_0, arg_65_0.row, arg_65_0.column)
	end))
end

function var_0_1.BuildLongMoveInfos(arg_66_0)
	local var_66_0 = {}
	local var_66_1 = 0

	WorldConst = var_1_10003

	for iter_66_0 = var_66_1, var_1_10003.MaxRow - 1 do
		local var_66_2

		if not var_66_0[iter_66_0] then
			var_66_2 = {}
		end

		var_66_0[iter_66_0] = var_66_2

		local var_66_3 = 0

		WorldConst = var_1_10007

		for iter_66_1 = var_66_3, var_1_10007.MaxColumn - 1 do
			if arg_66_0:IsWalkable(iter_66_0, iter_66_1) then
				local var_66_4 = arg_66_0:GetCell(iter_66_0, iter_66_1)

				if var_10.GetInFOV(var_66_4) then
					var_66_0[iter_66_0][iter_66_1] = {
						isFinish = false,
						isMark = false,
						row = iter_66_0,
						column = iter_66_1,
						dp = {},
						last = {},
						isStayPoint = arg_66_0:IsStayPoint(iter_66_0, iter_66_1),
						isObstacle = arg_66_0:IsObstacle(iter_66_0, iter_66_1)
					}
				end
			end
		end
	end

	return var_66_0
end

function var_0_1.GetLongMoveRange(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_1.row
	local var_67_1 = arg_67_1.column
	local var_67_2 = arg_67_0:CalcFleetSpeed(arg_67_1)
	local var_67_3 = arg_67_0:BuildLongMoveInfos()
	local var_67_4 = {}
	local var_67_5 = {}
	local var_67_6 = {
		{
			row = 1,
			column = 0
		},
		{
			row = -1,
			column = 0
		},
		{
			row = 0,
			column = 1
		},
		{
			row = 0,
			column = -1
		}
	}

	local function var_67_7(arg_68_0, arg_68_1, arg_68_2)
		return arg_68_0 < arg_68_1 or arg_68_2 < arg_68_0
	end

	local function var_67_8(arg_69_0)
		if not arg_69_0 then
			return
		end

		arg_69_0.isFinish = true
		table = var_1

		var_1.insert(var_67_4, arg_69_0)

		if arg_69_0.isStayPoint then
			local var_69_0 = arg_69_0.dp

			for iter_69_0 = 1, var_67_2 do
				if var_69_0[iter_69_0] and (not var_69_0[0] or var_69_0[0] > var_69_0[iter_69_0] + 1) then
					var_69_0[0] = var_69_0[iter_69_0] + 1
					arg_69_0.last[0] = arg_69_0.last[iter_69_0]
				end
			end
		end

		return
	end

	var_67_3[var_67_0][var_67_1].dp[0] = 0
	var_67_9.isMark = true

	var_67_8(var_67_9)

	while var_67_9 do
		_ = var_12

		var_12.each(var_67_6, function(arg_70_0)
			local var_70_0 = var_67_7
			local var_70_1 = var_67_9.row + arg_70_0.row
			local var_70_2 = 0

			WorldConst = var_2_10005

			if not var_70_0(var_70_1, var_70_2, var_2_10005.MaxRow - 1) then
				local var_70_3 = var_67_7
				local var_70_4 = var_67_9.column + arg_70_0.column
				local var_70_5 = 0

				WorldConst = var_5

				if var_70_3(var_70_4, var_70_5, var_5.MaxColumn - 1) then
					return
				end

				if var_67_3[var_67_9.row + arg_70_0.row][var_67_9.column + arg_70_0.column] and not var_1.isFinish then
					for iter_70_0 = 1, var_67_2 do
						if var_67_9.dp[iter_70_0 - 1] and (not var_1.dp[iter_70_0] or var_1.dp[iter_70_0] > var_67_9.dp[iter_70_0 - 1]) then
							var_1.dp[iter_70_0] = var_67_9.dp[iter_70_0 - 1]
							var_1.last[iter_70_0] = {
								var_67_9,
								iter_70_0 - 1
							}

							if not var_1.isMark then
								var_1.isMark = true
								table = var_6

								var_6.insert(var_67_5, var_1)
							end
						end
					end
				end

				return
			end
		end)

		repeat
			table = var_12

			local var_67_9 = var_12.remove(var_67_5, 1)

			var_67_8(var_67_9)
		until not var_67_9 or not var_67_9.isObstacle
	end

	local var_67_10 = {}

	ipairs = var_13

	for iter_67_0, iter_67_1 in var_13(var_67_4) do
		if iter_67_1.dp[0] and iter_67_1.dp[0] > 0 then
			table = var_18

			var_18.insert(var_67_10, {
				row = iter_67_1.row,
				column = iter_67_1.column,
				stay = iter_67_1.dp[0]
			})
		end
	end

	return var_67_10, var_67_3
end

function var_0_1.IsWalkable(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0

	if arg_71_0:GetCell(arg_71_1, arg_71_2) and var_3.walkable and not var_3:CanLeave() then
		var_71_0 = arg_71_0:IsStayPoint(arg_71_1, arg_71_2)
	end

	return var_71_0
end

function var_0_1.IsStayPoint(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = arg_72_0:GetCell(arg_72_1, arg_72_2)
	local var_72_1

	if var_3.CanArrive(var_72_0) then
		var_72_1 = not arg_72_0:ExistFleet(arg_72_1, arg_72_2)
	end

	return var_72_1
end

function var_0_1.IsObstacle(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = arg_73_0:GetCell(arg_73_1, arg_73_2)

	return not var_3.CanPass(var_73_0)
end

function var_0_1.IsSign(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_0:GetCell(arg_74_1, arg_74_2)

	return var_3.IsSign(var_74_0)
end

function var_0_1.FindNearestBlankPoint(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = {}
	local var_75_1 = 0

	WorldConst = var_1_10005

	for iter_75_0 = var_75_1, var_1_10005.MaxRow - 1 do
		if not var_75_0[iter_75_0] then
			var_75_0[iter_75_0] = {}
		end

		local var_75_2 = 0

		WorldConst = var_1_10009

		for iter_75_1 = var_75_2, var_1_10009.MaxColumn - 1 do
			var_75_0[iter_75_0][iter_75_1] = arg_75_0:IsWalkable(iter_75_0, iter_75_1)
		end
	end

	local var_75_3 = {
		row = arg_75_1,
		column = arg_75_2
	}
	local var_75_4 = {}

	::label_75_0::

	local var_75_5 = #var_75_3

	if 0 < var_75_5 then
		repeat
			table = var_75_5
			var_75_5 = var_75_5.remove(var_75_3, 1)
			table = var_75_6

			var_75_6.insert(var_75_4, var_75_5)

			local var_75_6 = {
				{
					row = 1,
					column = 0
				},
				{
					row = -1,
					column = 0
				},
				{
					row = 0,
					column = 1
				},
				{
					row = 0,
					column = -1
				}
			}

			_ = var_8

			var_8.each(var_75_6, function(arg_76_0)
				arg_76_0.row = var_75_5.row + arg_76_0.row
				arg_76_0.column = var_75_5.column + arg_76_0.column

				local var_76_0 = arg_76_0.row

				if 0 <= var_76_0 then
					local var_76_1 = arg_76_0.row

					WorldConst = var_2

					if var_76_1 < var_2.MaxRow then
						local var_76_2 = arg_76_0.column

						if 0 <= var_76_2 then
							local var_76_3 = arg_76_0.column

							WorldConst = var_2

							if var_76_3 < var_2.MaxColumn then
								_ = var_76_3

								local var_76_4

								if not var_76_3.any(var_75_3, function(arg_77_0)
									return arg_77_0.row == arg_76_0.row and arg_77_0.column == arg_76_0.column
								end) then
									_ = var_76_4
									var_76_4 = var_76_4.any(var_75_4, function(arg_78_0)
										return arg_78_0.row == arg_76_0.row and arg_78_0.column == arg_76_0.column
									end)
								end

								if not var_76_4 and var_75_0[arg_76_0.row][arg_76_0.column] then
									local var_76_5 = arg_75_0

									if var_2.ExistAny(var_76_5, arg_76_0.row, arg_76_0.column) then
										table = var_2

										var_2.insert(var_75_3, arg_76_0)
									else
										return arg_76_0
									end
								end
							end
						end
					end
				end

				return
			end)

			goto label_75_0
		until true
	end

	return
end

function var_0_1.WriteBack(arg_79_0, arg_79_1, arg_79_2)
	local var_79_0 = arg_79_0
	local var_79_1 = arg_79_0.GetFleet(var_79_0)
	local var_79_2 = {}

	ipairs = var_79_0

	for iter_79_0, iter_79_1 in var_79_0(var_79_1:GetShips(true)) do
		table = var_10

		var_10.insert(var_79_2, iter_79_1)
	end

	if arg_79_2.statistics.submarineAid then
		local var_79_3 = arg_79_0
		local var_79_4 = arg_79_0.GetSubmarineFleet(var_79_3)

		assert = var_6

		var_6(var_79_4, "submarine fleet not exist.")

		local var_79_5 = var_79_4
		local var_79_6 = var_79_4.GetTeamShips

		TeamType = var_9

		local var_79_7 = var_79_6(var_79_5, var_9.Submarine, true)

		ipairs = var_79_3

		for iter_79_2, iter_79_3 in var_79_3(var_79_7) do
			table = var_1_10012

			var_1_10012.insert(var_79_2, iter_79_3)
		end

		var_79_4:UseAmmo()
		var_79_4:AddDefeatEnemies(arg_79_1)
	end

	var_79_1:AddDefeatEnemies(arg_79_1)

	_ = var_5

	var_5.each(var_79_2, function(arg_80_0)
		if arg_79_2.statistics[arg_80_0.id] then
			arg_80_0.hpRant = var_1.bp
		end

		if arg_80_0.hpRant <= 0 then
			arg_80_0:Rebirth()
		end

		return
	end)

	local var_79_8 = arg_79_0
	local var_79_9 = arg_79_0.GetCell(var_79_8, var_79_1.row, var_79_1.column)
	local var_79_10 = var_5.GetStageEnemy(var_79_9)

	assert = var_79_8

	var_79_8(var_79_10)

	if arg_79_1 then
		var_79_10:UpdateFlag(1)

		table = var_79_8
		arg_79_0.phaseDisplayList = var_79_8.mergeArray(arg_79_0.phaseDisplayList, var_79_10:SetHP(0))
		var_79_8 = false
		_ = var_79_9

		var_79_9.each(arg_79_0:GetFleets(), function(arg_81_0)
			local var_81_0

			if not var_79_8 then
				var_81_0 = arg_81_0:HasDamageLevel()
			end

			var_79_8 = var_81_0

			arg_81_0:ClearDamageLevel()

			return
		end)

		if var_79_8 then
			table = var_8

			var_8.insert(arg_79_0.phaseDisplayList, 1, {
				story = "W1500",
				hp = var_79_10:GetMaxHP()
			})
		end
	else
		arg_79_0.isLoss = true

		var_79_1:IncDamageLevel(var_79_10)
		var_79_10:UpdateData(var_79_10.data - 1)

		table = var_79_8
		arg_79_0.phaseDisplayList = var_79_8.mergeArray(arg_79_0.phaseDisplayList, var_79_10:SetHP(arg_79_2.statistics._maxBossHP))
		nowWorld = var_79_8

		if var_79_8().isAutoFight then
			var_79_8:TriggerAutoFight(false)

			pg = var_8

			local var_79_11 = var_8.TipsMgr.GetInstance()
			local var_79_12 = var_8.ShowTips

			i18n = var_11

			var_79_12(var_79_11, var_11("autofight_tip_bigworld_dead"))
		end
	end

	_ = var_79_8

	var_79_8.each(arg_79_2.hpDropInfo, function(arg_82_0)
		local var_82_0 = #arg_79_0.phaseDisplayList + 1

		ipairs = var_2_10002

		for iter_82_0, iter_82_1 in var_2_10002(arg_79_0.phaseDisplayList) do
			if iter_82_1.hp < arg_82_0.hp then
				var_82_0 = iter_82_0

				break
			end
		end

		local var_82_1 = arg_79_0
		local var_82_2 = var_2.AddPhaseDisplay
		local var_82_3 = {
			hp = arg_82_0.hp
		}

		PlayerConst = var_6
		var_82_3.drops = var_6.addTranDrop(arg_82_0.drop_info)

		var_82_2(var_82_1, var_82_3, var_82_0)

		return
	end)

	return
end

function var_0_1.AddPhaseDisplay(arg_83_0, arg_83_1, arg_83_2)
	if arg_83_2 then
		table = var_1_10003

		var_1_10003.insert(arg_83_0.phaseDisplayList, arg_83_2, arg_83_1)
	else
		table = var_1_10003

		var_1_10003.insert(arg_83_0.phaseDisplayList, arg_83_1)
	end

	return
end

function var_0_1.FindAttachments(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = {}

	pairs = var_1_10004

	for iter_84_0, iter_84_1 in var_1_10004(arg_84_0.typeAttachments) do
		if not arg_84_1 or arg_84_1 == iter_84_0 then
			ipairs = var_1_10009

			for iter_84_2, iter_84_3 in var_1_10009(iter_84_1) do
				if not arg_84_2 or iter_84_3.id == arg_84_2 then
					table = var_1_10014

					var_1_10014.insert(var_84_0, iter_84_3)
				end
			end
		end
	end

	return var_84_0
end

function var_0_1.FindEnemys(arg_85_0)
	local var_85_0 = {}

	pairs = var_1_10002

	for iter_85_0, iter_85_1 in var_1_10002(arg_85_0.typeAttachments) do
		WorldMapAttachment = var_1_10007

		if var_1_10007.IsEnemyType(iter_85_0) then
			table = var_1_10007
			var_85_0 = var_1_10007.mergeArray(var_85_0, iter_85_1)
		end
	end

	return var_85_0
end

function var_0_1.GetMapMinMax(arg_86_0)
	Vector2 = var_1_10001
	WorldConst = var_1_10003

	local var_86_0 = var_1_10003.MaxColumn

	WorldConst = var_1_10004

	local var_86_1 = var_1_10001(var_86_0, var_1_10004.MaxRow)

	Vector2 = var_1_10002
	WorldConst = var_4

	local var_86_2 = -var_4.MaxColumn

	WorldConst = var_1_10005

	local var_86_3 = var_1_10002(var_86_2, -var_1_10005.MaxRow)
	local var_86_4 = 0

	WorldConst = var_86_2

	for iter_86_0 = var_86_4, var_86_2.MaxRow - 1 do
		local var_86_5 = 0

		WorldConst = var_1_10008

		for iter_86_1 = var_86_5, var_1_10008.MaxColumn - 1 do
			if arg_86_0:GetCell(iter_86_0, iter_86_1) then
				math = var_1_10012
				var_86_1.x = var_1_10012.min(var_86_1.x, iter_86_1)
				math = var_1_10012
				var_86_1.y = var_1_10012.min(var_86_1.y, iter_86_0)
				math = var_1_10012
				var_86_3.x = var_1_10012.max(var_86_3.x, iter_86_1)
				math = var_1_10012
				var_86_3.y = var_1_10012.max(var_86_3.y, iter_86_0)
			end
		end
	end

	return var_86_1.y, var_86_3.y, var_86_1.x, var_86_3.x
end

function var_0_1.GetMapSize(arg_87_0)
	local var_87_0, var_87_1, var_87_2, var_87_3 = arg_87_0:GetMapMinMax()

	return var_87_1 - var_87_0 + 1, var_87_3 - var_87_2 + 1
end

function var_0_1.CountEventEffectKeys(arg_88_0, arg_88_1)
	local var_88_0 = 0

	ipairs = var_1_10003

	for iter_88_0, iter_88_1 in var_1_10003(arg_88_0:GetNormalFleets()) do
		local var_88_1 = arg_88_0:GetCell(iter_88_1.row, iter_88_1.column)

		if var_8.GetAliveAttachment(var_88_1) then
			local var_88_2 = var_9.type

			WorldMapAttachment = var_88_1

			if var_88_2 == var_88_1.TypeEvent and var_9:GetEventEffect() == arg_88_1 then
				var_88_0 = var_88_0 + 1
			end
		end
	end

	return var_88_0
end

function var_0_1.EventEffectOpenFOV(arg_89_0, arg_89_1)
	assert = var_1_10002

	local var_89_0 = arg_89_1.effect_type

	WorldMapAttachment = var_1_10005

	var_1_10002(var_89_0 == var_1_10005.EffectEventFOV)

	unpack = var_1_10002

	local var_89_1, var_89_2 = var_1_10002(arg_89_1.effect_paramater)

	if not (var_89_2 >= 0) or not var_89_2 then
		math = var_5
		var_89_2 = var_5.abs(var_89_2) - 1
	end

	local var_89_3 = arg_89_0
	local var_89_4 = arg_89_0.FindAttachments

	WorldMapAttachment = var_1_10008

	local var_89_5 = var_89_4(var_89_3, var_1_10008.TypeEvent, var_89_1)

	_ = var_1_10006

	var_1_10006.each(var_89_5, function(arg_90_0)
		local var_90_0 = arg_89_0

		var_90_0.centerCellFOV = {
			row = arg_90_0.row,
			column = arg_90_0.column
		}
		math = var_90_0

		local var_90_1 = var_90_0.max(arg_90_0.row - var_89_2, 0)

		math = var_2

		local var_90_2 = var_2.min
		local var_90_3 = arg_90_0.row + var_89_2

		WorldConst = var_5

		for iter_90_0 = var_90_1, var_90_2(var_90_3, var_5.MaxRow - 1) do
			math = var_90_4

			local var_90_4 = var_90_4.max(arg_90_0.column - var_89_2, 0)

			math = var_2_10006
			var_2_10006 = var_2_10006.min

			local var_90_5 = arg_90_0.column + var_89_2

			WorldConst = var_9

			for iter_90_1 = var_90_4, var_2_10006(var_90_5, var_9.MaxColumn - 1) do
				WorldConst = var_9

				if var_9.InFOVRange(arg_90_0.row, arg_90_0.column, iter_90_0, iter_90_1, var_89_2) then
					local var_90_6 = arg_89_0

					if var_9.GetCell(var_90_6, iter_90_0, iter_90_1) then
						local var_90_9

						if var_0 then
							local var_90_7 = var_9
							local var_90_8 = var_9.UpdateInFov

							bit = var_90_9
							var_90_9 = var_90_9.bor

							local var_90_10 = var_9.infov

							WorldConst = var_2_10016

							var_90_8(var_90_7, var_90_9(var_90_10, var_2_10016.FOVEventEffect))
						else
							local var_90_11 = var_9
							local var_90_12 = var_9.UpdateInFov

							bit = var_90_9

							local var_90_13 = var_90_9.band
							local var_90_14 = var_9.infov

							WorldConst = var_2_10016
							var_2_10016 = var_2_10016.Flag16Max
							WorldConst = var_2_10017

							var_90_12(var_90_11, var_90_13(var_90_14, var_2_10016 - var_2_10017.FOVEventEffect))
						end
					end
				end
			end
		end

		return
	end)

	return
end

function var_0_1.OrderAROpenFOV(arg_91_0, arg_91_1)
	if arg_91_1 then
		var_1_10002 = arg_91_0:GetFleet()
		arg_91_0.centerCellFOV = {
			row = var_1_10002.row,
			column = var_1_10002.column
		}
	end

	pairs = var_1_10002

	for iter_91_0, iter_91_1 in var_1_10002(arg_91_0.cells) do
		if arg_91_1 then
			local var_91_0 = iter_91_1
			local var_91_1 = iter_91_1.UpdateInFov

			bit = var_1_10010
			var_1_10010 = var_1_10010.bor

			local var_91_2 = iter_91_1.infov

			WorldConst = var_1_10013

			var_91_1(var_91_0, var_1_10010(var_91_2, var_1_10013.FOVEventEffect))
		else
			local var_91_3 = iter_91_1
			local var_91_4 = iter_91_1.UpdateInFov

			bit = var_1_10010
			var_1_10010 = var_1_10010.band

			local var_91_5 = iter_91_1.infov

			WorldConst = var_1_10013
			var_1_10013 = var_1_10013.Flag16Max
			WorldConst = var_1_10014

			var_91_4(var_91_3, var_1_10010(var_91_5, var_1_10013 - var_1_10014.FOVEventEffect))
		end
	end

	return
end

function var_0_1.GetMaxDistanceCell(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0
	local var_92_1 = 0
	local var_92_2 = {
		{
			row = arg_92_0.top,
			column = arg_92_0.left
		},
		{
			row = arg_92_0.bottom,
			column = arg_92_0.left
		},
		{
			row = arg_92_0.top,
			column = arg_92_0.right
		},
		{
			row = arg_92_0.bottom,
			column = arg_92_0.right
		}
	}

	pairs = var_6

	for iter_92_0, iter_92_1 in var_6(var_92_2) do
		if var_92_1 < (iter_92_1.row - arg_92_1) * (iter_92_1.row - arg_92_1) + (iter_92_1.column - arg_92_2) * (iter_92_1.column - arg_92_2) then
			var_92_0 = iter_92_1
			var_92_1 = var_11
		end
	end

	local var_92_3 = var_92_0

	math = var_7

	local var_92_4 = var_7.sqrt(var_92_1)
end

function var_0_1.GetCellsInFOV(arg_93_0)
	local var_93_0 = {}

	pairs = var_1_10002

	for iter_93_0, iter_93_1 in var_1_10002(arg_93_0.cells) do
		if iter_93_1:GetInFOV() then
			table = var_7

			var_7.insert(var_93_0, iter_93_1)
		end
	end

	return var_93_0
end

function var_0_1.AlwaysInFOV(arg_94_0)
	return arg_94_0.config.map_sight == 1
end

function var_0_1.GetEventTipWord(arg_95_0)
	local var_95_0 = arg_95_0
	local var_95_1 = arg_95_0.FindAttachments

	WorldMapAttachment = var_1_10004

	local var_95_2 = var_95_1(var_95_0, var_1_10004.TypeEvent)
	local var_95_3 = ""
	local var_95_4 = 0

	ipairs = var_4

	for iter_95_0, iter_95_1 in var_4(var_95_2) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.world_event_desc[iter_95_1.id]

		if iter_95_1:IsAlive() and var_1_10009 and var_95_4 < var_1_10009.hint_pri then
			var_95_4 = var_1_10009.hint_pri
			var_95_3 = var_1_10009.hint
		end
	end

	return var_95_3, var_95_4
end

function var_0_1.GetEventPoisonRate(arg_96_0)
	local var_96_0 = arg_96_0
	local var_96_1 = arg_96_0.FindAttachments

	WorldMapAttachment = var_1_10004

	local var_96_2 = var_96_1(var_96_0, var_1_10004.TypeEvent)
	local var_96_3 = 0

	ipairs = var_96_0

	for iter_96_0, iter_96_1 in var_96_0(var_96_2) do
		if iter_96_1:IsAlive() then
			var_96_3 = var_96_3 + iter_96_1.config.infection_value
		end
	end

	return var_96_3, arg_96_0.config.is_sairen
end

function var_0_1.GetPressingLevel(arg_97_0)
	return arg_97_0.config.complete_effect
end

function var_0_1.CheckMapPressing(arg_98_0)
	return arg_98_0:GetPressingLevel() > 0 and not arg_98_0.isPressing and arg_98_0:GetEventPoisonRate() == 0
end

function var_0_1.CheckMapPressingDisplay(arg_99_0)
	return arg_99_0:GetPressingLevel() > 1
end

function var_0_1.UpdateClearFlag(arg_100_0, arg_100_1)
	tobool = var_1_10002
	arg_100_0.clearFlag = var_1_10002(arg_100_1)

	return
end

function var_0_1.IsUnlockFleetMode(arg_101_0)
	if arg_101_0.config.move_switch == 1 then
		return true
	elseif arg_101_0.config.move_switch == 0 then
		return false
	else
		assert = var_1

		var_1(false, "config error")
	end

	return
end

function var_0_1.CheckFleetSalvage(arg_102_0, arg_102_1)
	underscore = var_1_10002

	if var_1_10002.detect(arg_102_0:GetFleets(), function(arg_103_0)
		local var_103_0

		if arg_103_0:IsCatSalvage() and not arg_102_1 and not arg_103_0:IsSalvageFinish() and not arg_102_0.salvageAutoResult then
			var_103_0 = arg_103_0.catSalvageFrom ~= arg_102_0.id
		end

		return var_103_0
	end) then
		return var_2.id
	else
		arg_102_0.salvageAutoResult = false
	end

	return
end

function var_0_1.GetChapterAuraBuffs(arg_104_0)
	local var_104_0 = {}

	ipairs = var_1_10002

	for iter_104_0, iter_104_1 in var_1_10002(arg_104_0.fleets) do
		local var_104_1 = iter_104_1:getMapAura()

		ipairs = var_1_10008

		for iter_104_2, iter_104_3 in var_1_10008(var_104_1) do
			table = var_1_10013

			var_1_10013.insert(var_104_0, iter_104_3)
		end
	end

	return var_104_0
end

function var_0_1.GetChapterAidBuffs(arg_105_0)
	local var_105_0 = {}

	ipairs = var_1_10002

	for iter_105_0, iter_105_1 in var_1_10002(arg_105_0.fleets) do
		if iter_105_0 ~= arg_105_0.findex then
			local var_105_1 = iter_105_1:getMapAid()

			pairs = var_1_10008

			for iter_105_2, iter_105_3 in var_1_10008(var_105_1) do
				var_105_0[iter_105_2] = iter_105_3
			end
		end
	end

	return var_105_0
end

function var_0_1.getFleetBattleBuffs(arg_106_0, arg_106_1, arg_106_2)
	local var_106_0 = {}

	underscore = var_1_10004

	var_1_10004.each(arg_106_1:GetBuffList(), function(arg_107_0)
		if arg_107_0.config.lua_id ~= 0 then
			table = var_2_10002

			var_2_10002.insert(var_106_0, var_1)
		end

		return
	end)

	local var_106_1 = {}

	if arg_106_2 and arg_106_1:IsCatSalvage() then
		-- block empty
	else
		var_106_1 = arg_106_0:BuildBattleBuffList(arg_106_1)
	end

	return var_106_0, var_106_1
end

function var_0_1.BuildBattleBuffList(arg_108_0, arg_108_1)
	local var_108_0 = {}
	local var_108_1 = arg_108_0
	local var_108_2 = arg_108_0.triggerSkill
	local var_108_3 = arg_108_1

	FleetSkill = var_1_10007

	local var_108_4, var_108_5 = var_108_2(var_108_1, var_108_3, var_1_10007.TypeBattleBuff)

	if var_108_4 then
		local var_108_6 = #var_108_4

		if 0 < var_108_6 then
			local var_108_7 = {}

			ipairs = var_108_3

			for iter_108_0, iter_108_1 in var_108_3(var_108_4) do
				var_1_10011 = var_108_5[iter_108_0]

				local var_108_8

				if not var_108_7[arg_108_1:findCommanderBySkillId(var_1_10011.id)] then
					var_108_8 = {}
				end

				var_108_7[var_1_10012] = var_108_8
				table = var_108_8

				var_108_8.insert(var_108_7[var_1_10012], iter_108_1)
			end

			pairs = var_108_3

			for iter_108_2, iter_108_3 in var_108_3(var_108_7) do
				table = var_1_10011

				var_1_10011.insert(var_108_0, {
					iter_108_2,
					iter_108_3
				})
			end
		end
	end

	local var_108_9 = arg_108_1:getCommanders()

	pairs = var_108_3

	for iter_108_4, iter_108_5 in var_108_3(var_108_9) do
		local var_108_10 = iter_108_5:getTalents()

		ipairs = var_1_10012

		for iter_108_6, iter_108_7 in var_1_10012(var_108_10) do
			local var_108_11 = #iter_108_7:getBuffsAddition()

			if 0 < var_108_11 then
				local var_108_12

				ipairs = var_19

				for iter_108_8, iter_108_9 in var_19(var_108_0) do
					if iter_108_9[1] == iter_108_5 then
						var_108_12 = iter_108_9[2]

						break
					end
				end

				if not var_108_12 then
					var_108_12 = {}
					table = var_19

					var_19.insert(var_108_0, {
						iter_108_5,
						var_108_12
					})
				end

				ipairs = var_19

				for iter_108_10, iter_108_11 in var_19(var_17) do
					table = var_1_10024

					var_1_10024.insert(var_108_12, iter_108_11)
				end
			end
		end
	end

	return var_108_0
end

function var_0_1.CanLongMove(arg_109_0, arg_109_1)
	if arg_109_0:IsUnlockFleetMode() then
		if not arg_109_1:HasTrapBuff() then
			local var_109_0 = arg_109_0:GetFleetTerrain(arg_109_1)

			WorldMapCell = var_1_10003

			if var_109_0 == var_1_10003.TerrainFog then
				var_109_0 = false
			else
				var_109_0 = true
			end

			return var_109_0
		end
	end
end

function var_0_1.triggerSkill(arg_110_0, arg_110_1, arg_110_2)
	_ = var_1_10003

	local var_110_0 = var_1_10003.filter(arg_110_1:findSkills(arg_110_2), function(arg_111_0)
		local var_111_0 = arg_111_0:GetTriggers()

		_ = var_2_10002

		local var_111_1 = var_2_10002.any(var_111_0, function(arg_112_0)
			local var_112_0 = arg_112_0[1]

			FleetSkill = var_3_10002

			return var_112_0 == var_3_10002.TriggerInSubTeam and arg_112_0[2] == 1
		end)
		local var_111_2 = arg_110_1
		local var_111_3 = var_3.GetFleetType(var_111_2)

		FleetType = var_4

		local var_111_4

		if var_111_1 == (var_111_3 == var_4.Submarine) then
			_ = var_4
			var_111_4 = var_4.all(arg_111_0:GetTriggers(), function(arg_113_0)
				local var_113_0 = arg_110_0

				return var_1.triggerCheck(var_113_0, arg_110_1, arg_111_0, arg_113_0)
			end)
		else
			var_111_4 = false
		end

		if false then
			var_111_4 = true
		end

		return var_111_4
	end)

	_ = var_1_10004

	return var_1_10004.reduce(var_110_0, nil, function(arg_114_0, arg_114_1)
		local var_114_0 = arg_114_1
		local var_114_1 = arg_114_1.GetType(var_114_0)
		local var_114_2 = arg_114_1:GetArgs()

		FleetSkill = var_114_0

		if var_114_1 ~= var_114_0.TypeMoveSpeed then
			FleetSkill = var_114_3

			if var_114_1 ~= var_114_3.TypeHuntingLv then
				FleetSkill = var_114_3

				local var_114_3

				if var_114_1 == var_114_3.TypeTorpedoPowerUp then
					var_114_3 = arg_114_0 or 0

					do return var_114_3 + var_114_2[1] end

					goto label_114_0
				end

				FleetSkill = var_114_3

				if var_114_1 ~= var_114_3.TypeAmbushDodge then
					FleetSkill = var_4

					if var_114_1 == var_4.TypeAirStrikeDodge then
						math = var_4

						do return var_4.max(arg_114_0 or 0, var_114_2[1]) end

						goto label_114_0
					end

					FleetSkill = var_4

					if var_114_1 ~= var_4.TypeAttack then
						FleetSkill = var_4

						if var_114_1 == var_4.TypeStrategy then
							arg_114_0 = arg_114_0 or {}
							table = var_4

							var_4.insert(arg_114_0, var_114_2)

							return arg_114_0
						else
							FleetSkill = var_4

							if var_114_1 == var_4.TypeBattleBuff then
								arg_114_0 = arg_114_0 or {}
								table = var_4

								var_4.insert(arg_114_0, var_114_2[1])

								return arg_114_0
							end
						end

						::label_114_0::

						return
					end
				end
			end
		end
	end), var_110_0
end

function var_0_1.triggerCheck(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	local var_115_0 = arg_115_3[1]

	FleetSkill = var_1_10005

	local var_115_2

	if var_115_0 == var_1_10005.TriggerDDHead then
		local var_115_1 = arg_115_1

		var_115_2 = arg_115_1.GetTeamShipVOs
		TeamType = var_1_10008

		if #var_115_2(var_115_1, var_1_10008.Vanguard, false) > 0 then
			ShipType = var_1_10006
			var_1_10006 = var_1_10006.IsTypeQuZhu

			local var_115_3 = var_115_2[1]

			var_1_10006 = var_1_10006(var_1_10008.getShipType(var_115_3))
		else
			var_1_10006 = false
		end

		if false then
			var_1_10006 = true
		end

		return var_1_10006
	else
		FleetSkill = var_115_2

		local var_115_5

		if var_115_0 == var_115_2.TriggerVanCount then
			local var_115_4 = arg_115_1

			var_115_5 = arg_115_1.GetTeamShipVOs
			TeamType = var_1_10008
			var_1_10006 = #var_115_5(var_115_4, var_1_10008.Vanguard, false) >= arg_115_3[2] and #var_115_5 <= arg_115_3[3]

			return var_1_10006
		else
			FleetSkill = var_115_5

			if var_115_0 == var_115_5.TriggerShipCount then
				_ = var_5
				var_1_10006 = #var_5.filter(arg_115_1:GetShipVOs(false), function(arg_116_0)
					table = var_2_10001

					return var_2_10001.contains(arg_115_3[2], arg_116_0:getShipType())
				end) >= arg_115_3[3] and #var_5 <= arg_115_3[4]

				return var_1_10006
			else
				FleetSkill = var_5

				local var_115_6

				if var_115_0 == var_5.TriggerAroundEnemy then
					var_115_6 = {
						row = arg_115_1.row,
						column = arg_115_1.column
					}
					var_1_10006 = {}

					for iter_115_0 = -arg_115_3[2], var_7 do
						math = var_1_10012

						for iter_115_1 = -(var_7 - var_1_10012.abs(iter_115_0)), var_1_10012 do
							local var_115_7 = arg_115_0:GetCell(var_115_6.row + iter_115_0, var_115_6.column + iter_115_1)

							table = var_1_10018

							var_1_10018.insert(var_1_10006, var_115_7)
						end
					end

					underscore = var_8

					return var_8.any(var_1_10006, function(arg_117_0)
						local var_117_0

						if not arg_117_0:ExistEnemy() or not arg_117_0:GetStageEnemy().config.type then
							var_117_0 = nil
						end

						type = var_2_10002

						local var_117_1

						if var_2_10002(arg_115_3[3]) ~= "number" or arg_115_3[3] ~= var_117_0 then
							type = var_2

							if var_2(arg_115_3[3]) == "table" then
								table = var_2
								var_117_1 = var_2.contains(arg_115_3[3], var_117_0)
							else
								var_117_1 = false
							end
						else
							var_117_1 = true
						end

						return var_117_1
					end)
				else
					FleetSkill = var_115_6

					local var_115_8

					if var_115_0 == var_115_6.TriggerNekoPos then
						var_115_8 = arg_115_1:findCommanderBySkillId(arg_115_2.id)
						pairs = var_1_10006

						for iter_115_2, iter_115_3 in var_1_10006(arg_115_1:getCommanders()) do
							if var_115_8.id == iter_115_3.id and iter_115_2 == arg_115_3[2] then
								return true
							end
						end
					else
						FleetSkill = var_115_8

						local var_115_9

						if var_115_0 == var_115_8.TriggerAroundLand then
							var_115_9 = {
								row = arg_115_1.row,
								column = arg_115_1.column
							}

							for iter_115_4 = -arg_115_3[2], var_6 do
								math = iter_115_0

								for iter_115_5 = -(var_6 - iter_115_0.abs(iter_115_4)), iter_115_0 do
									local var_115_10 = var_115_9.row + iter_115_4
									local var_115_11 = var_115_9.column + iter_115_5

									if arg_115_0:GetCell(var_115_10, var_115_11) and not arg_115_0:IsWalkable(var_115_10, var_115_11) then
										return true
									end
								end
							end

							return false
						else
							FleetSkill = var_115_9

							local var_115_12

							if var_115_0 == var_115_9.TriggerAroundCombatAlly then
								var_115_12 = {
									row = arg_115_1.row,
									column = arg_115_1.column
								}
								_ = var_6

								return var_6.any(arg_115_0.fleets, function(arg_118_0)
									if arg_115_1.id ~= arg_118_0.id then
										local var_118_0 = arg_118_0:GetFleetType()

										FleetType = var_2

										if var_118_0 == var_2.Normal then
											local var_118_1 = arg_115_0
											local var_118_2 = var_118_0.GetCell(var_118_1, arg_118_0.line.row, arg_118_0.line.column)

											if var_118_0.ExistEnemy(var_118_2) then
												ManhattonDist = var_118_0

												if not (var_118_0(var_115_12, {
													row = arg_118_0.line.row,
													column = arg_118_0.line.column
												}) <= arg_115_3[2]) then
													var_118_0 = false
												else
													var_118_0 = true
												end
											end

											return var_118_0
										end
									end
								end)
							else
								FleetSkill = var_115_12

								if var_115_0 == var_115_12.TriggerInSubTeam then
									return true
								else
									assert = var_5

									var_5(false, "invalid trigger type: " .. var_115_0)
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.OnUpdateAttachmentExist(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	local var_119_0 = arg_119_3.type
	local var_119_1 = arg_119_0.typeAttachments
	local var_119_2

	if not arg_119_0.typeAttachments[var_119_0] then
		var_119_2 = {}
	end

	var_119_1[var_119_0] = var_119_2
	WorldMapCell = var_119_1

	if arg_119_1 == var_119_1.EventAddAttachment then
		table = var_5

		var_5.insert(arg_119_0.typeAttachments[var_119_0], arg_119_3)
	else
		WorldMapCell = var_5

		if arg_119_1 == var_5.EventRemoveAttachment then
			table = var_5

			var_5.removebyvalue(arg_119_0.typeAttachments[var_119_0], arg_119_3)
		end
	end

	local var_119_3 = arg_119_3

	if arg_119_3.GetVisionRadius(var_119_3) > 0 then
		local var_119_4 = 0

		WorldMapCell = var_119_3

		if arg_119_1 == var_119_3.EventAddAttachment then
			var_119_4 = var_119_4 + 1
		else
			WorldMapCell = var_7

			if arg_119_1 == var_7.EventRemoveAttachment then
				var_119_4 = var_119_4 - 1
			else
				assert = var_7

				var_7(false, "listener event error: " .. arg_119_1)
			end
		end

		arg_119_0.centerCellFOV = {
			row = arg_119_2.row,
			column = arg_119_2.column
		}

		for iter_119_0 = arg_119_2.row - var_5, arg_119_2.row + var_5 do
			for iter_119_1 = arg_119_2.column - var_5, arg_119_2.column + var_5 do
				if arg_119_0:GetCell(iter_119_0, iter_119_1) then
					WorldConst = var_1_10016

					if var_1_10016.InFOVRange(arg_119_2.row, arg_119_2.column, var_15.row, var_15.column, var_5) then
						var_15:ChangeInLight(var_119_4 > 0)
					end
				end
			end
		end
	end

	local var_119_5 = #arg_119_3:GetRadiationBuffs()

	if 0 < var_119_5 then
		local var_119_6 = {}

		ipairs = var_8

		for iter_119_2, iter_119_3 in var_8(var_6) do
			unpack = var_1_10013

			local var_119_7, var_119_8

			var_1_10013, var_119_7, var_119_8 = var_1_10013(iter_119_3)
			WorldMapCell = var_1_10016

			if arg_119_1 == var_1_10016.EventAddAttachment then
				var_119_6[var_1_10013] = true

				arg_119_0:AddBuff(var_1_10013, var_119_7, var_119_8)
			else
				WorldMapCell = var_1_10016

				if arg_119_1 == var_1_10016.EventRemoveAttachment then
					var_119_6[var_1_10013] = true

					arg_119_0:RemoveBuff(var_1_10013, var_119_7, var_119_8)
				end
			end
		end

		pairs = var_8

		for iter_119_4, iter_119_5 in var_8(var_119_6) do
			if iter_119_5 then
				arg_119_0:FlushFaction(iter_119_4)
			end
		end
	end

	return
end

function var_0_1.GetBGM(arg_120_0)
	return arg_120_0.config.bgm
end

function var_0_1.NeedClear(arg_121_0)
	local var_121_0, var_121_1 = arg_121_0:GetEventPoisonRate()

	if not (var_121_1 > 0) or var_121_0 ~= 0 then
		local var_121_2

		if not arg_121_0.clearFlag then
			if not (arg_121_0.config.is_clear > 0) then
				var_121_2 = false

				goto label_121_0
			end

			var_121_2 = true
		end

		::label_121_0::

		return var_121_2
	end
end

function var_0_1.GetBuff(arg_122_0, arg_122_1, arg_122_2)
	if not arg_122_0.factionBuffs[arg_122_1][arg_122_2] then
		local var_122_0 = arg_122_0.factionBuffs[arg_122_1]

		WorldBuff = var_1_10004
		var_122_0[arg_122_2] = var_1_10004.New()

		local var_122_1 = arg_122_0.factionBuffs[arg_122_1][arg_122_2]

		var_3.Setup(var_122_1, {
			floor = 0,
			id = arg_122_2
		})
	end

	return arg_122_0.factionBuffs[arg_122_1][arg_122_2]
end

function var_0_1.AddBuff(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
	local var_123_0 = arg_123_0:GetBuff(arg_123_1, arg_123_2)

	var_4.AddFloor(var_123_0, arg_123_3)

	return
end

function var_0_1.RemoveBuff(arg_124_0, arg_124_1, arg_124_2, arg_124_3)
	local var_124_0 = arg_124_0:GetBuff(arg_124_1, arg_124_2)

	if arg_124_3 then
		var_124_0:AddFloor(arg_124_3 * -1)
	else
		arg_124_0.factionBuffs[arg_124_1][arg_124_2] = nil
	end

	return
end

function var_0_1.GetBuffList(arg_125_0, arg_125_1, arg_125_2)
	if arg_125_1 == var_0_1.FactionSelf then
		underscore = var_3

		local var_125_0 = var_3.filter

		underscore = var_1_10005

		do return var_125_0(var_1_10005.values(arg_125_0.factionBuffs[arg_125_1]), function(arg_126_0)
			return arg_126_0:GetFloor() > 0
		end) end

		goto label_125_0
	end

	if arg_125_1 == var_0_1.FactionEnemy then
		WorldMapAttachment = var_125_1

		if not var_125_1.IsEnemyType(arg_125_2.type) then
			do
				local var_125_1 = arg_125_2.type

				WorldMapAttachment = var_1_10004

				if var_125_1 == var_1_10004.TypeEvent then
					local var_125_2 = arg_125_2

					var_125_1 = arg_125_2.GetSpEventType(var_125_2)
					WorldMapAttachment = var_4

					if var_125_1 == var_4.SpEventEnemy then
						underscore = var_125_1
						var_125_1 = var_125_1.filter
						underscore = var_125_2

						do return var_125_1(var_125_2.values(arg_125_0.factionBuffs[arg_125_1]), function(arg_127_0)
							return arg_127_0:GetFloor() > 0
						end) end

						goto label_125_0
					end
				end

				do return {} end

				if false then
					assert = var_125_1

					local var_125_3 = false

					string = var_1_10006

					var_125_1(var_125_3, var_1_10006.format("faction error: $d", arg_125_1))
				end
			end

			::label_125_0::

			return
		end
	end
end

function var_0_1.FlushFaction(arg_128_0, arg_128_1)
	if arg_128_1 == var_0_1.FactionSelf then
		underscore = var_2

		var_2.each(arg_128_0:GetFleets(), function(arg_129_0)
			local var_129_0 = arg_129_0
			local var_129_1 = arg_129_0.DispatchEvent

			WorldMapFleet = var_2_10004

			var_129_1(var_129_0, var_2_10004.EventUpdateBuff)

			return
		end)
	else
		local var_128_0

		if arg_128_1 == var_0_1.FactionEnemy then
			var_128_0 = {}
			underscore = var_1_10003

			var_1_10003.each(arg_128_0:FindEnemys(), function(arg_130_0)
				local var_130_0 = var_128_0

				WorldMapCell = var_2_10002
				var_130_0[var_2_10002.GetName(arg_130_0.row, arg_130_0.column)] = true

				return
			end)

			underscore = var_3

			local var_128_1 = var_3.each
			local var_128_2 = arg_128_0

			var_1_10005 = arg_128_0.FindAttachments
			WorldMapAttachment = var_1_10008

			var_128_1(var_1_10005(var_128_2, var_1_10008.TypeEvent), function(arg_131_0)
				local var_131_0 = arg_131_0:GetSpEventType()

				WorldMapAttachment = var_2_10002

				if var_131_0 == var_2_10002.SpEventEnemy then
					local var_131_1 = var_128_0

					WorldMapCell = var_2
					var_131_1[var_2.GetName(arg_131_0.row, arg_131_0.column)] = true
				end

				return
			end)

			pairs = var_128_1

			for iter_128_0 in var_128_1(var_128_0) do
				local var_128_3 = arg_128_0.cells[iter_128_0]

				var_7.DispatchEvent(var_128_3, var_0_1.EventUpdateMapBuff)
			end
		else
			assert = var_128_0

			local var_128_4 = false

			string = var_1_10005

			var_128_0(var_128_4, var_1_10005.format("faction error: $d", arg_128_1))
		end
	end

	return
end

function var_0_1.GetBattleLuaBuffs(arg_132_0, arg_132_1, arg_132_2)
	local var_132_0 = {}

	underscore = var_1_10004

	var_1_10004.each(arg_132_0:GetBuffList(arg_132_1, arg_132_2), function(arg_133_0)
		if arg_133_0.config.lua_id > 0 then
			table = var_1

			var_1.insert(var_132_0, arg_133_0.config.lua_id)
		end

		return
	end)

	return var_132_0
end

function var_0_1.UpdateFleetLocation(arg_134_0, arg_134_1, arg_134_2, arg_134_3)
	local var_134_0 = arg_134_0:GetFleet(arg_134_1)

	assert = var_1_10005

	var_1_10005(var_134_0, "without this fleet : " .. arg_134_1)

	if var_134_0.row ~= arg_134_2 or var_134_0.column ~= arg_134_3 then
		arg_134_0:CheckFleetUpdateFOV(var_134_0, function()
			var_134_0.row = arg_134_2
			var_134_0.column = arg_134_3

			return
		end)

		local var_134_1 = var_134_0
		local var_134_2 = var_134_0.DispatchEvent

		WorldMapFleet = var_8

		var_134_2(var_134_1, var_8.EventUpdateLocation)
	end

	return
end

function var_0_1.GetRangeDic(arg_136_0, arg_136_1)
	local var_136_0 = {}

	WorldConst = var_1_10003

	var_1_10003.RangeCheck(arg_136_1, arg_136_0:GetFOVRange(arg_136_1), function(arg_137_0, arg_137_1)
		WorldMapCell = var_2_10002

		local var_137_0 = var_2_10002.GetName(arg_137_0, arg_137_1)

		if arg_136_0.cells[var_137_0] then
			local var_137_1 = var_136_0

			defaultValue = var_4
			var_137_1[var_137_0] = var_4(var_136_0[var_137_0], 0) + 1
		end

		return
	end)

	return var_136_0
end

function var_0_1.CheckFleetUpdateFOV(arg_138_0, arg_138_1, arg_138_2)
	if not arg_138_0:IsValid() then
		arg_138_2()

		return
	end

	local var_138_0 = arg_138_0
	local var_138_1 = arg_138_0.GetRangeDic(var_138_0, arg_138_1)
	local var_138_2 = arg_138_0:GetFleetTerrain(arg_138_1)

	WorldMapCell = var_138_0

	local var_138_3 = var_138_2 == var_138_0.TerrainFog
	local var_138_4 = arg_138_0:IsFleetTerrainSairenFog(arg_138_1)
	local var_138_5 = arg_138_0:CalcFleetSpeed(arg_138_1)

	arg_138_2()

	local var_138_6 = arg_138_0
	local var_138_7 = arg_138_0.GetRangeDic(var_138_6, arg_138_1)
	local var_138_8 = arg_138_0:GetFleetTerrain(arg_138_1)

	WorldMapCell = var_138_6

	local var_138_9 = var_138_8 == var_138_6.TerrainFog
	local var_138_10 = arg_138_0:IsFleetTerrainSairenFog(arg_138_1)
	local var_138_11 = arg_138_0:CalcFleetSpeed(arg_138_1)

	arg_138_0.centerCellFOV = {
		row = arg_138_1.row,
		column = arg_138_1.column
	}

	local var_138_12 = false
	local var_138_13 = false
	local var_138_14 = {}

	if not var_138_3 then
		pairs = var_1_10014

		for iter_138_0, iter_138_1 in var_1_10014(var_138_1) do
			defaultValue = var_1_10019
			var_138_14[iter_138_0] = var_1_10019(var_138_14[iter_138_0], 0) - iter_138_1
		end
	end

	if not var_138_9 then
		pairs = var_1_10014

		for iter_138_2, iter_138_3 in var_1_10014(var_138_7) do
			defaultValue = var_1_10019
			var_138_14[iter_138_2] = var_1_10019(var_138_14[iter_138_2], 0) + iter_138_3
		end
	end

	pairs = var_1_10014

	for iter_138_4, iter_138_5 in var_1_10014(var_138_14) do
		if iter_138_5 ~= 0 then
			local var_138_15 = arg_138_0.cells[iter_138_4]

			var_1_10019.ChangeInLight(var_138_15, iter_138_5 > 0)

			var_138_12 = true
		end
	end

	if arg_138_0:GetFleet() == arg_138_1 then
		local var_138_16 = {}

		if var_138_3 then
			pairs = var_14

			for iter_138_6, iter_138_7 in var_14(var_138_1) do
				defaultValue = var_1_10019
				var_138_16[iter_138_6] = var_1_10019(var_138_16[iter_138_6], 0) - iter_138_7
			end
		end

		if var_138_9 then
			pairs = var_14

			for iter_138_8, iter_138_9 in var_14(var_138_7) do
				defaultValue = var_1_10019
				var_138_16[iter_138_8] = var_1_10019(var_138_16[iter_138_8], 0) + iter_138_9
			end
		end

		if var_138_3 ~= var_138_9 or var_138_4 ~= var_138_10 then
			pairs = var_14

			for iter_138_10, iter_138_11 in var_14(arg_138_0.cells) do
				local var_138_17

				if var_138_16[iter_138_10] and var_138_16[iter_138_10] ~= 0 then
					var_138_17 = var_138_16[iter_138_10] > 0
				end

				iter_138_11:UpdateFog(var_138_9, var_138_17, var_138_10)
			end

			var_138_12 = true
		else
			pairs = var_14

			for iter_138_12, iter_138_13 in var_14(var_138_16) do
				if iter_138_13 ~= 0 then
					local var_138_18 = arg_138_0.cells[iter_138_12]

					var_19.UpdateFog(var_138_18, nil, iter_138_13 > 0, nil)

					var_138_12 = true
				end
			end
		end

		if var_138_5 ~= var_138_11 then
			var_138_13 = true
		end
	end

	if var_138_12 then
		arg_138_0:DispatchEvent(var_0_1.EventUpdateFleetFOV)
	end

	if var_138_13 then
		arg_138_0:DispatchEvent(var_0_1.EventUpdateMoveSpeed)
	end

	return
end

function var_0_1.CheckSelectFleetUpdateFog(arg_139_0, arg_139_1)
	if not arg_139_0:IsValid() then
		arg_139_1()

		return
	end

	local var_139_0 = arg_139_0:GetFleet()
	local var_139_1 = arg_139_0
	local var_139_2 = arg_139_0.GetRangeDic(var_139_1, var_139_0)
	local var_139_3 = arg_139_0:GetFleetTerrain(var_139_0)

	WorldMapCell = var_139_1

	local var_139_4 = var_139_3 == var_139_1.TerrainFog
	local var_139_5 = arg_139_0:IsFleetTerrainSairenFog(var_139_0)

	arg_139_1()

	local var_139_6 = arg_139_0:GetFleet()
	local var_139_7 = arg_139_0
	local var_139_8 = arg_139_0.GetRangeDic(var_139_7, var_139_6)
	local var_139_9 = arg_139_0:GetFleetTerrain(var_139_6)

	WorldMapCell = var_139_7

	local var_139_10 = var_139_9 == var_139_7.TerrainFog
	local var_139_11 = arg_139_0:IsFleetTerrainSairenFog(var_139_6)

	arg_139_0.centerCellFOV = {
		row = var_139_6.row,
		column = var_139_6.column
	}

	local var_139_12 = {}

	if var_139_4 then
		pairs = var_10

		for iter_139_0, iter_139_1 in var_10(var_139_2) do
			defaultValue = var_1_10015
			var_139_12[iter_139_0] = var_1_10015(var_139_12[iter_139_0], 0) - iter_139_1
		end
	end

	if var_139_10 then
		pairs = var_10

		for iter_139_2, iter_139_3 in var_10(var_139_8) do
			defaultValue = var_1_10015
			var_139_12[iter_139_2] = var_1_10015(var_139_12[iter_139_2], 0) + iter_139_3
		end
	end

	if var_139_4 ~= var_139_10 or var_139_5 ~= var_139_11 then
		pairs = var_10

		for iter_139_4, iter_139_5 in var_10(arg_139_0.cells) do
			local var_139_13

			if var_139_12[iter_139_4] and var_139_12[iter_139_4] ~= 0 then
				var_139_13 = var_139_12[iter_139_4] > 0
			end

			iter_139_5:UpdateFog(var_139_10, var_139_13, var_139_11)
		end
	else
		pairs = var_10

		for iter_139_6, iter_139_7 in var_10(var_139_12) do
			if iter_139_7 ~= 0 then
				local var_139_14 = arg_139_0.cells[iter_139_6]

				var_15.UpdateFog(var_139_14, nil, iter_139_7 > 0, nil)
			end
		end
	end

	arg_139_0:DispatchEvent(var_0_1.EventUpdateFleetFOV)

	return
end

function var_0_1.CheckEventAutoTrigger(arg_140_0, arg_140_1)
	local var_140_0 = arg_140_1
	local var_140_1 = arg_140_1.GetSpEventType(var_140_0)

	WorldMapAttachment = var_1_10003

	if var_140_1 == var_1_10003.SpEventConsumeItem then
		getProxy = var_140_1
		SettingsProxy = var_140_0

		local var_140_2 = var_140_1(var_140_0)

		return var_2.GetWorldFlag(var_140_2, "consume_item")
	end

	if arg_140_1:GetEventEffect() then
		local var_140_3 = arg_140_0
		local var_140_4 = arg_140_0.GetFleet(var_140_3)
		local var_140_5 = var_2.effect_type

		WorldMapAttachment = var_140_3

		local var_140_6

		if var_140_5 == var_140_3.EffectEventConsumeCarry then
			if not var_2.effect_paramater[1] then
				var_140_6 = {}
			end

			underscore = var_1_10006

			return not var_1_10006.any(var_140_6, function(arg_141_0)
				local var_141_0 = var_140_4

				return not var_1.ExistCarry(var_141_0, arg_141_0)
			end)
		else
			WorldMapAttachment = var_140_6

			if var_140_5 == var_140_6.EffectEventCatSalvage then
				local var_140_7

				if var_140_4:GetDisplayCommander() then
					var_140_7 = not var_140_4:IsCatSalvage()
				end

				return var_140_7
			end
		end
	end

	return true
end

function var_0_1.CanAutoFight(arg_142_0)
	if arg_142_0.config.is_auto > 0 then
		for iter_142_0 = 1, arg_142_0.config.is_auto do
			nowWorld = var_1_10005

			local var_142_0 = var_1_10005()

			var_1_10005 = var_1_10005.IsSystemOpen
			WorldConst = var_1_10008

			if not var_1_10005(var_142_0, var_1_10008["SystemAutoFight_" .. iter_142_0]) then
				return false
			end
		end

		return true
	else
		return false
	end

	return
end

function var_0_1.CkeckTransport(arg_143_0)
	assert = var_1_10001

	var_1_10001(arg_143_0:IsValid(), "without map info")

	if arg_143_0.config.is_transfer == 0 then
		local var_143_0 = false

		i18n = var_1_10002
		var_1_10002 = var_1_10002("world_transport_disable")

		return
	end

	local var_143_1 = arg_143_0

	if arg_143_0.CheckAttachmentTransport(var_143_1) == "block" then
		var_1_10002 = false
		i18n = var_143_1
		var_143_1 = var_143_1("world_movelimit_event_text")

		return
	end

	nowWorld = var_1_10002

	local var_143_2 = var_1_10002()

	if var_2.CheckTaskLockMap(var_143_2) then
		local var_143_3 = false

		i18n = var_143_1

		local var_143_4 = var_143_1("world_task_maplock")

		return
	end

	return true
end

return var_0_1
