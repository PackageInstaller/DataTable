class = var_0_10000

local var_0_0 = "AvatarFrameProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.FRAME_TASK_UPDATED = "frame task updated"
var_0_1.FRAME_TASK_TIME_OUT = "frame task time out"

function var_0_1.register(arg_1_0)
	arg_1_0.avatarFrames = {}

	return
end

function var_0_1.clearData(arg_2_0)
	arg_2_0.avatarFrames = {}

	return
end

function var_0_1.initListData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}
	local var_3_1 = {}

	ipairs = var_1_10006

	for iter_3_0, iter_3_1 in var_1_10006(arg_3_2) do
		local var_3_2 = arg_3_0:createAvatarFrameTask(arg_3_1, iter_3_1)

		table = var_1_10012

		var_1_10012.insert(var_3_0, var_3_2)
	end

	if arg_3_3 and #arg_3_3 then
		ipairs = var_6

		for iter_3_2, iter_3_3 in var_6(arg_3_3) do
			local var_3_3 = arg_3_0:createAvatarFrameTask(arg_3_1, {
				id = iter_3_3
			})

			var_11.setTaskFinish(var_3_3)

			table = var_12

			var_12.insert(var_3_1, var_11)
		end
	end

	table = var_6

	var_6.insert(arg_3_0.avatarFrames, {
		actId = arg_3_1,
		tasks = var_3_0,
		finish_tasks = var_3_1
	})

	return
end

function var_0_1.update(arg_4_0, arg_4_1, arg_4_2)
	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_2) do
		arg_4_0:updateAvatarTask(arg_4_1, iter_4_1)
	end

	local var_4_0 = arg_4_0.facade

	var_3.sendNotification(var_4_0, var_0_1.FRAME_TASK_UPDATED)

	return
end

function var_0_1.addData(arg_5_0, arg_5_1, arg_5_2)
	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_2) do
		local var_5_0 = arg_5_0:createAvatarFrameTask(arg_5_1, iter_5_1)

		arg_5_0:addAvatarTask(arg_5_1, var_5_0)
	end

	local var_5_1 = arg_5_0.facade

	var_3.sendNotification(var_5_1, var_0_1.FRAME_TASK_UPDATED)

	return
end

function var_0_1.removeData(arg_6_0, arg_6_1, arg_6_2)
	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_2) do
		arg_6_0:removeAvatarTask(arg_6_1, iter_6_1.id)
	end

	local var_6_0 = arg_6_0.facade

	var_3.sendNotification(var_6_0, var_0_1.FRAME_TASK_UPDATED)

	return
end

function var_0_1.createAvatarFrameTask(arg_7_0, arg_7_1, arg_7_2)
	pg = var_1_10003

	local var_7_0 = var_1_10003.activity_template[arg_7_1].config_id

	AvatarFrameTask = var_1_10004

	return (var_1_10004.New(arg_7_1, var_7_0, arg_7_2))
end

function var_0_1.updateAvatarTask(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0 = 1, #arg_8_0.avatarFrames do
		if arg_8_0.avatarFrames[iter_8_0].actId == arg_8_1 then
			for iter_8_1 = #arg_8_0.avatarFrames[iter_8_0].tasks, 1, -1 do
				if var_7.tasks[iter_8_1].id == arg_8_2.id then
					local var_8_0 = var_7.tasks[iter_8_1]

					var_12.updateProgress(var_8_0, arg_8_2.progress)
				end
			end
		end
	end

	return
end

function var_0_1.addAvatarTask(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = 1, #arg_9_0.avatarFrames do
		if arg_9_0.avatarFrames[iter_9_0].actId == arg_9_1 then
			for iter_9_1 = #arg_9_0.avatarFrames[iter_9_0].tasks, 1, -1 do
				if var_7.tasks[iter_9_1].id == arg_9_2.id then
					table = var_12

					var_12.remove(var_7.tasks, iter_9_1)
				end
			end

			table = var_8

			var_8.insert(var_7.tasks, arg_9_2)
		end
	end

	return
end

function var_0_1.removeAvatarTask(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0 = 1, #arg_10_0.avatarFrames do
		if arg_10_0.avatarFrames[iter_10_0].actId == arg_10_1 then
			for iter_10_1 = #arg_10_0.avatarFrames[iter_10_0].tasks, 1, -1 do
				if var_7.tasks[iter_10_1].id == arg_10_2 then
					table = var_12

					var_12.remove(var_7.tasks, iter_10_1)
				end
			end
		end
	end

	return
end

function var_0_1.getAvatarFrameById(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_0.avatarFrames do
		if arg_11_0.avatarFrames[iter_11_0].actId == arg_11_1 then
			Clone = var_6

			return var_6(arg_11_0.avatarFrames[iter_11_0])
		end
	end

	return nil
end

function var_0_1.getAllAvatarFrame(arg_12_0)
	Clone = var_1_10001

	return var_1_10001(arg_12_0.avatarFrames)
end

function var_0_1.getCanReceiveCount(arg_13_0)
	local var_13_0 = 0

	for iter_13_0 = 1, #arg_13_0.avatarFrames do
		local var_13_1 = arg_13_0.avatarFrames[iter_13_0]

		ipairs = var_1_10007

		for iter_13_1, iter_13_2 in var_1_10007(var_13_1.tasks) do
			if iter_13_2:getTaskStatus() == 1 then
				var_13_0 = var_13_0 + 1
			end
		end
	end

	return var_13_0
end

function var_0_1.clearTimeOut(arg_14_0)
	if not arg_14_0.avatarFrames or #arg_14_0.avatarFrames == 0 then
		return
	end

	local var_14_0 = false

	for iter_14_0 = #arg_14_0.avatarFrames, 1, -1 do
		local var_14_1 = arg_14_0.avatarFrames[iter_14_0].actId

		getProxy = var_1_10007
		ActivityProxy = var_1_10009
		var_1_10009 = var_1_10007(var_1_10009)

		if not var_1_10007.getActivityById(var_1_10009, var_14_1) or var_1_10007:isEnd() then
			table = var_1_10008

			var_1_10008.remove(arg_14_0.avatarFrames, iter_14_0)

			var_14_0 = true
		end
	end

	if var_14_0 then
		local var_14_2 = arg_14_0.facade

		var_2.sendNotification(var_14_2, var_0_1.FRAME_TASK_UPDATED)

		local var_14_3 = arg_14_0.facade

		var_2.sendNotification(var_14_3, var_0_1.FRAME_TASK_TIME_OUT)
	end

	return
end

return var_0_1
