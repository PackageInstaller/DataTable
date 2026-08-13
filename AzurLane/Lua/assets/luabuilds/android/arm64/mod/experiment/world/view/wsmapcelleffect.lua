class = var_0_10000

local var_0_0 = "WSMapCellEffect"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WSMapEffect"))

var_0_1.Fields = {
	cell = "table",
	theme = "table"
}
var_0_1.Listeners = {
	onUpdate = "Update"
}

function var_0_1.GetName(arg_1_0, arg_1_1)
	return "cell_effect_" .. arg_1_0 .. "_" .. arg_1_1
end

function var_0_1.Setup(arg_2_0, arg_2_1, arg_2_2)
	assert = var_1_10003

	var_1_10003(arg_2_0.cell == nil)

	arg_2_0.cell = arg_2_1

	local var_2_0 = arg_2_0.cell
	local var_2_1 = var_3.AddListener

	WorldMapCell = var_1_10006

	var_2_1(var_2_0, var_1_10006.EventUpdateInFov, arg_2_0.onUpdate)

	local var_2_2 = arg_2_0.cell
	local var_2_3 = var_3.AddListener

	WorldMapCell = var_6

	var_2_3(var_2_2, var_6.EventUpdateDiscovered, arg_2_0.onUpdate)

	local var_2_4 = arg_2_0.cell
	local var_2_5 = var_3.AddListener

	WorldMapCell = var_6

	var_2_5(var_2_4, var_6.EventUpdateFog, arg_2_0.onUpdate)

	arg_2_0.theme = arg_2_2

	local var_2_6 = var_0_1.super.Setup
	local var_2_7 = arg_2_0

	WorldConst = var_6

	local var_2_8 = var_6.GetTerrainEffectRes
	local var_2_9 = arg_2_0.cell

	var_2_6(var_2_7, var_2_8(var_8.GetTerrain(var_2_9), arg_2_0.cell.terrainDir, arg_2_0.cell.terrainStrong))
	arg_2_0:Load(function()
		local var_3_0 = arg_2_0.cell
		local var_3_1 = var_0.GetTerrain(var_3_0)

		WorldMapCell = var_2_10002

		local var_3_3

		if var_3_1 == var_2_10002.TerrainStream then
			local var_3_2 = arg_2_0

			var_3_3 = var_3_3.SetModelOrder
			WorldConst = var_2_10005

			var_3_3(var_3_2, var_2_10005.LOEffectB, var_0.row)
		else
			WorldMapCell = var_3_3

			local var_3_5

			if var_3_1 == var_3_3.TerrainWind then
				local var_3_4 = arg_2_0

				var_3_5 = var_3_5.SetModelOrder
				WorldConst = var_2_10005

				var_3_5(var_3_4, var_2_10005.LOEffectC, var_0.row)

				setActive = var_3_5

				local var_3_6 = arg_2_0.model
				local var_3_7 = var_4.GetChild(var_3_6, 0)
				local var_3_8 = var_4.Find(var_3_7, "Xyz/Arrow")

				var_2_10005 = var_0.terrainStrong > 0

				var_3_5(var_3_8, var_2_10005)

				local var_3_9 = arg_2_0

				var_3_5 = var_3_5.UpdateModelScale
				WorldConst = var_2_10005

				var_3_5(var_3_9, var_2_10005.GetWindScale(var_0.terrainStrong))
			else
				WorldMapCell = var_3_5

				local var_3_11

				if var_3_1 == var_3_5.TerrainIce then
					local var_3_10 = arg_2_0

					var_3_11 = var_3_11.SetModelOrder
					WorldConst = var_2_10005

					var_3_11(var_3_10, var_2_10005.LOEffectA, var_0.row)
				else
					WorldMapCell = var_3_11

					if var_3_1 == var_3_11.TerrainPoison then
						local var_3_12 = arg_2_0
						local var_3_13 = var_2.SetModelOrder

						WorldConst = var_2_10005

						var_3_13(var_3_12, var_2_10005.LOEffectA, var_0.row)
					end
				end
			end
		end

		local var_3_14 = arg_2_0

		var_2.Init(var_3_14)

		return
	end)

	return
end

function var_0_1.Dispose(arg_4_0)
	local var_4_0 = arg_4_0.cell
	local var_4_1 = var_1.RemoveListener

	WorldMapCell = var_1_10004

	var_4_1(var_4_0, var_1_10004.EventUpdateInFov, arg_4_0.onUpdate)

	local var_4_2 = arg_4_0.cell
	local var_4_3 = var_1.RemoveListener

	WorldMapCell = var_4

	var_4_3(var_4_2, var_4.EventUpdateDiscovered, arg_4_0.onUpdate)

	local var_4_4 = arg_4_0.cell
	local var_4_5 = var_1.RemoveListener

	WorldMapCell = var_4

	var_4_5(var_4_4, var_4.EventUpdateFog, arg_4_0.onUpdate)
	var_0_1.super.Dispose(arg_4_0)

	return
end

function var_0_1.Init(arg_5_0)
	local var_5_0 = arg_5_0.cell
	local var_5_1 = arg_5_0.transform

	var_5_1.name = var_0_1.GetName(var_5_0.row, var_5_0.column)

	local var_5_2 = arg_5_0.theme

	var_5_1.anchoredPosition3D = var_3.GetLinePosition(var_5_2, var_5_0.row, var_5_0.column)

	arg_5_0:Update()

	return
end

function var_0_1.Update(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.cell

	if arg_6_1 ~= nil then
		WorldMapCell = var_1_10003

		if arg_6_1 ~= var_1_10003.EventUpdateInFov then
			WorldMapCell = var_1_10003

			if arg_6_1 == var_1_10003.EventUpdateFog then
				setActive = var_1_10003

				local var_6_1 = arg_6_0.transform
				local var_6_2

				if var_6_0:GetInFOV() then
					var_6_2 = not var_6_0:InFog()
				end

				var_1_10003(var_6_1, var_6_2)
			end

			return
		end
	end
end

return var_0_1
