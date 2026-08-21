local var_0_0 = class("IslandGoundLayerSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_0.OnAttach(arg_1_0, arg_1_1)
	arg_1_0.floorTileRenderer = arg_1_1:GetComponent(typeof(BLHX.Rendering.FloorTileRenderer))

	return
end

function var_0_0.OnStart(arg_2_0)
	return
end

function var_0_0.FillFloorCell(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.data:MapPoint2GroundPoint(arg_3_1:GetPosition())

	arg_3_0.floorTileRenderer:SetTexture(IslandConst.AGORA_LAYER_FLOOR, arg_3_0:ItemID2TextureId(arg_3_1), arg_3_1:GetShapeId(), var_3_0.x, var_3_0.y)

	return
end

function var_0_0.ClearFloorCell(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.data:MapPoint2GroundPoint(arg_4_1)

	arg_4_0.floorTileRenderer:RemoveTexture(IslandConst.AGORA_LAYER_FLOOR, var_4_0.x, var_4_0.y)

	return
end

function var_0_0.FillTileCell(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.data:MapPoint2GroundPoint(arg_5_1:GetPosition())

	arg_5_0.floorTileRenderer:SetTexture(IslandConst.AGORA_LAYER_TILE, arg_5_0:ItemID2TextureId(arg_5_1), arg_5_1:GetShapeId(), var_5_0.x, var_5_0.y)

	return
end

function var_0_0.ClearTileCell(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.data:MapPoint2GroundPoint(arg_6_1)

	arg_6_0.floorTileRenderer:RemoveTexture(IslandConst.AGORA_LAYER_TILE, var_6_0.x, var_6_0.y)

	return
end

function var_0_0.ItemID2TextureId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetID()
	local var_7_1 = arg_7_1:GetModel()
	local var_7_2 = LuaHelper.GetFloorTileRendererLayerIndex(arg_7_0.floorTileRenderer, var_7_1)

	assert(var_7_2 >= 0, "cant found textureId>>>>>>>>>" .. var_7_1)

	return var_7_2
end

function var_0_0.Enable(arg_8_0)
	return
end

function var_0_0.Disable(arg_9_0)
	return
end

function var_0_0.OnDetach(arg_10_0)
	return
end

return var_0_0
