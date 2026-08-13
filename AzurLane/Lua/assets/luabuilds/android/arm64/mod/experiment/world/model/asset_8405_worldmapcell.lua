class = var_0_10000

local var_0_0 = "WorldMapCell"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	inLight = "number",
	row = "number",
	fogLight = "boolean",
	terrain = "number",
	dir = "number",
	column = "number",
	walkable = "boolean",
	terrainDir = "number",
	discovered = "boolean",
	attachments = "table",
	fogSairen = "boolean",
	fog = "boolean",
	terrainStrong = "number",
	infov = "number"
}
var_0_1.EventAddAttachment = "WorldMapCell.EventAddAttachment"
var_0_1.EventRemoveAttachment = "WorldMapCell.EventRemoveAttachment"
var_0_1.EventUpdateInFov = "WorldMapCell.EventUpdateInFov"
var_0_1.EventUpdateDiscovered = "WorldMapCell.EventUpdateDiscovered"
var_0_1.EventUpdateFog = "WorldMapCell.EventUpdateFog"
var_0_1.EventUpdateFogImage = "WorldMapCell.EventUpdateFogImage"
var_0_1.EventUpdateTerrain = "WorldMapCell.EventUpdateTerrain"

function var_0_1.GetName(arg_1_0, arg_1_1)
	return "cell_" .. arg_1_0 .. "_" .. arg_1_1
end

var_0_1.TerrainNone = 0
var_0_1.TerrainStream = 1
var_0_1.TerrainIce = 2
var_0_1.TerrainWind = 3
var_0_1.TerrainFog = 4
var_0_1.TerrainFire = 5
var_0_1.TerrainPoison = 6

function var_0_1.Build(arg_2_0)
	arg_2_0.attachments = {}
	arg_2_0.dir = 0
	arg_2_0.infov = 0
	arg_2_0.inLight = 0
	arg_2_0.fog = false
	arg_2_0.fogLight = false
	arg_2_0.fogSairen = false

	return
end

function var_0_1.Setup(arg_3_0, arg_3_1)
	arg_3_0.row = arg_3_1[1]
	arg_3_0.column = arg_3_1[2]
	arg_3_0.walkable = arg_3_1[3]

	return
end

function var_0_1.Dispose(arg_4_0)
	WPool = var_1_10001

	var_1_10001:ReturnArray(arg_4_0.attachments)
	arg_4_0:Clear()

	return
end

function var_0_1.AddAttachment(arg_5_0, arg_5_1)
	assert = var_1_10002
	_ = var_1_10004

	var_1_10002(not var_1_10004.any(arg_5_0.attachments, function(arg_6_0)
		return arg_6_0.row == arg_5_1.row and arg_6_0.column == arg_5_1.column and arg_6_0.type == arg_5_1.type and arg_6_0.id == arg_5_1.id
	end))

	assert = var_1_10002

	var_1_10002(arg_5_1.row == arg_5_0.row and arg_5_1.column == arg_5_0.column)

	assert = var_1_10002
	WorldMapAttachment = var_4

	var_1_10002(var_4.SortOrder[arg_5_1.type], arg_5_1.type .. " : sort order not set.")

	WorldMapAttachment = var_1_10002

	local var_5_0 = var_1_10002.SortOrder[arg_5_1.type]
	local var_5_1 = #arg_5_0.attachments + 1

	ipairs = var_4

	for iter_5_0, iter_5_1 in var_4(arg_5_0.attachments) do
		WorldMapAttachment = var_1_10009

		if var_1_10009.SortOrder[iter_5_1.type] < var_5_0 then
			var_5_1 = iter_5_0

			break
		end
	end

	table = var_4

	var_4.insert(arg_5_0.attachments, var_5_1, arg_5_1)
	arg_5_0:DispatchEvent(var_0_1.EventAddAttachment, arg_5_1)

	if not arg_5_0.discovered and arg_5_1:ShouldMarkAsLurk() then
		arg_5_1:UpdateLurk(true)
	end

	return
end

function var_0_1.RemoveAttachment(arg_7_0, arg_7_1)
	if arg_7_1 ~= nil then
		type = var_1_10002

		if var_1_10002(arg_7_1) == "number" then
			arg_7_1 = arg_7_1 or #arg_7_0.attachments
			assert = var_1_10002

			var_1_10002(arg_7_1 >= 1 and arg_7_1 <= #arg_7_0.attachments)

			local var_7_0 = arg_7_0.attachments[arg_7_1]

			table = var_1_10003

			var_1_10003.remove(arg_7_0.attachments, arg_7_1)
			arg_7_0:DispatchEvent(var_0_1.EventRemoveAttachment, var_7_0)

			WPool = var_1_10003

			var_1_10003:Return(var_7_0)
		else
			local var_7_1 = arg_7_1.class

			WorldMapAttachment = var_1_10003

			if var_7_1 == var_1_10003 then
				for iter_7_0 = #arg_7_0.attachments, 1, -1 do
					if arg_7_0.attachments[iter_7_0] == arg_7_1 then
						arg_7_0:RemoveAttachment(iter_7_0)

						break
					end
				end
			end
		end

		return
	end
end

function var_0_1.ContainsAttachment(arg_8_0, arg_8_1)
	_ = var_1_10002

	return var_1_10002.any(arg_8_0.attachments, function(arg_9_0)
		return arg_9_0 == arg_8_1
	end)
end

function var_0_1.GetInFOV(arg_10_0)
	if arg_10_0.fog then
		return arg_10_0.fogLight
	else
		return arg_10_0.infov > 0 or arg_10_0.inLight > 0
	end

	return
end

function var_0_1.UpdateInFov(arg_11_0, arg_11_1)
	AfterCheck = var_1_10002

	var_1_10002({
		{
			function()
				local var_12_0 = arg_11_0

				return var_0.GetInFOV(var_12_0)
			end,
			function()
				local var_13_0 = arg_11_0

				var_0.DispatchEvent(var_13_0, var_0_1.EventUpdateInFov)

				return
			end
		}
	}, function()
		arg_11_0.infov = arg_11_1

		return
	end)

	return
end

function var_0_1.ChangeInLight(arg_15_0, arg_15_1)
	AfterCheck = var_1_10002

	var_1_10002({
		{
			function()
				local var_16_0 = arg_15_0

				return var_0.GetInFOV(var_16_0)
			end,
			function()
				local var_17_0 = arg_15_0

				var_0.DispatchEvent(var_17_0, var_0_1.EventUpdateInFov)

				return
			end
		}
	}, function()
		arg_15_0.inLight = arg_15_0.inLight + (arg_15_1 and 1 or -1)

		return
	end)

	return
end

function var_0_1.InFog(arg_19_0)
	if arg_19_0.fog then
		return not arg_19_0.fogLight
	else
		return arg_19_0:GetTerrain() == var_0_1.TerrainFog
	end

	return
end

function var_0_1.LookSairenFog(arg_20_0)
	local var_20_0

	if not arg_20_0.fogSairen then
		var_20_0 = arg_20_0:IsTerrainSairenFog()
	end

	return var_20_0
end

function var_0_1.UpdateFog(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	AfterCheck = var_1_10004

	var_1_10004({
		{
			function()
				local var_22_0 = arg_21_0

				return var_0.GetInFOV(var_22_0)
			end,
			function()
				local var_23_0 = arg_21_0

				var_0.DispatchEvent(var_23_0, var_0_1.EventUpdateInFov)

				return
			end
		},
		{
			function()
				local var_24_0 = arg_21_0

				return var_0.InFog(var_24_0)
			end,
			function()
				local var_25_0 = arg_21_0

				var_0.DispatchEvent(var_25_0, var_0_1.EventUpdateFog)

				return
			end
		},
		{
			function()
				local var_26_0 = arg_21_0

				return var_0.LookSairenFog(var_26_0)
			end,
			function()
				local var_27_0 = arg_21_0

				var_0.DispatchEvent(var_27_0, var_0_1.EventUpdateFogImage)

				return
			end
		}
	}, function()
		local var_28_0 = arg_21_0

		defaultValue = var_2_10001
		var_28_0.fog = var_2_10001(arg_21_1, arg_21_0.fog)

		local var_28_1 = arg_21_0

		defaultValue = var_1
		var_28_1.fogLight = var_1(arg_21_2, arg_21_0.fogLight)

		local var_28_2 = arg_21_0

		defaultValue = var_1
		var_28_2.fogSairen = var_1(arg_21_3, arg_21_0.fogSairen)

		return
	end)

	return
end

function var_0_1.UpdateDiscovered(arg_29_0, arg_29_1)
	if arg_29_0.discovered ~= arg_29_1 then
		arg_29_0.discovered = arg_29_1

		arg_29_0:DispatchEvent(var_0_1.EventUpdateDiscovered)
	end

	return
end

function var_0_1.GetTerrain(arg_30_0)
	local var_30_0

	if not arg_30_0.terrain then
		var_30_0 = var_0_1.TerrainNone
	end

	return var_30_0
end

function var_0_1.UpdateTerrain(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	AfterCheck = var_1_10004

	var_1_10004({
		{
			function()
				local var_32_0 = arg_31_0

				return var_0.InFog(var_32_0)
			end,
			function()
				local var_33_0 = arg_31_0

				var_0.DispatchEvent(var_33_0, var_0_1.EventUpdateFog)

				return
			end
		},
		{
			function()
				local var_34_0 = arg_31_0

				return var_0.LookSairenFog(var_34_0)
			end,
			function()
				local var_35_0 = arg_31_0

				var_0.DispatchEvent(var_35_0, var_0_1.EventUpdateFogImage)

				return
			end
		}
	}, function()
		arg_31_0.terrain = arg_31_1

		if arg_31_0.terrain == var_0_1.TerrainStream then
			assert = var_0

			var_0(arg_31_2)

			arg_31_0.terrainDir = arg_31_2
		elseif arg_31_0.terrain == var_0_1.TerrainWind then
			assert = var_0

			local var_36_0

			if arg_31_2 then
				var_36_0 = arg_31_3
			end

			var_0(var_36_0)

			arg_31_0.terrainDir = arg_31_2
			arg_31_0.terrainStrong = arg_31_3
		elseif arg_31_0.terrain == var_0_1.TerrainFog then
			arg_31_0.terrainStrong = arg_31_3
		elseif arg_31_0.terrain == var_0_1.TerrainPoison then
			arg_31_0.terrainStrong = arg_31_3
		end

		local var_36_1 = arg_31_0

		var_0.DispatchEvent(var_36_1, var_0_1.EventUpdateTerrain)

		return
	end)

	return
end

function var_0_1.GetAliveAttachments(arg_37_0)
	_ = var_1_10001

	return var_1_10001.filter(arg_37_0.attachments, function(arg_38_0)
		return arg_38_0:IsAlive()
	end)
end

function var_0_1.GetAliveAttachment(arg_39_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_39_0.attachments, function(arg_40_0)
		return arg_40_0:IsAlive()
	end)
end

function var_0_1.GetDisplayAttachment(arg_41_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_41_0.attachments, function(arg_42_0)
		local var_42_0

		if arg_42_0:IsAlive() then
			var_42_0 = arg_42_0:IsVisible()
		end

		return var_42_0
	end)
end

function var_0_1.GetInterativeAttachment(arg_43_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_43_0.attachments, function(arg_44_0)
		WorldMapAttachment = var_2_10001

		local var_44_0

		if var_2_10001.IsInteractiveType(arg_44_0.type) and arg_44_0:IsAlive() then
			var_44_0 = arg_44_0:IsVisible()
		end

		return var_44_0
	end)
end

function var_0_1.GetEventAttachment(arg_45_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_45_0.attachments, function(arg_46_0)
		local var_46_0

		if arg_46_0:IsAlive() then
			var_46_0 = arg_46_0.type
			WorldMapAttachment = var_2_10002
			var_46_0 = var_46_0 == var_2_10002.TypeEvent
		end

		return var_46_0
	end)
end

function var_0_1.GetCompassAttachment(arg_47_0)
	local var_47_0 = {}

	ipairs = var_1_10002

	for iter_47_0, iter_47_1 in var_1_10002(arg_47_0.attachments) do
		table = var_1_10007

		var_1_10007.insert(var_47_0, iter_47_0)
	end

	_ = var_2

	local var_47_1 = var_2.detect

	_ = var_4

	return var_47_1(var_4.sort(var_47_0, function(arg_48_0, arg_48_1)
		local var_48_0

		if not arg_47_0.attachments[arg_48_0].config.compass_index then
			var_48_0 = 0
		end

		local var_48_1

		if not arg_47_0.attachments[arg_48_1].config.compass_index then
			var_48_1 = 0
		end

		return var_48_1 < var_48_0
	end), function(arg_49_0)
		local var_49_0 = arg_47_0.attachments[arg_49_0]

		if var_1.ShouldMarkAsLurk(var_49_0) then
			local var_49_1

			if var_1:IsAlive() and var_1:IsVisible() then
				var_49_1 = arg_47_0.discovered
			end

			return var_49_1
		else
			local var_49_2 = var_1.type

			WorldMapAttachment = var_2_10003

			if var_49_2 == var_2_10003.TypeEvent then
				local var_49_3

				if var_1:IsAlive() then
					var_49_3 = var_1.config.visuality == 0
				end

				return var_49_3
			else
				local var_49_4 = var_1.type

				WorldMapAttachment = var_3

				if var_49_4 ~= var_3.TypeFleet then
					local var_49_5 = var_1.type

					WorldMapAttachment = var_3

					if var_49_5 ~= var_3.TypePort then
						return var_1:IsAlive()
					end
				end
			end
		end

		return
	end) and arg_47_0.attachments[var_2]
end

function var_0_1.FindAliveAttachment(arg_50_0, arg_50_1)
	assert = var_1_10002

	var_1_10002(arg_50_1 ~= nil)

	_ = var_1_10002

	return var_1_10002.detect(arg_50_0.attachments, function(arg_51_0)
		local var_51_0

		if arg_51_0:IsAlive() then
			var_51_0 = arg_51_0.type == arg_50_1
		end

		return var_51_0
	end)
end

function var_0_1.IsTerrainSairenFog(arg_52_0)
	return arg_52_0.terrain == var_0_1.TerrainFog and arg_52_0.terrainStrong == 0
end

function var_0_1.CanLeave(arg_53_0)
	local var_53_0

	if arg_53_0.walkable and arg_53_0:GetTerrainObstacleConfig("leave") then
		underscore = var_53_0
		var_53_0 = var_53_0.all(arg_53_0.attachments, function(arg_54_0)
			return not arg_54_0:IsAlive() or arg_54_0:CanLeave()
		end)
	end

	return var_53_0
end

function var_0_1.CanArrive(arg_55_0)
	local var_55_0

	if arg_55_0.walkable and arg_55_0:GetTerrainObstacleConfig("arrive") then
		underscore = var_55_0
		var_55_0 = var_55_0.all(arg_55_0.attachments, function(arg_56_0)
			return not arg_56_0:IsAlive() or arg_56_0:CanArrive()
		end)
	end

	return var_55_0
end

function var_0_1.CanPass(arg_57_0)
	local var_57_0

	if arg_57_0.walkable and arg_57_0:GetTerrainObstacleConfig("pass") then
		underscore = var_57_0
		var_57_0 = var_57_0.all(arg_57_0.attachments, function(arg_58_0)
			return not arg_58_0:IsAlive() or arg_58_0:CanPass()
		end)
	end

	return var_57_0
end

function var_0_1.IsSign(arg_59_0)
	_ = var_1_10001

	return var_1_10001.any(arg_59_0.attachments, function(arg_60_0)
		local var_60_0

		if arg_60_0:IsAlive() then
			var_60_0 = arg_60_0:IsSign()
		end

		return var_60_0
	end)
end

function var_0_1.ExistEnemy(arg_61_0)
	tobool = var_1_10001

	return var_1_10001(arg_61_0:GetStageEnemy())
end

function var_0_1.GetStageEnemy(arg_62_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_62_0.attachments, function(arg_63_0)
		local var_63_0

		if arg_63_0:IsAlive() then
			WorldMapAttachment = var_63_0
			var_63_0 = var_63_0.IsEnemyType(arg_63_0.type)
		end

		return var_63_0
	end)
end

function var_0_1.GetDisplayQuad(arg_64_0)
	local var_64_0
	local var_64_1 = arg_64_0
	local var_64_2 = arg_64_0.GetDisplayAttachment(var_64_1)

	if not arg_64_0:InFog() and var_64_2 then
		local var_64_3 = var_64_2.type

		WorldMapAttachment = var_64_1

		if var_64_3 == var_64_1.TypeEvent then
			if var_64_2.config.object_icon and #var_64_3 > 0 then
				var_64_0 = var_64_3
			end

			goto label_64_0
		end

		WorldMapAttachment = var_64_3

		if var_64_3.IsEnemyType(var_64_2.type) then
			var_64_0 = {
				"cell_red"
			}

			goto label_64_0
		end

		local var_64_4 = var_64_2.type

		WorldMapAttachment = var_4

		if var_64_4 ~= var_4.TypePort then
			do
				local var_64_5 = var_64_2.type

				WorldMapAttachment = var_4

				if var_64_5 == var_4.TypeBox then
					var_64_0 = {
						"cell_yellow"
					}
				end
			end

			::label_64_0::

			return var_64_0
		end
	end
end

function var_0_1.GetEmotion(arg_65_0)
	if arg_65_0.terrain == var_0_1.TerrainPoison then
		WorldConst = var_1

		local var_65_0

		if not var_1.PoisonEffect then
			var_65_0 = nil
		end

		return var_65_0
	end
end

function var_0_1.GetScannerAttachment(arg_66_0)
	local var_66_0 = arg_66_0:GetAliveAttachments()
	local var_66_1
	local var_66_2

	ipairs = var_1_10004

	for iter_66_0, iter_66_1 in var_1_10004(var_66_0) do
		if iter_66_1:IsScannerAttachment() and (not var_66_1 or var_66_2 < var_9) then
			var_66_1 = iter_66_1
			var_66_2 = var_9
		end
	end

	return var_66_1
end

var_0_1.TerrainObstacleConfig = {
	SairenFog = 4,
	[var_0_1.TerrainNone] = 7,
	[var_0_1.TerrainStream] = 6,
	[var_0_1.TerrainIce] = 6,
	[var_0_1.TerrainWind] = 2,
	[var_0_1.TerrainFog] = 6,
	[var_0_1.TerrainFire] = 7,
	[var_0_1.TerrainPoison] = 7
}

function var_0_1.GetTerrainObstacleConfig(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0
	local var_67_1

	if arg_67_0.IsTerrainSairenFog(var_67_0) then
		var_67_1 = "SairenFog"
	else
		var_67_0 = arg_67_0
		var_67_1 = arg_67_0.GetTerrain(var_67_0)
	end

	WorldConst = var_1_10003

	local var_67_2 = var_1_10003.GetObstacleKey(arg_67_1)

	bit = var_67_0

	return var_67_0.band(var_0_1.TerrainObstacleConfig[var_67_1], var_67_2) > 0
end

function var_0_1.IsMovingTerrain(arg_68_0)
	return arg_68_0 == var_0_1.TerrainStream or arg_68_0 == var_0_1.TerrainIce or arg_68_0 == var_0_1.TerrainWind
end

return var_0_1
