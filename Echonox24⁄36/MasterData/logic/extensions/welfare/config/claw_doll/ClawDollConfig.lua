-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/config/claw_doll/ClawDollConfig.lua

module("logic.extensions.welfare.config.claw_doll.ClawDollConfig", package.seeall)

local M = class("ClawDollConfig", BaseConfig)

M.TaskState = {
	Doing = 2,
	CanReceive = 3,
	IsReceived = 1
}

function M:onInit()
	self._const = {}
	self._rewardExchange = {}
	self._boll = {}
end

function M:getNames()
	return {
		ConfigName.ClawDollExchange,
		ConfigName.ClawDollActivity,
		ConfigName.ClawDollBoll
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.ClawDollExchange then
		self._rewardExchange = content
	elseif name == ConfigName.ClawDollActivity then
		self._const = content
	elseif name == ConfigName.ClawDollBoll then
		self._boll = content
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getExchangeList(cfgId)
	if cfgId == nil then
		return
	end

	return self._rewardExchange[cfgId]
end

function M:getCoinIdByCfgId(cfgId)
	if cfgId == nil then
		return
	end

	return self._const[cfgId].coinId
end

function M:getPreviewRewardByCfgId(cfgId)
	if cfgId == nil then
		return
	end

	local first = self._const[cfgId].rewardlst[1]
	local second = self._const[cfgId].rewardlst[2]
	local third = self._const[cfgId].rewardlst[3]

	return first, second, third
end

function M:getDollsPollListByCfgId(cfgId)
	if cfgId == nil then
		return
	end

	return self._const[cfgId].dolls
end

function M:getSpeedByCfgId(cfgId)
	if cfgId == nil then
		return
	end

	return self._const[cfgId].speed
end

function M:getBollList()
	return self._boll
end

M.instance = M.New()

return M
