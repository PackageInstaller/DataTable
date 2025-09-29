-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/scene/SpecialTrainingScene.lua

module("logic.extensions.specialtraining.scene.SpecialTrainingScene", package.seeall)

local M = class("SpecialTrainingScene", SceneBaseSpacx)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("stage", SpecialTrainingStage)
	self:_addComponent("camera", SceneCamera)
	self:_addComponent("pickerHandler", SpecialTrainingScenePickerHandler)
end

function M:getSceneType()
	return SceneType.SpecialTrainingScene
end

return M
