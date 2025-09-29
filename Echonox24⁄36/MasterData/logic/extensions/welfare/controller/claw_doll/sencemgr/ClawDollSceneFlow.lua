-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/claw_doll/sencemgr/ClawDollSceneFlow.lua

module("logic.extensions.welfare.controller.claw_doll.sencemgr.ClawDollSceneFlow", package.seeall)

local M = class("ClawDollSceneFlow", DefaultSceneFlow)

function M:_registerComponents()
	M.super._registerComponents(self)
	self:_addComponent("resMgr", ClawDollResMgr)
	self:_addComponent("viewMgr", ClawDollViewMgr)
end

function M:createEnterSceneWork(info)
	self._isBackScene = info.isBack

	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New())
	sequence:addChild(WorkLoadScene.New())
	sequence:addChild(WorkLoadResource.New())
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(WorkInterval.New(0.3))
	sequence:addChild(WorkHideLoading.New())
	work:addChild(sequence)

	return work
end

function M:createExitSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onExitFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkExitScene.New())
	work:addChild(sequence)

	return work
end

function M:getIsBackScene()
	return self._isBackScene
end

return M
