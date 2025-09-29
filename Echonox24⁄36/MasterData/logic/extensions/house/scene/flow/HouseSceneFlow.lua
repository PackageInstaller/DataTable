-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/flow/HouseSceneFlow.lua

module("logic.extensions.house.scene.flow.HouseSceneFlow", package.seeall)

local M = class("HouseSceneFlow", DefaultSceneFlow)

function M:_registerComponents()
	M.super._registerComponents(self)
	self:_addComponent("viewmgr", HouseSceneViewMgr)
	self:_addComponent("performTrigger", HouseScenePerformTrigger)
	self:_addComponent("navigationMgr", HouseSceneNavigationMgr)
	self:_addComponent("unitMgr", UnitMgr)
end

function M:createEnterSceneWork(info)
	self._isBackScene = info.isBack

	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New())
	sequence:addChild(WorkEnableLoadingOptimize.New())
	sequence:addChild(WorkInterval.New(0.2))

	local parallel = FlowParallel.New()

	parallel:addChild(WorkListenLoadScene.New())
	parallel:addChild(WorkLoadScene.New())
	sequence:addChild(parallel)
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(WorkInterval.New(0.3))
	sequence:addChild(WorkDisableLoadingOptimize.New())
	sequence:addChild(WorkHideLoading.New())
	work:addChild(sequence)

	return work
end

function M:getIsBackScene()
	return self._isBackScene
end

return M
