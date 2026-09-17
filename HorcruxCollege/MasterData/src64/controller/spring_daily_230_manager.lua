local ActivityDaily230Manager = class("ActivityDaily230Manager", (require("controller.base_manager")))

ActivityDaily230Manager.MULTITON_MSG = "ActivityDaily230Manager instancealready constructed!"

function ActivityDaily230Manager:ctor()
	ActivityDaily230Manager.super.ctor(self)

	self._data = {}
	self._config = require("data.activity_story.activity_story_230_data")
	self._infos = {}

	for iter_1_0, iter_1_1 in pairs(self._config) do
		local var_1_0 = string.split(iter_1_1.id, "-")
		local var_1_1 = tonumber(var_1_0[1])

		self._infos[var_1_1] = self._infos[var_1_1] or {}
		self._infos[var_1_1][tonumber(var_1_0[2])] = iter_1_1
	end
end

function ActivityDaily230Manager:requestInfo(arg_2_1)
	return
end

function ActivityDaily230Manager:handlerInfo(arg_3_1)
	return
end

function ActivityDaily230Manager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function ActivityDaily230Manager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function ActivityDaily230Manager:updateStoryInfo(arg_6_1)
	for iter_6_0 = 1, #arg_6_1.dataList do
		local var_6_0 = string.split(arg_6_1.dataList[iter_6_0].id, "-")
		local var_6_1 = tonumber(var_6_0[1])
		local var_6_2 = tonumber(var_6_0[2])

		self._infos[var_6_1][var_6_2].tips = arg_6_1.dataList[iter_6_0].des
		self._infos[var_6_1][var_6_2].stat = arg_6_1.dataList[iter_6_0].stat
	end

	if self.layer then
		self.layer:updateStoryInfo()
	end
end

function ActivityDaily230Manager:haveNewStory()
	for iter_7_0 = 1, #self._infos do
		for iter_7_1 = 1, #self._infos[iter_7_0] do
			if self._infos[iter_7_0][iter_7_1].stat and self._infos[iter_7_0][iter_7_1].stat == 1 then
				return true
			end
		end
	end

	return false
end

return ActivityDaily230Manager
