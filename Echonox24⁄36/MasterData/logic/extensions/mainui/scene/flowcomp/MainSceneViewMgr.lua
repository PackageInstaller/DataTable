-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/flowcomp/MainSceneViewMgr.lua

module("logic.extensions.mainui.scene.flowcomp.MainSceneViewMgr", package.seeall)

local M = class("MainSceneViewMgr", ISceneFlowComp)

function M:ctor(flow)
	M.super.ctor(self, flow)
end

function M:onInit(sceneInfo)
	return
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onEnterDone()
	self:cacheEnterStatusLog()
end

function M:onExit()
	self:_setEvent(false)
	ViewMgr.instance:close(ViewName.MainUIView, false, WindowType.WindowCloseReasonType.NormalCloseType, true)
	GlobalDispatcher:dispatchEvent(EventType.ON_EXIT_MAIN_SCENE)
end

function M:onExitDone()
	return
end

function M:onSceneLoadDone()
	ViewMgr.instance:preCreate(ViewName.MainUIView)
end

function M:onLeaveScene()
	ViewMgr.instance:close(ViewName.MainUIView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
end

function M:onReturnScene()
	return
end

function M:onReturnSceneFinished()
	MainScenePerformUtil.printViewBackStack("回归场景，打印界面堆栈")
	ViewMgr.instance:_openPreFullUpView()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_VIEW_STATUS_PRINT, self._handleViewEnterStatusPrint, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_VIEW_STATUS_PRINT, self._handleViewEnterStatusPrint, self)
	end
end

function M:_handleViewEnterStatusPrint(e)
	printWarn(self:getLastEnterStatusLog())
end

function M:openView()
	local notOpenUI = self._flow:getIsNotOpenUI()
	local isBackScene = self._flow:getIsBackScene()
	local isJumpToMainView = self._flow:getIsJumpToMainView()
	local info = SceneFace.instance:getCurrBackInfo()

	if info then
		info.isBack = nil
		info.isLoading = nil
		info.notOpenUI = nil
		info.jumpToMainView = nil
	end

	if notOpenUI then
		if isBackScene then
			ViewMgr.instance:_openPreFullUpView()
		end
	elseif isBackScene then
		ViewMgr.instance:_openPreFullUpView()
	elseif isJumpToMainView then
		printWarn("jump To Main View")
		ViewMgr.instance:jumpToMainView(ViewName.MainUIView)
	else
		ViewMgr.instance:open(ViewName.MainUIView)
	end
end

function M:cacheEnterStatusLog()
	self._cacheEnterStatusLog = nil

	if not enableLog then
		return
	end

	local nowTime = ServerTime.now()
	local notOpenUI = self._flow:getIsNotOpenUI()
	local isBackScene = self._flow:getIsBackScene()
	local isJumpToMainView = self._flow:getIsJumpToMainView()
	local viewBackStack = MainScenePerformUtil.printViewBackStack("堆栈", true)

	self._cacheEnterStatusLog = string.format("[%s]notOpenUI[%s] isBackScene[%s] isJump[%s]\n%s", TimeUtil.instance:stampToDateStr(nowTime), notOpenUI, isBackScene, isJumpToMainView, viewBackStack)
end

function M:getLastEnterStatusLog()
	return self._cacheEnterStatusLog
end

return M
