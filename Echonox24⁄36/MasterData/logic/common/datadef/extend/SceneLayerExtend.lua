-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/extend/SceneLayerExtend.lua

module("logic.common.datadef.extend.SceneLayerExtend", package.seeall)

local SceneLayerExtend = {}

function LayerMask.GetArrayMask(arg)
	local value = 0

	for i = 1, #arg do
		local n = LayerMask.NameToLayer(arg[i])

		if n ~= nil then
			value = value + 2^n
		end
	end

	return value
end

function SceneLayerExtend.extend()
	SceneLayer.Stone = "Stone"
	SceneLayer.TransparentFX = "TransparentFX"
	SceneLayer.Raycast = "Raycast"
	SceneLayer.NavMesh = "NavMesh"
	SceneLayer.HighImportance = "high_importance"
	SceneLayer.MediumImportance = "medium_importance"
	SceneLayer.LowImportance = "low_importance"
	SceneLayer.Default_Value = Astral.LayerUtil.NameToLayer(SceneLayer.Default)
	SceneLayer.Stone_Value = Astral.LayerUtil.NameToLayer(SceneLayer.Stone)
	SceneLayer.UI_Value = Astral.LayerUtil.NameToLayer(SceneLayer.UI)
	SceneLayer.UI3D_Value = Astral.LayerUtil.NameToLayer(SceneLayer.UI3D)
	SceneLayer.Unit_Value = Astral.LayerUtil.NameToLayer(SceneLayer.Unit)
	SceneLayer.TransparentFX_Value = Astral.LayerUtil.NameToLayer(SceneLayer.TransparentFX)
	SceneLayer.Raycast_Value = Astral.LayerUtil.NameToLayer(SceneLayer.Raycast)
	SceneLayer.NavMesh_Value = Astral.LayerUtil.NameToLayer(SceneLayer.NavMesh)
end

return SceneLayerExtend
