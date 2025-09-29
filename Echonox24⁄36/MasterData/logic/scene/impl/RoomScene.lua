-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/impl/RoomScene.lua

module("logic.scene.impl.RoomScene", package.seeall)

local M = class("RoomScene", SceneBaseSpacx)

function M:_initComponents()
	self:_addComponent("stage", RoomSceneStage)
	self:_addComponent("camera", MainSceneCam)
	self:_addComponent("light", MainSceneLight)
	self:_addComponent("pickerHandler", RoomScenePickerHandler)
	self:_addComponent("musicMgr", MainSceneMusicMgr)
	self:_addComponent("viewCamMgr", MainSceneViewCamMgr)
	self:_addComponent("airtightMgr", MainSceneAirtightMgr)
	self:_addComponent("performEditor", MainScenePerformEditor)
end

function M:getSceneType()
	return SceneType.Room
end

return M
