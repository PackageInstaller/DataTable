-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitydaylirecharge/controller/ActivitydaylirechargeController.lua

module("logic.extensions.activitydaylirecharge.controller.ActivitydaylirechargeController", package.seeall)

local ActivitydaylirechargeController = class("ActivitydaylirechargeController", BaseController)

ActivitydaylirechargeController.PM_DailyRechargeInfoRes = "ActivitydaylirechargeController.PM_DailyRechargeInfoRes"
ActivitydaylirechargeController.PM_GainDailyRechargePrizeRes = "ActivitydaylirechargeController.PM_GainDailyRechargePrizeRes"

function ActivitydaylirechargeController:ctor()
	return
end

function ActivitydaylirechargeController:onInit()
	GlobalDispatcher:addListener(DailyRechargeAgent.PM_DailyRechargeInfoRes, self._PM_DailyRechargeInfoRes, self)
	GlobalDispatcher:addListener(DailyRechargeAgent.PM_GainDailyRechargePrizeRes, self._PM_GainDailyRechargePrizeRes, self)
	self:onReset()
end

function ActivitydaylirechargeController:onReset()
	return
end

function ActivitydaylirechargeController:_PM_DailyRechargeInfoRes(status, msg)
	if status == 0 then
		ActivitydaylirechargeModel.instance:setRechargeInfo(msg)
	end

	GlobalDispatcher:dispatch(ActivitydaylirechargeController.PM_DailyRechargeInfoRes, status, msg)
end

function ActivitydaylirechargeController:_PM_GainDailyRechargePrizeRes(status, msg)
	if status == 0 then
		DailyRechargeAgent.instance:sendPM_DailyRechargeInfoReq()
	end

	GlobalDispatcher:dispatch(ActivitydaylirechargeController.PM_GainDailyRechargePrizeRes, status, msg)
end

ActivitydaylirechargeController.instance = ActivitydaylirechargeController.New()

return ActivitydaylirechargeController
