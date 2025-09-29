-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/MasterTrainingTask/config/MasterTrainingTaskConfig.lua

module("logic.extensions.MasterTrainingTask.config.MasterTrainingTaskConfig", package.seeall)

local M = class("MasterTrainingTaskConfig", BaseConfig)

M.TaskState = {
	Doing = 2,
	CanReceive = 3,
	IsReceived = 1
}

function M:onInit()
	self._trainingTask = false
end

function M:getNames()
	return {
		ConfigName.MasterTrainingTask
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.MasterTrainingTask then
		self._trainingTask = content
	end
end

function M:getCfgList()
	return self._trainingTask.dataList
end

function M:getConfigByTaskid(id)
	return self._trainingTask[id]
end

function M:getOnlineCfg()
	local onlineTask = {}

	for _, v in ipairs(self._trainingTask.dataList) do
		if v.isOnline == 1 then
			table.insert(onlineTask, v)
		end
	end

	return onlineTask
end

M.instance = M.New()

return M
