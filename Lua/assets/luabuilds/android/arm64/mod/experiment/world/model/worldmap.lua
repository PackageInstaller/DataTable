local var_0_0 = class("WorldMap", import("...BaseEntity"))

var_0_0.Fields = {
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
var_0_0.Listeners = {
	onUpdateAttachmentExist = "OnUpdateAttachmentExist"
}
var_0_0.EventUpdateActive = "WorldMap.EventUpdateActive"
var_0_0.EventUpdateFIndex = "WorldMap.EventUpdateFIndex"
var_0_0.EventUpdateMapBuff = "WorldMap.EventUpdateMapBuff"
var_0_0.EventUpdateFleetFOV = "WorldMap.EventUpdateFleetFOV"
var_0_0.EventUpdateMoveSpeed = "WorldMap.EventUpdateMoveSpeed"

function var_0_0.DebugPrint(arg_1_0)
	return string.format("地图 [%s] [id: %s] [gid: %s] [危险度: %s] [是否压制：%s]", arg_1_0.config.name, arg_1_0.id, tostring(arg_1_0.gid), arg_1_0:GetDanger(), arg_1_0.isPressing)
end

function var_0_0.Build(arg_2_0)
	arg_2_0.cells = {}
	arg_2_0.ports = {}
	arg_2_0.phaseDisplayList = {}

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:UnbindFleets()
	arg_3_0:DisposeTheme()
	arg_3_0:DisposeGrid()
	arg_3_0:DisposePort()
	arg_3_0:Clear()

	return
end

function var_0_0.Setup(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1

	assert(pg.world_chapter_random[arg_4_0.id], "world_chapter_random not exist: " .. tostring(arg_4_0.id))

	arg_4_0.config = setmetatable({}, {
		__index = function(arg_5_0, arg_5_1)
			return arg_4_0:GetConfig(arg_5_1)
		end
	})

	return
end

function var_0_0.GetName(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 and World.ReplacementMapType(arg_6_1, arg_6_0)

	if var_6_0 == "sairen_chapter" or var_6_0 == "teasure_chapter" then
		local var_6_1 = arg_6_1:GetBaseMap():GetName()

		return var_6_1 .. "-" .. arg_6_0.config.name
	else
		return arg_6_0.config.name
	end

	return
end

function var_0_0.GetConfig(arg_7_0, arg_7_1)
	if pg.world_chapter_random[arg_7_0.id] then
		local var_7_0 = pg.world_chapter_random[arg_7_0.id][arg_7_1]

		if not pg.world_chapter_random[arg_7_0.id][arg_7_1] then
			if pg.world_chapter_template[arg_7_0.gid] then
				var_7_0 = pg.world_chapter_template[arg_7_0.gid][arg_7_1] or nil

				assert(var_7_0 ~= nil, "can not find " .. arg_7_1 .. " in WorldMap " .. arg_7_0.id)

				return var_7_0
			end
		end
	end
end

var_0_0.FactionSelf = 0
var_0_0.FactionEnemy = 1

function var_0_0.UpdateGridId(arg_8_0, arg_8_1)
	arg_8_0.gid = arg_8_1

	assert(pg.world_chapter_template[arg_8_0.gid], "world_chapter_template not exist: " .. tostring(arg_8_0.gid))
	arg_8_0:DisposeTheme()
	arg_8_0:DisposeGrid()
	arg_8_0:DisposePort()

	arg_8_0.factionBuffs = {
		[var_0_0.FactionSelf] = {},
		[var_0_0.FactionEnemy] = {}
	}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.config.world_chapter_buff) do
		local var_8_0, var_8_1, var_8_2 = unpack(iter_8_1)

		arg_8_0:AddBuff(var_8_0, var_8_1, var_8_2)
	end

	arg_8_0:SetupTheme()
	arg_8_0:SetupGrid()
	arg_8_0:SetupPort()

	return
end

function var_0_0.SetupTheme(arg_9_0)
	local var_9_0 = WPool:Get(WorldMapTheme)

	var_9_0:Setup(arg_9_0.config.theme)

	arg_9_0.theme = var_9_0

	return
end

function var_0_0.DisposeTheme(arg_10_0)
	if arg_10_0.theme then
		WPool:Return(arg_10_0.theme)

		arg_10_0.theme = nil
	end

	return
end

function var_0_0.SetupGrid(arg_11_0, arg_11_1)
	_.each(arg_11_0.config.grids, function(arg_12_0)
		local var_12_0 = WPool:Get(WorldMapCell)

		var_12_0:Setup(arg_12_0)

		if arg_11_0:AlwaysInFOV() then
			var_12_0.infov = bit.bor(var_12_0.infov, WorldConst.FOVMapSight)
		end

		arg_11_0.cells[WorldMapCell.GetName(var_12_0.row, var_12_0.column)] = var_12_0

		if not arg_11_1 then
			var_12_0:AddListener(WorldMapCell.EventAddAttachment, arg_11_0.onUpdateAttachmentExist)
			var_12_0:AddListener(WorldMapCell.EventRemoveAttachment, arg_11_0.onUpdateAttachmentExist)
		end

		return
	end)

	arg_11_0.left, arg_11_0.right = 999999, 0
	arg_11_0.top, arg_11_0.bottom = 999999, 0

	for iter_11_0 = 0, WorldConst.MaxRow do
		local var_11_0
		local var_11_1

		for iter_11_1 = 0, WorldConst.MaxColumn do
			local var_11_2 = arg_11_0:GetCell(iter_11_0, iter_11_1)

			if var_11_2 then
				if not var_11_0 then
					var_11_0 = iter_11_1
					var_11_2.dir = bit.bor(var_11_2.dir, bit.lshift(1, WorldConst.DirLeft))
				end

				var_11_1 = iter_11_1
			end
		end

		if var_11_1 then
			local var_11_3 = arg_11_0:GetCell(iter_11_0, var_11_1)

			var_11_3.dir = bit.bor(var_11_3.dir, bit.lshift(1, WorldConst.DirRight))
		end

		if var_11_0 then
			arg_11_0.left = math.min(arg_11_0.left, var_11_0)
		end

		if var_11_1 then
			arg_11_0.right = math.max(arg_11_0.right, var_11_1)
		end
	end

	for iter_11_2 = 0, WorldConst.MaxColumn do
		local var_11_4
		local var_11_5

		for iter_11_3 = 0, WorldConst.MaxRow do
			local var_11_6 = arg_11_0:GetCell(iter_11_3, iter_11_2)

			if var_11_6 then
				if not var_11_4 then
					var_11_4 = iter_11_3
					var_11_6.dir = bit.bor(var_11_6.dir, bit.lshift(1, WorldConst.DirUp))
				end

				var_11_5 = iter_11_3
			end
		end

		if var_11_5 then
			local var_11_7 = arg_11_0:GetCell(var_11_5, iter_11_2)

			var_11_7.dir = bit.bor(var_11_7.dir, bit.lshift(1, WorldConst.DirDown))
		end

		if var_11_4 then
			arg_11_0.top = math.min(arg_11_0.top, var_11_4)
		end

		if var_11_5 then
			arg_11_0.bottom = math.max(arg_11_0.bottom, var_11_5)
		end
	end

	return
end

function var_0_0.DisposeGrid(arg_13_0, arg_13_1)
	if not arg_13_1 then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.cells) do
			iter_13_1:RemoveListener(WorldMapCell.EventAddAttachment, arg_13_0.onUpdateAttachmentExist)
			iter_13_1:RemoveListener(WorldMapCell.EventRemoveAttachment, arg_13_0.onUpdateAttachmentExist)
		end
	end

	WPool:ReturnMap(arg_13_0.cells)

	arg_13_0.cells = {}
	arg_13_0.typeAttachments = {}
	arg_13_0.left = nil
	arg_13_0.top = nil
	arg_13_0.right = nil
	arg_13_0.bottom = nil

	return
end

function var_0_0.SetupPort(arg_14_0)
	if #arg_14_0.config.port_id > 0 then
		local var_14_0 = WPool:Get(WorldMapPort)

		var_14_0:Setup(arg_14_0.config.port_id[1])

		local var_14_1, var_14_2 = unpack(arg_14_0.config.port_id[2])

		for iter_14_0 = var_14_1 - 1, var_14_1 + 1 do
			for iter_14_1 = var_14_2 - 1, var_14_2 + 1 do
				if iter_14_0 ~= var_14_1 or iter_14_1 ~= var_14_2 then
					local var_14_3 = arg_14_0:GetCell(iter_14_0, iter_14_1)

					if var_14_3 then
						var_14_3:AddAttachment(WorldMapAttachment.MakeFakePort(iter_14_0, iter_14_1, var_14_0.id))
					end
				end
			end
		end

		table.insert(arg_14_0.ports, var_14_0)
	end

	return
end

function var_0_0.DisposePort(arg_15_0)
	WPool:ReturnArray(arg_15_0.ports)

	arg_15_0.ports = {}

	return
end

function var_0_0.IsValid(arg_16_0)
	return arg_16_0.valid
end

function var_0_0.SetValid(arg_17_0, arg_17_1)
	arg_17_0.valid = arg_17_1

	if arg_17_1 and arg_17_0.fleets then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0:GetNormalFleets()) do
			arg_17_0.centerCellFOV = {
				row = iter_17_1.row,
				column = iter_17_1.column
			}

			if arg_17_0:GetFleetTerrain(iter_17_1) ~= WorldMapCell.TerrainFog then
				WorldConst.RangeCheck(iter_17_1, arg_17_0:GetFOVRange(iter_17_1), function(arg_18_0, arg_18_1)
					local var_18_0 = arg_17_0.cells[WorldMapCell.GetName(arg_18_0, arg_18_1)]

					if var_18_0 then
						var_18_0:ChangeInLight(true)
					end

					return
				end)
			elseif arg_17_0.findex == iter_17_0 then
				local var_17_0 = {}

				WorldConst.RangeCheck(iter_17_1, arg_17_0:GetFOVRange(iter_17_1), function(arg_19_0, arg_19_1)
					local var_19_0 = WorldMapCell.GetName(arg_19_0, arg_19_1)

					if arg_17_0.cells[var_19_0] then
						var_17_0[var_19_0] = true
					end

					return
				end)

				local var_17_1 = arg_17_0:IsFleetTerrainSairenFog(iter_17_1)

				for iter_17_2, iter_17_3 in pairs(arg_17_0.cells) do
					iter_17_3:UpdateFog(true, ({})[iter_17_2], var_17_1)
				end
			end
		end
	end

	return
end

function var_0_0.IsMapOpen(arg_20_0)
	local var_20_0 = nowWorld()

	return var_20_0:GetProgress() >= arg_20_0:GetOpenProgress()
end

function var_0_0.GetOpenProgress(arg_21_0)
	local var_21_0 = nowWorld():GetRealm()

	if var_21_0 > 0 then
		return arg_21_0.config.open_stage[var_21_0] or 9999
	end
end

function var_0_0.RemoveAllCellDiscovered(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.cells) do
		iter_22_1:UpdateDiscovered(false)
	end

	return
end

function var_0_0.GetDanger(arg_23_0)
	return arg_23_0.config.hazard_level
end

function var_0_0.BindFleets(arg_24_0, arg_24_1)
	arg_24_0.fleets = arg_24_1

	return
end

function var_0_0.UnbindFleets(arg_25_0)
	arg_25_0.fleets = nil

	return
end

function var_0_0.GetFleets(arg_26_0)
	return _.rest(arg_26_0.fleets, 1)
end

function var_0_0.GetFleet(arg_27_0, arg_27_1)
	return arg_27_1 and _.detect(arg_27_0.fleets, function(arg_28_0)
		return arg_28_0.id == arg_27_1
	end) or arg_27_0.fleets[arg_27_0.findex]
end

function var_0_0.GetNormalFleets(arg_29_0)
	return _.filter(arg_29_0.fleets, function(arg_30_0)
		return arg_30_0:GetFleetType() == FleetType.Normal
	end)
end

function var_0_0.GetSubmarineFleet(arg_31_0)
	return _.detect(arg_31_0.fleets, function(arg_32_0)
		return arg_32_0:GetFleetType() == FleetType.Submarine
	end)
end

function var_0_0.FindFleet(arg_33_0, arg_33_1, arg_33_2)
	return _.detect(arg_33_0.fleets, function(arg_34_0)
		return arg_34_0.row == arg_33_1 and arg_34_0.column == arg_33_2
	end)
end

function var_0_0.CheckFleetMovable(arg_35_0, arg_35_1)
	return arg_35_0:GetCell(arg_35_1.row, arg_35_1.column):CanLeave()
end

function var_0_0.GetFleetTerrain(arg_36_0, arg_36_1)
	return arg_36_0:GetCell(arg_36_1.row, arg_36_1.column):GetTerrain()
end

function var_0_0.IsFleetTerrainSairenFog(arg_37_0, arg_37_1)
	return arg_37_0:GetCell(arg_37_1.row, arg_37_1.column):IsTerrainSairenFog()
end

function var_0_0.RemoveFleetsCarries(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or arg_38_0.fleets

	_.each(arg_38_1, function(arg_39_0)
		arg_39_0:RemoveAllCarries()

		return
	end)

	return
end

function var_0_0.UpdateFleetIndex(arg_40_0, arg_40_1)
	if arg_40_0.findex ~= arg_40_1 then
		arg_40_0:CheckSelectFleetUpdateFog(function()
			arg_40_0.findex = arg_40_1

			return
		end)
		arg_40_0:DispatchEvent(var_0_0.EventUpdateFIndex)
	end

	return
end

function var_0_0.UpdateActive(arg_42_0, arg_42_1)
	local var_42_0 = nowWorld():GetAtlas()

	if arg_42_0.active ~= arg_42_1 then
		arg_42_0.active = arg_42_1

		if arg_42_1 then
			arg_42_0:SetValid(false)
			var_42_0:SetActiveMap(arg_42_0)

			arg_42_0.isCost = true

			var_42_0:UpdateCostMap(arg_42_0.id, arg_42_0.isCost)
		elseif arg_42_0:NeedClear() then
			arg_42_0:RemoveAllCellDiscovered()

			arg_42_0.clearFlag = false
			arg_42_0.isCost = false

			var_42_0:UpdateCostMap(arg_42_0.id, arg_42_0.isCost)
		end

		arg_42_0:DispatchEvent(var_0_0.EventUpdateActive)
	end

	return
end

function var_0_0.InPort(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0:GetPort()

	if not var_43_0 or arg_43_2 and var_43_0.config.port_camp ~= arg_43_2 then
		return false
	end

	local var_43_1 = arg_43_0:GetFleet(arg_43_1)

	if var_43_1:GetFleetType() == FleetType.Submarine then
		return var_43_0.id
	else
		local var_43_2 = arg_43_0:GetCell(var_43_1.row, var_43_1.column):GetAliveAttachment()

		if var_43_2 and var_43_2.type == WorldMapAttachment.TypePort then
			return var_43_2.id
		end
	end

	return false
end

function var_0_0.canExit(arg_44_0)
	return arg_44_0.gid and pg.world_chapter_template_reset[arg_44_0.gid] ~= nil
end

function var_0_0.CheckAttachmentTransport(arg_45_0)
	local var_45_0 = WorldConst.GetTransportBlockEvent()
	local var_45_1 = arg_45_0:FindAttachments(WorldMapAttachment.TypeEvent)

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		if iter_45_1:IsAlive() and var_45_0[iter_45_1.id] then
			return "block"
		end
	end

	local var_45_2 = WorldConst.GetTransportStoryEvent()

	for iter_45_2, iter_45_3 in ipairs(var_45_1) do
		if iter_45_3:IsAlive() and var_45_2[iter_45_3.id] then
			return "story"
		end
	end

	return
end

function var_0_0.GetPort(arg_46_0, arg_46_1)
	return arg_46_1 and _.detect(arg_46_0.ports, function(arg_47_0)
		return arg_47_0.id == arg_46_1
	end) or arg_46_0.ports[1]
end

function var_0_0.GetCell(arg_48_0, arg_48_1, arg_48_2)
	return arg_48_0.cells[WorldMapCell.GetName(arg_48_1, arg_48_2)]
end

function var_0_0.CalcTransportPos(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = calcPositionAngle(arg_49_1.config.area_pos[1] - arg_49_2.config.area_pos[1], arg_49_1.config.area_pos[2] - arg_49_2.config.area_pos[2])
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

	for iter_49_0 = arg_49_0.left + 1, arg_49_0.right - 1 do
		local var_49_6 = math.abs(calcPositionAngle(iter_49_0 - var_49_2.column, var_49_2.row - arg_49_0.top) - var_49_0)

		if var_49_6 < var_49_4 then
			var_49_3 = {
				row = arg_49_0.top,
				column = iter_49_0
			}
			var_49_4 = var_49_6
		end

		local var_49_7 = math.abs(calcPositionAngle(iter_49_0 - var_49_2.column, var_49_2.row - arg_49_0.bottom) - var_49_0)

		if var_49_7 < var_49_4 then
			var_49_3 = {
				row = arg_49_0.bottom,
				column = iter_49_0
			}
			var_49_4 = var_49_7
		end
	end

	for iter_49_1 = arg_49_0.top + 1, arg_49_0.bottom - 1 do
		local var_49_8 = math.abs(calcPositionAngle(arg_49_0.left - var_49_2.column, var_49_2.row - iter_49_1) - var_49_0)

		if var_49_8 < var_49_4 then
			var_49_3 = {
				row = iter_49_1,
				column = arg_49_0.left
			}
			var_49_4 = var_49_8
		end

		local var_49_9 = math.abs(calcPositionAngle(arg_49_0.right - var_49_2.column, var_49_2.row - iter_49_1) - var_49_0)

		if var_49_9 < var_49_4 then
			var_49_3 = {
				row = iter_49_1,
				column = arg_49_0.right
			}
			var_49_4 = var_49_9
		end
	end

	if var_49_1 then
		arg_49_0:DisposeGrid(var_49_1)

		arg_49_0.gid = nil
	end

	return var_49_3
end

function var_0_0.AnyFleetInEdge(arg_50_0)
	return arg_50_0.active and _.any(arg_50_0:GetNormalFleets(), function(arg_51_0)
		return arg_51_0.row == arg_50_0.top or arg_51_0.row == arg_50_0.bottom or arg_51_0.column == arg_50_0.left or arg_51_0.column == arg_50_0.right
	end)
end

function var_0_0.CheckInteractive(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:FindAttachments(WorldMapAttachment.TypeEvent)

	for iter_52_0, iter_52_1 in ipairs(var_52_0) do
		if iter_52_1:RemainOpEffect() then
			return iter_52_1
		end
	end

	for iter_52_2, iter_52_3 in ipairs(var_52_0) do
		if iter_52_3:IsAlive() then
			local var_52_1 = iter_52_3:GetEventEffect()

			if var_52_1 and var_52_1.autoactivate > 0 then
				return iter_52_3
			end
		end
	end

	arg_52_1 = arg_52_1 or arg_52_0:GetFleet()

	local var_52_2 = arg_52_0:GetCell(arg_52_1.row, arg_52_1.column)

	if var_52_2.discovered then
		for iter_52_4, iter_52_5 in ipairs((var_52_2:GetAliveAttachments())) do
			if WorldMapAttachment.IsInteractiveType(iter_52_5.type) and not iter_52_5:IsTriggered() then
				if iter_52_5:IsSign() then
					return nil
				elseif iter_52_5.type == WorldMapAttachment.TypeEvent then
					local var_52_3 = iter_52_5:GetEventEffect()

					if var_52_3 and (var_52_3.effective_num <= 1 or arg_52_0:CountEventEffectKeys(var_52_3) >= var_52_3.effective_num) then
						return iter_52_5
					end
				else
					return iter_52_5
				end
			end
		end
	end

	return
end

function var_0_0.CheckDiscover(arg_53_0)
	for iter_53_0, iter_53_1 in pairs(arg_53_0.cells) do
		if not iter_53_1.discovered and iter_53_1:GetInFOV() then
			table.insert({}, {
				row = iter_53_1.row,
				column = iter_53_1.column
			})
		end
	end

	return {}
end

function var_0_0.CheckDisplay(arg_54_0, arg_54_1)
	if arg_54_1.type == WorldMapAttachment.TypeTrap then
		return true
	end

	local var_54_0 = arg_54_0:GetCell(arg_54_1.row, arg_54_1.column)

	return var_54_0:GetDisplayAttachment() == arg_54_1
end

function var_0_0.GetFOVRange(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	arg_55_2 = arg_55_2 or arg_55_1.row
	arg_55_3 = arg_55_3 or arg_55_1.column

	local var_55_0 = arg_55_0:GetCell(arg_55_2, arg_55_3)

	if var_55_0:GetTerrain() == WorldMapCell.TerrainFog then
		return var_55_0.terrainStrong or arg_55_1:GetFOVRange()
	end
end

function var_0_0.UpdateVisionFlag(arg_56_0, arg_56_1)
	arg_56_0.visionFlag = arg_56_1

	arg_56_0:OrderAROpenFOV(arg_56_0.visionFlag)

	return
end

function var_0_0.UpdatePressingMark(arg_57_0, arg_57_1)
	if tobool(arg_57_0.isPressing) ~= tobool(arg_57_1) then
		arg_57_0.isPressing = arg_57_1

		nowWorld():GetTaskProxy():doUpdateTaskByMap(arg_57_0.id, arg_57_1)
	end

	return
end

function var_0_0.ExistAny(arg_58_0, arg_58_1, arg_58_2)
	return arg_58_0:GetCell(arg_58_1, arg_58_2):GetAliveAttachment() or arg_58_0:ExistFleet(arg_58_1, arg_58_2)
end

function var_0_0.ExistFleet(arg_59_0, arg_59_1, arg_59_2)
	return tobool(arg_59_0:FindFleet(arg_59_1, arg_59_2))
end

function var_0_0.CalcFleetSpeed(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_1:GetSpeed()

	if arg_60_0:GetCell(arg_60_1.row, arg_60_1.column):GetTerrain() == WorldMapCell.TerrainFog then
		var_60_0 = math.min(var_60_0, 1)
	end

	return var_60_0
end

function var_0_0.FindPath(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	local var_61_0 = var_0_0.pathFinder

	if not var_0_0.pathFinder then
		var_61_0 = PathFinding.New({}, WorldConst.MaxRow, WorldConst.MaxColumn)
		var_0_0.pathFinder = var_61_0
	end

	local var_61_1 = {}

	for iter_61_0 = 0, WorldConst.MaxRow - 1 do
		var_61_1[iter_61_0] = var_61_1[iter_61_0] or {}

		for iter_61_1 = 0, WorldConst.MaxColumn - 1 do
			local var_61_2 = PathFinding.PrioForbidden

			if arg_61_0:IsWalkable(iter_61_0, iter_61_1) then
				if arg_61_3 then
					local var_61_3 = arg_61_0:GetCell(iter_61_0, iter_61_1)

					if var_61_3:GetInFOV() then
						var_61_2 = PathFinding.PrioNormal

						if iter_61_0 == arg_61_2.row and iter_61_1 == arg_61_2.column then
							if not arg_61_0:IsStayPoint(iter_61_0, iter_61_1) then
								var_61_2 = PathFinding.PrioObstacle
							end
						elseif arg_61_0:IsObstacle(iter_61_0, iter_61_1) then
							var_61_2 = PathFinding.PrioObstacle
						end
					end

					var_61_1[iter_61_0][iter_61_1] = var_61_2
				end
			end
		end
	end

	var_61_0.cells = var_61_1

	return var_61_0:Find(arg_61_1, arg_61_2)
end

function var_0_0.FindAIPath(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = var_0_0.pathFinder

	if not var_0_0.pathFinder then
		var_62_0 = PathFinding.New({}, WorldConst.MaxRow, WorldConst.MaxColumn)
		var_0_0.pathFinder = var_62_0
	end

	local var_62_1 = {}

	for iter_62_0 = 0, WorldConst.MaxRow - 1 do
		var_62_1[iter_62_0] = var_62_1[iter_62_0] or {}

		for iter_62_1 = 0, WorldConst.MaxColumn - 1 do
			local var_62_2 = PathFinding.PrioForbidden

			if arg_62_0:IsWalkable(iter_62_0, iter_62_1) then
				var_62_2 = PathFinding.PrioNormal

				if (iter_62_0 ~= arg_62_2.row or iter_62_1 ~= arg_62_2.column) and arg_62_0:ExistFleet(iter_62_0, iter_62_1) then
					var_62_2 = PathFinding.PrioObstacle
				end
			end

			var_62_1[iter_62_0][iter_62_1] = var_62_2
		end
	end

	var_62_0.cells = var_62_1

	return var_62_0:Find(arg_62_1, arg_62_2)
end

function var_0_0.GetMoveRange(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0:CalcFleetSpeed(arg_63_1)
	local var_63_1 = {}

	for iter_63_0 = 0, WorldConst.MaxRow - 1 do
		if not ({})[iter_63_0] then
			({})[iter_63_0] = {}
		end

		for iter_63_1 = 0, WorldConst.MaxColumn - 1 do
			({})[iter_63_0][iter_63_1] = arg_63_0:IsWalkable(iter_63_0, iter_63_1)
		end
	end

	local var_63_2 = {}
	local var_63_3 = {
		{
			step = 0,
			row = arg_63_1.row,
			column = arg_63_1.column
		}
	}

	;({})[arg_63_1.row][arg_63_1.column] = false

	while #{
		{
			step = 0,
			row = arg_63_1.row,
			column = arg_63_1.column
		}
	} > 0 do
		table.insert(var_63_2, (table.remove({
			{
				step = 0,
				row = arg_63_1.row,
				column = arg_63_1.column
			}
		}, 1)))
		_.each({
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
		}, function(arg_64_0)
			arg_64_0.row = var_0.row + arg_64_0.row
			arg_64_0.column = var_0.column + arg_64_0.column
			arg_64_0.step = var_0.step + 1

			if arg_64_0.row >= 0 and arg_64_0.row < WorldConst.MaxRow and arg_64_0.column >= 0 and arg_64_0.column < WorldConst.MaxColumn and arg_64_0.step <= var_63_0 and var_63_1[arg_64_0.row][arg_64_0.column] then
				var_63_1[arg_64_0.row][arg_64_0.column] = false

				if arg_63_0:IsObstacle(arg_64_0.row, arg_64_0.column) then
					table.insert(var_63_2, arg_64_0)
				else
					table.insert(var_63_3, arg_64_0)
				end
			end

			return
		end)
	end

	var_63_2 = _.filter(var_63_2, function(arg_65_0)
		return arg_63_0:IsStayPoint(arg_65_0.row, arg_65_0.column)
	end)

	return var_63_2
end

function var_0_0.BuildLongMoveInfos(arg_66_0)
	for iter_66_0 = 0, WorldConst.MaxRow - 1 do
		local var_66_0 = ({})[iter_66_0]

		if not ({})[iter_66_0] then
			var_66_0 = {}
		end

		;({})[iter_66_0] = var_66_0

		for iter_66_1 = 0, WorldConst.MaxColumn - 1 do
			if arg_66_0:IsWalkable(iter_66_0, iter_66_1) then
				local var_66_1 = arg_66_0:GetCell(iter_66_0, iter_66_1)

				if var_66_1:GetInFOV() then
					({})[iter_66_0][iter_66_1] = {
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

	return {}
end

function var_0_0.GetLongMoveRange(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0:CalcFleetSpeed(arg_67_1)
	local var_67_1 = arg_67_0:BuildLongMoveInfos()
	local var_67_2 = {}
	local var_67_3 = {}

	local function var_67_4(arg_68_0, arg_68_1, arg_68_2)
		return arg_68_0 < arg_68_1 or arg_68_2 < arg_68_0
	end

	local var_67_5 = var_67_1[arg_67_1.row][arg_67_1.column]

	var_67_1[arg_67_1.row][arg_67_1.column].dp[0] = 0
	var_67_5.isMark = true

	;(function(arg_69_0)
		if not arg_69_0 then
			return
		end

		arg_69_0.isFinish = true

		table.insert(var_67_2, arg_69_0)

		if arg_69_0.isStayPoint then
			for iter_69_0 = 1, var_67_0 do
				if arg_69_0.dp[iter_69_0] and (not arg_69_0.dp[0] or arg_69_0.dp[0] > arg_69_0.dp[iter_69_0] + 1) then
					arg_69_0.dp[0] = arg_69_0.dp[iter_69_0] + 1
					arg_69_0.last[0] = arg_69_0.last[iter_69_0]
				end
			end
		end

		return
	end)(var_67_5)

	while var_67_5 do
		_.each({
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
		}, function(arg_70_0)
			if var_67_4(var_67_5.row + arg_70_0.row, 0, WorldConst.MaxRow - 1) or var_67_4(var_67_5.column + arg_70_0.column, 0, WorldConst.MaxColumn - 1) then
				return
			end

			local var_70_0 = var_67_1[var_67_5.row + arg_70_0.row][var_67_5.column + arg_70_0.column]

			if var_67_1[var_67_5.row + arg_70_0.row][var_67_5.column + arg_70_0.column] and not var_70_0.isFinish then
				for iter_70_0 = 1, var_67_0 do
					if var_67_5.dp[iter_70_0 - 1] and (not var_70_0.dp[iter_70_0] or var_70_0.dp[iter_70_0] > var_67_5.dp[iter_70_0 - 1]) then
						var_70_0.dp[iter_70_0] = var_67_5.dp[iter_70_0 - 1]
						var_70_0.last[iter_70_0] = {
							var_67_5,
							iter_70_0 - 1
						}

						if not var_70_0.isMark then
							var_70_0.isMark = true

							table.insert(var_67_3, var_70_0)
						end
					end
				end
			end

			return
		end)

		repeat
			var_67_5 = table.remove({}, 1)

			;(function(arg_69_0)
				if not arg_69_0 then
					return
				end

				arg_69_0.isFinish = true

				table.insert(var_67_2, arg_69_0)

				if arg_69_0.isStayPoint then
					for iter_69_0 = 1, var_67_0 do
						if arg_69_0.dp[iter_69_0] and (not arg_69_0.dp[0] or arg_69_0.dp[0] > arg_69_0.dp[iter_69_0] + 1) then
							arg_69_0.dp[0] = arg_69_0.dp[iter_69_0] + 1
							arg_69_0.last[0] = arg_69_0.last[iter_69_0]
						end
					end
				end

				return
			end)(var_67_5)
		until not var_67_5 or not var_67_5.isObstacle
	end

	local var_67_6 = {}

	for iter_67_0, iter_67_1 in ipairs({}) do
		if iter_67_1.dp[0] and iter_67_1.dp[0] > 0 then
			table.insert(var_67_6, {
				row = iter_67_1.row,
				column = iter_67_1.column,
				stay = iter_67_1.dp[0]
			})
		end
	end

	return var_67_6, var_67_1
end

function var_0_0.IsWalkable(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = arg_71_0:GetCell(arg_71_1, arg_71_2)
	local var_71_1

	if var_71_0 then
		::label_71_0::

		var_71_1 = var_71_0.walkable

		if var_71_0.walkable then
			var_71_1 = var_71_0:CanLeave()
			var_71_1 = var_71_1 or arg_71_0:IsStayPoint(arg_71_1, arg_71_2)
		end
	end

	return var_71_1
end

function var_0_0.IsStayPoint(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = arg_72_0:GetCell(arg_72_1, arg_72_2):CanArrive()

	var_72_0 = var_72_0 and not arg_72_0:ExistFleet(arg_72_1, arg_72_2)

	return var_72_0
end

function var_0_0.IsObstacle(arg_73_0, arg_73_1, arg_73_2)
	return not arg_73_0:GetCell(arg_73_1, arg_73_2):CanPass()
end

function var_0_0.IsSign(arg_74_0, arg_74_1, arg_74_2)
	return arg_74_0:GetCell(arg_74_1, arg_74_2):IsSign()
end

function var_0_0.FindNearestBlankPoint(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = {}

	for iter_75_0 = 0, WorldConst.MaxRow - 1 do
		if not ({})[iter_75_0] then
			({})[iter_75_0] = {}
		end

		for iter_75_1 = 0, WorldConst.MaxColumn - 1 do
			({})[iter_75_0][iter_75_1] = arg_75_0:IsWalkable(iter_75_0, iter_75_1)
		end
	end

	local var_75_1 = {
		row = arg_75_1,
		column = arg_75_2
	}
	local var_75_2 = {}

	while #{
		row = arg_75_1,
		column = arg_75_2
	} > 0 do
		table.insert({}, (table.remove({
			row = arg_75_1,
			column = arg_75_2
		}, 1)))
		_.each({
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
		}, function(arg_76_0)
			arg_76_0.row = var_0.row + arg_76_0.row
			arg_76_0.column = var_0.column + arg_76_0.column

			if arg_76_0.row >= 0 and arg_76_0.row < WorldConst.MaxRow and arg_76_0.column >= 0 and arg_76_0.column < WorldConst.MaxColumn then
				local var_76_0 = _.any(var_75_1, function(arg_77_0)
					return arg_77_0.row == arg_76_0.row and arg_77_0.column == arg_76_0.column
				end) or _.any(var_75_2, function(arg_78_0)
					return arg_78_0.row == arg_76_0.row and arg_78_0.column == arg_76_0.column
				end)

				if not var_76_0 and var_75_0[arg_76_0.row][arg_76_0.column] then
					if arg_75_0:ExistAny(arg_76_0.row, arg_76_0.column) then
						table.insert(var_75_1, arg_76_0)
					else
						return arg_76_0
					end
				end
			end

			return
		end)
	end

	return
end

function var_0_0.WriteBack(arg_79_0, arg_79_1, arg_79_2)
	local var_79_0 = arg_79_0:GetFleet()

	for iter_79_0, iter_79_1 in ipairs(var_79_0:GetShips(true)) do
		table.insert({}, iter_79_1)
	end

	if arg_79_2.statistics.submarineAid then
		local var_79_1 = arg_79_0:GetSubmarineFleet()

		assert(var_79_1, "submarine fleet not exist.")

		for iter_79_2, iter_79_3 in ipairs((var_79_1:GetTeamShips(TeamType.Submarine, true))) do
			table.insert({}, iter_79_3)
		end

		var_79_1:UseAmmo()
		var_79_1:AddDefeatEnemies(arg_79_1)
	end

	var_79_0:AddDefeatEnemies(arg_79_1)
	_.each({}, function(arg_80_0)
		if arg_79_2.statistics[arg_80_0.id] then
			arg_80_0.hpRant = arg_79_2.statistics[arg_80_0.id].bp
		end

		if arg_80_0.hpRant <= 0 then
			arg_80_0:Rebirth()
		end

		return
	end)

	local var_79_2 = arg_79_0:GetCell(var_79_0.row, var_79_0.column):GetStageEnemy()

	assert(var_79_2)

	if arg_79_1 then
		var_79_2:UpdateFlag(1)

		arg_79_0.phaseDisplayList = table.mergeArray(arg_79_0.phaseDisplayList, var_79_2:SetHP(0))

		local var_79_3 = false

		_.each(arg_79_0:GetFleets(), function(arg_81_0)
			var_79_3 = var_79_3 or arg_81_0:HasDamageLevel()

			arg_81_0:ClearDamageLevel()

			return
		end)

		if false then
			table.insert(arg_79_0.phaseDisplayList, 1, {
				story = "W1500",
				hp = var_79_2:GetMaxHP()
			})
		end
	else
		arg_79_0.isLoss = true

		var_79_0:IncDamageLevel(var_79_2)
		var_79_2:UpdateData(var_79_2.data - 1)

		arg_79_0.phaseDisplayList = table.mergeArray(arg_79_0.phaseDisplayList, var_79_2:SetHP(arg_79_2.statistics._maxBossHP))

		local var_79_4 = nowWorld()

		if var_79_4.isAutoFight then
			var_79_4:TriggerAutoFight(false)
			pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_tip_bigworld_dead"))
		end
	end

	_.each(arg_79_2.hpDropInfo, function(arg_82_0)
		local var_82_0 = #arg_79_0.phaseDisplayList + 1

		for iter_82_0, iter_82_1 in ipairs(arg_79_0.phaseDisplayList) do
			if iter_82_1.hp < arg_82_0.hp then
				var_82_0 = iter_82_0

				break
			end
		end

		arg_79_0:AddPhaseDisplay({
			hp = arg_82_0.hp,
			drops = PlayerConst.addTranDrop(arg_82_0.drop_info)
		}, var_82_0)

		return
	end)

	return
end

function var_0_0.AddPhaseDisplay(arg_83_0, arg_83_1, arg_83_2)
	if arg_83_2 then
		table.insert(arg_83_0.phaseDisplayList, arg_83_2, arg_83_1)
	else
		table.insert(arg_83_0.phaseDisplayList, arg_83_1)
	end

	return
end

function var_0_0.FindAttachments(arg_84_0, arg_84_1, arg_84_2)
	for iter_84_0, iter_84_1 in pairs(arg_84_0.typeAttachments) do
		if not arg_84_1 or arg_84_1 == iter_84_0 then
			for iter_84_2, iter_84_3 in ipairs(iter_84_1) do
				if not arg_84_2 or iter_84_3.id == arg_84_2 then
					table.insert({}, iter_84_3)
				end
			end
		end
	end

	return {}
end

function var_0_0.FindEnemys(arg_85_0)
	local var_85_0 = {}

	for iter_85_0, iter_85_1 in pairs(arg_85_0.typeAttachments) do
		if WorldMapAttachment.IsEnemyType(iter_85_0) then
			var_85_0 = table.mergeArray(var_85_0, iter_85_1)
		end
	end

	return var_85_0
end

function var_0_0.GetMapMinMax(arg_86_0)
	local var_86_0 = Vector2(WorldConst.MaxColumn, WorldConst.MaxRow)
	local var_86_1 = Vector2(-WorldConst.MaxColumn, -WorldConst.MaxRow)

	for iter_86_0 = 0, WorldConst.MaxRow - 1 do
		for iter_86_1 = 0, WorldConst.MaxColumn - 1 do
			if arg_86_0:GetCell(iter_86_0, iter_86_1) then
				var_86_0.x = math.min(var_86_0.x, iter_86_1)
				var_86_0.y = math.min(var_86_0.y, iter_86_0)
				var_86_1.x = math.max(var_86_1.x, iter_86_1)
				var_86_1.y = math.max(var_86_1.y, iter_86_0)
			end
		end
	end

	return var_86_0.y, var_86_1.y, var_86_0.x, var_86_1.x
end

function var_0_0.GetMapSize(arg_87_0)
	local var_87_0, var_87_1, var_87_2, var_87_3 = arg_87_0:GetMapMinMax()

	return var_87_1 - var_87_0 + 1, var_87_3 - var_87_2 + 1
end

function var_0_0.CountEventEffectKeys(arg_88_0, arg_88_1)
	local var_88_0 = 0

	for iter_88_0, iter_88_1 in ipairs(arg_88_0:GetNormalFleets()) do
		local var_88_1 = arg_88_0:GetCell(iter_88_1.row, iter_88_1.column):GetAliveAttachment()

		if var_88_1 and var_88_1.type == WorldMapAttachment.TypeEvent and var_88_1:GetEventEffect() == arg_88_1 then
			var_88_0 = var_88_0 + 1
		end
	end

	return var_88_0
end

function var_0_0.EventEffectOpenFOV(arg_89_0, arg_89_1)
	assert(arg_89_1.effect_type == WorldMapAttachment.EffectEventFOV)

	local var_89_0, var_89_1 = unpack(arg_89_1.effect_paramater)

	if var_89_1 < 0 or not var_89_1 then
		var_89_1 = math.abs(var_89_1) - 1
	end

	_.each(arg_89_0:FindAttachments(WorldMapAttachment.TypeEvent, var_89_0), function(arg_90_0)
		arg_89_0.centerCellFOV = {
			row = arg_90_0.row,
			column = arg_90_0.column
		}

		for iter_90_0 = math.max(arg_90_0.row - var_89_1, 0), math.min(arg_90_0.row + var_89_1, WorldConst.MaxRow - 1) do
			for iter_90_1 = math.max(arg_90_0.column - var_89_1, 0), math.min(arg_90_0.column + var_89_1, WorldConst.MaxColumn - 1) do
				if WorldConst.InFOVRange(arg_90_0.row, arg_90_0.column, iter_90_0, iter_90_1, var_89_1) then
					local var_90_0 = arg_89_0:GetCell(iter_90_0, iter_90_1)

					if var_90_0 then
						if var_0 then
							var_90_0:UpdateInFov(bit.bor(var_90_0.infov, WorldConst.FOVEventEffect))
						else
							var_90_0:UpdateInFov(bit.band(var_90_0.infov, WorldConst.Flag16Max - WorldConst.FOVEventEffect))
						end
					end
				end
			end
		end

		return
	end)

	return
end

function var_0_0.OrderAROpenFOV(arg_91_0, arg_91_1)
	if arg_91_1 then
		local var_91_0 = arg_91_0:GetFleet()

		arg_91_0.centerCellFOV = {
			row = var_91_0.row,
			column = var_91_0.column
		}
	end

	for iter_91_0, iter_91_1 in pairs(arg_91_0.cells) do
		if arg_91_1 then
			iter_91_1:UpdateInFov(bit.bor(iter_91_1.infov, WorldConst.FOVEventEffect))
		else
			iter_91_1:UpdateInFov(bit.band(iter_91_1.infov, WorldConst.Flag16Max - WorldConst.FOVEventEffect))
		end
	end

	return
end

function var_0_0.GetMaxDistanceCell(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0
	local var_92_1 = 0

	for iter_92_0, iter_92_1 in pairs({
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
	}) do
		if var_92_1 < (iter_92_1.row - arg_92_1) * (iter_92_1.row - arg_92_1) + (iter_92_1.column - arg_92_2) * (iter_92_1.column - arg_92_2) then
			var_92_0 = iter_92_1
			var_92_1 = (iter_92_1.row - arg_92_1) * (iter_92_1.row - arg_92_1) + (iter_92_1.column - arg_92_2) * (iter_92_1.column - arg_92_2)
		end
	end

	local var_92_3 = math.sqrt(var_92_1)
end

function var_0_0.GetCellsInFOV(arg_93_0)
	for iter_93_0, iter_93_1 in pairs(arg_93_0.cells) do
		if iter_93_1:GetInFOV() then
			table.insert({}, iter_93_1)
		end
	end

	return {}
end

function var_0_0.AlwaysInFOV(arg_94_0)
	return arg_94_0.config.map_sight == 1
end

function var_0_0.GetEventTipWord(arg_95_0)
	local var_95_0 = ""
	local var_95_1 = 0

	for iter_95_0, iter_95_1 in ipairs((arg_95_0:FindAttachments(WorldMapAttachment.TypeEvent))) do
		if iter_95_1:IsAlive() and pg.world_event_desc[iter_95_1.id] and var_95_1 < pg.world_event_desc[iter_95_1.id].hint_pri then
			var_95_1 = pg.world_event_desc[iter_95_1.id].hint_pri
			var_95_0 = pg.world_event_desc[iter_95_1.id].hint
		end
	end

	return var_95_0, var_95_1
end

function var_0_0.GetEventPoisonRate(arg_96_0)
	local var_96_0 = 0

	for iter_96_0, iter_96_1 in ipairs((arg_96_0:FindAttachments(WorldMapAttachment.TypeEvent))) do
		if iter_96_1:IsAlive() then
			var_96_0 = var_96_0 + iter_96_1.config.infection_value
		end
	end

	return var_96_0, arg_96_0.config.is_sairen
end

function var_0_0.GetPressingLevel(arg_97_0)
	return arg_97_0.config.complete_effect
end

function var_0_0.CheckMapPressing(arg_98_0)
	return arg_98_0:GetPressingLevel() > 0 and not arg_98_0.isPressing and arg_98_0:GetEventPoisonRate() == 0
end

function var_0_0.CheckMapPressingDisplay(arg_99_0)
	return arg_99_0:GetPressingLevel() > 1
end

function var_0_0.UpdateClearFlag(arg_100_0, arg_100_1)
	arg_100_0.clearFlag = tobool(arg_100_1)

	return
end

function var_0_0.IsUnlockFleetMode(arg_101_0)
	if arg_101_0.config.move_switch == 1 then
		return true
	elseif arg_101_0.config.move_switch == 0 then
		return false
	else
		assert(false, "config error")
	end

	return
end

function var_0_0.CheckFleetSalvage(arg_102_0, arg_102_1)
	local var_102_0 = underscore.detect(arg_102_0:GetFleets(), function(arg_103_0)
		local var_103_0 = arg_103_0:IsCatSalvage()

		if var_103_0 then
			var_103_0 = arg_102_1 or arg_103_0:IsSalvageFinish() or arg_102_0.salvageAutoResult or arg_103_0.catSalvageFrom ~= arg_102_0.id
		end

		return var_103_0
	end)

	if var_102_0 then
		return var_102_0.id
	else
		arg_102_0.salvageAutoResult = false
	end

	return
end

function var_0_0.GetChapterAuraBuffs(arg_104_0)
	for iter_104_0, iter_104_1 in ipairs(arg_104_0.fleets) do
		for iter_104_2, iter_104_3 in ipairs((iter_104_1:getMapAura())) do
			table.insert({}, iter_104_3)
		end
	end

	return {}
end

function var_0_0.GetChapterAidBuffs(arg_105_0)
	for iter_105_0, iter_105_1 in ipairs(arg_105_0.fleets) do
		if iter_105_0 ~= arg_105_0.findex then
			for iter_105_2, iter_105_3 in pairs((iter_105_1:getMapAid())) do
				({})[iter_105_2] = iter_105_3
			end
		end
	end

	return {}
end

function var_0_0.getFleetBattleBuffs(arg_106_0, arg_106_1, arg_106_2)
	local var_106_0 = {}

	underscore.each(arg_106_1:GetBuffList(), function(arg_107_0)
		if arg_107_0.config.lua_id ~= 0 then
			table.insert(var_106_0, arg_107_0.config.lua_id)
		end

		return
	end)

	local var_106_1 = {}

	if arg_106_2 and arg_106_1:IsCatSalvage() then
		-- block empty
	else
		var_106_1 = arg_106_0:BuildBattleBuffList(arg_106_1)
	end

	return {}, var_106_1
end

function var_0_0.BuildBattleBuffList(arg_108_0, arg_108_1)
	local var_108_0, var_108_1 = arg_108_0:triggerSkill(arg_108_1, FleetSkill.TypeBattleBuff)

	if var_108_0 and #var_108_0 > 0 then
		for iter_108_0, iter_108_1 in ipairs(var_108_0) do
			local var_108_2 = arg_108_1:findCommanderBySkillId(var_108_1[iter_108_0].id)
			local var_108_3 = ({})[var_108_2]

			if not ({})[var_108_2] then
				var_108_3 = {}
			end

			;({})[var_108_2] = var_108_3

			table.insert(({})[var_108_2], iter_108_1)
		end

		for iter_108_2, iter_108_3 in pairs({}) do
			table.insert({}, {
				iter_108_2,
				iter_108_3
			})
		end
	end

	for iter_108_4, iter_108_5 in pairs((arg_108_1:getCommanders())) do
		for iter_108_6, iter_108_7 in ipairs((iter_108_5:getTalents())) do
			local var_108_4 = iter_108_7:getBuffsAddition()

			if #var_108_4 > 0 then
				local var_108_5

				for iter_108_8, iter_108_9 in ipairs({}) do
					if iter_108_9[1] == iter_108_5 then
						var_108_5 = iter_108_9[2]

						break
					end
				end

				if not var_108_5 then
					var_108_5 = {}

					table.insert({}, {
						iter_108_5,
						{}
					})
				end

				for iter_108_10, iter_108_11 in ipairs(var_108_4) do
					table.insert(var_108_5, iter_108_11)
				end
			end
		end
	end

	return {}
end

function var_0_0.CanLongMove(arg_109_0, arg_109_1)
	return arg_109_0:IsUnlockFleetMode() and not arg_109_1:HasTrapBuff() and arg_109_0:GetFleetTerrain(arg_109_1) ~= WorldMapCell.TerrainFog
end

function var_0_0.triggerSkill(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = _.filter(arg_110_1:findSkills(arg_110_2), function(arg_111_0)
		return _.any(arg_111_0:GetTriggers(), function(arg_112_0)
			return arg_112_0[1] == FleetSkill.TriggerInSubTeam and arg_112_0[2] == 1
		end) == (arg_110_1:GetFleetType() == FleetType.Submarine) and _.all(arg_111_0:GetTriggers(), function(arg_113_0)
			return arg_110_0:triggerCheck(arg_110_1, arg_111_0, arg_113_0)
		end)
	end)

	return _.reduce(var_110_0, nil, function(arg_114_0, arg_114_1)
		local var_114_0 = arg_114_1:GetType()
		local var_114_1 = arg_114_1:GetArgs()

		if var_114_0 == FleetSkill.TypeMoveSpeed or var_114_0 == FleetSkill.TypeHuntingLv or var_114_0 == FleetSkill.TypeTorpedoPowerUp then
			return (arg_114_0 or 0) + var_114_1[1]
		elseif var_114_0 == FleetSkill.TypeAmbushDodge or var_114_0 == FleetSkill.TypeAirStrikeDodge then
			return math.max(arg_114_0 or 0, var_114_1[1])
		elseif var_114_0 == FleetSkill.TypeAttack or var_114_0 == FleetSkill.TypeStrategy then
			arg_114_0 = arg_114_0 or {}

			table.insert(arg_114_0, var_114_1)

			return arg_114_0
		elseif var_114_0 == FleetSkill.TypeBattleBuff then
			arg_114_0 = arg_114_0 or {}

			table.insert(arg_114_0, var_114_1[1])

			return arg_114_0
		end

		return
	end), var_110_0
end

function var_0_0.triggerCheck(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	if arg_115_3[1] == FleetSkill.TriggerDDHead then
		local var_115_0 = arg_115_1:GetTeamShipVOs(TeamType.Vanguard, false)

		return #var_115_0 > 0 and ShipType.IsTypeQuZhu(var_115_0[1]:getShipType())
	elseif arg_115_3[1] == FleetSkill.TriggerVanCount then
		local var_115_1 = arg_115_1:GetTeamShipVOs(TeamType.Vanguard, false)

		return #var_115_1 >= arg_115_3[2] and #var_115_1 <= arg_115_3[3]
	elseif arg_115_3[1] == FleetSkill.TriggerShipCount then
		local var_115_2 = _.filter(arg_115_1:GetShipVOs(false), function(arg_116_0)
			return table.contains(arg_115_3[2], arg_116_0:getShipType())
		end)

		return #var_115_2 >= arg_115_3[3] and #var_115_2 <= arg_115_3[4]
	elseif arg_115_3[1] == FleetSkill.TriggerAroundEnemy then
		for iter_115_0 = -arg_115_3[2], arg_115_3[2] do
			local var_115_3 = arg_115_3[2] - math.abs(iter_115_0)

			for iter_115_1 = -var_115_3, var_115_3 do
				table.insert({}, (arg_115_0:GetCell(({
					row = arg_115_1.row,
					column = arg_115_1.column
				}).row + iter_115_0, ({
					row = arg_115_1.row,
					column = arg_115_1.column
				}).column + iter_115_1)))
			end
		end

		return underscore.any({}, function(arg_117_0)
			local var_117_0 = arg_117_0:ExistEnemy() and arg_117_0:GetStageEnemy().config.type or nil

			return type(arg_115_3[3]) == "number" and arg_115_3[3] == var_117_0 or type(arg_115_3[3]) == "table" and table.contains(arg_115_3[3], var_117_0)
		end)
	elseif arg_115_3[1] == FleetSkill.TriggerNekoPos then
		local var_115_4 = arg_115_1:findCommanderBySkillId(arg_115_2.id)

		for iter_115_2, iter_115_3 in pairs(arg_115_1:getCommanders()) do
			if var_115_4.id == iter_115_3.id and iter_115_2 == arg_115_3[2] then
				return true
			end
		end
	elseif arg_115_3[1] == FleetSkill.TriggerAroundLand then
		for iter_115_4 = -arg_115_3[2], arg_115_3[2] do
			local var_115_5 = arg_115_3[2] - math.abs(iter_115_4)

			for iter_115_5 = -var_115_5, var_115_5 do
				if arg_115_0:GetCell(({
					row = arg_115_1.row,
					column = arg_115_1.column
				}).row + iter_115_4, ({
					row = arg_115_1.row,
					column = arg_115_1.column
				}).column + iter_115_5) and not arg_115_0:IsWalkable(({
					row = arg_115_1.row,
					column = arg_115_1.column
				}).row + iter_115_4, ({
					row = arg_115_1.row,
					column = arg_115_1.column
				}).column + iter_115_5) then
					return true
				end
			end
		end

		return false
	elseif arg_115_3[1] == FleetSkill.TriggerAroundCombatAlly then
		local var_115_6 = {
			row = arg_115_1.row,
			column = arg_115_1.column
		}

		return _.any(arg_115_0.fleets, function(arg_118_0)
			if arg_115_1.id ~= arg_118_0.id and arg_118_0:GetFleetType() == FleetType.Normal then
				local var_118_0 = arg_115_0:GetCell(arg_118_0.line.row, arg_118_0.line.column):ExistEnemy()

				if var_118_0 then
					var_118_0 = ManhattonDist(var_115_6, {
						row = arg_118_0.line.row,
						column = arg_118_0.line.column
					}) <= arg_115_3[2]
				end

				return var_118_0
			end
		end)
	elseif arg_115_3[1] == FleetSkill.TriggerInSubTeam then
		return true
	else
		assert(false, "invalid trigger type: " .. arg_115_3[1])
	end

	return
end

function var_0_0.OnUpdateAttachmentExist(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	arg_119_0.typeAttachments[arg_119_3.type] = arg_119_0.typeAttachments[arg_119_3.type] or {}

	if arg_119_1 == WorldMapCell.EventAddAttachment then
		table.insert(arg_119_0.typeAttachments[arg_119_3.type], arg_119_3)
	elseif arg_119_1 == WorldMapCell.EventRemoveAttachment then
		table.removebyvalue(arg_119_0.typeAttachments[arg_119_3.type], arg_119_3)
	end

	local var_119_0 = arg_119_3:GetVisionRadius()

	if var_119_0 > 0 then
		local var_119_1 = 0

		if arg_119_1 == WorldMapCell.EventAddAttachment then
			var_119_1 = var_119_1 + 1
		elseif arg_119_1 == WorldMapCell.EventRemoveAttachment then
			var_119_1 = var_119_1 - 1
		else
			assert(false, "listener event error: " .. arg_119_1)
		end

		arg_119_0.centerCellFOV = {
			row = arg_119_2.row,
			column = arg_119_2.column
		}

		for iter_119_0 = arg_119_2.row - var_119_0, arg_119_2.row + var_119_0 do
			for iter_119_1 = arg_119_2.column - var_119_0, arg_119_2.column + var_119_0 do
				local var_119_2 = arg_119_0:GetCell(iter_119_0, iter_119_1)

				if var_119_2 and WorldConst.InFOVRange(arg_119_2.row, arg_119_2.column, var_119_2.row, var_119_2.column, var_119_0) then
					var_119_2:ChangeInLight(var_119_1 > 0)
				end
			end
		end
	end

	local var_119_3 = arg_119_3:GetRadiationBuffs()

	if #var_119_3 > 0 then
		for iter_119_2, iter_119_3 in ipairs(var_119_3) do
			local var_119_4, var_119_5, var_119_6 = unpack(iter_119_3)

			if arg_119_1 == WorldMapCell.EventAddAttachment then
				({})[var_119_4] = true

				arg_119_0:AddBuff(var_119_4, var_119_5, var_119_6)
			elseif arg_119_1 == WorldMapCell.EventRemoveAttachment then
				({})[var_119_4] = true

				arg_119_0:RemoveBuff(var_119_4, var_119_5, var_119_6)
			end
		end

		for iter_119_4, iter_119_5 in pairs({}) do
			if iter_119_5 then
				arg_119_0:FlushFaction(iter_119_4)
			end
		end
	end

	return
end

function var_0_0.GetBGM(arg_120_0)
	return arg_120_0.config.bgm
end

function var_0_0.NeedClear(arg_121_0)
	local var_121_0, var_121_1 = arg_121_0:GetEventPoisonRate()

	if var_121_1 <= 0 or var_121_0 ~= 0 then
		local var_121_2 = arg_121_0.clearFlag

		if not arg_121_0.clearFlag then
			if arg_121_0.config.is_clear <= 0 then
				var_121_2 = false

				goto label_121_0
			end

			var_121_2 = true
		end

		::label_121_0::

		return var_121_2
	end
end

function var_0_0.GetBuff(arg_122_0, arg_122_1, arg_122_2)
	if not arg_122_0.factionBuffs[arg_122_1][arg_122_2] then
		arg_122_0.factionBuffs[arg_122_1][arg_122_2] = WorldBuff.New()

		arg_122_0.factionBuffs[arg_122_1][arg_122_2]:Setup({
			floor = 0,
			id = arg_122_2
		})
	end

	return arg_122_0.factionBuffs[arg_122_1][arg_122_2]
end

function var_0_0.AddBuff(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
	arg_123_0:GetBuff(arg_123_1, arg_123_2):AddFloor(arg_123_3)

	return
end

function var_0_0.RemoveBuff(arg_124_0, arg_124_1, arg_124_2, arg_124_3)
	if arg_124_3 then
		arg_124_0:GetBuff(arg_124_1, arg_124_2):AddFloor(arg_124_3 * -1)
	else
		arg_124_0.factionBuffs[arg_124_1][arg_124_2] = nil
	end

	return
end

function var_0_0.GetBuffList(arg_125_0, arg_125_1, arg_125_2)
	if arg_125_1 == var_0_0.FactionSelf then
		return underscore.filter(underscore.values(arg_125_0.factionBuffs[arg_125_1]), function(arg_126_0)
			return arg_126_0:GetFloor() > 0
		end)
	elseif arg_125_1 == var_0_0.FactionEnemy then
		if WorldMapAttachment.IsEnemyType(arg_125_2.type) or arg_125_2.type == WorldMapAttachment.TypeEvent and arg_125_2:GetSpEventType() == WorldMapAttachment.SpEventEnemy then
			return underscore.filter(underscore.values(arg_125_0.factionBuffs[arg_125_1]), function(arg_127_0)
				return arg_127_0:GetFloor() > 0
			end)
		else
			return {}
		end
	else
		assert(false, string.format("faction error: $d", arg_125_1))
	end

	return
end

function var_0_0.FlushFaction(arg_128_0, arg_128_1)
	if arg_128_1 == var_0_0.FactionSelf then
		underscore.each(arg_128_0:GetFleets(), function(arg_129_0)
			arg_129_0:DispatchEvent(WorldMapFleet.EventUpdateBuff)

			return
		end)
	elseif arg_128_1 == var_0_0.FactionEnemy then
		local var_128_0 = {}

		underscore.each(arg_128_0:FindEnemys(), function(arg_130_0)
			var_128_0[WorldMapCell.GetName(arg_130_0.row, arg_130_0.column)] = true

			return
		end)
		underscore.each(arg_128_0:FindAttachments(WorldMapAttachment.TypeEvent), function(arg_131_0)
			if arg_131_0:GetSpEventType() == WorldMapAttachment.SpEventEnemy then
				var_128_0[WorldMapCell.GetName(arg_131_0.row, arg_131_0.column)] = true
			end

			return
		end)

		for iter_128_0 in pairs({}) do
			arg_128_0.cells[iter_128_0]:DispatchEvent(var_0_0.EventUpdateMapBuff)
		end
	else
		assert(false, string.format("faction error: $d", arg_128_1))
	end

	return
end

function var_0_0.GetBattleLuaBuffs(arg_132_0, arg_132_1, arg_132_2)
	local var_132_0 = {}

	underscore.each(arg_132_0:GetBuffList(arg_132_1, arg_132_2), function(arg_133_0)
		if arg_133_0.config.lua_id > 0 then
			table.insert(var_132_0, arg_133_0.config.lua_id)
		end

		return
	end)

	return {}
end

function var_0_0.UpdateFleetLocation(arg_134_0, arg_134_1, arg_134_2, arg_134_3)
	local var_134_0 = arg_134_0:GetFleet(arg_134_1)

	assert(var_134_0, "without this fleet : " .. arg_134_1)

	if var_134_0.row ~= arg_134_2 or var_134_0.column ~= arg_134_3 then
		arg_134_0:CheckFleetUpdateFOV(var_134_0, function()
			var_134_0.row = arg_134_2
			var_134_0.column = arg_134_3

			return
		end)
		var_134_0:DispatchEvent(WorldMapFleet.EventUpdateLocation)
	end

	return
end

function var_0_0.GetRangeDic(arg_136_0, arg_136_1)
	local var_136_0 = {}

	WorldConst.RangeCheck(arg_136_1, arg_136_0:GetFOVRange(arg_136_1), function(arg_137_0, arg_137_1)
		local var_137_0 = WorldMapCell.GetName(arg_137_0, arg_137_1)

		if arg_136_0.cells[var_137_0] then
			var_136_0[var_137_0] = defaultValue(var_136_0[var_137_0], 0) + 1
		end

		return
	end)

	return {}
end

function var_0_0.CheckFleetUpdateFOV(arg_138_0, arg_138_1, arg_138_2)
	if not arg_138_0:IsValid() then
		arg_138_2()

		return
	end

	local var_138_0 = arg_138_0:GetRangeDic(arg_138_1)
	local var_138_1 = arg_138_0:GetFleetTerrain(arg_138_1) == WorldMapCell.TerrainFog
	local var_138_2 = arg_138_0:IsFleetTerrainSairenFog(arg_138_1)
	local var_138_3 = arg_138_0:CalcFleetSpeed(arg_138_1)

	arg_138_2()

	local var_138_4 = arg_138_0:GetRangeDic(arg_138_1)
	local var_138_5 = arg_138_0:GetFleetTerrain(arg_138_1) == WorldMapCell.TerrainFog
	local var_138_6 = arg_138_0:IsFleetTerrainSairenFog(arg_138_1)
	local var_138_7 = arg_138_0:CalcFleetSpeed(arg_138_1)

	arg_138_0.centerCellFOV = {
		row = arg_138_1.row,
		column = arg_138_1.column
	}

	local var_138_8 = false
	local var_138_9 = false

	if not var_138_1 then
		for iter_138_0, iter_138_1 in pairs(var_138_0) do
			({})[iter_138_0] = defaultValue(({})[iter_138_0], 0) - iter_138_1
		end
	end

	if not var_138_5 then
		for iter_138_2, iter_138_3 in pairs(var_138_4) do
			({})[iter_138_2] = defaultValue(({})[iter_138_2], 0) + iter_138_3
		end
	end

	for iter_138_4, iter_138_5 in pairs({}) do
		if iter_138_5 ~= 0 then
			arg_138_0.cells[iter_138_4]:ChangeInLight(iter_138_5 > 0)

			var_138_8 = true
		end
	end

	if arg_138_0:GetFleet() == arg_138_1 then
		if var_138_1 then
			for iter_138_6, iter_138_7 in pairs(var_138_0) do
				({})[iter_138_6] = defaultValue(({})[iter_138_6], 0) - iter_138_7
			end
		end

		if var_138_5 then
			for iter_138_8, iter_138_9 in pairs(var_138_4) do
				({})[iter_138_8] = defaultValue(({})[iter_138_8], 0) + iter_138_9
			end
		end

		if var_138_1 ~= var_138_5 or var_138_2 ~= var_138_6 then
			for iter_138_10, iter_138_11 in pairs(arg_138_0.cells) do
				local var_138_10

				if ({})[iter_138_10] and ({})[iter_138_10] ~= 0 then
					var_138_10 = ({})[iter_138_10] > 0
				end

				iter_138_11:UpdateFog(var_138_5, var_138_10, var_138_6)
			end

			var_138_8 = true
		else
			for iter_138_12, iter_138_13 in pairs({}) do
				if iter_138_13 ~= 0 then
					arg_138_0.cells[iter_138_12]:UpdateFog(nil, iter_138_13 > 0, nil)

					var_138_8 = true
				end
			end
		end

		if var_138_3 ~= var_138_7 then
			var_138_9 = true
		end
	end

	if var_138_8 then
		arg_138_0:DispatchEvent(var_0_0.EventUpdateFleetFOV)
	end

	if var_138_9 then
		arg_138_0:DispatchEvent(var_0_0.EventUpdateMoveSpeed)
	end

	return
end

function var_0_0.CheckSelectFleetUpdateFog(arg_139_0, arg_139_1)
	if not arg_139_0:IsValid() then
		arg_139_1()

		return
	end

	local var_139_0 = arg_139_0:GetFleet()
	local var_139_1 = arg_139_0:GetRangeDic(var_139_0)
	local var_139_2 = arg_139_0:GetFleetTerrain(var_139_0) == WorldMapCell.TerrainFog
	local var_139_3 = arg_139_0:IsFleetTerrainSairenFog(var_139_0)

	arg_139_1()

	local var_139_4 = arg_139_0:GetFleet()
	local var_139_5 = arg_139_0:GetRangeDic(var_139_4)
	local var_139_6 = arg_139_0:GetFleetTerrain(var_139_4) == WorldMapCell.TerrainFog
	local var_139_7 = arg_139_0:IsFleetTerrainSairenFog(var_139_4)

	arg_139_0.centerCellFOV = {
		row = var_139_4.row,
		column = var_139_4.column
	}

	if var_139_2 then
		for iter_139_0, iter_139_1 in pairs(var_139_1) do
			({})[iter_139_0] = defaultValue(({})[iter_139_0], 0) - iter_139_1
		end
	end

	if var_139_6 then
		for iter_139_2, iter_139_3 in pairs(var_139_5) do
			({})[iter_139_2] = defaultValue(({})[iter_139_2], 0) + iter_139_3
		end
	end

	if var_139_2 ~= var_139_6 or var_139_3 ~= var_139_7 then
		for iter_139_4, iter_139_5 in pairs(arg_139_0.cells) do
			local var_139_8

			if ({})[iter_139_4] and ({})[iter_139_4] ~= 0 then
				var_139_8 = ({})[iter_139_4] > 0
			end

			iter_139_5:UpdateFog(var_139_6, var_139_8, var_139_7)
		end
	else
		for iter_139_6, iter_139_7 in pairs({}) do
			if iter_139_7 ~= 0 then
				arg_139_0.cells[iter_139_6]:UpdateFog(nil, iter_139_7 > 0, nil)
			end
		end
	end

	arg_139_0:DispatchEvent(var_0_0.EventUpdateFleetFOV)

	return
end

function var_0_0.CheckEventAutoTrigger(arg_140_0, arg_140_1)
	if arg_140_1:GetSpEventType() == WorldMapAttachment.SpEventConsumeItem then
		return getProxy(SettingsProxy):GetWorldFlag("consume_item")
	end

	local var_140_0 = arg_140_1:GetEventEffect()

	if var_140_0 then
		local var_140_1 = arg_140_0:GetFleet()

		if var_140_0.effect_type == WorldMapAttachment.EffectEventConsumeCarry then
			local var_140_2 = var_140_0.effect_paramater[1] or {}

			return not underscore.any(var_140_2, function(arg_141_0)
				return not var_140_1:ExistCarry(arg_141_0)
			end)
		elseif var_140_0.effect_type == WorldMapAttachment.EffectEventCatSalvage then
			return var_140_1:GetDisplayCommander() and not var_140_1:IsCatSalvage()
		end
	end

	return true
end

function var_0_0.CanAutoFight(arg_142_0)
	if arg_142_0.config.is_auto > 0 then
		for iter_142_0 = 1, arg_142_0.config.is_auto do
			local var_142_0 = nowWorld()

			if not var_142_0:IsSystemOpen(WorldConst["SystemAutoFight_" .. iter_142_0]) then
				return false
			end
		end

		return true
	else
		return false
	end

	return
end

function var_0_0.CkeckTransport(arg_143_0)
	assert(arg_143_0:IsValid(), "without map info")

	if arg_143_0.config.is_transfer == 0 then
		local var_143_1 = i18n("world_transport_disable")

		return
	end

	if arg_143_0:CheckAttachmentTransport() == "block" then
		local var_143_3 = i18n("world_movelimit_event_text")

		return
	end

	local var_143_4 = nowWorld()

	if var_143_4:CheckTaskLockMap() then
		local var_143_6 = i18n("world_task_maplock")

		return
	end

	return true
end

return var_0_0
