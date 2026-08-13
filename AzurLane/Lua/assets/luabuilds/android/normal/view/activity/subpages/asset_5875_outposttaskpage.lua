class = var_0_10000

local var_0_0 = "OutPostTaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	setText = var_1

	var_1(arg_1_0.dayTF, arg_1_0.nday)

	return
end

function var_0_1.PlayStory(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client").story
	local var_2_2 = arg_2_0.taskGroup[arg_2_0.nday][1]
	local var_2_3 = arg_2_0.taskGroup[arg_2_0.nday][2]
	local var_2_4 = arg_2_0.taskProxy
	local var_2_6

	if not var_4.getTaskById(var_2_4, var_2_2) then
		local var_2_5 = arg_2_0.taskProxy

		var_2_6 = var_4.getFinishTaskById(var_2_5, var_2_2)
	end

	local var_2_7 = arg_2_0.taskProxy
	local var_2_9

	if not var_5.getTaskById(var_2_7, var_2_3) then
		local var_2_8 = arg_2_0.taskProxy

		var_2_9 = var_5.getFinishTaskById(var_2_8, var_2_3)
	end

	local var_2_10 = 1
	local var_2_11 = var_2_6

	if var_2_6.getTaskStatus(var_2_11) == 2 then
		var_2_11 = var_2_9

		if var_2_9.getTaskStatus(var_2_11) == 2 then
			var_2_10 = 0
		end
	end

	local var_2_12 = arg_2_0.nday - var_2_10

	checkExist = var_2_11

	if var_2_11(var_2_1, {
		var_2_12
	}, {
		1
	}) then
		pg = var_8

		local var_2_13 = var_8.NewStoryMgr.GetInstance()

		var_8.Play(var_2_13, var_2_1[var_2_12][1])
	end

	return
end

return var_0_1
