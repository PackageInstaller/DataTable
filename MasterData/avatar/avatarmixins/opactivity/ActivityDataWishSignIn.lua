-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataWishSignIn.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityWishMisc = require("ClientData/ResOpActivityWishMisc")
local ResOpActivityWishRewardPool = require("ClientData/ResOpActivityWishRewardPool")
local ActivityDataWishSignIn = Class("ActivityDataWishSignIn", ActivityDataBase)

function ActivityDataWishSignIn:ctor()
	self.isWishDay = false
	self.isRewardDay = false
	self.hasAllGet = false
	self.wishPool = {}
	self.wishPoolByWday = {}
	self.got = {}
	self.nextWishTime = 0
	self.rewardTime = 0
end

function ActivityDataWishSignIn:updateClientData(actId)
	self.actId = actId

	local miscData = ResOpActivityWishMisc[actId] or {}

	self.miscData = miscData
	self.isSpecWish = false

	if miscData.next_day_award and miscData.next_day_award == 1 then
		self.isSpecWish = true
	end

	self.awardPoolId = miscData.reward_pool
	self.resAwards = ResOpActivityWishRewardPool[self.awardPoolId]
end

function ActivityDataWishSignIn:updateRoleData(roleData, fromDataUpdate)
	self:refreshWday()

	local rData = roleData.wish

	self.hasWish = rData.day_wish == 1
	self.got = {}

	if rData.awarded then
		self.got = ClientUtils.getBitsDictFromByteString(rData.awarded)
	end

	self.gotCount = 0

	for i, id in pairs(self.got) do
		self.gotCount = self.gotCount + 1
	end

	self.wishPool = {}
	self.wishPoolByWday = {}

	for i, data in ipairs(rData.wish_pool) do
		local mData = {}
		local wDay = tonumber(ClientUtils.getServerTimeData(data.wish_time - Const.TIME_NEXT_DAY, "%w"))

		wDay = wDay == 0 and 7 or wDay
		mData.index = data.index
		mData.wishTime = data.wish_time
		mData.wDay = wDay

		table.insert(self.wishPool, mData)

		self.wishPoolByWday[wDay] = mData
	end

	table.sort(self.wishPool, function(a, b)
		return a.wishTime < b.wishTime
	end)

	self.hasAllGet = false

	local dayCount = self.miscData.wish_days and #self.miscData.wish_days or 0

	if self.isSpecWish then
		self.hasAllGet = self.gotCount == #self.resAwards
	elseif self.gotCount == dayCount then
		self.hasAllGet = true
	end

	self:initTime()

	if fromDataUpdate then
		CurAvatar:_refreshActivityUI()
	end
end

function ActivityDataWishSignIn:updateMgrData()
	self:refreshWday()
	self:initTime()
end

function ActivityDataWishSignIn:refreshWday()
	local miscData = self.miscData
	local curWdaySvrTime = ClientUtils.getServerTime() - Const.TIME_NEXT_DAY
	local wDay = tonumber(ClientUtils.getServerTimeData(curWdaySvrTime, "%w"))

	self.curWday = wDay == 0 and 7 or wDay
	self.isWishDay = false
	self.isRewardDay = false

	if not self.isSpecWish then
		if not miscData.wish_days then
			return
		end

		for i, day in ipairs(miscData.wish_days) do
			if day == self.curWday then
				self.isWishDay = true

				break
			end
		end

		for i, day in ipairs(miscData.reward_days) do
			if day == self.curWday then
				self.isRewardDay = true

				break
			end
		end
	else
		self.isWishDay = true
	end
end

function ActivityDataWishSignIn:initTime()
	if self.isSpecWish then
		self.rewardTime = ClientUtils.getServerTimeNextDay()
	else
		local nextWishDay = 6

		if self.miscData.wish_days then
			for i, day in ipairs(self.miscData.wish_days) do
				if day == self.curWday then
					if self.miscData.wish_days[i + 1] then
						nextWishDay = self.miscData.wish_days[i + 1]
					else
						nextWishDay = self.miscData.wish_days[1]
					end
				end
			end
		end

		local rewardDay = self.miscData.reward_days[1]

		self.rewardTime = ClientUtils.getServerTimeNextWday(rewardDay)
		self.nextWishTime = ClientUtils.getServerTimeNextWday(nextWishDay)
	end
end

function ActivityDataWishSignIn:getState()
	local state = 0

	if self.isWishDay then
		if self.hasWish then
			state = 2
		elseif self.isSpecWish then
			if self:isOver() then
				state = 0
			elseif #self.wishPool > 0 then
				state = 3
			else
				state = 1
			end
		else
			state = 1
		end
	elseif self.isRewardDay and not self.hasAllGet and #self.wishPool > 0 then
		state = 3
	end

	return state
end

function ActivityDataWishSignIn:checkNew()
	local hasNew = false
	local svrTime = ClientUtils.getServerTime()

	for i, wishAward in ipairs(self.wishPool) do
		if self.isSpecWish and not self.got[wishAward.index + 1] and not self.hasWish then
			hasNew = true

			break
		elseif self.isRewardDay and not self.got[wishAward.index + 1] then
			hasNew = true

			break
		end
	end

	if self.isWishDay and not self.hasWish then
		hasNew = true
	end

	return hasNew
end

function ActivityDataWishSignIn:isOver()
	if self.isSpecWish and self.gotCount == #self.resAwards then
		return true
	end

	return false
end

return ActivityDataWishSignIn
