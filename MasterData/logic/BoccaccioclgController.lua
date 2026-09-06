-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/controller/BoccaccioclgController.lua

module("logic.extensions.boccaccioclg.controller.BoccaccioclgController", package.seeall)

local BoccaccioclgController = class("BoccaccioclgController", BaseController)

BoccaccioclgController.BuffType = {
	Defense = 3,
	Attack = 2,
	Blood = 1
}

function BoccaccioclgController:ctor()
	return
end

function BoccaccioclgController:onInit()
	self:onReset()
end

function BoccaccioclgController:onReset()
	return
end

function BoccaccioclgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(286)
end

function BoccaccioclgController:onNotifyFightRes(msg)
	if not msg.isWin then
		return
	end

	BoccaccioclgModel.instance:onNotifyFightRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.BoccaccioclgresultView, msg)

		return true
	end)
end

function BoccaccioclgController:value2Score(activityId, buffType, value)
	local buffCfg = BoccaccioclgConfig.instance:getSignBuffCfg(activityId, buffType)

	if not buffCfg then
		return 0
	end

	value = checknumber(value)

	return math.ceil(value * buffCfg.scoreWanPercent / 10000)
end

function BoccaccioclgController:isInChallengeTime(activityId)
	local rankCfg = GodDailyRankConfig.instance:getRankCfgById(activityId)
	local challengeClosedTimeRange = rankCfg.challengeClosedTimeRange

	if string.nilorempty(challengeClosedTimeRange) then
		return true
	end

	local arr = string.split(challengeClosedTimeRange, "-")

	return not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true)
end

BoccaccioclgController.instance = BoccaccioclgController.New()

return BoccaccioclgController
