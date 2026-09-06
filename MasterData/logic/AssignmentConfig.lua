-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/config/AssignmentConfig.lua

module("logic.extensions.assignment.config.AssignmentConfig", package.seeall)

local AssignmentConfig = class("AssignmentConfig", BaseConfig)

function AssignmentConfig:onInit()
	AssignmentConfig.super.onInit(self)

	self._petDispatch = nil
	self._dispatchTask = nil
	self._dispatchPrizeBox = nil
	self._petDispatchCommonConfig = nil
	self._petDispatchRefreshConfig = nil
end

function AssignmentConfig:getNames()
	return {
		"pet_dispatch",
		"dispatch_pro",
		"dispatch_task",
		"dispatch_prize_box",
		"pet_dispatch_common_config",
		"pet_dispatch_refresh_config"
	}
end

function AssignmentConfig:handleConfig(name, content)
	if name == "pet_dispatch" then
		self._petDispatch = content
	elseif name == "dispatch_pro" then
		self._dispatch_pro = content
	elseif name == "dispatch_task" then
		self._dispatchTask = content
	elseif name == "dispatch_prize_box" then
		self._dispatchPrizeBox = content
	elseif name == "pet_dispatch_common_config" then
		self._petDispatchCommonConfig = content
	elseif name == "pet_dispatch_refresh_config" then
		self._petDispatchRefreshConfig = content
	end
end

function AssignmentConfig:getPetDispatch()
	return self._petDispatch
end

function AssignmentConfig:getDispatchPro(dispatchPro)
	return self._dispatch_pro[dispatchPro]
end

function AssignmentConfig:getDispatchTask(id)
	if id == nil then
		return self._dispatchTask
	else
		return self._dispatchTask[id]
	end
end

function AssignmentConfig:getDispatchPrizeBox(id)
	if id == nil then
		return self._dispatchPrizeBox
	end

	return self._dispatchPrizeBox[id]
end

function AssignmentConfig:getPetDispatchCommonConfig()
	return self._petDispatchCommonConfig
end

function AssignmentConfig:getPetDispatchRefreshConfig(refreshType, times)
	if refreshType == nil then
		return self._petDispatchRefreshConfig
	elseif times == nil then
		return self._petDispatchRefreshConfig[refreshType]
	else
		return self._petDispatchRefreshConfig[refreshType][times]
	end
end

function AssignmentConfig:getPetDispatchRefreshMaxTimes(refreshType)
	local cfgs = self._petDispatchRefreshConfig[refreshType]

	if not cfgs then
		return 0
	end

	local maxTimes = 0

	for k, v in pairs(cfgs) do
		if maxTimes < v.times then
			maxTimes = v.times
		end
	end

	return maxTimes
end

function AssignmentConfig:getPetDispatchRefreshTotalCost(refreshType, times, todayTimes)
	if todayTimes == nil then
		return 0
	end

	local targetTimes = times + todayTimes
	local cfg = self._petDispatchRefreshConfig[refreshType][targetTimes]

	if not cfg then
		return 0
	end

	local hasNum = MaterialMgr.getMatCount(cfg.consume)
	local totalCost = 0

	for i = targetTimes, 1, -1 do
		if todayTimes == i then
			break
		end

		cfg = self._petDispatchRefreshConfig[refreshType][i]
		totalCost = totalCost + MaterialFacade.instance:getGoodCostByStr(self._petDispatchRefreshConfig[refreshType][i].consume)
	end

	return totalCost
end

AssignmentConfig.instance = AssignmentConfig.New()

return AssignmentConfig
