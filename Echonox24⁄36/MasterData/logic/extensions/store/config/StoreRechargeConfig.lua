-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/config/StoreRechargeConfig.lua

module("logic.extensions.store.config.StoreRechargeConfig", package.seeall)

local M = class("StoreRechargeConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.RechargeAccumulateReward,
		ConfigName.FirstChange
	}
end

function M:getPermanentRechargeList()
	local cfgs = self._dict[ConfigName.RechargeAccumulateReward].dataList

	return cfgs
end

function M:getFirstChargeConfig()
	return self._dict[ConfigName.FirstChange].dataList[1]
end

M.instance = M.New()

return M
