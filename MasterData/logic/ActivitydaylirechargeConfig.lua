-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitydaylirecharge/config/ActivitydaylirechargeConfig.lua

module("logic.extensions.activitydaylirecharge.config.ActivitydaylirechargeConfig", package.seeall)

local ActivitydaylirechargeConfig = class("ActivitydaylirechargeConfig", BaseConfig)

function ActivitydaylirechargeConfig:onInit()
	return
end

function ActivitydaylirechargeConfig:getNames()
	return {
		"activity_daily_recharge",
		"activity_daily_recharge_plan",
		"activity_daily_recharge_prize"
	}
end

function ActivitydaylirechargeConfig:handleConfig(name, content)
	if name == "activity_daily_recharge" then
		self._activity_daily_recharge = content
	elseif name == "activity_daily_recharge_plan" then
		self._activity_daily_recharge_plan = content
		self._activity_daily_recharge_planSortList = {}

		local tempList = {}

		for i, v in ipairs(content.dataList) do
			tempList[v.activity] = tempList[v.activity] or {}

			table.insert(tempList[v.activity], {
				time = GameUtil.string2time(v.time),
				cfg = v
			})
		end

		for i, v in ipairs(tempList) do
			table.sort(v, function(a, b)
				return a.time < b.time
			end)
		end

		for k, v in pairs(tempList) do
			self._activity_daily_recharge_planSortList[k] = {}

			for _, vo in ipairs(v) do
				table.insert(self._activity_daily_recharge_planSortList[k], vo.cfg)
			end
		end
	elseif name == "activity_daily_recharge_prize" then
		self._activity_daily_recharge_prize = content
	end
end

function ActivitydaylirechargeConfig:getActCfg(id)
	return self._activity_daily_recharge[id]
end

function ActivitydaylirechargeConfig:getRechargePlan(actId)
	return self._activity_daily_recharge_planSortList[actId]
end

function ActivitydaylirechargeConfig:getRechargePlanByIndex(actId, index)
	return self._activity_daily_recharge_planSortList[actId][index]
end

function ActivitydaylirechargeConfig:getPrizePlan(prizePlanId)
	return self._activity_daily_recharge_prize[prizePlanId]
end

ActivitydaylirechargeConfig.instance = ActivitydaylirechargeConfig.New()

return ActivitydaylirechargeConfig
