-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/model/ActivitySummaryModel.lua

module("logic.extensions.bonus.model.ActivitySummaryModel", package.seeall)

local ActivitySummaryModel = class("ActivitySummaryModel", BaseModel)

function ActivitySummaryModel:ctor()
	return
end

function ActivitySummaryModel:onInit()
	self:onReset()
end

function ActivitySummaryModel:onReset()
	self.signMap = {}
end

function ActivitySummaryModel:onGetSignInfo(msg)
	local activityId = msg.activityId
	local obj = {}

	obj.activityId = activityId
	obj.onlineDay = msg.onlineDay
	obj.hasGainPrizeDays = msg.hasGainPrizeDays
	obj.exchangeCodes = GameUtil.pbToTable(msg.exchangeCodes)
	obj.buytimes = msg.buyTimes
	obj.like = GameUtil.pbToTable(msg.likeInfo)
	obj.hasGainedDailyPrize = checkbool(msg.hasGainedDailyPrize)
	obj.hasGainedWeekPrize = checkbool(msg.hasGainedWeekPrize)
	self.signMap[activityId] = obj
end

function ActivitySummaryModel:onGetSignInPrize(msg)
	local activityId = msg.activityId
	local obj = self:getSignInfo(activityId) or {}

	obj.hasGainPrizeDays = obj.hasGainPrizeDays or {}

	for _, day in ipairs(msg.day or {}) do
		if table.indexof(obj.hasGainPrizeDays, day) == false then
			table.insert(obj.hasGainPrizeDays, day)
		end
	end

	self.signMap[activityId] = obj
end

function ActivitySummaryModel:onGainDailySignInPrize(msg)
	local activityId = msg.activityId
	local obj = self:getSignInfo(activityId) or {}

	obj.hasGainedDailyPrize = true
	self.signMap[activityId] = obj
end

function ActivitySummaryModel:onBuyTime(msg, activityId)
	local obj = self:getSignInfo(activityId) or {}

	obj.buytimes = msg.buyTimes
	self.signMap[activityId] = obj
end

function ActivitySummaryModel:onLike(msg, activityId)
	if not self.signMap[activityId].like then
		local newLikeObj = {}

		newLikeObj.tab = msg.tab
		newLikeObj.id = msg.id

		table.insert(self.signMap[activityId].like, newLikeObj)

		self.signMap[activityId].like = self.signMap[activityId].like
	end
end

function ActivitySummaryModel:hasLike(activityId, tab, id)
	if activityId and self.signMap[activityId] then
		if not self.signMap[activityId].like then
			for _, v in ipairs(self.signMap[activityId].like) do
				if v.tab == tab and v.id == id then
					return true
				end
			end
		end
	end

	return false
end

function ActivitySummaryModel:getSignInfo(activityId)
	return self.signMap[activityId]
end

function ActivitySummaryModel:onGetWeeklyPrize(msg)
	local activityId = msg.activityId
	local obj = self:getSignInfo(activityId) or {}

	obj.hasGainedWeekPrize = true
	self.signMap[activityId] = obj
end

ActivitySummaryModel.instance = ActivitySummaryModel.New()

return ActivitySummaryModel
