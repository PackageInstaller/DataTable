-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/facade/MainPlayerInputFacade.lua

module("logic.scene.facade.MainPlayerInputFacade", package.seeall)

local M = class("MainPlayerInputFacade")

function M:ctor()
	self._inputComp = nil
	self._moveStatus = nil
end

function M:init()
	self._moveStatus = MainPlayerAction.MoveStatus.STOP

	MainPlayerActionMgr.Instance:SetMoveStatusListener(self._onMoveStatusChange, self)
	MainPlayerActionMgr.Instance:SetPointerPressedListener(self._onPointerPressed, self)
	MainPlayerActionMgr.Instance:SetPointerReleaseListener(self._onPointerRelease, self)
end

function M:_onMoveStatusChange(moveStatus)
	self._moveStatus = moveStatus

	GlobalDispatcher:dispatchEvent(EventType.INPUT_MOVE_STATUS_CHANGE, moveStatus)
end

function M:_onPointerPressed(pos)
	GlobalDispatcher:dispatchEvent(EventType.INPUT_POINTER_PRESSED, pos)
end

function M:_onPointerRelease(pos)
	GlobalDispatcher:dispatchEvent(EventType.INPUT_POINTER_RELEASE, pos)
end

function M:getScreenPosition()
	return MainPlayerActionMgr.Instance.screenPosition
end

M.instance = M.New()

return M
