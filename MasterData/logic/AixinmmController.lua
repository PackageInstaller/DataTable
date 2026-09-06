-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/controller/AixinmmController.lua

module("logic.extensions.aixinmm.controller.AixinmmController", package.seeall)

local AixinmmController = class("AixinmmController", BaseController)

AixinmmController.PM_AiXinMMClgGetInfoRes = "AixinmmController.PM_AiXinMMClgGetInfoRes"
AixinmmController.PM_AiXinMMClgChallengeRes = "AixinmmController.PM_AiXinMMClgChallengeRes"
AixinmmController.PM_AiXinMMClgChallengeEndRes = "AixinmmController.PM_AiXinMMClgChallengeEndRes"

function AixinmmController:ctor()
	return
end

function AixinmmController:onInit()
	GlobalDispatcher:addListener(AiXinMMClgAgent.PM_AiXinMMClgGetInfoRes, self._PM_AiXinMMClgGetInfoRes, self)
	GlobalDispatcher:addListener(AiXinMMClgAgent.PM_AiXinMMClgChallengeRes, self._PM_AiXinMMClgChallengeRes, self)
	GlobalDispatcher:addListener(AiXinMMClgAgent.PM_AiXinMMClgChallengeEndRes, self._PM_AiXinMMClgChallengeEndRes, self)
	self:onReset()
end

function AixinmmController:onReset()
	return
end

function AixinmmController:openView()
	local cid = AixinmmConfig.instance:getChallengeId()
	local isOpen = TLChallengeController.instance:isInOpenTime(cid)

	if isOpen then
		UIStateManager.instance:push(ViewName.AixinmmmainView)
	else
		FloatWordMgr.instance:show("不在活动时间内")
	end
end

function AixinmmController:_PM_AiXinMMClgGetInfoRes(status, msg)
	if status == 0 then
		AixinmmModel.instance:setClgInfo(msg)
	end

	GlobalDispatcher:dispatch(AixinmmController.PM_AiXinMMClgGetInfoRes, status, msg)
end

function AixinmmController:_PM_AiXinMMClgChallengeRes(status, msg)
	if status == 0 then
		UIJumper.instance:removeTopState(ViewName.AixinmmMissionView)
	end

	GlobalDispatcher:dispatch(AixinmmController.PM_AiXinMMClgChallengeRes, status, msg)
end

function AixinmmController:_PM_AiXinMMClgChallengeEndRes(status, msg)
	if status == 0 then
		AixinmmModel.instance:challengeEnd(msg)
	end

	GlobalDispatcher:dispatch(AixinmmController.PM_AiXinMMClgChallengeEndRes, status, msg)
end

AixinmmController.instance = AixinmmController.New()

return AixinmmController
