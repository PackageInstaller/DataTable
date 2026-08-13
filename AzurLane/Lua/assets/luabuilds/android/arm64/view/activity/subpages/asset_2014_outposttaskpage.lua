class = var_0_10000

local var_0_0 = "OutPostTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

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

	if var_2_6:getTaskStatus() == 2 and var_2_9:getTaskStatus() == 2 then
		var_2_10 = 0
	end

	local var_2_11 = arg_2_0.nday - var_2_10

	checkExist = var_8

	if var_8(var_2_1, {
		var_2_11
	}, {
		1
	}) then
		pg = var_8

		local var_2_12 = var_8.NewStoryMgr.GetInstance()

		var_8.Play(var_2_12, var_2_1[var_2_11][1])
	end

	return
end

return var_0_1
