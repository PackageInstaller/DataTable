-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionWaitCreateRole.lua

module("logic.extensions.guide.controller.action.GuideActionWaitCreateRole", package.seeall)

local GuideActionWaitCreateRole = class("GuideActionWaitCreateRole", BaseGuideAction)

function GuideActionWaitCreateRole:ctor(guideId, stepId, guideStepCO)
	GuideActionWaitCreateRole.super.ctor(self, guideId, stepId, guideStepCO)

	self._viewId = tonumber(guideStepCO.guideControlParam)
	self._curOpenViewName = false
end

function GuideActionWaitCreateRole:onEnter(context)
	GlobalDispatcher:addEventListener(EventType.PLAYER_CREATED_UI_CLOSED, self._onCreatedPlayer, self)
	GuideActionWaitCreateRole.super.onEnter(self, context)
	self:_doWaitView(self._viewId)
end

function GuideActionWaitCreateRole:onExit()
	GlobalDispatcher:removeEventListener(EventType.PLAYER_CREATED, self._onCreatedPlayer, self)
	GuideActionWaitCreateRole.super.onExit(self)
end

function GuideActionWaitCreateRole:_onCreatedPlayer()
	self:_checkCanFinishStep()
end

function GuideActionWaitCreateRole:_checkCanFinishStep()
	self:_doFinishWork()
end

function GuideActionWaitCreateRole:_doWaitView(jumpId)
	local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

	if not jumpInfo then
		return
	end

	if PlayerModel.instance:isCreatedPlayer() then
		self:_doFinishWork()
	end

	self._curOpenViewName = jumpInfo.viewName
end

function GuideActionWaitCreateRole:_doFinishWork()
	ViewMgr.instance:preCreate(ViewName.StoryViewViewPresentor)

	if not ViewMgr.instance:isOpen(ViewName.RetrieveMainViewViewPresentor) then
		ViewMgr.instance:open(ViewName.RetrieveMainViewViewPresentor)
	end

	self:onDone(WorkResult.Succeed)
end

return GuideActionWaitCreateRole
