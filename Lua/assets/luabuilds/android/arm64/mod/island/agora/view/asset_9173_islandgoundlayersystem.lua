local IslandGoundLayerSystem = class("IslandGoundLayerSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function IslandGoundLayerSystem:OnAttach(arg_1_1)
	self.floorTileRenderer = arg_1_1:GetComponent(typeof(BLHX.Rendering.FloorTileRenderer))

	return
end

function IslandGoundLayerSystem:OnStart()
	return
end

function IslandGoundLayerSystem:FillFloorCell(arg_3_1)
	local var_3_0 = self.data:MapPoint2GroundPoint(arg_3_1:GetPosition())

	self.floorTileRenderer:SetTexture(IslandConst.AGORA_LAYER_FLOOR, self:ItemID2TextureId(arg_3_1), arg_3_1:GetShapeId(), var_3_0.x, var_3_0.y)

	return
end

function IslandGoundLayerSystem:ClearFloorCell(arg_4_1)
	local var_4_0 = self.data:MapPoint2GroundPoint(arg_4_1)

	self.floorTileRenderer:RemoveTexture(IslandConst.AGORA_LAYER_FLOOR, var_4_0.x, var_4_0.y)

	return
end

function IslandGoundLayerSystem:FillTileCell(arg_5_1)
	local var_5_0 = self.data:MapPoint2GroundPoint(arg_5_1:GetPosition())

	self.floorTileRenderer:SetTexture(IslandConst.AGORA_LAYER_TILE, self:ItemID2TextureId(arg_5_1), arg_5_1:GetShapeId(), var_5_0.x, var_5_0.y)

	return
end

function IslandGoundLayerSystem:ClearTileCell(arg_6_1)
	local var_6_0 = self.data:MapPoint2GroundPoint(arg_6_1)

	self.floorTileRenderer:RemoveTexture(IslandConst.AGORA_LAYER_TILE, var_6_0.x, var_6_0.y)

	return
end

function IslandGoundLayerSystem:ItemID2TextureId(arg_7_1)
	local var_7_0 = arg_7_1:GetID()
	local var_7_1 = arg_7_1:GetModel()
	local var_7_2 = LuaHelper.GetFloorTileRendererLayerIndex(self.floorTileRenderer, var_7_1)

	assert(var_7_2 >= 0, "cant found textureId>>>>>>>>>" .. var_7_1)

	return var_7_2
end

function IslandGoundLayerSystem:Enable()
	return
end

function IslandGoundLayerSystem:Disable()
	return
end

function IslandGoundLayerSystem:OnDetach()
	return
end

return IslandGoundLayerSystem
