-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/facade/HouseMainFacade.lua

module("logic.extensions.housemain.facade.HouseMainFacade", package.seeall)

local M = class("HouseMainFacade", BaseFacade)

function M:ctor()
	return
end

function M:backScene()
	LoadingFacade.instance:showLoading()
	settimer(0.6, function()
		ViewMgr.instance:closeAllViews(WindowType.WindowCloseReasonType.QuickCloseType)
		HouseMainRoomModel.instance:setFocusRoomId(nil)
		ViewMgr.instance:clearSomeViewFromBackStack(ViewName.RoomMainView)
		SceneFace.instance:backScene()
	end, self, false)
end

function M:onClickHome()
	LoadingFacade.instance:showLoading()
	settimer(0.6, function()
		HouseMainRoomModel.instance:setFocusRoomId(nil)
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
	end, self, false)
end

M.instance = M.New()

return M
