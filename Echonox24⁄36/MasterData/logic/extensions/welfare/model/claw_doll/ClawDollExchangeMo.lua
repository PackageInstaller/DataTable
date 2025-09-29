-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/claw_doll/ClawDollExchangeMo.lua

module("logic.extensions.welfare.model.claw_doll.ClawDollExchangeMo", package.seeall)

local M = class("ClawDollExchangeMo")

function M:ctor()
	self._id = nil
	self._count = nil
	self._maxCount = nil
	self._name = nil
	self._rewardId = nil
	self._rewardItemData = nil
	self._exchangeList = nil
end

function M:setClawExchangeMo(rewardNo)
	if rewardNo ~= nil then
		self._id = rewardNo.id
		self._count = 0
		self._cfgId = rewardNo.activityid
		self._maxCount = rewardNo and rewardNo.times or 0
		self._name = rewardNo and rewardNo.name or ""
		self._exchangeList = rewardNo and rewardNo.cost or {}
		self._rewardId = rewardNo and rewardNo.reward or 0
	elseif rewardNo == nil then
		printError("夹娃娃兑换传入参数错误")
	end
end

function M:getId()
	return self._id
end

function M:getCount()
	return self._count
end

function M:setCount(count)
	self._count = count
end

function M:getMaxCnt()
	return self._maxCount or 0
end

function M:getName()
	return self._name
end

function M:getCfgId()
	return self._cfgId
end

function M:getIsFinish()
	if self._maxCount <= self._count then
		return 1
	else
		return 0
	end
end

function M:getRewardItemData()
	if not self._rewardItemData then
		local rewardInfo = RewardConfig.instance:getRewardCfgByCode(self._rewardId)
		local itemId = rewardInfo.reward[1].code
		local count = rewardInfo.reward[1].num

		self._rewardItemData = ItemUtil.createItemData({
			itemId = itemId
		})

		self._rewardItemData:setCount(count)
	end

	return self._rewardItemData
end

function M:getExchangeList()
	return self._exchangeList
end

return M
