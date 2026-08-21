local var_0_0 = class("ActivityTask", import(".Task"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.progress = arg_1_2.progress or 0
	arg_1_0.acceptTime = arg_1_2.accept_time or 0
	arg_1_0.submitTime = arg_1_2.submit_time or 0
	arg_1_0._isOver = false

	arg_1_0:initConfig()

	return
end

function var_0_0.isFinish(arg_2_0)
	return arg_2_0:getProgress() >= arg_2_0:getConfig("target_num")
end

function var_0_0.setOver(arg_3_0)
	arg_3_0._isOver = true
	arg_3_0.progress = arg_3_0:getConfig("target_num")

	return
end

function var_0_0.isOver(arg_4_0)
	return arg_4_0._isOver
end

function var_0_0.isActivitySubmit(arg_5_0)
	if arg_5_0.type == 16 and arg_5_0.subType == 1006 then
		return true
	elseif arg_5_0.type == 6 and arg_5_0.subType == 1006 then
		return true
	end

	return false
end

function var_0_0.getProgress(arg_6_0)
	local var_6_0

	if arg_6_0:isActivitySubmit() then
		local var_6_1 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[tonumber(arg_6_0:getConfig("target_id"))].activity_id)

		if var_6_1 then
			var_6_0 = var_6_1:getVitemNumber((tonumber(arg_6_0:getConfig("target_id_2"))))
		else
			warning("找不到活动数据中物品得的数量")

			var_6_0 = 0
		end
	elseif arg_6_0.type == 6 and arg_6_0.subType == TASK_SUB_TYPE_PT then
		local var_6_2 = getProxy(ActivityProxy):getActivityById((tonumber(arg_6_0:getConfig("target_id_2"))))

		if var_6_2 then
			var_6_0 = var_6_2.data1 or 0
		else
			warning("找不到活动数据中物品得的数量", arg_6_0.id)

			var_6_0 = 0
		end
	else
		var_6_0 = arg_6_0.progress

		if arg_6_0.progress > arg_6_0:getConfig("target_num") then
			var_6_0 = arg_6_0:getConfig("target_num")
		end
	end

	return var_6_0 or 0
end

function var_0_0.getTarget(arg_7_0)
	return arg_7_0.target
end

function var_0_0.isReceive(arg_8_0)
	return false
end

function var_0_0.isSubmit(arg_9_0)
	if arg_9_0.subType == 1006 then
		return true
	end

	return false
end

function var_0_0.getTaskStatus(arg_10_0)
	if arg_10_0.progress >= arg_10_0:getConfig("target_num") then
		return 1
	end

	return 0
end

function var_0_0.onAdded(arg_11_0)
	return
end

function var_0_0.updateProgress(arg_12_0, arg_12_1)
	arg_12_0.progress = arg_12_1

	return
end

function var_0_0.isSelectable(arg_13_0)
	return false
end

function var_0_0.judgeOverflow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return false, false
end

function var_0_0.IsUrTask(arg_15_0)
	return false
end

function var_0_0.GetRealType(arg_16_0)
	return 6
end

function var_0_0.isNew(arg_17_0)
	if arg_17_0:isFinish() or arg_17_0:isOver() or arg_17_0:isCircle() then
		return false
	end

	if arg_17_0.actType == ActivityConst.ACTIVITY_TYPE_TASK_RYZA then
		if arg_17_0.groupIndex ~= 1 then
			if PlayerPrefs.GetInt("ryza_task_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_17_0.id) ~= 1 then
				return true
			end
		end

		return false
	end

	return false
end

function var_0_0.changeNew(arg_18_0)
	if arg_18_0.actType == ActivityConst.ACTIVITY_TYPE_TASK_RYZA and arg_18_0.groupIndex ~= 1 then
		if PlayerPrefs.GetInt("ryza_task_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_18_0.id) ~= 1 then
			PlayerPrefs.SetInt("ryza_task_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_18_0.id, 1)
		end
	end

	return
end

function var_0_0.ShowOnTaskScene(arg_19_0)
	return false
end

function var_0_0.getConfig(arg_20_0, arg_20_1)
	return arg_20_0.configData[arg_20_1]
end

function var_0_0.isAvatarTask(arg_21_0)
	return false
end

function var_0_0.initConfig(arg_22_0)
	arg_22_0.actConfig = pg.activity_template[arg_22_0.actId]
	arg_22_0.actType = arg_22_0.actConfig.type
	arg_22_0.groups = Activity.Create({
		id = arg_22_0.actId
	}):GetTaskIdsByDay()

	for iter_22_0 = 1, #arg_22_0.groups do
		if table.contains(arg_22_0.groups[iter_22_0], arg_22_0.id) then
			arg_22_0.groupIndex = iter_22_0
		end
	end

	arg_22_0.configData = pg.task_data_template[arg_22_0.id]
	arg_22_0.target = arg_22_0.configData.target_num
	arg_22_0.type = arg_22_0.configData.type
	arg_22_0.subType = arg_22_0.configData.sub_type
	arg_22_0.targetId1 = arg_22_0.configData.target_id
	arg_22_0.targetId2 = arg_22_0.configData.target_id_2
	arg_22_0.autoCommit = arg_22_0.configData.auto_commit == 1

	if arg_22_0.actType == ActivityConst.ACTIVITY_TYPE_TASK_RYZA then
		-- block empty
	end

	return
end

return var_0_0
