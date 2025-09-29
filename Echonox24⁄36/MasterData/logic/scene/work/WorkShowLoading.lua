-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkShowLoading.lua

module("logic.scene.work.WorkShowLoading", package.seeall)

local M = class("WorkShowLoading", WorkBase)

function M:ctor(isShowBlack)
	M.super.ctor(self)

	self._isShowBlack = isShowBlack
end

function M:onEnter(context)
	LoadingFacade.instance:showLoading(self._isShowBlack)
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
