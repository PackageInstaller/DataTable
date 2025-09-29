-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/flow/component/RetrieveWorkExitScene.lua

module("logic.extensions.retrieve.scene.flow.component.RetrieveWorkExitScene", package.seeall)

local M = class("RetrieveWorkExitScene", WorkBase)

function M:onEnter(context)
	RetrieveModel.instance:onReset()
	self:_closeRetrieveView()
	SceneMgr.instance:exitCurScene()
	VirtualCameraMgr.instance:clearFollowConfiner()

	context.model.isEnterRoomScene = nil

	self:onDone(WorkResult.Succeed)
end

function M:_closeRetrieveView()
	ViewMgr.instance:close(ViewName.RetrieveMainViewViewPresentor, false, WindowType.WindowCloseReasonType.QuickCloseType)
	ViewMgr.instance:close(ViewName.RetrieveRoleShowViewViewPresentor, false, WindowType.WindowCloseReasonType.QuickCloseType)
	ViewMgr.instance:close(ViewName.RetrieveHistoryViewPresentor, false, WindowType.WindowCloseReasonType.QuickCloseType)
	ViewMgr.instance:close(ViewName.RetrieveCutlineViewPresentor, false, WindowType.WindowCloseReasonType.QuickCloseType)
	ViewMgr.instance:close(ViewName.RetrieveTenCardShowViewViewPresentor, false, WindowType.WindowCloseReasonType.QuickCloseType)
	ViewMgr.instance:close(ViewName.RetrieveJumpViewViewPresentor, false, WindowType.WindowCloseReasonType.QuickCloseType)
end

function M:onExit(isInterrupt)
	return
end

return M
