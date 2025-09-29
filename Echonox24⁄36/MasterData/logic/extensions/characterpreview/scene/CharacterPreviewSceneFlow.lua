-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterpreview/scene/CharacterPreviewSceneFlow.lua

module("logic.extensions.characterpreview.scene.CharacterPreviewSceneFlow", package.seeall)

local M = class("CharacterPreviewSceneFlow", DefaultSceneFlow)

function M:_registerComponents()
	M.super._registerComponents(self)
	self:_addComponent("resMgr", CharacterPreviewResMgr)
	self:_addComponent("viewMgr", CharacterPreviewViewMgr)
end

function M:createEnterSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkLoadScene.New())
	sequence:addChild(WorkInterval.New(0))
	sequence:addChild(WorkLoadResource.New())
	sequence:addChild(WorkInterval.New(0))
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(WorkInterval.New(0))
	work:addChild(sequence)

	return work
end

function M:createExitSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onExitFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkExitScene.New())
	sequence:addChild(WorkInterval.New(0))
	work:addChild(sequence)

	return work
end

return M
