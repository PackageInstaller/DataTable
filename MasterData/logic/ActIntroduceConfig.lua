-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/config/ActIntroduceConfig.lua

module("logic.extensions.actintroduce.config.ActIntroduceConfig", package.seeall)

local ActIntroduceConfig = class("ActIntroduceConfig", BaseConfig)

function ActIntroduceConfig:onInit()
	ActIntroduceConfig.super.onInit(self)
end

function ActIntroduceConfig:getNames()
	return {
		"act_introduce_tab",
		"act_introduce_act",
		"act_introduce_version",
		"act_introduce_common"
	}
end

function ActIntroduceConfig:handleConfig(name, content)
	if name == "act_introduce_tab" then
		self._act_introduce_tab = content
	elseif name == "act_introduce_act" then
		self._act_introduce_act = content
	elseif name == "act_introduce_version" then
		self._act_introduce_version = content
	elseif name == "act_introduce_common" then
		self._act_introduce_common = content
	end
end

function ActIntroduceConfig:getActConfigsByIds(ids)
	local result = {}

	for i, id in ipairs(ids) do
		local config = self._act_introduce_act[id]

		if config then
			table.insert(result, config)
		end
	end

	return result
end

function ActIntroduceConfig:getCommonValue(key, bToNumber)
	if bToNumber then
		return checknumber(self._act_introduce_common[key].value)
	else
		return self._act_introduce_common[key].value
	end
end

function ActIntroduceConfig:getCurActVersion()
	for i, v in ipairs(self._act_introduce_version) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			return v
		end
	end

	return nil
end

function ActIntroduceConfig:getCurActTime()
	local version = self:getCurActVersion() or {}

	return version.startTime, version.endTime
end

function ActIntroduceConfig:getCurActTabIds()
	local version = self:getCurActVersion() or {}

	return version.tabs
end

function ActIntroduceConfig:getCurActTabConfigs()
	local tabIds = self:getCurActTabIds()
	local ShowPeriodTypes = {
		[GameUtil.inTimePeriod] = true
	}

	if tabIds and #tabIds > 0 then
		local result = {}

		for _, tabId in ipairs(tabIds) do
			local config = self._act_introduce_tab[tabId]

			if config and not string.nilorempty(config.startTime) and not string.nilorempty(config.endTime) then
				local periodType = GameUtil.getTimePeriodType(config.startTime, config.endTime)

				if ShowPeriodTypes[periodType] then
					table.insert(result, config)
				end
			end
		end

		return result
	end
end

function ActIntroduceConfig:getCurTabCfg()
	local tabIds = self:getCurActTabIds()

	if tabIds and #tabIds > 0 then
		local result = {}

		for _, tabId in ipairs(tabIds) do
			local config = self._act_introduce_tab[tabId]

			table.insert(result, config)
		end

		return result
	end
end

function ActIntroduceConfig:getTabCfgById(tabId)
	return self._act_introduce_tab[tabId]
end

function ActIntroduceConfig:getCurActDateConfigs()
	local version = self:getCurActVersion() or {}

	if version.dateviewIds then
		return self:getActConfigsByIds(version.dateviewIds)
	end
end

function ActIntroduceConfig:getConfigBeginAndEndTime(config)
	local actType = checknumber(config.actType)
	local actId = checknumber(config.actId)
	local startTime, endTime

	if config.startTimestamp and config.endTimestamp then
		return config.startTimestamp, config.endTimestamp
	end

	if actType > 0 and actId > 0 then
		startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(actType, actId)
	end

	if not startTime or not endTime then
		startTime = GameUtil.string2time(config.startTime)
		endTime = GameUtil.string2time(config.endTime)
	end

	if not startTime or not endTime then
		printError("配置有误，不能正确获取时间配置，请配置actType，actId或者startTime，endTime", config.groupId, config.id)
	end

	return startTime, endTime
end

ActIntroduceConfig.instance = ActIntroduceConfig.New()

return ActIntroduceConfig
