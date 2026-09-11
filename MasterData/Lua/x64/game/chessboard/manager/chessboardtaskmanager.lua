ChessBoardCheckTaskIterator = class("ChessBoardCheckTaskIterator")

function ChessBoardCheckTaskIterator:Ctor()
	self.curTaskIndex = 0
	self.curTaskList = {}

	for iter_1_0, iter_1_1 in pairs(manager.ChessBoardManager.taskManager_:GetTaskList()) do
		table.insert(self.curTaskList, (deepClone(iter_1_1)))
	end

	manager.ChessBoardManager.blockerManager_:ShowBlocker()
end

function ChessBoardCheckTaskIterator:MoveNext()
	self.curTaskIndex = self.curTaskIndex + 1

	if self.curTaskIndex <= #self.curTaskList then
		local var_2_0 = self.curTaskList[self.curTaskIndex]

		if self.curTaskList[self.curTaskIndex].cur >= self.curTaskList[self.curTaskIndex].need then
			ChessBoardAction.FinishTask(self.curTaskList[self.curTaskIndex].taskID, function()
				manager.ChessBoardManager.taskManager_:DeleteTask(var_2_0.taskID)

				if var_2_0.finishevent ~= 0 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.TASK_FINISH, {
						playerB = -1,
						playerA = 0,
						taskID = var_2_0.taskID
					})
					manager.ChessBoardManager:StartExecuteEvent()
				end

				manager.notify:CallUpdateFunc(CHESSBOARD_UPDATETASK)
				self:MoveNext()
			end)
		else
			self:MoveNext()
		end
	else
		self:Dispose()
	end
end

function ChessBoardCheckTaskIterator.Dispose(arg_4_0)
	manager.ChessBoardManager.blockerManager_:HideBlocker()

	arg_4_0.curTaskIndex = 0
	arg_4_0.curTaskList = 0
end

local var_0_0 = singletonClass("ChessBoardTaskManager")

function var_0_0.Ctor(arg_5_0)
	arg_5_0.activeTaskList_ = {}
end

function var_0_0:SetServerData(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		self.activeTaskList_[iter_6_1.taskID] = {
			taskID = iter_6_1.taskID,
			type = ChessBoardTaskPoolCfg[iter_6_1.taskID].type,
			conditionType = ChessBoardTaskPoolCfg[iter_6_1.taskID].condition_type,
			need = ChessBoardTaskPoolCfg[iter_6_1.taskID].need,
			cur = iter_6_1.progress,
			finishevent = ChessBoardTaskPoolCfg[iter_6_1.taskID].finishevent
		}
	end
end

function var_0_0:AddNewTask(arg_7_1)
	self.activeTaskList_[arg_7_1] = {
		cur = 0,
		taskID = arg_7_1,
		type = ChessBoardTaskPoolCfg[arg_7_1].type,
		conditionType = ChessBoardTaskPoolCfg[arg_7_1].condition_type,
		need = ChessBoardTaskPoolCfg[arg_7_1].need,
		finishevent = ChessBoardTaskPoolCfg[arg_7_1].finishevent
	}

	manager.notify:CallUpdateFunc(CHESSBOARD_UPDATETASK)
end

function var_0_0:UpdateTask(arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in pairs(self.activeTaskList_) do
		if iter_8_1.conditionType == arg_8_1 then
			iter_8_1.cur = iter_8_1.cur + arg_8_2
		end
	end

	manager.notify:CallUpdateFunc(CHESSBOARD_UPDATETASK)
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
	ChessBoardCheckTaskIterator.New():MoveNext()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.activeTaskList_ = {}
end

return var_0_0
