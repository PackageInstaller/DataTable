class = var_0_10000

local var_0_0 = "IslandGoundLayerSystem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_1.OnAttach(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetComponent

	typeof = var_1_10004
	BLHX = var_1_10005
	arg_1_0.floorTileRenderer = var_1_1(var_1_0, var_1_10004(var_1_10005.Rendering.FloorTileRenderer))

	return
end

function var_0_1.OnStart(arg_2_0)
	return
end

function var_0_1.FillFloorCell(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.data
	local var_3_1 = var_2.MapPoint2GroundPoint(var_3_0, arg_3_1:GetPosition())
	local var_3_2 = arg_3_1:GetShapeId()
	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.ItemID2TextureId(var_3_3, arg_3_1)

	IslandConst = var_3_3

	local var_3_5 = var_3_3.AGORA_LAYER_FLOOR
	local var_3_6 = arg_3_0.floorTileRenderer

	var_6.SetTexture(var_3_6, var_3_5, var_3_4, var_3_2, var_3_1.x, var_3_1.y)

	return
end

function var_0_1.ClearFloorCell(arg_4_0, arg_4_1)
	IslandConst = var_1_10002

	local var_4_0 = var_1_10002.AGORA_LAYER_FLOOR
	local var_4_1 = arg_4_0.data
	local var_4_2 = var_3.MapPoint2GroundPoint(var_4_1, arg_4_1)
	local var_4_3 = arg_4_0.floorTileRenderer

	var_4.RemoveTexture(var_4_3, var_4_0, var_4_2.x, var_4_2.y)

	return
end

function var_0_1.FillTileCell(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.data
	local var_5_1 = var_2.MapPoint2GroundPoint(var_5_0, arg_5_1:GetPosition())
	local var_5_2 = arg_5_1:GetShapeId()
	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.ItemID2TextureId(var_5_3, arg_5_1)

	IslandConst = var_5_3

	local var_5_5 = var_5_3.AGORA_LAYER_TILE
	local var_5_6 = arg_5_0.floorTileRenderer

	var_6.SetTexture(var_5_6, var_5_5, var_5_4, var_5_2, var_5_1.x, var_5_1.y)

	return
end

function var_0_1.ClearTileCell(arg_6_0, arg_6_1)
	IslandConst = var_1_10002

	local var_6_0 = var_1_10002.AGORA_LAYER_TILE
	local var_6_1 = arg_6_0.data
	local var_6_2 = var_3.MapPoint2GroundPoint(var_6_1, arg_6_1)
	local var_6_3 = arg_6_0.floorTileRenderer

	var_4.RemoveTexture(var_6_3, var_6_0, var_6_2.x, var_6_2.y)

	return
end

function var_0_1.ItemID2TextureId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetID()
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.GetModel(var_7_1)

	LuaHelper = var_7_1

	local var_7_3 = var_7_1.GetFloorTileRendererLayerIndex(arg_7_0.floorTileRenderer, var_7_2)

	assert = var_5

	var_5(var_7_3 >= 0, "cant found textureId>>>>>>>>>" .. var_7_2)

	return var_7_3
end

function var_0_1.Enable(arg_8_0)
	return
end

function var_0_1.Disable(arg_9_0)
	return
end

function var_0_1.OnDetach(arg_10_0)
	return
end

return var_0_1
