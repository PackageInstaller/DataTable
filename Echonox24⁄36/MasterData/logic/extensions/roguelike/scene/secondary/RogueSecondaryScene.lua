-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/secondary/RogueSecondaryScene.lua

module("logic.extensions.roguelike.scene.secondary.RogueSecondaryScene", package.seeall)

local M = class("RogueSecondaryScene", SceneBaseSpacx)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("stage", RogueSecondarySceneStage)
	self:_addComponent("camera", SceneCamera)
	self:_addComponent("light", RogueSceneLight)
end

function M:getSceneType()
	return SceneType.RunGroup
end

return M
