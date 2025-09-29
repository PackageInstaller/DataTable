-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/config/TaskConfig.lua

module("logic.extensions.task.config.TaskConfig", package.seeall)

local M = class("TaskConfig", BaseConfig)

function M:onInit()
	self._taskLabelCfg = {}
	self._taskCfg = {}
	self._taskPointCfg = {}
	self._taskBubbleCfg = {}
	self._statisticsCfg = {}
end

function M:getNames()
	return {
		ConfigName.TaskLabel,
		ConfigName.TaskPointReward,
		ConfigName.Task,
		ConfigName.TaskShowBubble,
		ConfigName.Statistics,
		ConfigName.HomeChainTask,
		ConfigName.HomeRepeatTask
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.TaskLabel then
		self._taskLabelCfg = content

		TaskModel.instance:initTaskTabData(content.dataList)
	elseif name == ConfigName.TaskPointReward then
		self._taskPointCfg = content
	elseif name == ConfigName.Task then
		self._taskCfg = content
	elseif name == ConfigName.TaskShowBubble then
		self._taskBubbleCfg = content
	elseif name == ConfigName.Statistics then
		self._statisticsCfg = content
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key, noPrintWhileNotFound)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	if not noPrintWhileNotFound then
		printError(string.format("no config with name: t_%s", cfgName))
	end
end

function M:getTaskCO(taskId)
	local dataCO = self._taskCfg[taskId]

	if taskId > 0 and not dataCO then
		dataCO = RoguelikeConfig.instance:getTaskById(taskId)

		if not dataCO and enableErrorLog then
			printError(string.format("TaskConfig::cannot find task config for taskid[%s]", taskId))
		end
	end

	return dataCO
end

function M:getTaskLabelCO(tabId)
	local dataCO = self._taskLabelCfg[tabId]

	if tabId > 0 and not dataCO and enableErrorLog then
		printError(string.format("TaskConfig::cannot find task config for tabId[%s]", tabId))
	end

	return dataCO
end

function M:getTaskPointCO(pointId)
	local dataCO = self._taskPointCfg[pointId]

	if pointId > 0 and not dataCO and enableErrorLog then
		printError(string.format("TaskConfig::cannot find task config for pointId[%s]", pointId))
	end

	return dataCO
end

function M:getTaskBubbleCO(code)
	local dataCO = self._taskBubbleCfg[code]

	if code > 0 and not dataCO and enableErrorLog then
		printError(string.format("TaskConfig::cannot find task bubble config for code[%s]", code))
	end

	return dataCO
end

function M:getStatisticsCO(code)
	local dataCO = self._statisticsCfg[code]

	if code > 0 and not dataCO and enableErrorLog then
		printError(string.format("TaskConfig::cannot find statistics config for code[%s]", code))
	end

	return dataCO
end

function M:getBubbleByFactor(factor)
	local tmp = {}

	for _, v in pairs(self._taskBubbleCfg) do
		if v.factor == factor then
			table.insert(tmp, v)
		end
	end

	local randomIndex = math.random(#tmp)
	local bubbleCo = tmp[randomIndex]

	return bubbleCo
end

M.instance = M.New()

return M
