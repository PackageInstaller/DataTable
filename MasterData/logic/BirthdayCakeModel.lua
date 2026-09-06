-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/model/BirthdayCakeModel.lua

module("logic.extensions.birthdaycake.model.BirthdayCakeModel", package.seeall)

local BirthdayCakeModel = class("BirthdayCakeModel", BaseModel)
local storeType = {
	A = 2,
	S = 1,
	B = 3
}

function BirthdayCakeModel:ctor()
	return
end

function BirthdayCakeModel:onInit()
	self:onReset()
end

function BirthdayCakeModel:onReset()
	self._taskList = {}
	self._mainInfo = {}
	self._records = {}
	self._worldProgressReward = {}
	self._worldProgressValue = 0
	self._activityId = 0
end

function BirthdayCakeModel:setMainInfo(msg)
	self._mainInfo = msg

	self:setWorldProgressReward(msg.worldProgressReward)
end

function BirthdayCakeModel:setBuyNum(msg)
	self._mainInfo.buyNum = msg.buyNum
end

function BirthdayCakeModel:setWorldProgressValue(msg)
	self._worldProgressValue = msg.worldProgressValue
end

function BirthdayCakeModel:setPlayerRecords(msg)
	self._records = msg.records
end

function BirthdayCakeModel:setWorldProgressReward(msg)
	self._worldProgressReward = {}

	for k, v in ipairs(msg) do
		table.insert(self._worldProgressReward, v)
	end
end

function BirthdayCakeModel:setContribute(msg)
	self._mainInfo.contribute = msg.contribute
end

function BirthdayCakeModel:setCarveUpNum()
	self._mainInfo.carveUpNum = self._mainInfo.carveUpNum + 1
end

function BirthdayCakeModel:setTaskList(msg)
	self._taskList = msg.taskList
end

function BirthdayCakeModel:getActivityId()
	self._activityId = BirthdayCakeConfig.instance:getOpenActivityCfg()

	return self._activityId
end

function BirthdayCakeModel:getMainInfo()
	return self._mainInfo
end

function BirthdayCakeModel:getContribute()
	return self._mainInfo.contribute
end

function BirthdayCakeModel:getCarveUpNum()
	return self._mainInfo.carveUpNum
end

function BirthdayCakeModel:getTotalNum()
	return self._mainInfo.totalNum
end

function BirthdayCakeModel:getBuyNum()
	return checknumber(self._mainInfo.buyNum)
end

function BirthdayCakeModel:getStoreInfo()
	if self._mainInfo.storeInfo then
		return self._mainInfo.storeInfo
	end

	return {}
end

function BirthdayCakeModel:getCarveUpHistoryInfo()
	if self._mainInfo.carveUpHistoryInfo then
		return self._mainInfo.carveUpHistoryInfo
	end

	return {}
end

function BirthdayCakeModel:getAllLotteryCountTypeS()
	if self._mainInfo.carveUpHistoryInfo then
		local num = 0
		local actCfg = BirthdayCakeConfig.instance:getCfgById(self._activityId)

		for i, v in ipairs(self._mainInfo.carveUpHistoryInfo) do
			local info = BirthdayCakeConfig.instance:getCakeStoreCfg(actCfg.storePlan, v.storeId)

			if info.storeType == storeType.S then
				num = num + v.num
			end
		end

		return num
	end

	return 0
end

function BirthdayCakeModel:getAllLotteryCount()
	if self._mainInfo.carveUpHistoryInfo then
		local num = 0
		local actCfg = BirthdayCakeConfig.instance:getCfgById(self._activityId)

		for i, v in ipairs(self._mainInfo.carveUpHistoryInfo) do
			num = num + v.num
		end

		return num
	end

	return 0
end

function BirthdayCakeModel:getRecords()
	if self._records then
		local temp = {}
		local records = {}

		for i, v in ipairs(self._records) do
			table.insert(temp, v)

			if #temp >= 2 then
				local list = self:getCloneList(temp)

				table.insert(records, list)

				temp = {}
			elseif i == #self._records then
				table.insert(records, temp)
			end
		end

		return records
	end

	return {}
end

function BirthdayCakeModel:getCloneList(temp)
	local list = {}

	for k, v in pairs(temp) do
		table.insert(list, v)
	end

	return list
end

function BirthdayCakeModel:getWorldProgressReward()
	return self._worldProgressReward
end

function BirthdayCakeModel:getWorldProgressValue()
	return checknumber(self._worldProgressValue)
end

function BirthdayCakeModel:getTaskList()
	return self._taskList
end

function BirthdayCakeModel:isPlayerRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self:getWorldProgressValue()

	if isScoreEnough then
		local isGeted = self:isPlayerRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function BirthdayCakeModel:isPlayerRewardGeted(prizeId)
	return TableUtil.isHad(self:getWorldProgressReward(), prizeId)
end

BirthdayCakeModel.instance = BirthdayCakeModel.New()

return BirthdayCakeModel
