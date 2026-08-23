local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationTaskData = class("ExplorationTaskData")

function ExplorationTaskData:ctor()
	self._curTaskInfo = nil
	self._netTaskInfoDic = {}
end

function ExplorationTaskData:resetData()
	self._curTaskInfo = nil
	self._netTaskInfoDic = {}
end

function ExplorationTaskData:setCurTaskInfo(arg_3_1)
	self._curTaskInfo = self:_createTaskInfo(arg_3_1)

	self:_updateCurTaskInfo(self._netTaskInfoDic[arg_3_1])
end

function ExplorationTaskData:getCurTaskInfo()
	return self._curTaskInfo
end

function ExplorationTaskData:_createTaskInfo(arg_5_1)
	local var_5_0 = g.core.config.exploration_task_info.get(arg_5_1)

	return {
		curValue = 0,
		state = ExplorationConst.TASK_STATE.NONE,
		awards = g.core.common.Drops:getGoodsArray(var_5_0.reward, false, true),
		cfg = var_5_0
	}
end

function ExplorationTaskData:_getCfgListByTaskType(arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = 1, g.core.config.exploration_task_info.getLength() do
		local var_6_1 = g.core.config.exploration_task_info.indexOf(iter_6_0)

		if var_6_1.task_type == arg_6_1 then
			var_6_0[#var_6_0 + 1] = var_6_1
		end
	end

	return var_6_0
end

function ExplorationTaskData:updateTaskInfo(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs((self:_getCfgListByTaskType(arg_7_1.id))) do
		local var_7_0 = {
			id = iter_7_1.id,
			status = arg_7_1.status
		}

		self._netTaskInfoDic[var_7_0.id] = var_7_0

		self:_updateCurTaskInfo(var_7_0)
	end
end

function ExplorationTaskData:_updateCurTaskInfo(arg_8_1)
	if not arg_8_1 or not self._curTaskInfo or arg_8_1.id ~= self._curTaskInfo.cfg.id then
		return
	end

	self._curTaskInfo.curValue = arg_8_1.status

	if self._curTaskInfo.curValue >= self._curTaskInfo.cfg.goal then
		self._curTaskInfo.state = ExplorationConst.TASK_STATE.MATCH
	end
end

function ExplorationTaskData:finishTaskInfo(arg_9_1)
	if self._curTaskInfo.cfg.id ~= arg_9_1 then
		return
	end

	local var_9_0 = self._curTaskInfo.cfg.next_id

	self._curTaskInfo = nil

	if var_9_0 and var_9_0 ~= 0 then
		self:setCurTaskInfo(var_9_0)
	end
end

return ExplorationTaskData
