-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/config/BirthdayWishesConfig.lua

module("logic.extensions.birthdaywishes.config.BirthdayWishesConfig", package.seeall)

local BirthdayWishesConfig = class("BirthdayWishesConfig", BaseConfig)

function BirthdayWishesConfig:onInit()
	BirthdayWishesConfig.super.onInit(self)

	self._bwBaseCfgs = nil
	self._bwTokenCfgs = nil
	self._bwPlanCfgs = nil
	self._bwLotteryPlanCfgs = nil
	self._bwTextPlanCfgs = nil
	self._tokenAllCfgs = nil
	self._bwWishListCfgs = nil
end

function BirthdayWishesConfig:getNames()
	return {
		"birthday_wishes_activity",
		"birthday_wishes_gift_plan",
		"birthday_wishes_lottery_plan",
		"birthday_wishes_text_plan",
		"birthday_wishes_token",
		"birthday_wishes_wishlist",
		"token",
		"birthday_wishes_collect_prize",
		"birthday_wishes_give_prize"
	}
end

function BirthdayWishesConfig:handleConfig(name, content)
	if name == "birthday_wishes_activity" then
		self._bwBaseCfgs = content
	elseif name == "birthday_wishes_gift_plan" then
		self._bwPlanCfgs = content
	elseif name == "birthday_wishes_lottery_plan" then
		self._bwLotteryPlanCfgs = content
	elseif name == "birthday_wishes_text_plan" then
		self._bwTextPlanCfgs = content
	elseif name == "birthday_wishes_token" then
		self._bwTokenCfgs = content
	elseif name == "token" then
		self._tokenAllCfgs = content
	elseif name == "birthday_wishes_wishlist" then
		self._bwWishListCfgs = content
	elseif name == "birthday_wishes_collect_prize" then
		self._birthday_wishes_collect_prize = content
	elseif name == "birthday_wishes_give_prize" then
		self._birthday_wishes_give_prize = content
	end
end

function BirthdayWishesConfig:getBirthdayWishesActivityId()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.BirthdayWishes)

	if cfgs == nil then
		return -1
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -2
end

function BirthdayWishesConfig:getBirthdayWishesBaseCfg(actId)
	if actId == nil or self._bwBaseCfgs == nil then
		return nil
	end

	return self._bwBaseCfgs[actId]
end

function BirthdayWishesConfig:getBirthdayWishesPlanCfgs(planId)
	if planId == nil or self._bwPlanCfgs == nil then
		return nil
	end

	return self._bwPlanCfgs[planId]
end

function BirthdayWishesConfig:getBirthdayWishesPlanCfgsById(planId, giftType)
	local cfgs = self:getBirthdayWishesPlanCfgs(planId)

	if cfgs then
		return cfgs[giftType]
	end

	return nil
end

function BirthdayWishesConfig:getBirthdayWishesLotteryPlanCfgs(giftType)
	if giftType == nil or self._bwLotteryPlanCfgs == nil then
		return nil
	end

	return self._bwLotteryPlanCfgs[giftType]
end

function BirthdayWishesConfig:getBirthdayWishesTextPlanCfgs(planId)
	if self._bwTextPlanCfgs == nil or planId == nil then
		return nil
	end

	return self._bwTextPlanCfgs[planId]
end

function BirthdayWishesConfig:getBirthdayWishesTextPlanCfgsById(planId, id)
	local cfg = self:getBirthdayWishesTextPlanCfgs(planId)

	if cfg then
		return cfg[id]
	end

	return nil
end

function BirthdayWishesConfig:getBirthdayWishesTokenCfg(onlyId)
	if onlyId == nil or self._bwTokenCfgs == nil then
		return nil
	end

	return self._bwTokenCfgs[onlyId]
end

function BirthdayWishesConfig:getTokenCfgByTokenId(tokenId)
	if tokenId == nil or self._tokenAllCfgs == nil then
		return nil
	end

	return self._tokenAllCfgs[tokenId]
end

function BirthdayWishesConfig:getBirthdayWishesListCfgs(planId)
	return self._bwWishListCfgs[planId]
end

function BirthdayWishesConfig:getBirthdayWishesListCfgsById(planId, id)
	local cfgs = self:getBirthdayWishesListCfgs(planId)

	if cfgs then
		return cfgs[id]
	end

	return nil
end

function BirthdayWishesConfig:getActData(activityId)
	return self._bwBaseCfgs[activityId]
end

function BirthdayWishesConfig:getWishListData(wishLitPlanId)
	return self._bwPlanCfgs[wishLitPlanId]
end

function BirthdayWishesConfig:getWishListDataById(wishLitPlanId, id)
	return self._bwWishListCfgs[wishLitPlanId] and self._bwWishListCfgs[wishLitPlanId][id]
end

function BirthdayWishesConfig:getCollectPrizeDataById(activityId, prizeId)
	return self._birthday_wishes_collect_prize[activityId] and self._birthday_wishes_collect_prize[activityId][prizeId]
end

function BirthdayWishesConfig:getWishGivePrizeData(activityId)
	return self._birthday_wishes_give_prize[activityId]
end

function BirthdayWishesConfig:getWishGivePrizeDataById(activityId, prizeId)
	return self._birthday_wishes_give_prize[activityId] and self._birthday_wishes_give_prize[activityId][prizeId]
end

function BirthdayWishesConfig:getWishListPlanId(activityId)
	return self._bwBaseCfgs[activityId] and self._bwBaseCfgs[activityId].wishlistPlanId
end

function BirthdayWishesConfig:getTokenMatStr(tokenId)
	return self._tokenAllCfgs[tokenId] and self._tokenAllCfgs[tokenId].reward
end

function BirthdayWishesConfig:getCollectPrize(activityId, prizeId)
	if self._birthday_wishes_collect_prize[activityId] then
		return self._birthday_wishes_collect_prize[activityId] and self._birthday_wishes_collect_prize[activityId].prize
	end
end

function BirthdayWishesConfig:getWishesTextPlan(activityId)
	return self._bwBaseCfgs[activityId] and self._bwBaseCfgs[activityId].wishesTextPlan
end

function BirthdayWishesConfig:getGivePrizes(activityId)
	local arr = {}

	for i, v in ipairs(self._birthday_wishes_give_prize[activityId]) do
		table.insert(arr, v.times)
	end

	return arr
end

function BirthdayWishesConfig:getGotoStr(activityId)
	return self._bwBaseCfgs[activityId] and self._bwBaseCfgs[activityId].gotoStr
end

BirthdayWishesConfig.instance = BirthdayWishesConfig.New()

return BirthdayWishesConfig
