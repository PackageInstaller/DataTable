-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatelottery/config/AccumulateLotteryConfig.lua

module("logic.extensions.accumulatelottery.config.AccumulateLotteryConfig", package.seeall)

local AccumulateLotteryConfig = class("AccumulateLotteryConfig", BaseConfig)

function AccumulateLotteryConfig:onInit()
	return
end

function AccumulateLotteryConfig:getNames()
	return {
		"annuity_accumulate_lottery_config",
		"annuity_accumulate_lottery_storey",
		"annuity_accumulate_lottery_consume"
	}
end

function AccumulateLotteryConfig:handleConfig(name, content)
	if name == "annuity_accumulate_lottery_config" then
		self._lotteryConfig = content
	elseif name == "annuity_accumulate_lottery_storey" then
		self._lotteryStorey = content
	elseif name == "annuity_accumulate_lottery_consume" then
		self._lotteryConsume = content
	end
end

function AccumulateLotteryConfig:getActivities()
	return self._lotteryConfig.dataList
end

function AccumulateLotteryConfig:getActivityCo(activityId)
	return self._lotteryConfig[activityId]
end

function AccumulateLotteryConfig:getLotteryConsumeList()
	return self._lotteryConsume.dataList
end

function AccumulateLotteryConfig:getActivitiesStorey(activityId)
	if self._sortedLotteryStorey then
		return self._sortedLotteryStorey[activityId]
	end

	self._sortedLotteryStorey = {}

	for i = 1, #self._lotteryStorey.dataList do
		local data = self._lotteryStorey.dataList[i]

		self._sortedLotteryStorey[data.activityId] = self._sortedLotteryStorey[data.activityId] or {}

		local acDatas = self._sortedLotteryStorey[data.activityId]

		acDatas[data.storey] = acDatas[data.storey] or {}

		local storey = acDatas[data.storey]

		table.insert(storey, data)
	end

	for k, v in pairs(self._sortedLotteryStorey) do
		for k1, v1 in pairs(v) do
			table.sort(v1, function(x, y)
				return x.rewardId < y.rewardId
			end)
		end
	end

	return self._sortedLotteryStorey[activityId]
end

function AccumulateLotteryConfig:getLotteryConsume(activityId, times)
	local lotteryCo = self._lotteryConfig[activityId]

	if not lotteryCo then
		return
	end

	local consumeCos = self._lotteryConsume[lotteryCo.consumePlanId]
	local maxTimes = -9999
	local maxTimeCo

	for k, v in pairs(consumeCos) do
		if v.frequency then
			if #v.frequency == 1 and v.frequency[1] == times then
				return lotteryCo.itemId .. ":" .. v.cost
			end

			if #v.frequency == 2 and times >= v.frequency[1] and times <= v.frequency[2] then
				return lotteryCo.itemId .. ":" .. v.cost
			end

			local max = math.max(checknumber(v.frequency[1]), checknumber(v.frequency[2]))

			if maxTimes < max then
				maxTimes = max
				maxTimeCo = v
			end
		end
	end

	if maxTimeCo and maxTimes <= times then
		return lotteryCo.itemId .. ":" .. maxTimeCo.cost
	end
end

AccumulateLotteryConfig.instance = AccumulateLotteryConfig.New()

return AccumulateLotteryConfig
