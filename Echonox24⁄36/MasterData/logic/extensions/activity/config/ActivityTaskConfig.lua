-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activity/config/ActivityTaskConfig.lua

module("logic.extensions.activity.config.ActivityTaskConfig", package.seeall)

local M = class("ActivityTaskConfig", BaseConfig)

function M:onInit()
	self._taskLabel = {}
	self._task = {}
end

function M:getNames()
	return {
		ConfigName.ActivityTaskLabel,
		ConfigName.ActivityTask
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.ActivityTaskLabel then
		self._taskLabel = content
	elseif name == ConfigName.ActivityTask then
		self._task = content
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getTaskInfoById(id)
	return self._task[id]
end

function M:getTaskLabelInfoById(id)
	return self._taskLabel[id]
end

function M:getTaskConfigIdByLabel(label)
	for k, v in ipairs(self._task.dataList) do
		if v.label == label then
			return v.activityId
		end
	end
end

function M:getTaskConfByActivityId(id)
	local res = {}

	for _, item in ipairs(self._task.dataList) do
		if item.activityId == id then
			table.insert(res, item)
		end
	end

	return res
end

M.instance = M.New()

return M
