-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/camera/MainCameraMaskMode.lua

module("logic.scene.camera.MainCameraMaskMode", package.seeall)

local MainCameraMaskMode = {}

MainCameraMaskMode.Layers = {
	[0] = {
		SceneLayer.Default,
		SceneLayer.Unit,
		SceneLayer.TransparentFX,
		SceneLayer.Stone,
		SceneLayer.HighImportance,
		SceneLayer.MediumImportance,
		SceneLayer.LowImportance
	},
	{
		SceneLayer.Default,
		SceneLayer.Unit,
		SceneLayer.Stone
	},
	[101] = {
		SceneLayer.Default,
		SceneLayer.Stone
	}
}

return MainCameraMaskMode
