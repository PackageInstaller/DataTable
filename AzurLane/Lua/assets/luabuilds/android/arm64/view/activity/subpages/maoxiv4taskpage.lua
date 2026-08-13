class = var_0_10000

local var_0_0 = "MaoxiV4TaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	local var_1_0 = arg_1_0.activity

	if var_1.getConfig(var_1_0, "config_client").firstStory then
		playStory = var_1_10002

		var_1_10002(var_1)
	end

	arg_1_0:PlayStory()

	if arg_1_0.dayTF then
		setText = var_2

		local var_1_1 = arg_1_0.dayTF

		tostring = var_1_10005

		var_2(var_1_1, var_1_10005(arg_1_0.nday))
	end

	local var_1_2 = arg_1_0.uilist

	var_2.align(var_1_2, #arg_1_0.taskGroup[arg_1_0.nday])

	return
end

function var_0_1.PlayStory(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client").story
	local var_2_2 = arg_2_0.nday - 1
	local var_2_3

	if arg_2_0.nday == 7 then
		var_2_3 = arg_2_0.taskGroup[arg_2_0.nday][1]

		local var_2_4 = arg_2_0.taskGroup[arg_2_0.nday][2]
		local var_2_5 = arg_2_0.taskProxy
		local var_2_7

		if not var_5.getTaskById(var_2_5, var_2_3) then
			local var_2_6 = arg_2_0.taskProxy

			var_2_7 = var_5.getFinishTaskById(var_2_6, var_2_3)
		end

		local var_2_8 = arg_2_0.taskProxy
		local var_2_10

		if not var_6.getTaskById(var_2_8, var_2_4) then
			local var_2_9 = arg_2_0.taskProxy

			var_2_10 = var_6.getFinishTaskById(var_2_9, var_2_4)
		end

		if var_2_7:getTaskStatus() == 2 and var_2_10:getTaskStatus() == 2 then
			var_2_2 = var_2_2 + 1
		end
	end

	checkExist = var_2_3

	if var_2_3(var_2_1, {
		var_2_2
	}, {
		1
	}) then
		pg = var_3

		local var_2_11 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_2_11, var_2_1[var_2_2][1])
	end

	return
end

return var_0_1
