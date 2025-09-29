-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/recharge/StoreRechargeMo.lua

module("logic.extensions.store.model.recharge.StoreRechargeMo", package.seeall)

local M = class("StoreRechargeMo")

function M:ctor(rechargeCo)
	self.id = rechargeCo.id
	self._credit = rechargeCo.credit
	self._rewardId = rechargeCo.reward
	self._itemStatus = false
end

function M:getId()
	return self.id
end

function M:getCredit()
	return self._credit
end

function M:getRewards()
	if not self._rewards then
		self._rewards = {}

		local rewardCO = RewardConfig.instance:getRewardCfgByCode(self._rewardId)

		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			table.insert(self._rewards, v)
		end
	end

	return self._rewards
end

function M:setItemStatus(value)
	self._itemStatus = value
end

function M:getItemStatus()
	return self._itemStatus and self._itemStatus or StoreEnum.StoreRechargeStatus.unsatisfied
end

return M
