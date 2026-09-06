-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitydaylirecharge/model/ActivitydaylirechargeModel.lua

module("logic.extensions.activitydaylirecharge.view.ActivitydaylirechargeModel", package.seeall)

local ActivitydaylirechargeModel = class("ActivitydaylirechargeModel", BaseModel)

function ActivitydaylirechargeModel:ctor()
	return
end

function ActivitydaylirechargeModel:onInit()
	self:onReset()
end

function ActivitydaylirechargeModel:onReset()
	self._prizeIds = {}
	self._rechargeNum = 0
end

function ActivitydaylirechargeModel:isActOpen()
	local isOpen = false
	local planCfgIndex = 1
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ActivityDailyRecharge)
	local activityId = cfg and cfg.activityId

	if not activityId then
		-- block empty
	else
		local actCfg = ActivitydaylirechargeConfig.instance:getActCfg(activityId)

		if not actCfg then
			printError("每日累充没配置表 activityId：", activityId)
		else
			local planCfgs = ActivitydaylirechargeConfig.instance:getRechargePlan(activityId)

			for i, v in ipairs(planCfgs) do
				local day = string.match(v.time, "-(%d+)T")
				local nextDay = checknumber(day) + 1
				local endTime = string.gsub(v.time, "-(%d+)T", "-" .. nextDay .. "T")

				if GameUtil.checkIsInTimePeriod(v.time, endTime) then
					isOpen = true
					planCfgIndex = i
				end
			end
		end
	end

	return isOpen, activityId, planCfgIndex
end

function ActivitydaylirechargeModel:isGetPrize(prizeId)
	for i, v in ipairs(self._prizeIds) do
		if v == prizeId then
			return true
		end
	end
end

function ActivitydaylirechargeModel:getHasGetPrizeIds()
	return self._prizeIds
end

function ActivitydaylirechargeModel:setRechargeInfo(msg)
	self._rechargeNum = msg.money
	self._prizeIds = msg.prizeIds
end

function ActivitydaylirechargeModel:getRechargeNum()
	return self._rechargeNum
end

ActivitydaylirechargeModel.instance = ActivitydaylirechargeModel.New()

return ActivitydaylirechargeModel
