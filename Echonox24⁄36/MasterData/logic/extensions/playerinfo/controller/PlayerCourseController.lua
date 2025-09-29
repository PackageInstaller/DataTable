-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/controller/PlayerCourseController.lua

module("logic.extensions.playerinfo.controller.PlayerCourseController", package.seeall)

local M = class("PlayerCourseController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onLateInit()
	self._model = PlayerCourseModel.instance

	GlobalDispatcher:addEventListener(EventType.PLAYER_INFO_MAIN_OPEN, self._onEnterPlayInfoMainView, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_INFO_MAIN_DESTROY, self._onQuitPlayInfoMainView, self)
end

function M:tryAskCourseData()
	local userId = self._model:getCourseUserId()

	if userId and not self._model:permission() then
		PlayerCourseAgent.instance:sendGetPlayerDisplayInfoRequest(userId)
	end
end

function M:_onEnterPlayInfoMainView()
	self:tryAskCourseData()
end

function M:_onQuitPlayInfoMainView()
	self._model:onReset()
end

M.instance = M.New()

return M
