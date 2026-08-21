local var_0_0 = class("WorldMapCell", import("...BaseEntity"))

var_0_0.Fields = {
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
var_0_0.EventAddAttachment = "WorldMapCell.EventAddAttachment"
var_0_0.EventRemoveAttachment = "WorldMapCell.EventRemoveAttachment"
var_0_0.EventUpdateInFov = "WorldMapCell.EventUpdateInFov"
var_0_0.EventUpdateDiscovered = "WorldMapCell.EventUpdateDiscovered"
var_0_0.EventUpdateFog = "WorldMapCell.EventUpdateFog"
var_0_0.EventUpdateFogImage = "WorldMapCell.EventUpdateFogImage"
var_0_0.EventUpdateTerrain = "WorldMapCell.EventUpdateTerrain"

function var_0_0.GetName(arg_1_0, arg_1_1)
	return "cell_" .. arg_1_0 .. "_" .. arg_1_1
end

var_0_0.TerrainNone = 0
var_0_0.TerrainStream = 1
var_0_0.TerrainIce = 2
var_0_0.TerrainWind = 3
var_0_0.TerrainFog = 4
var_0_0.TerrainFire = 5
var_0_0.TerrainPoison = 6

function var_0_0.Build(arg_2_0)
	arg_2_0.attachments = {}
	arg_2_0.dir = 0
	arg_2_0.infov = 0
	arg_2_0.inLight = 0
	arg_2_0.fog = false
	arg_2_0.fogLight = false
	arg_2_0.fogSairen = false

	return
end

function var_0_0.Setup(arg_3_0, arg_3_1)
	arg_3_0.row = arg_3_1[1]
	arg_3_0.column = arg_3_1[2]
	arg_3_0.walkable = arg_3_1[3]

	return
end

function var_0_0.Dispose(arg_4_0)
	WPool:ReturnArray(arg_4_0.attachments)
	arg_4_0:Clear()

	return
end

function var_0_0.AddAttachment(arg_5_0, arg_5_1)
	assert(not _.any(arg_5_0.attachments, function(arg_6_0)
		return arg_6_0.row == arg_5_1.row and arg_6_0.column == arg_5_1.column and arg_6_0.type == arg_5_1.type and arg_6_0.id == arg_5_1.id
	end))
	assert(arg_5_1.row == arg_5_0.row and arg_5_1.column == arg_5_0.column)
	assert(WorldMapAttachment.SortOrder[arg_5_1.type], arg_5_1.type .. " : sort order not set.")

	local var_5_0 = #arg_5_0.attachments + 1

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.attachments) do
		if WorldMapAttachment.SortOrder[arg_5_1.type] > WorldMapAttachment.SortOrder[iter_5_1.type] then
			var_5_0 = iter_5_0

			break
		end
	end

	table.insert(arg_5_0.attachments, var_5_0, arg_5_1)
	arg_5_0:DispatchEvent(var_0_0.EventAddAttachment, arg_5_1)

	if not arg_5_0.discovered and arg_5_1:ShouldMarkAsLurk() then
		arg_5_1:UpdateLurk(true)
	end

	return
end

function var_0_0.RemoveAttachment(arg_7_0, arg_7_1)
	if arg_7_1 == nil or type(arg_7_1) == "number" then
		arg_7_1 = arg_7_1 or #arg_7_0.attachments

		assert(arg_7_1 >= 1 and arg_7_1 <= #arg_7_0.attachments)
		table.remove(arg_7_0.attachments, arg_7_1)
		arg_7_0:DispatchEvent(var_0_0.EventRemoveAttachment, arg_7_0.attachments[arg_7_1])
		WPool:Return(arg_7_0.attachments[arg_7_1])
	elseif arg_7_1.class == WorldMapAttachment then
		for iter_7_0 = #arg_7_0.attachments, 1, -1 do
			if arg_7_0.attachments[iter_7_0] == arg_7_1 then
				arg_7_0:RemoveAttachment(iter_7_0)

				break
			end
		end
	end

	return
end

function var_0_0.ContainsAttachment(arg_8_0, arg_8_1)
	return _.any(arg_8_0.attachments, function(arg_9_0)
		return arg_9_0 == arg_8_1
	end)
end

function var_0_0.GetInFOV(arg_10_0)
	if arg_10_0.fog then
		return arg_10_0.fogLight
	else
		return arg_10_0.infov > 0 or arg_10_0.inLight > 0
	end

	return
end

function var_0_0.UpdateInFov(arg_11_0, arg_11_1)
	AfterCheck({
		{
			function()
				return arg_11_0:GetInFOV()
			end,
			function()
				arg_11_0:DispatchEvent(var_0_0.EventUpdateInFov)

				return
			end
		}
	}, function()
		arg_11_0.infov = arg_11_1

		return
	end)

	return
end

function var_0_0.ChangeInLight(arg_15_0, arg_15_1)
	AfterCheck({
		{
			function()
				return arg_15_0:GetInFOV()
			end,
			function()
				arg_15_0:DispatchEvent(var_0_0.EventUpdateInFov)

				return
			end
		}
	}, function()
		arg_15_0.inLight = arg_15_0.inLight + (arg_15_1 and 1 or -1)

		return
	end)

	return
end

function var_0_0.InFog(arg_19_0)
	if arg_19_0.fog then
		return not arg_19_0.fogLight
	else
		return arg_19_0:GetTerrain() == var_0_0.TerrainFog
	end

	return
end

function var_0_0.LookSairenFog(arg_20_0)
	return arg_20_0.fogSairen or arg_20_0:IsTerrainSairenFog()
end

function var_0_0.UpdateFog(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	AfterCheck({
		{
			function()
				return arg_21_0:GetInFOV()
			end,
			function()
				arg_21_0:DispatchEvent(var_0_0.EventUpdateInFov)

				return
			end
		},
		{
			function()
				return arg_21_0:InFog()
			end,
			function()
				arg_21_0:DispatchEvent(var_0_0.EventUpdateFog)

				return
			end
		},
		{
			function()
				return arg_21_0:LookSairenFog()
			end,
			function()
				arg_21_0:DispatchEvent(var_0_0.EventUpdateFogImage)

				return
			end
		}
	}, function()
		arg_21_0.fog = defaultValue(arg_21_1, arg_21_0.fog)
		arg_21_0.fogLight = defaultValue(arg_21_2, arg_21_0.fogLight)
		arg_21_0.fogSairen = defaultValue(arg_21_3, arg_21_0.fogSairen)

		return
	end)

	return
end

function var_0_0.UpdateDiscovered(arg_29_0, arg_29_1)
	if arg_29_0.discovered ~= arg_29_1 then
		arg_29_0.discovered = arg_29_1

		arg_29_0:DispatchEvent(var_0_0.EventUpdateDiscovered)
	end

	return
end

function var_0_0.GetTerrain(arg_30_0)
	return arg_30_0.terrain or var_0_0.TerrainNone
end

function var_0_0.UpdateTerrain(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	AfterCheck({
		{
			function()
				return arg_31_0:InFog()
			end,
			function()
				arg_31_0:DispatchEvent(var_0_0.EventUpdateFog)

				return
			end
		},
		{
			function()
				return arg_31_0:LookSairenFog()
			end,
			function()
				arg_31_0:DispatchEvent(var_0_0.EventUpdateFogImage)

				return
			end
		}
	}, function()
		arg_31_0.terrain = arg_31_1

		if arg_31_0.terrain == var_0_0.TerrainStream then
			assert(arg_31_2)

			arg_31_0.terrainDir = arg_31_2
		elseif arg_31_0.terrain == var_0_0.TerrainWind then
			local var_36_0 = arg_31_2 and arg_31_3

			assert(var_36_0)

			arg_31_0.terrainDir = arg_31_2
			arg_31_0.terrainStrong = arg_31_3
		elseif arg_31_0.terrain == var_0_0.TerrainFog then
			arg_31_0.terrainStrong = arg_31_3
		elseif arg_31_0.terrain == var_0_0.TerrainPoison then
			arg_31_0.terrainStrong = arg_31_3
		end

		arg_31_0:DispatchEvent(var_0_0.EventUpdateTerrain)

		return
	end)

	return
end

function var_0_0.GetAliveAttachments(arg_37_0)
	return _.filter(arg_37_0.attachments, function(arg_38_0)
		return arg_38_0:IsAlive()
	end)
end

function var_0_0.GetAliveAttachment(arg_39_0)
	return _.detect(arg_39_0.attachments, function(arg_40_0)
		return arg_40_0:IsAlive()
	end)
end

function var_0_0.GetDisplayAttachment(arg_41_0)
	return _.detect(arg_41_0.attachments, function(arg_42_0)
		return arg_42_0:IsAlive() and arg_42_0:IsVisible()
	end)
end

function var_0_0.GetInterativeAttachment(arg_43_0)
	return _.detect(arg_43_0.attachments, function(arg_44_0)
		return WorldMapAttachment.IsInteractiveType(arg_44_0.type) and arg_44_0:IsAlive() and arg_44_0:IsVisible()
	end)
end

function var_0_0.GetEventAttachment(arg_45_0)
	return _.detect(arg_45_0.attachments, function(arg_46_0)
		return arg_46_0:IsAlive() and arg_46_0.type == WorldMapAttachment.TypeEvent
	end)
end

function var_0_0.GetCompassAttachment(arg_47_0)
	for iter_47_0, iter_47_1 in ipairs(arg_47_0.attachments) do
		table.insert({}, iter_47_0)
	end

	local var_47_0 = _.detect(_.sort({}, function(arg_48_0, arg_48_1)
		local var_48_0 = arg_47_0.attachments[arg_48_0].config.compass_index or 0
		local var_48_1 = arg_47_0.attachments[arg_48_1].config.compass_index or 0

		return var_48_1 < var_48_0
	end), function(arg_49_0)
		if arg_47_0.attachments[arg_49_0]:ShouldMarkAsLurk() then
			return arg_47_0.attachments[arg_49_0]:IsAlive() and arg_47_0.attachments[arg_49_0]:IsVisible() and arg_47_0.discovered
		elseif arg_47_0.attachments[arg_49_0].type == WorldMapAttachment.TypeEvent then
			return arg_47_0.attachments[arg_49_0]:IsAlive() and arg_47_0.attachments[arg_49_0].config.visuality == 0
		elseif arg_47_0.attachments[arg_49_0].type ~= WorldMapAttachment.TypeFleet and arg_47_0.attachments[arg_49_0].type ~= WorldMapAttachment.TypePort then
			return arg_47_0.attachments[arg_49_0]:IsAlive()
		end

		return
	end)

	return var_47_0 and arg_47_0.attachments[var_47_0]
end

function var_0_0.FindAliveAttachment(arg_50_0, arg_50_1)
	assert(arg_50_1 ~= nil)

	return _.detect(arg_50_0.attachments, function(arg_51_0)
		return arg_51_0:IsAlive() and arg_51_0.type == arg_50_1
	end)
end

function var_0_0.IsTerrainSairenFog(arg_52_0)
	return arg_52_0.terrain == var_0_0.TerrainFog and arg_52_0.terrainStrong == 0
end

function var_0_0.CanLeave(arg_53_0)
	local var_53_0 = arg_53_0.walkable

	if arg_53_0.walkable then
		var_53_0 = arg_53_0:GetTerrainObstacleConfig("leave")
		var_53_0 = var_53_0 and underscore.all(arg_53_0.attachments, function(arg_54_0)
			return not arg_54_0:IsAlive() or arg_54_0:CanLeave()
		end)
	end

	return var_53_0
end

function var_0_0.CanArrive(arg_55_0)
	local var_55_0 = arg_55_0.walkable

	if arg_55_0.walkable then
		var_55_0 = arg_55_0:GetTerrainObstacleConfig("arrive")
		var_55_0 = var_55_0 and underscore.all(arg_55_0.attachments, function(arg_56_0)
			return not arg_56_0:IsAlive() or arg_56_0:CanArrive()
		end)
	end

	return var_55_0
end

function var_0_0.CanPass(arg_57_0)
	local var_57_0 = arg_57_0.walkable

	if arg_57_0.walkable then
		var_57_0 = arg_57_0:GetTerrainObstacleConfig("pass")
		var_57_0 = var_57_0 and underscore.all(arg_57_0.attachments, function(arg_58_0)
			return not arg_58_0:IsAlive() or arg_58_0:CanPass()
		end)
	end

	return var_57_0
end

function var_0_0.IsSign(arg_59_0)
	return _.any(arg_59_0.attachments, function(arg_60_0)
		return arg_60_0:IsAlive() and arg_60_0:IsSign()
	end)
end

function var_0_0.ExistEnemy(arg_61_0)
	return tobool(arg_61_0:GetStageEnemy())
end

function var_0_0.GetStageEnemy(arg_62_0)
	return _.detect(arg_62_0.attachments, function(arg_63_0)
		return arg_63_0:IsAlive() and WorldMapAttachment.IsEnemyType(arg_63_0.type)
	end)
end

function var_0_0.GetDisplayQuad(arg_64_0)
	local var_64_0
	local var_64_1 = arg_64_0:GetDisplayAttachment()

	if not arg_64_0:InFog() and var_64_1 then
		if var_64_1.type == WorldMapAttachment.TypeEvent then
			if var_64_1.config.object_icon and #var_64_1.config.object_icon > 0 then
				var_64_0 = var_64_1.config.object_icon
			end
		elseif WorldMapAttachment.IsEnemyType(var_64_1.type) then
			var_64_0 = {
				"cell_red"
			}
		elseif var_64_1.type == WorldMapAttachment.TypePort or var_64_1.type == WorldMapAttachment.TypeBox then
			var_64_0 = {
				"cell_yellow"
			}
		end
	end

	return var_64_0
end

function var_0_0.GetEmotion(arg_65_0)
	if arg_65_0.terrain == var_0_0.TerrainPoison then
		return WorldConst.PoisonEffect or nil
	end
end

function var_0_0.GetScannerAttachment(arg_66_0)
	local var_66_0
	local var_66_1

	for iter_66_0, iter_66_1 in ipairs((arg_66_0:GetAliveAttachments())) do
		local var_66_2 = iter_66_1:IsScannerAttachment()

		if var_66_2 and (not var_66_0 or var_66_1 < var_66_2) then
			var_66_0 = iter_66_1
			var_66_1 = var_66_2
		end
	end

	return var_66_0
end

var_0_0.TerrainObstacleConfig = {
	SairenFog = 4,
	[var_0_0.TerrainNone] = 7,
	[var_0_0.TerrainStream] = 6,
	[var_0_0.TerrainIce] = 6,
	[var_0_0.TerrainWind] = 2,
	[var_0_0.TerrainFog] = 6,
	[var_0_0.TerrainFire] = 7,
	[var_0_0.TerrainPoison] = 7
}

function var_0_0.GetTerrainObstacleConfig(arg_67_0, arg_67_1)
	return bit.band(var_0_0.TerrainObstacleConfig[arg_67_0:IsTerrainSairenFog() and "SairenFog" or arg_67_0:GetTerrain()], (WorldConst.GetObstacleKey(arg_67_1))) > 0
end

function var_0_0.IsMovingTerrain(arg_68_0)
	return arg_68_0 == var_0_0.TerrainStream or arg_68_0 == var_0_0.TerrainIce or arg_68_0 == var_0_0.TerrainWind
end

return var_0_0
