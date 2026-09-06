-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/config/AccumulategiftConfig.lua

module("logic.extensions.accumulategift.config.AccumulategiftConfig", package.seeall)

local AccumulategiftConfig = class("AccumulategiftConfig", BaseConfig)

function AccumulategiftConfig:onInit()
	AccumulategiftConfig.super.onInit(self)

	self._activityCfgs = nil
	self._giftCfgs = nil
	self.campaign_consume_const = nil
	self._lastActivityId = nil
end

function AccumulategiftConfig:getNames()
	return {
		"campaign_consume_activity",
		"campaign_consume_gift",
		"campaign_consume_const"
	}
end

function AccumulategiftConfig:handleConfig(name, content)
	if name == "campaign_consume_activity" then
		self._activityCfgs = content
	elseif name == "campaign_consume_gift" then
		self._giftCfgs = content
	elseif name == "campaign_consume_const" then
		self.campaign_consume_const = content
	end
end

function AccumulategiftConfig:getCampaignConsumeCfg(activityId)
	return self._activityCfgs[activityId]
end

function AccumulategiftConfig:GetActivityPlanID(actId)
	if checknumber(actId) < 1 or self._activityCfgs == nil or self._activityCfgs[actId] == nil then
		return 1
	end

	return self._activityCfgs[actId].planId
end

function AccumulategiftConfig:GetConsumeGiftCfg(planId, id)
	if checknumber(planId) < 1 or self._giftCfgs == nil then
		return
	end

	local list = self._giftCfgs[planId]

	if checknumber(id) < 1 then
		return list
	end

	return list[id]
end

function AccumulategiftConfig:GetOpenActivityId()
	if self._activityCfgs == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(22)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			self._lastActivityId = item.activityId

			return item.activityId
		end
	end

	return -3
end

function AccumulategiftConfig:getConstValue(key)
	if self.campaign_consume_const[key] then
		return self.campaign_consume_const[key].value
	end
end

AccumulategiftConfig.instance = AccumulategiftConfig.New()

return AccumulategiftConfig
