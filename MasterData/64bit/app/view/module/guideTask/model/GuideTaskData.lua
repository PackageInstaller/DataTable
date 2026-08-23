local GuideTaskData = class("GuideTaskData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.guide_task_info
local var_0_2 = g.core.common.ModuleUnlock

function GuideTaskData:ctor()
	self:initData()
end

function GuideTaskData:initData()
	GuideTaskData.super.ctor(self)

	self._tasks = {}
	self._ids = {}
	self._classityTask = {}

	self:_initGuideTaskClassifycfg()
end

function GuideTaskData:updateInfo(arg_3_1)
	self._tasks = arg_3_1.tasks or {}
	self._ids = arg_3_1.ids or {}
end

function GuideTaskData:updateTask(arg_4_1)
	local var_4_0 = false

	for iter_4_0, iter_4_1 in ipairs(self._tasks) do
		if iter_4_1.type == arg_4_1.id then
			iter_4_1.value = arg_4_1.status
			var_4_0 = true

			break
		end
	end

	if not var_4_0 then
		self._tasks[#self._tasks + 1] = {
			type = arg_4_1.id,
			value = arg_4_1.status
		}
	end
end

function GuideTaskData:updateAward(arg_5_1)
	self._ids[#self._ids + 1] = arg_5_1
end

function GuideTaskData:getProgress(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self._tasks) do
		if iter_6_1.type == arg_6_1 then
			return iter_6_1.value
		end
	end

	return 0
end

function GuideTaskData:isAwarded(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self._ids) do
		if iter_7_1 == arg_7_1 then
			return true
		end
	end

	return false
end

function GuideTaskData:isFinished(arg_8_1)
	local var_8_0 = var_0_1.get(arg_8_1)
	local var_8_1 = true

	for iter_8_0 = 1, 4 do
		if var_8_0["mission_type_" .. iter_8_0] > 0 then
			local var_8_2 = self:getProgress(var_8_0["mission_type_" .. iter_8_0])

			var_8_1 = var_8_1 and (var_8_0["mission_type_" .. iter_8_0] == 3 or nil) and var_8_2 <= var_8_0["mission_value_" .. iter_8_0] and var_8_2 > 0
		end
	end

	return var_8_1
end

function GuideTaskData:hasAward()
	for iter_9_0 = 1, var_0_1.getLength() do
		local var_9_0 = var_0_1.indexOf(iter_9_0)

		if not self:isAwarded(var_9_0.id) and self:isFinished(var_9_0.id) then
			return true
		end
	end

	return false
end

function GuideTaskData:getGuideTaskInfoById(arg_10_1)
	local var_10_0 = {}
	local var_10_1 = var_0_1.get(arg_10_1)

	if var_10_1 then
		for iter_10_0 = 1, 4 do
			if var_10_1["mission_type_" .. iter_10_0] > 0 then
				local var_10_2 = self:getProgress(var_10_1["mission_type_" .. iter_10_0])
				local var_10_3 = math.min(var_10_2, var_10_1["mission_value_" .. iter_10_0])
				local var_10_4 = var_10_2 >= var_10_1["mission_value_" .. iter_10_0]

				if var_10_1["mission_type_" .. iter_10_0] == 3 then
					if var_10_2 == 0 then
						var_10_4 = false
						var_10_3 = 0
					else
						var_10_4 = var_10_2 <= var_10_1["mission_value_" .. iter_10_0]
						var_10_3 = math.max(var_10_2, var_10_1["mission_value_" .. iter_10_0])
					end
				end

				table.insert(var_10_0, {
					name = var_10_1["mission_des_" .. iter_10_0],
					curProgress = var_10_3,
					maxProgress = var_10_1["mission_value_" .. iter_10_0],
					isFinish = var_10_4
				})
			end
		end
	end

	return var_10_0
end

function GuideTaskData:getGuideTaskAwards(arg_11_1)
	local var_11_0 = var_0_1.get(arg_11_1)
	local var_11_1 = {}

	for iter_11_0 = 1, 3 do
		if var_11_0["reward_type_" .. iter_11_0] > 0 then
			var_11_1[#var_11_1 + 1] = {
				type = var_11_0["reward_type_" .. iter_11_0],
				value = var_11_0["reward_value_" .. iter_11_0],
				size = var_11_0["reward_size_" .. iter_11_0]
			}
		end
	end

	return var_11_1
end

function GuideTaskData:_initGuideTaskClassifycfg()
	self._classityTask = {}

	for iter_12_0 = 1, var_0_1.getLength() do
		local var_12_0 = var_0_1.indexOf(iter_12_0)
		local var_12_1 = var_12_0.function_id

		if var_0_2:isModuleUnlock(var_12_0.function_id) or var_12_0.function_id == g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA and var_0_2:isFunctionUnlock(var_12_1) or var_12_0.function_id == g.core.const.ConstMgr.FUNCTION_TYPE.SPIRE and var_0_2:isFunctionUnlock(var_12_1) then
			self._classityTask[var_12_0.type] = self._classityTask[var_12_0.type] or {}

			table.insert(self._classityTask[var_12_0.type], var_12_0)
		end
	end
end

function GuideTaskData:getClassifyTask()
	self:_initGuideTaskClassifycfg()

	return self._classityTask
end

function GuideTaskData:getClassifyTaskByType(arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self._classityTask) do
		var_14_0 = var_14_0 + 1

		if var_14_0 == arg_14_1 then
			return iter_14_1
		end
	end

	return nil
end

function GuideTaskData:checkGuideTaskCompleted(arg_15_1)
	if arg_15_1.id then
		if self:isShowGuideTaskAwardsById(arg_15_1.id) then
			return true
		end
	elseif arg_15_1.type then
		local var_15_0 = self:getClassifyTaskByType(arg_15_1.type)

		if var_15_0 then
			for iter_15_0 = 1, #var_15_0 do
				if self:isShowGuideTaskAwardsById(var_15_0[iter_15_0].id) then
					return true
				end
			end
		end
	else
		for iter_15_1 = 1, var_0_1.getLength() do
			if self:isShowGuideTaskAwardsById(var_0_1.indexOf(iter_15_1).id) then
				return true
			end
		end
	end

	return false
end

function GuideTaskData:isShowGuideTaskAwardsById(arg_16_1)
	return self:isFinished(arg_16_1) and not self:isAwarded(arg_16_1)
end

function GuideTaskData:checkGuideTaskNewById(arg_17_1)
	if arg_17_1.id then
		if self:isShowGuideTaskNewById(arg_17_1.id) then
			return true
		end
	elseif arg_17_1.type then
		local var_17_0 = self:getClassifyTaskByType(arg_17_1.type)

		if var_17_0 then
			for iter_17_0 = 1, #var_17_0 do
				if self:isShowGuideTaskNewById(var_17_0[iter_17_0].id) then
					return true
				end
			end
		end
	else
		for iter_17_1 = 1, var_0_1.getLength() do
			local var_17_1 = var_0_1.indexOf(iter_17_1)

			if var_0_2:isModuleUnlock(var_17_1.function_id) and self:isShowGuideTaskNewById(var_17_1.id) then
				return true
			end
		end
	end

	return false
end

function GuideTaskData:isShowGuideTaskNewById(arg_18_1)
	local var_18_0 = g.core.common.Storage:load("guideTaskNew.json")

	if not var_18_0 then
		local var_18_1 = {}

		for iter_18_0 = 1, var_0_1.getLength() do
			table.insert(var_18_1, {
				isCleanNew = false,
				id = var_0_1.indexOf(iter_18_0).id
			})
		end

		g.core.common.Storage:save("guideTaskNew.json", var_18_1)

		return true
	else
		for iter_18_1, iter_18_2 in ipairs(var_18_0) do
			if iter_18_2.id == arg_18_1 and not iter_18_2.isCleanNew then
				return true
			end
		end
	end

	return false
end

function GuideTaskData:cleanGuideTaskNew(arg_19_1)
	local var_19_0 = g.core.common.Storage:load("guideTaskNew.json")

	if var_19_0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			if iter_19_1.id == arg_19_1 then
				iter_19_1.isCleanNew = true
			end
		end

		g.core.common.Storage:save("guideTaskNew.json", var_19_0)
	end
end

function GuideTaskData:getAllGuideTaskFinished()
	for iter_20_0 = 1, var_0_1.getLength() do
		local var_20_0 = var_0_1.indexOf(iter_20_0).id

		if not self:isFinished(var_20_0) or not self:isAwarded(var_20_0) then
			return false
		end
	end

	return true
end

return GuideTaskData
