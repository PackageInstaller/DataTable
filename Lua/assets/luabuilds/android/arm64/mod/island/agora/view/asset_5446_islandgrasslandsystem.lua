local IslandGrassLandSystem = class("IslandGrassLandSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function IslandGrassLandSystem:OnLaterAttach(arg_1_1)
	local var_1_0 = self.data:GetSize()

	BLHX.Rendering.TerrainDetailTileMask.Instance:Init(self._go.transform.position.x, self._go.transform.position.z, var_1_0.x, var_1_0.y, 1)

	return
end

function IslandGrassLandSystem:SetVisible(arg_2_1, arg_2_2)
	local var_2_0

	if arg_2_1:IsBuildingType() then
		do return end

		var_2_0 = arg_2_1:GetSizeWithRotation()
	end

	local var_2_1 = self.data:MapPoint2GroundPoint((arg_2_1:GetPosition()))

	BLHX.Rendering.TerrainDetailTileMask.Instance:SetVisible(var_2_1.x, var_2_1.y, var_2_0.x, var_2_0.y, arg_2_2)

	return
end

function IslandGrassLandSystem:OnDetach()
	BLHX.Rendering.TerrainDetailTileMask.Instance:Dispose()

	return
end

return IslandGrassLandSystem
