CheckTaskIterator = class("CheckTaskIterator")

function CheckTaskIterator:Ctor()
	self.curTaskIndex = 0
	self.curTaskList = {}

	for iter_1_0, iter_1_1 in pairs(manager.NewChessManager.taskManager_:GetTaskList()) do
		table.insert(self.curTaskList, (deepClone(iter_1_1)))
	end

	manager.NewChessManager:ShowBlock()
end

function CheckTaskIterator:MoveNext()
	self.curTaskIndex = self.curTaskIndex + 1

	if self.curTaskIndex <= #self.curTaskList then
		local var_2_0 = self.curTaskList[self.curTaskIndex]

		if self.curTaskList[self.curTaskIndex].cur >= self.curTaskList[self.curTaskIndex].need then
			NewWarChessAction.FinishTask(self.curTaskList[self.curTaskIndex].taskID, function()
				manager.NewChessManager.taskManager_:DeleteTask(var_2_0.taskID)

				if var_2_0.finishevent ~= 0 then
					manager.NewChessManager:ExecutChess(NewChessConst.TIMING_TASK, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_TASK, {
						var_2_0.taskID
					})))
					manager.NewChessManager:StartExecuteEvent()
				end

				manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
				self:MoveNext()
			end)
		else
			self:MoveNext()
		end
	else
		self:Dispose()
	end
end

function CheckTaskIterator.Dispose(arg_4_0)
	manager.NewChessManager:CloseBlock()

	arg_4_0.curTaskIndex = 0
	arg_4_0.curTaskList = 0

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
end

local var_0_0 = singletonClass("NewChessTaskManager")

function var_0_0.Ctor(arg_5_0)
	arg_5_0.activeTaskList_ = {}
end

function var_0_0:SetServerData(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		self.activeTaskList_[iter_6_1.taskID] = {
			taskID = iter_6_1.taskID,
			type = NewWarChessTaskPoolCfg[iter_6_1.taskID].type,
			conditionType = NewWarChessTaskPoolCfg[iter_6_1.taskID].condition_type,
			need = NewWarChessTaskPoolCfg[iter_6_1.taskID].need,
			cur = iter_6_1.progress,
			clickevent = NewWarChessTaskPoolCfg[iter_6_1.taskID].clickevent,
			finishevent = NewWarChessTaskPoolCfg[iter_6_1.taskID].finishevent
		}
	end
end

function var_0_0:AddNewTask(arg_7_1)
	self.activeTaskList_[arg_7_1] = {
		cur = 0,
		taskID = arg_7_1,
		type = NewWarChessTaskPoolCfg[arg_7_1].type,
		conditionType = NewWarChessTaskPoolCfg[arg_7_1].condition_type,
		need = NewWarChessTaskPoolCfg[arg_7_1].need,
		clickevent = NewWarChessTaskPoolCfg[arg_7_1].clickevent,
		finishevent = NewWarChessTaskPoolCfg[arg_7_1].finishevent
	}

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
end

function var_0_0:UpdateTask(arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in pairs(self.activeTaskList_) do
		if iter_8_1.conditionType == arg_8_1 then
			iter_8_1.cur = iter_8_1.cur + arg_8_2
		end
	end

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
end

function var_0_0:DeleteTask(arg_9_1)
	self.activeTaskList_[arg_9_1] = nil
end

function var_0_0:GetTaskList()
	return self.activeTaskList_
end

function var_0_0:GetTaskInfo(arg_11_1)
	return self.activeTaskList_[arg_11_1]
end

function var_0_0.CheckTask(arg_12_0)
	CheckTaskIterator.New():MoveNext()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.activeTaskList_ = {}
end

return var_0_0
