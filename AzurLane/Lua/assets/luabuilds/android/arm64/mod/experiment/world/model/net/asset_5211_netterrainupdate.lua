class = var_0_10000

local var_0_0 = "NetTerrainUpdate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....BaseEntity"))

var_0_1.Fields = {
	row = "number",
	terrain = "number",
	terrainDir = "number",
	column = "number",
	terrainStrong = "number"
}

function var_0_1.DebugPrint(arg_1_0)
	return "{" .. arg_1_0.row .. "," .. arg_1_0.column .. "} " .. arg_1_0.terrain
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.row = arg_2_1.pos.row
	arg_2_0.column = arg_2_1.pos.column
	arg_2_0.terrain = arg_2_1.type

	local var_2_0 = arg_2_0.terrain

	WorldMapCell = var_1_10003

	if var_2_0 == var_1_10003.TerrainStream then
		WorldConst = var_2_0
		arg_2_0.terrainDir = var_2_0.ParseConfigDir(arg_2_1.dir.row - 1, arg_2_1.dir.column - 1)
	else
		local var_2_1 = arg_2_0.terrain

		WorldMapCell = var_3

		if var_2_1 == var_3.TerrainWind then
			WorldConst = var_2_1
			arg_2_0.terrainDir = var_2_1.ParseConfigDir(arg_2_1.dir.row - 1, arg_2_1.dir.column - 1)
			arg_2_0.terrainStrong = arg_2_1.distance
		else
			local var_2_2 = arg_2_0.terrain

			WorldMapCell = var_3

			if var_2_2 == var_3.TerrainFog then
				arg_2_0.terrainStrong = arg_2_1.distance
			else
				local var_2_3 = arg_2_0.terrain

				WorldMapCell = var_3

				if var_2_3 == var_3.TerrainPoison then
					arg_2_0.terrainStrong = arg_2_1.distance
				end
			end
		end
	end

	return
end

function var_0_1.GetTerrain(arg_3_0)
	return arg_3_0.terrain
end

return var_0_1
