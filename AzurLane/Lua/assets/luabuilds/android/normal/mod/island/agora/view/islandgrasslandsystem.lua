class = var_0_10000

local var_0_0 = "IslandGrassLandSystem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_1.OnLaterAttach(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._go.transform.position
	local var_1_1 = arg_1_0.data
	local var_1_2 = var_3.GetSize(var_1_1)

	BLHX = var_1_1

	local var_1_3 = var_1_1.Rendering.TerrainDetailTileMask.Instance

	var_4.Init(var_1_3, var_1_0.x, var_1_0.z, var_1_2.x, var_1_2.y, 1)

	return
end

function var_0_1.SetVisible(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1:IsBuildingType() then
		return
	end

	local var_2_0 = arg_2_1:GetPosition()
	local var_2_1 = arg_2_1:GetSizeWithRotation()
	local var_2_2 = arg_2_0.data
	local var_2_3 = var_5.MapPoint2GroundPoint(var_2_2, var_2_0)

	BLHX = var_2_2

	local var_2_4 = var_2_2.Rendering.TerrainDetailTileMask.Instance

	var_6.SetVisible(var_2_4, var_2_3.x, var_2_3.y, var_2_1.x, var_2_1.y, arg_2_2)

	return
end

function var_0_1.OnDetach(arg_3_0)
	BLHX = var_1_10001

	local var_3_0 = var_1_10001.Rendering.TerrainDetailTileMask.Instance

	var_1.Dispose(var_3_0)

	return
end

return var_0_1
