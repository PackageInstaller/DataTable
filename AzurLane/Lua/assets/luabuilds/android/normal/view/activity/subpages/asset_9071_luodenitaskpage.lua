class = var_0_10000

local var_0_0 = "LuodeniTaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	local var_1_0 = arg_1_0.activity

	if var_1.getConfig(var_1_0, "config_client").firstStory then
		playStory = var_1_0

		var_1_0(var_1)
	end

	arg_1_0:PlayStory()

	if arg_1_0.dayTF then
		setText = var_2

		local var_1_1 = arg_1_0.dayTF

		tostring = var_1_10004

		var_2(var_1_1, var_1_10004(arg_1_0.nday))
	end

	local var_1_2 = arg_1_0.uilist

	var_2.align(var_1_2, #arg_1_0.taskGroup[arg_1_0.nday])

	setText = var_2

	local var_1_3 = arg_1_0.dayTF

	setColorStr = var_4

	local var_1_4 = var_4(arg_1_0.nday, "#F2F5FF")

	setColorStr = var_5

	var_2(var_1_3, var_1_4 .. var_5("/" .. #arg_1_0.taskGroup, "#F2F5FF"))

	return
end

function var_0_1.PlayStory(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client").story
	local var_2_2 = false

	if arg_2_0.nday == 1 then
		local var_2_3 = arg_2_0.taskGroup[1][1]
		local var_2_4 = arg_2_0.taskGroup[1][2]
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
			checkExist = var_7

			if var_7(var_2_1, {
				1
			}, {
				1
			}) then
				var_2_2 = true
			end
		end
	end

	if arg_2_0.nday == 2 then
		var_2_2 = true
	end

	if arg_2_0.nday == 1 and var_2_2 or arg_2_0.nday == 2 then
		pg = var_3

		local var_2_11 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_2_11, var_2_1[1][1])
	end

	if arg_2_0.nday == 5 then
		local var_2_12 = arg_2_0.nday
		local var_2_13 = arg_2_0.taskGroup[arg_2_0.nday][1]
		local var_2_14 = arg_2_0.taskGroup[arg_2_0.nday][2]
		local var_2_15 = arg_2_0.taskProxy
		local var_2_17

		if not var_6.getTaskById(var_2_15, var_2_13) then
			local var_2_16 = arg_2_0.taskProxy

			var_2_17 = var_6.getFinishTaskById(var_2_16, var_2_13)
		end

		local var_2_18 = arg_2_0.taskProxy
		local var_2_20

		if not var_7.getTaskById(var_2_18, var_2_14) then
			local var_2_19 = arg_2_0.taskProxy

			var_2_20 = var_7.getFinishTaskById(var_2_19, var_2_14)
		end

		if var_2_17:getTaskStatus() == 2 and var_2_20:getTaskStatus() == 2 then
			var_2_12 = var_2_12 + 1
		end

		checkExist = var_8

		if var_8(var_2_1, {
			var_2_12
		}, {
			1
		}) then
			pg = var_8

			local var_2_21 = var_8.NewStoryMgr.GetInstance()

			var_8.Play(var_2_21, var_2_1[var_2_12][1])
		end
	elseif arg_2_0.nday ~= 1 then
		checkExist = var_3

		if var_3(var_2_1, {
			arg_2_0.nday
		}, {
			1
		}) then
			pg = var_3

			local var_2_22 = var_3.NewStoryMgr.GetInstance()

			var_3.Play(var_2_22, var_2_1[arg_2_0.nday][1])
		end
	end

	return
end

function var_0_1.GetProgressColor(arg_3_0)
	return "#98A7D1", "#98A7D1"
end

return var_0_1
