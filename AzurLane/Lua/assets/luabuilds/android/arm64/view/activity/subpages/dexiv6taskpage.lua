local var_0_0 = class("MaoxiV4TaskPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	arg_1_0:PlayStory()

	if arg_1_0.dayTF then
		setText(arg_1_0.dayTF, tostring(arg_1_0.nday))
	end

	arg_1_0.uilist:align(#arg_1_0.taskGroup[arg_1_0.nday])

	return
end

function var_0_0.PlayStory(arg_2_0)
	local var_2_0 = arg_2_0.activity:getConfig("config_client").story
	local var_2_1 = arg_2_0.activity:getConfig("config_client").specialstory
	local var_2_2 = arg_2_0.nday == 1 and (arg_2_0.taskProxy:getTaskVO(arg_2_0.taskGroup[arg_2_0.nday][1]):isReceive() and arg_2_0.taskProxy:getTaskVO(arg_2_0.taskGroup[arg_2_0.nday][2]):isReceive() and var_2_1[1] or var_2_0[arg_2_0.nday]) or arg_2_0.nday == 2 and (not pg.NewStoryMgr.GetInstance():IsPlayed(var_2_1[1]) and var_2_1[1] or var_2_0[arg_2_0.nday]) or arg_2_0.nday == #var_2_0 and (arg_2_0.taskProxy:getTaskVO(arg_2_0.taskGroup[arg_2_0.nday][1]):isReceive() and arg_2_0.taskProxy:getTaskVO(arg_2_0.taskGroup[arg_2_0.nday][2]):isReceive() and var_2_1[2] or var_2_0[arg_2_0.nday]) or var_2_0[arg_2_0.nday]

	print("story name:" .. var_2_2)
	pg.NewStoryMgr.GetInstance():Play(var_2_2)

	return
end

return var_0_0
