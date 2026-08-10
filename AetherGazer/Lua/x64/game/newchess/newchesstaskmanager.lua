CheckTaskIterator = class("CheckTaskIterator")

function CheckTaskIterator.Ctor(arg_1_0)
	arg_1_0.curTaskIndex = 0
	arg_1_0.curTaskList = {}

	for iter_1_0, iter_1_1 in pairs(manager.NewChessManager.taskManager_:GetTaskList()) do
		local var_1_0 = deepClone(iter_1_1)

		table.insert(arg_1_0.curTaskList, var_1_0)
	end

	manager.NewChessManager:ShowBlock()
end

function CheckTaskIterator.MoveNext(arg_2_0)
	arg_2_0.curTaskIndex = arg_2_0.curTaskIndex + 1

	if arg_2_0.curTaskIndex <= #arg_2_0.curTaskList then
		local var_2_0 = arg_2_0.curTaskList[arg_2_0.curTaskIndex]

		if var_2_0.cur >= var_2_0.need then
			NewWarChessAction.FinishTask(var_2_0.taskID, function()
				manager.NewChessManager.taskManager_:DeleteTask(var_2_0.taskID)

				if var_2_0.finishevent ~= 0 then
					local var_3_0 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_TASK, {
						var_2_0.taskID
					})

					manager.NewChessManager:ExecutChess(NewChessConst.TIMING_TASK, nil, var_3_0)
					manager.NewChessManager:StartExecuteEvent()
				end

				manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
				arg_2_0:MoveNext()
			end)
		else
			arg_2_0:MoveNext()
		end
	else
		arg_2_0:Dispose()
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

function var_0_0.SetServerData(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		local var_6_0 = NewWarChessTaskPoolCfg[iter_6_1.taskID]

		arg_6_0.activeTaskList_[iter_6_1.taskID] = {
			taskID = iter_6_1.taskID,
			type = var_6_0.type,
			conditionType = var_6_0.condition_type,
			need = var_6_0.need,
			cur = iter_6_1.progress,
			clickevent = var_6_0.clickevent,
			finishevent = var_6_0.finishevent
		}
	end
end

function var_0_0.AddNewTask(arg_7_0, arg_7_1)
	local var_7_0 = NewWarChessTaskPoolCfg[arg_7_1]

	arg_7_0.activeTaskList_[arg_7_1] = {
		cur = 0,
		taskID = arg_7_1,
		type = var_7_0.type,
		conditionType = var_7_0.condition_type,
		need = var_7_0.need,
		clickevent = var_7_0.clickevent,
		finishevent = var_7_0.finishevent
	}

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
end

function var_0_0.UpdateTask(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.activeTaskList_) do
		if iter_8_1.conditionType == arg_8_1 then
			iter_8_1.cur = iter_8_1.cur + arg_8_2
		end
	end

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
end

function var_0_0.DeleteTask(arg_9_0, arg_9_1)
	arg_9_0.activeTaskList_[arg_9_1] = nil
end

function var_0_0.GetTaskList(arg_10_0)
	return arg_10_0.activeTaskList_
end

function var_0_0.GetTaskInfo(arg_11_0, arg_11_1)
	return arg_11_0.activeTaskList_[arg_11_1]
end

function var_0_0.CheckTask(arg_12_0)
	CheckTaskIterator.New():MoveNext()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.activeTaskList_ = {}
end

return var_0_0
