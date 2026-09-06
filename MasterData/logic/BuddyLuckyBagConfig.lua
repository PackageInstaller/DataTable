-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/config/BuddyLuckyBagConfig.lua

module("logic.extensions.buddyluckybag.config.BuddyLuckyBagConfig", package.seeall)

local BuddyLuckyBagConfig = class("BuddyLuckyBagConfig", BaseConfig)

function BuddyLuckyBagConfig:getNames()
	return {
		"buddy_lucky_bag_activity",
		"buddy_lucky_bag_bag",
		"buddy_lucky_bag_card",
		"buddy_lucky_bag_pool"
	}
end

function BuddyLuckyBagConfig:handleConfig(name, content)
	if name == "buddy_lucky_bag_activity" then
		self._buddy_lucky_bag_activity = content
	elseif name == "buddy_lucky_bag_bag" then
		self._buddy_lucky_bag_bag = content
	elseif name == "buddy_lucky_bag_card" then
		self._buddy_lucky_bag_card = content
	elseif name == "buddy_lucky_bag_pool" then
		self._buddy_lucky_bag_pool = content
	end
end

function BuddyLuckyBagConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function BuddyLuckyBagConfig:getActivityData(activityId)
	return self:_safeGet(self._buddy_lucky_bag_activity, activityId)
end

function BuddyLuckyBagConfig:getBagDatas(activityId)
	return self:_safeGet(self._buddy_lucky_bag_bag, activityId)
end

function BuddyLuckyBagConfig:getBagData(activityId, bagId)
	return self:_safeGet(self._buddy_lucky_bag_bag, activityId, bagId)
end

function BuddyLuckyBagConfig:getCardDatas(activityId)
	return self:_safeGet(self._buddy_lucky_bag_card, activityId)
end

function BuddyLuckyBagConfig:getCardData(activityId, cardId)
	return self:_safeGet(self._buddy_lucky_bag_card, activityId, cardId)
end

function BuddyLuckyBagConfig:getPoolPrizeDatas(poolId)
	return self:_safeGet(self._buddy_lucky_bag_pool, poolId)
end

function BuddyLuckyBagConfig:getPoolPrizeData(poolId, prizeId)
	return self:_safeGet(self._buddy_lucky_bag_pool, poolId, prizeId)
end

BuddyLuckyBagConfig.instance = BuddyLuckyBagConfig.New()

return BuddyLuckyBagConfig
