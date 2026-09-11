local var_0_0 = {}

function var_0_0.Init()
	var_0_0.UpdateTaskRedPoint(ActivityConst.ACTIVITY_2_0_SEAL)
end

manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_2_0_SEAL) then
		var_0_0.UpdateTaskRedPoint(ActivityConst.ACTIVITY_2_0_SEAL)
	end
end)
manager.net:Bind(64101, function(arg_3_0)
	XH1stSealData:OnServerData(arg_3_0)
end)

function var_0_0.InitRedPointKey(arg_4_0)
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.XH1ST_SEAL, arg_4_0), {
		RedPointConst.XH1ST_SEAL_TASK
	})
end

function var_0_0.UpdateTaskRedPoint(arg_5_0)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_5_0]) do
		local var_5_1 = TaskData2:GetTask(iter_5_1)

		if var_5_1 ~= nil then
			if not TaskData2:GetTaskComplete(iter_5_1) and var_5_1.progress >= AssignmentCfg[iter_5_1].need then
				var_5_0 = true

				break
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.XH1ST_SEAL_TASK, var_5_0 and 1 or 0)
end

function var_0_0.ResetSeal(arg_6_0, arg_6_1)
	manager.net:SendWithLoadingNew(64102, {
		activity_id = arg_6_0,
		ticket_id = arg_6_1
	}, 64103, var_0_0.OnResetSealCallback)
end

function var_0_0:OnResetSealCallback(arg_7_1)
	if isSuccess(self.result) then
		XH1stSealData:ResetTicket()
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.RequestSeal(arg_8_0, arg_8_1)
	manager.net:SendWithLoadingNew(64112, {
		activity_id = arg_8_0,
		ticket_id = arg_8_1
	}, 64113, var_0_0.OnRequestSealCallback)
end

function var_0_0:OnRequestSealCallback(arg_9_1)
	if isSuccess(self.result) then
		manager.notify:CallUpdateFunc(XH1ST_ON_SEAL_RESULT, self, arg_9_1)
	else
		ShowTips(GetTips(self.result))
	end
end

return var_0_0
