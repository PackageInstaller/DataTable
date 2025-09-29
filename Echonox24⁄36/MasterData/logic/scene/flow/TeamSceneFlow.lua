-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/TeamSceneFlow.lua

module("logic.scene.flow.TeamSceneFlow", package.seeall)

local M = class("TeamSceneFlow", DefaultSceneFlow)

function M:_registerComponents()
	M.super._registerComponents(self)
	self:_addComponent("viewmgr", TeamSceneViewMgr)
	self:_addComponent("scenePickerHandler", TeamScenePickerHandler)
end

function M:createEnterSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()
	local parallel = FlowParallel.New()

	parallel:addChild(WorkListenLoadScene.New())
	parallel:addChild(WorkLoadScene.New())
	sequence:addChild(WorkShowLoading.New())
	sequence:addChild(parallel)
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(WorkInterval.New(0.2))
	sequence:addChild(WorkHideLoading.New())
	work:addChild(sequence)

	return work
end

return M
