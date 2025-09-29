-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonLvMO.lua

module("logic.extensions.season.model.SeasonLvMO", package.seeall)

local M = class("SeasonLvMO")

function M:ctor(lv)
	self._lv = lv
	self._isLoop = false
	self._rewardStatus = SeasonEnum.RewardStatus.None
	self._lvCfg = nil
	self._arrayUnpaidReward = nil
	self._arrayPaidReward = nil
	self._arrayAllReward = nil
	self._isTips = false
end

function M:setLvCfg(cfg)
	self._lvCfg = cfg

	self:_initRewards()
end

function M:_initRewards()
	local function _createRewards(rewardId, arrayReward, isVip)
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)

		if rewardCO then
			for _, v in ipairs(rewardCO.reward or {}) do
				local itemMO = SeasonRewardItemMO.New(v.code, v.num, isVip)

				itemMO:setLv(self._lv)
				table.insert(arrayReward, itemMO)
			end
		end
	end

	self._arrayUnpaidReward = {}
	self._arrayPaidReward = {}
	self._arrayAllReward = {}

	_createRewards(self._lvCfg.freeReward, self._arrayUnpaidReward, false)
	_createRewards(self._lvCfg.vipReward, self._arrayPaidReward, true)

	for _, mo in ipairs(self._arrayUnpaidReward) do
		table.insert(self._arrayAllReward, mo)
	end

	for _, mo in ipairs(self._arrayPaidReward) do
		table.insert(self._arrayAllReward, mo)
	end

	if #self._arrayUnpaidReward > 1 then
		printWarn(string.format("非vip奖励最多配1个，赛季id:%s,lv:%s", SeasonModel.instance:getSeasonId(), self._lv))
	end

	if #self._arrayPaidReward > 2 then
		printWarn(string.format("vip奖励最多配2个，赛季id:%s,lv:%s", SeasonModel.instance:getSeasonId(), self._lv))
	end
end

function M:getLv()
	return self._lv
end

function M:setIsLoop(isLoop)
	self._isLoop = isLoop
end

function M:isLoop()
	return self._isLoop
end

function M:isArrive()
	local curLv = SeasonModel.instance:getCurrLv()

	return curLv >= self._lv
end

function M:setRewardStatus(status)
	self._rewardStatus = status
end

function M:getRewardStatus()
	return self._rewardStatus
end

function M:getUnpaidRewards()
	return self._arrayUnpaidReward
end

function M:getPaidRewards()
	return self._arrayPaidReward
end

function M:getTotalRewards()
	return self._arrayAllReward
end

function M:getRewards()
	local isVip = SeasonModel.instance:isVip()

	if isVip then
		return self:getTotalRewards()
	else
		return self:getUnpaidRewards()
	end
end

function M:isBigReward()
	local list = self:getRewards()

	return #list > 2
end

function M:isBigPerformReward()
	local list = self:getTotalRewards()

	return #list > 2
end

function M:setIsTips()
	self._isTips = true
end

function M:isTips()
	return self._isTips
end

return M
