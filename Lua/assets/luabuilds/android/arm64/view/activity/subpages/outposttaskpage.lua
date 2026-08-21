local var_0_0 = class("OutPostTaskPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setText(arg_1_0.dayTF, arg_1_0.nday)

	return
end

function var_0_0.PlayStory(arg_2_0)
	local var_2_0 = arg_2_0.activity:getConfig("config_client").story
	local var_2_1 = arg_2_0.taskProxy:getTaskById(arg_2_0.taskGroup[arg_2_0.nday][1]) or arg_2_0.taskProxy:getFinishTaskById(arg_2_0.taskGroup[arg_2_0.nday][1])
	local var_2_2 = arg_2_0.taskProxy:getTaskById(arg_2_0.taskGroup[arg_2_0.nday][2]) or arg_2_0.taskProxy:getFinishTaskById(arg_2_0.taskGroup[arg_2_0.nday][2])
	local var_2_3 = 1

	if var_2_1:getTaskStatus() == 2 and var_2_2:getTaskStatus() == 2 then
		var_2_3 = 0
	end

	local var_2_4 = arg_2_0.nday - var_2_3

	if checkExist(var_2_0, {
		arg_2_0.nday - var_2_3
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_2_0[var_2_4][1])
	end

	return
end

return var_0_0
