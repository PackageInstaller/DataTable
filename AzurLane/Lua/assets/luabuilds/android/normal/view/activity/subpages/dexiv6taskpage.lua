class = var_0_10000

local var_0_0 = "MaoxiV4TaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	arg_1_0:PlayStory()

	if arg_1_0.dayTF then
		setText = var_1

		local var_1_0 = arg_1_0.dayTF

		tostring = var_1_10003

		var_1(var_1_0, var_1_10003(arg_1_0.nday))
	end

	local var_1_1 = arg_1_0.uilist

	var_1.align(var_1_1, #arg_1_0.taskGroup[arg_1_0.nday])

	return
end

function var_0_1.PlayStory(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client").story
	local var_2_2 = arg_2_0.activity
	local var_2_3 = var_2.getConfig(var_2_2, "config_client").specialstory
	local var_2_4
	local var_2_5

	if arg_2_0.nday == 1 then
		var_2_5 = arg_2_0.taskGroup[arg_2_0.nday][1]

		local var_2_6 = arg_2_0.taskGroup[arg_2_0.nday][2]
		local var_2_7 = arg_2_0.taskProxy
		local var_2_8 = var_6.getTaskVO(var_2_7, var_2_5)
		local var_2_9 = arg_2_0.taskProxy
		local var_2_10 = var_7.getTaskVO(var_2_9, var_2_6)

		if var_2_8:isReceive() and var_2_10:isReceive() then
			var_2_4 = var_2_3[1]
		else
			var_2_4 = var_2_1[arg_2_0.nday]
		end
	elseif arg_2_0.nday == 2 then
		pg = var_2_5

		local var_2_11 = var_2_5.NewStoryMgr.GetInstance()

		if not var_2_5.IsPlayed(var_2_11, var_2_3[1]) then
			var_2_4 = var_2_3[1]
		else
			var_2_4 = var_2_1[arg_2_0.nday]
		end
	elseif arg_2_0.nday == #var_2_1 then
		var_2_5 = arg_2_0.taskGroup[arg_2_0.nday][1]

		local var_2_12 = arg_2_0.taskGroup[arg_2_0.nday][2]
		local var_2_13 = arg_2_0.taskProxy
		local var_2_14 = var_6.getTaskVO(var_2_13, var_2_5)
		local var_2_15 = arg_2_0.taskProxy
		local var_2_16 = var_7.getTaskVO(var_2_15, var_2_12)

		if var_2_14:isReceive() and var_2_16:isReceive() then
			var_2_4 = var_2_3[2]
		else
			var_2_4 = var_2_1[arg_2_0.nday]
		end
	else
		var_2_4 = var_2_1[arg_2_0.nday]
	end

	print = var_2_5

	var_2_5("story name:" .. var_2_4)

	pg = var_2_5

	local var_2_17 = var_2_5.NewStoryMgr.GetInstance()

	var_4.Play(var_2_17, var_2_4)

	return
end

return var_0_1
