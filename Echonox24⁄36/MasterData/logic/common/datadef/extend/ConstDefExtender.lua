-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/extend/ConstDefExtender.lua

module("logic.common.datadef.extend.ConstDefExtender", package.seeall)

local ConstDefExtender = {}

function PrefabLoader.Get(go)
	return Astral.SimpleLuaComponentContainer.Add(go, PrefabLoader)
end

function CameraTarget.Get(go)
	return Astral.SimpleLuaComponentContainer.Add(go, CameraTarget)
end

function ConstDefExtender.extend()
	UnitBaseExtend.extend()
	SceneLayerExtend.extend()
	SceneTagExtend.extend()
	UnitTagExt.extend()
	SignAmountExtend.extend()
end

return ConstDefExtender
