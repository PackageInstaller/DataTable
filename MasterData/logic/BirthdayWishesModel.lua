-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/model/BirthdayWishesModel.lua

module("logic.extensions.birthdaywishes.model.BirthdayWishesModel", package.seeall)

local BirthdayWishesModel = class("BirthdayWishesModel", BaseModel)

BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY = "newyearcollect1"

function BirthdayWishesModel:ctor()
	self._bwBaseInfo = nil
end

function BirthdayWishesModel:onInit()
	BirthdayWishesModel.super.onInit(self)
	self:onReset()
	self:getBirthdayWishesBaseInfo()
end

function BirthdayWishesModel:onReset()
	BirthdayWishesModel.super.onReset(self)

	self._bwBaseInfo = nil
	self._activityId = nil
	self._wishListCD = nil
	self._dailyPutoutTimes = 0
	self._recordInfos = {}
	self._buddyWishListInfos = {}
	self._buddyWishListMap = {}
	self._buddyWishListIdMap = {}
	self._wishListRecordInfos = {}
	self._newYearCollectModelPool = {}
	self._giftType = 9
end

function BirthdayWishesModel:GetModel(activityId)
	if self._newYearCollectModelPool[activityId] == nil then
		local cur = {}

		cur.gainCollectPrizeIds = {}
		cur.totalGiveNum = 0
		cur.gainGivePrizeIds = {}
		self._newYearCollectModelPool[activityId] = cur
	end

	return self._newYearCollectModelPool[activityId]
end

function BirthdayWishesModel:getBirthdayWishesBaseInfo()
	if self._bwBaseInfo == nil then
		self._bwBaseInfo = {
			first = 0,
			giveNum = 0,
			giftInfos = {},
			gifeNumInfos = {}
		}
	end

	return self._bwBaseInfo
end

function BirthdayWishesModel:getBirthdayWishesPlanCfgs(planId)
	local list = BirthdayWishesConfig.instance:getBirthdayWishesPlanCfgs(planId)
	local temp = {}

	for _, v in pairs(list or {}) do
		if v and checknumber(v.giftPlan) == planId then
			table.insert(temp, v)
		end
	end

	if #temp > 1 then
		table.sort(temp, function(a, b)
			return a.giftType < b.giftType
		end)
	end

	return temp
end

function BirthdayWishesModel:getActivityId()
	return self._activityId
end

function BirthdayWishesModel:setActivityId(actId)
	self._activityId = actId
end

function BirthdayWishesModel:getRecordInfos()
	return self._recordInfos
end

function BirthdayWishesModel:getBuddyWishListInfos()
	return self._buddyWishListInfos
end

function BirthdayWishesModel:getWishListRecordInfos()
	return self._wishListRecordInfos
end

function BirthdayWishesModel:getGiftType()
	return self._giftType
end

function BirthdayWishesModel:setGiftType(giftType)
	self._giftType = giftType
end

function BirthdayWishesModel:getBuddyWishListInfoByNameOrId(key)
	if self._buddyWishListMap[key] then
		return self._buddyWishListMap[key]
	end

	if self._buddyWishListIdMap[key] then
		return self._buddyWishListIdMap[key]
	end

	return nil
end

function BirthdayWishesModel:getWishListCD()
	return self._wishListCD
end

function BirthdayWishesModel:getDailyPutOutTimes()
	return self._dailyPutoutTimes
end

function BirthdayWishesModel:getWordsList(activity)
	local curModel = self:GetModel(activity)
	local wordsList = {}

	for i = 1, curModel.totalGiveNum do
		table.insert(wordsList, i)
	end

	return wordsList
end

function BirthdayWishesModel:csSendBirthdayWishesUserInfo(msg)
	self._bwBaseInfo = {
		first = 0,
		giveNum = 0,
		giftInfos = {},
		gifeNumInfos = {}
	}

	if msg == nil then
		return
	end

	self._bwBaseInfo.giveNum = checknumber(msg.giveNum)
	self._bwBaseInfo.first = checknumber(msg.first)

	for _, info in pairs(msg.giftInfos or {}) do
		if info and checknumber(info.giftType) > 0 then
			self._bwBaseInfo.giftInfos[info.giftType] = {
				openTime = info.openTime,
				redOpen = info.redOpen
			}
		end
	end

	for _, info in pairs(msg.gifeNumInfos or {}) do
		if info and checknumber(info.giftType) > 0 then
			self._bwBaseInfo.gifeNumInfos[info.giftType] = self._bwBaseInfo.gifeNumInfos[info.giftType] or {}
			self._bwBaseInfo.gifeNumInfos[info.giftType][info.giftId] = checknumber(info.num)
		end
	end

	self._wishListCD = checknumber(msg.wishListCD)
	self._dailyPutoutTimes = checknumber(msg.dailyPutoutTimes)
end

function BirthdayWishesModel:handlePM_BirthdayWishesUserInfoRes(msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.gainCollectPrizeIds = msg.gainCollectPrizeIds or {}
	curModel.totalGiveNum = msg.totalGiveNum
	curModel.gainGivePrizeIds = msg.gainGivePrizeIds or {}
end

function BirthdayWishesModel:csSendBirthdayWishesGiftOpen(curParams)
	if curParams == nil or curParams.giftType == nil then
		return
	end

	self._bwBaseInfo.giftInfos[curParams.giftType] = self._bwBaseInfo.giftInfos[curParams.giftType] or {}
	self._bwBaseInfo.giftInfos[curParams.giftType].openTime = checknumber(self._bwBaseInfo.giftInfos[curParams.giftType].openTime) + 1
end

function BirthdayWishesModel:csSendBirthdayWishesUserRedPointSet(msg)
	self._bwBaseInfo.giftInfos[msg.giftType] = self._bwBaseInfo.giftInfos[msg.giftType] or {}
	self._bwBaseInfo.giftInfos[msg.giftType].redOpen = msg.redOpen
end

function BirthdayWishesModel:csSendBirthdayWishesGiveFriend(curParams)
	if curParams == nil then
		return
	end

	self._bwBaseInfo.giveNum = checknumber(self._bwBaseInfo.giveNum) + 1
end

function BirthdayWishesModel:csSendBirthdayWishesSendWish()
	self._bwBaseInfo.first = 1
end

function BirthdayWishesModel:handlePM_BirthadyWishesGainCollectPrizeRes(msg)
	local curModel = self:GetModel(msg.activityId)

	table.insert(curModel.gainCollectPrizeIds, msg.prizeId)
end

function BirthdayWishesModel:handlePM_BirthadyWishesGainGivePrizeRes(msg)
	local curModel = self:GetModel(msg.activityId)

	if curModel.gainGivePrizeIds then
		table.insert(curModel.gainGivePrizeIds, msg.prizeId)
	end
end

function BirthdayWishesModel:handleBirthdayWishesGetAllWishListRes(msg)
	self._buddyWishListInfos = msg.wishListInfos
	self._buddyWishListMap = {}
	self._buddyWishListIdMap = {}

	for i, v in ipairs(msg.wishListInfos) do
		self._buddyWishListMap[v.headInfo.userName] = v
		self._buddyWishListIdMap[v.headInfo.userId] = v
	end
end

function BirthdayWishesModel:handleBirthdayWishesGetWishListRecordRes(msg)
	self._wishListRecordInfos = msg.infos
end

function BirthdayWishesModel:handleBirthdayWishesGiveAndGetRecord(msg)
	self._recordInfos = msg.records
end

function BirthdayWishesModel:getRechargeTabRedpoint(money)
	local count = self:getSatisfyRechargeCount(money)

	if count < 1 then
		return false
	end

	local list = DoubleElevenConfig.instance:getDaysRechargeMoneyCfgs(money)

	if list == nil or list == 0 then
		return false
	end

	for i = 1, count do
		if list[i] and not self:isRechargeItemReceive(list[i].itemId) then
			return true
		end
	end

	return false
end

BirthdayWishesModel.instance = BirthdayWishesModel.New()

return BirthdayWishesModel
