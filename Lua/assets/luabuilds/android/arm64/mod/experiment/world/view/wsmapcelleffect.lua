local var_0_0 = class("WSMapCellEffect", import(".WSMapEffect"))

var_0_0.Fields = {
	cell = "table",
	theme = "table"
}
var_0_0.Listeners = {
	onUpdate = "Update"
}

function var_0_0.GetName(arg_1_0, arg_1_1)
	return "cell_effect_" .. arg_1_0 .. "_" .. arg_1_1
end

function var_0_0.Setup(arg_2_0, arg_2_1, arg_2_2)
	assert(arg_2_0.cell == nil)

	arg_2_0.cell = arg_2_1

	arg_2_0.cell:AddListener(WorldMapCell.EventUpdateInFov, arg_2_0.onUpdate)
	arg_2_0.cell:AddListener(WorldMapCell.EventUpdateDiscovered, arg_2_0.onUpdate)
	arg_2_0.cell:AddListener(WorldMapCell.EventUpdateFog, arg_2_0.onUpdate)

	arg_2_0.theme = arg_2_2

	var_0_0.super.Setup(arg_2_0, WorldConst.GetTerrainEffectRes(arg_2_0.cell:GetTerrain(), arg_2_0.cell.terrainDir, arg_2_0.cell.terrainStrong))
	arg_2_0:Load(function()
		local var_3_0 = arg_2_0.cell
		local var_3_1 = arg_2_0.cell:GetTerrain()

		if var_3_1 == WorldMapCell.TerrainStream then
			arg_2_0:SetModelOrder(WorldConst.LOEffectB, var_3_0.row)
		elseif var_3_1 == WorldMapCell.TerrainWind then
			arg_2_0:SetModelOrder(WorldConst.LOEffectC, var_3_0.row)

			local var_3_2 = arg_2_0.model:GetChild(0)

			setActive(var_3_2:Find("Xyz/Arrow"), var_3_0.terrainStrong > 0)
			arg_2_0:UpdateModelScale(WorldConst.GetWindScale(var_3_0.terrainStrong))
		elseif var_3_1 == WorldMapCell.TerrainIce then
			arg_2_0:SetModelOrder(WorldConst.LOEffectA, var_3_0.row)
		elseif var_3_1 == WorldMapCell.TerrainPoison then
			arg_2_0:SetModelOrder(WorldConst.LOEffectA, var_3_0.row)
		end

		arg_2_0:Init()

		return
	end)

	return
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.cell:RemoveListener(WorldMapCell.EventUpdateInFov, arg_4_0.onUpdate)
	arg_4_0.cell:RemoveListener(WorldMapCell.EventUpdateDiscovered, arg_4_0.onUpdate)
	arg_4_0.cell:RemoveListener(WorldMapCell.EventUpdateFog, arg_4_0.onUpdate)
	var_0_0.super.Dispose(arg_4_0)

	return
end

function var_0_0.Init(arg_5_0)
	arg_5_0.transform.name = var_0_0.GetName(arg_5_0.cell.row, arg_5_0.cell.column)
	arg_5_0.transform.anchoredPosition3D = arg_5_0.theme:GetLinePosition(arg_5_0.cell.row, arg_5_0.cell.column)

	arg_5_0:Update()

	return
end

function var_0_0.Update(arg_6_0, arg_6_1)
	if arg_6_1 ~= nil and arg_6_1 ~= WorldMapCell.EventUpdateInFov then
		if arg_6_1 == WorldMapCell.EventUpdateFog then
			local var_6_0 = arg_6_0.cell:GetInFOV() and not arg_6_0.cell:InFog()

			setActive(arg_6_0.transform, var_6_0)
		end

		return
	end
end

return var_0_0
