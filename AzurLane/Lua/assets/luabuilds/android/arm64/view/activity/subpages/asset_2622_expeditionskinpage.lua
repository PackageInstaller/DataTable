class = var_0_10000

local var_0_0 = "ExpeditionSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnDataSetting(arg_1_0)
	arg_1_0.nday = 0
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_1_0.taskProxy = var_1(var_1_10003)

	local var_1_0 = arg_1_0.activity

	arg_1_0.taskGroup = var_1.getConfig(var_1_0, "config_data")

	local var_1_1 = arg_1_0.activity

	arg_1_0.preStory = var_1.getConfig(var_1_1, "config_client").firstStory

	if arg_1_0.preStory ~= nil then
		pg = var_1

		local var_1_2 = var_1.NewStoryMgr.GetInstance()

		var_1.Play(var_1_2, arg_1_0.preStory)
	end

	updateActivityTaskStatus = var_1

	return var_1(arg_1_0.activity)
end

function var_0_1.OnUpdateFlush(arg_2_0)
	arg_2_0.nday = arg_2_0.activity.data3

	arg_2_0:PlayStory()

	if arg_2_0.dayTF then
		setText = var_1

		var_1(arg_2_0.dayTF, arg_2_0.nday .. "/" .. #arg_2_0.taskGroup)
	end

	local var_2_0 = arg_2_0.uilist

	var_1.align(var_2_0, #arg_2_0.taskGroup[arg_2_0.nday])

	return
end

function var_0_1.PlayStory(arg_3_0)
	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_client").story
	local var_3_2 = arg_3_0.nday - 1
	local var_3_3

	if arg_3_0.nday < 7 then
		var_3_3 = arg_3_0.taskGroup[arg_3_0.nday][1]

		local var_3_4 = arg_3_0.taskGroup[arg_3_0.nday][2]
		local var_3_5 = arg_3_0.taskProxy
		local var_3_7

		if not var_5.getTaskById(var_3_5, var_3_3) then
			local var_3_6 = arg_3_0.taskProxy

			var_3_7 = var_5.getFinishTaskById(var_3_6, var_3_3)
		end

		local var_3_8 = arg_3_0.taskProxy
		local var_3_10

		if not var_6.getTaskById(var_3_8, var_3_4) then
			local var_3_9 = arg_3_0.taskProxy

			var_3_10 = var_6.getFinishTaskById(var_3_9, var_3_4)
		end

		if var_3_7:getTaskStatus() == 2 and var_3_10:getTaskStatus() == 2 then
			var_3_2 = var_3_2 + 1
		end
	end

	checkExist = var_3_3

	if var_3_3(var_3_1, {
		var_3_2
	}, {
		1
	}) then
		pg = var_3

		local var_3_11 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_3_11, var_3_1[var_3_2][1])
	end

	return
end

function var_0_1.GetProgressColor(arg_4_0)
	return "#b9b49c"
end

return var_0_1
