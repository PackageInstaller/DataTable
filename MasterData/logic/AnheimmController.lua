-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/AnheimmController.lua

module("logic.extensions.timelimitedchallenge.controller.AnheimmController", package.seeall)

local AnheimmController = class("AnheimmController", BaseController)

function AnheimmController:ctor()
	return
end

function AnheimmController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
	AnHeiMMChallengeAgent.instance:addHandler(AnHeiMMChallengeAgent.PM_AnHeiMMChallengeChallengeEndRes, self._onAnheimmFightEndRes, self)
end

function AnheimmController:onReset()
	self._needOpenRuleView = false
end

function AnheimmController:_dailyReset()
	AnheimmModel.instance:onReset()
	GlobalDispatcher:dispatch(GlobalNotify.RefreshAnheiMMChallenge)
end

function AnheimmController:_onAnheimmFightEndRes(msg)
	AnheimmModel.instance:setBtlResult(msg)
end

function AnheimmController:setNeedOpenRuleView(value)
	self._needOpenRuleView = value
end

function AnheimmController:getNeedOpenRuleView()
	self._needOpenRuleView = false

	return self._needOpenRuleView
end

AnheimmController.instance = AnheimmController.New()

return AnheimmController
