class = var_0_10000

local var_0_0 = "ActivityTask"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Task"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_2.progress then
		var_1_0 = 0
	end

	arg_1_0.progress = var_1_0

	local var_1_1

	if not arg_1_2.accept_time then
		var_1_1 = 0
	end

	arg_1_0.acceptTime = var_1_1

	local var_1_2

	if not arg_1_2.submit_time then
		var_1_2 = 0
	end

	arg_1_0.submitTime = var_1_2
	arg_1_0._isOver = false

	arg_1_0:initConfig()

	return
end

function var_0_1.isFinish(arg_2_0)
	return arg_2_0:getProgress() >= arg_2_0:getConfig("target_num")
end

function var_0_1.setOver(arg_3_0)
	arg_3_0._isOver = true
	arg_3_0.progress = arg_3_0:getConfig("target_num")

	return
end

function var_0_1.isOver(arg_4_0)
	return arg_4_0._isOver
end

function var_0_1.isActivitySubmit(arg_5_0)
	if arg_5_0.type == 16 and arg_5_0.subType == 1006 then
		return true
	elseif arg_5_0.type == 6 and arg_5_0.subType == 1006 then
		return true
	end

	return false
end

function var_0_1.getProgress(arg_6_0)
	local var_6_0
	local var_6_1 = arg_6_0

	if arg_6_0.isActivitySubmit(var_6_1) then
		tonumber = var_2

		local var_6_2 = var_2(arg_6_0:getConfig("target_id"))

		tonumber = var_6_1

		local var_6_3 = arg_6_0

		var_6_1 = var_6_1(arg_6_0.getConfig(var_6_3, "target_id_2"))
		pg = var_4

		local var_6_4 = var_4.activity_drop_type[var_6_2].activity_id

		getProxy = var_6_3
		ActivityProxy = var_6

		local var_6_5 = var_6_3(var_6)

		if var_5.getActivityById(var_6_5, var_6_4) then
			var_6_0 = var_5:getVitemNumber(var_6_1)
		else
			warning = var_6_5

			var_6_5("找不到活动数据中物品得的数量")

			var_6_0 = 0
		end
	else
		if arg_6_0.type == 6 then
			local var_6_6 = arg_6_0.subType

			TASK_SUB_TYPE_PT = var_6_1

			if var_6_6 == var_6_1 then
				tonumber = var_6_6

				local var_6_7 = arg_6_0
				local var_6_8 = var_6_6(arg_6_0.getConfig(var_6_7, "target_id_2"))

				getProxy = var_3
				ActivityProxy = var_6_7

				local var_6_9 = var_3(var_6_7)

				if var_3.getActivityById(var_6_9, var_6_8) then
					var_6_0 = var_3.data1 or 0
				else
					warning = var_6_9

					var_6_9("找不到活动数据中物品得的数量", arg_6_0.id)

					var_6_0 = 0
				end

				goto label_6_0
			end
		end

		if arg_6_0.progress > arg_6_0:getConfig("target_num") then
			var_6_0 = arg_6_0:getConfig("target_num")
		end
	end

	::label_6_0::

	return var_6_0 or 0
end

function var_0_1.getTarget(arg_7_0)
	return arg_7_0.target
end

function var_0_1.isReceive(arg_8_0)
	return false
end

function var_0_1.isSubmit(arg_9_0)
	if arg_9_0.subType == 1006 then
		return true
	end

	return false
end

function var_0_1.getTaskStatus(arg_10_0)
	if arg_10_0.progress >= arg_10_0:getConfig("target_num") then
		return 1
	end

	return 0
end

function var_0_1.onAdded(arg_11_0)
	return
end

function var_0_1.updateProgress(arg_12_0, arg_12_1)
	arg_12_0.progress = arg_12_1

	return
end

function var_0_1.isSelectable(arg_13_0)
	return false
end

function var_0_1.judgeOverflow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return false, false
end

function var_0_1.IsUrTask(arg_15_0)
	return false
end

function var_0_1.GetRealType(arg_16_0)
	return 6
end

function var_0_1.isNew(arg_17_0)
	local var_17_0 = arg_17_0

	if not arg_17_0.isFinish(var_17_0) then
		var_17_0 = arg_17_0

		if not arg_17_0.isOver(var_17_0) then
			var_17_0 = arg_17_0

			if arg_17_0.isCircle(var_17_0) then
				return false
			end

			local var_17_1 = arg_17_0.actType

			ActivityConst = var_17_0

			if var_17_1 == var_17_0.ACTIVITY_TYPE_TASK_RYZA then
				if arg_17_0.groupIndex ~= 1 then
					PlayerPrefs = var_1

					local var_17_2 = var_1.GetInt
					local var_17_3 = "ryza_task_"

					getProxy = var_1_10003
					PlayerProxy = var_1_10004

					local var_17_4 = var_1_10003(var_1_10004)

					if var_17_2(var_17_3 .. var_3.getRawData(var_17_4).id .. "_" .. arg_17_0.id) ~= 1 then
						return true
					end
				end

				return false
			end

			return false
		end
	end
end

function var_0_1.changeNew(arg_18_0)
	local var_18_0 = arg_18_0.actType

	ActivityConst = var_1_10002

	if var_18_0 == var_1_10002.ACTIVITY_TYPE_TASK_RYZA and arg_18_0.groupIndex ~= 1 then
		PlayerPrefs = var_1

		local var_18_1 = var_1.GetInt
		local var_18_2 = "ryza_task_"

		getProxy = var_1_10003
		PlayerProxy = var_1_10004

		local var_18_3 = var_1_10003(var_1_10004)

		if var_18_1(var_18_2 .. var_3.getRawData(var_18_3).id .. "_" .. arg_18_0.id) ~= 1 then
			PlayerPrefs = var_1

			local var_18_4 = var_1.SetInt
			local var_18_5 = "ryza_task_"

			getProxy = var_3
			PlayerProxy = var_4

			local var_18_6 = var_3(var_4)

			var_18_4(var_18_5 .. var_3.getRawData(var_18_6).id .. "_" .. arg_18_0.id, 1)
		end
	end

	return
end

function var_0_1.ShowOnTaskScene(arg_19_0)
	return false
end

function var_0_1.getConfig(arg_20_0, arg_20_1)
	return arg_20_0.configData[arg_20_1]
end

function var_0_1.isAvatarTask(arg_21_0)
	return false
end

function var_0_1.initConfig(arg_22_0)
	pg = var_1_10001
	arg_22_0.actConfig = var_1_10001.activity_template[arg_22_0.actId]
	Activity = var_1

	local var_22_0 = var_1.Create({
		id = arg_22_0.actId
	})

	arg_22_0.actType = arg_22_0.actConfig.type
	arg_22_0.groups = var_22_0:GetTaskIdsByDay()

	for iter_22_0 = 1, #arg_22_0.groups do
		table = var_1_10006

		if var_1_10006.contains(arg_22_0.groups[iter_22_0], arg_22_0.id) then
			arg_22_0.groupIndex = iter_22_0
		end
	end

	pg = var_2
	arg_22_0.configData = var_2.task_data_template[arg_22_0.id]
	arg_22_0.target = arg_22_0.configData.target_num
	arg_22_0.type = arg_22_0.configData.type
	arg_22_0.subType = arg_22_0.configData.sub_type
	arg_22_0.targetId1 = arg_22_0.configData.target_id
	arg_22_0.targetId2 = arg_22_0.configData.target_id_2
	arg_22_0.autoCommit = arg_22_0.configData.auto_commit == 1

	local var_22_1 = arg_22_0.actType

	ActivityConst = var_3

	if var_22_1 == var_3.ACTIVITY_TYPE_TASK_RYZA then
		-- block empty
	end

	return
end

return var_0_1
