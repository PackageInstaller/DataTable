-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataBingo.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityBingoDetail = require("ClientData/ResOpActivityBingoDetail")
local ResOpActivityBingoMisc = require("ClientData/ResOpActivityBingoMisc")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityBingoBigReward = require("ClientData/ResOpActivityBingoBigReward")
local UserData = require("Helper/UserData")
local ActivityDataBingo = Class("ActivityDataBingo", ActivityDataBase)

function ActivityDataBingo:ctor()
	self.curRound = 1
	self.hasTargetRoll = false
	self.randItemEnough = false
	self.targetItemEnough = false

	local svrData = {}

	svrData.round = 1
	svrData.cube = {}
	svrData.rewarded = {}
	svrData.big_reward_id = 0
	self.serverData = svrData
end

function ActivityDataBingo:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityBingoDetail[actId] or {}
	self.finalId = ResOpActivityBingoMisc[actId].final_award_id
end

function ActivityDataBingo:updateRoleData(roleData)
	local data = roleData.bingo
	local svrData = {}

	svrData.round = data.round + 1
	svrData.cube = ClientUtils.getBitsDictFromByteString(data.cube)
	svrData.rewarded = {}

	if data.rewarded then
		for i, data in ipairs(data.rewarded) do
			svrData.rewarded[data.id] = data
		end
	end

	svrData.big_reward_id = 0

	local awardId = data.big_reward_id
	local awardData = data.rewarded[awardId]

	if awardData then
		local awardInfo = ResOpActivityBingoBigReward[self.finalId][awardId]

		if awardData.times < awardInfo.max_get_times then
			svrData.big_reward_id = data.big_reward_id
		end
	else
		svrData.big_reward_id = data.big_reward_id
	end

	self.serverData = svrData
end

function ActivityDataBingo:checkItemEnough()
	local randItemId = ResOpActivityBingoMisc[self.actId].rand_item_id
	local randItemNeed = ResOpActivityBingoMisc[self.actId].rand_item_cost
	local itemNum = CurAvatar:getItemNumById(randItemId)

	if itemNum and randItemNeed <= itemNum then
		self.randItemEnough = true
	else
		self.randItemEnough = false
	end

	local targetItemId = ResOpActivityBingoMisc[self.actId].target_item_id
	local targetItemNeed = ResOpActivityBingoMisc[self.actId].target_item_cost

	if targetItemId then
		self.hasTargetRoll = true

		local tgtItemNum = CurAvatar:getItemNumById(targetItemId)

		if targetItemNeed <= tgtItemNum then
			self.targetItemEnough = true
		else
			self.targetItemEnough = false
		end
	end
end

function ActivityDataBingo:updateBingoDraw(indexTab)
	if self.serverData.cube then
		for _, idx in ipairs(indexTab) do
			self.serverData.cube[idx + 1] = true
		end
	end
end

function ActivityDataBingo:updateRound(round, finalAwardId, finelAwardTimes, new_big_reward_id)
	self.serverData.round = round + 1
	self.serverData.cube = {}
	self.serverData.big_reward_id = new_big_reward_id

	local awardId = finalAwardId
	local awardInfo = ResOpActivityBingoBigReward[self.finalId][awardId]

	if not (finelAwardTimes < awardInfo.max_get_times) then
		self.serverData.big_reward_id = 0
	end

	local rewarded = self.serverData.rewarded[finalAwardId]
	local count = 0

	if not rewarded then
		self.serverData.rewarded[finalAwardId] = {}
		count = 0
	else
		count = self.serverData.rewarded[finalAwardId].times
	end

	self.serverData.rewarded[finalAwardId].times = count + 1
end

function ActivityDataBingo:checkNew()
	self:checkItemEnough()

	if self.randItemEnough == true or self.targetItemEnough == true then
		return true
	end

	return false
end

function ActivityDataBingo:updateBigReward(reward_id)
	self.serverData.big_reward_id = reward_id
end

function ActivityDataBingo:getUnlockDayBigAwardData()
	local awardData = ResOpActivityBingoBigReward[self.finalId]

	if awardData[1].unlock_day then
		local daysData = {}

		for index, awardInfo in ipairs(awardData) do
			local unlockDay = awardInfo.unlock_day or 1

			if not daysData[unlockDay] then
				daysData[unlockDay] = {}
			end

			table.insert(daysData[unlockDay], awardInfo)
		end

		local sortedData = {}

		for unlockD, cellDats in pairs(daysData) do
			table.insert(sortedData, {
				unlockD,
				cellDats
			})
		end

		table.sort(sortedData, utils.getSortingFunc(1, true))

		return sortedData
	end
end

function ActivityDataBingo:isAwardValid(awardData)
	return self.serverData.round >= awardData.unlock_round and self:getDayUnlockTime(awardData) <= 0
end

local OneDaySeconds = 86400

function ActivityDataBingo:getDayUnlockTime(awardData)
	if awardData.unlock_day and awardData.unlock_day > 1 then
		if self.actObject.startTime and not self.startDayTime then
			self.startDayTime = ClientUtils.getServerTimeTodayStart(self.actObject.startTime)
		end

		if self.startDayTime then
			local unlockTime = self.startDayTime + (awardData.unlock_day - 1) * OneDaySeconds

			return unlockTime - ClientUtils.getServerTime()
		end
	end

	return 0
end

function ActivityDataBingo:setBingoNewInfo(round, unlockDay)
	UserData.saveCommonData("BingoActNew", self.actObject.opId)
	UserData.saveCommonData("BingoRoundNew", round or 1)
	UserData.saveCommonData("BingoDayNew", unlockDay or 1)

	self.markNewRound = round or 1
	self.markNewDay = unlockDay or 1
end

function ActivityDataBingo:getBingoNewInfo()
	if not self.markNewRound then
		local opId = UserData.loadCommonData("BingoActNew")

		if opId == tostring(self.actObject.opId) then
			local round = UserData.loadCommonData("BingoRoundNew")
			local unlockDay = UserData.loadCommonData("BingoDayNew")

			self.markNewRound = tonumber(round) or 1
			self.markNewDay = tonumber(unlockDay) or 1

			if self.markNewRound > self.serverData.round then
				self:setBingoNewInfo(1, 1)
			end
		else
			self.markNewRound = 1
			self.markNewDay = 1
		end
	end

	return self.markNewRound, self.markNewDay
end

function ActivityDataBingo:hasBingoAwardNew()
	local markNewRound, markNewDay = self:getBingoNewInfo()

	if markNewRound >= self.serverData.round then
		return false
	end

	local awardData = ResOpActivityBingoBigReward[self.finalId]

	if awardData then
		for index, aData in ipairs(awardData) do
			if markNewRound < aData.unlock_round and self:isAwardValid(aData) then
				return true
			end
		end
	end

	return false
end

return ActivityDataBingo
