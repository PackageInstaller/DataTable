-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/config/integral_drop/ActivityIntegralDropConfig.lua

module("logic.extensions.welfare.config.integral_drop.ActivityIntegralDropConfig", package.seeall)

local M = class("ActivityIntegralDropConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.IntegralDrop
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.IntegralDrop then
		self._rewardList = content
	end
end

function M:getAllInfoById(id)
	return self._rewardList[id]
end

function M:getStepRewardInfoByOrder(id, order)
	local rewardCode = self._rewardList[id][order].reward
	local rewardInfo = RewardConfig.instance:getRewardCfgByCode(rewardCode)
	local itemId = rewardInfo.reward[1].code
	local count = rewardInfo.reward[1].num

	return itemId, count
end

function M:getRewardCoinId(id)
	return self._rewardList[id][1].coinId
end

M.instance = M.New()

return M
