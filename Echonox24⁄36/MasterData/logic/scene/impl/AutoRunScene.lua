-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/impl/AutoRunScene.lua

module("logic.scene.impl.AutoRunScene", package.seeall)

local M = class("AutoRunScene", SceneBase)

function M:_initComponents()
	self:_addComponent("stage", AutoRunSceneStage)
end

function M:getSceneType()
	return SceneType.AutoRun
end

return M
