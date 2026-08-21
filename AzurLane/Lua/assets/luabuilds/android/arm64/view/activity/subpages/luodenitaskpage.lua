local var_0_0 = class("LuodeniTaskPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	local var_1_0 = arg_1_0.activity:getConfig("config_client").firstStory

	if var_1_0 then
		playStory(var_1_0)
	end

	arg_1_0:PlayStory()

	if arg_1_0.dayTF then
		setText(arg_1_0.dayTF, tostring(arg_1_0.nday))
	end

	arg_1_0.uilist:align(#arg_1_0.taskGroup[arg_1_0.nday])
	setText(arg_1_0.dayTF, setColorStr(arg_1_0.nday, "#F2F5FF") .. setColorStr("/" .. #arg_1_0.taskGroup, "#F2F5FF"))

	return
end

function var_0_0.PlayStory(arg_2_0)
	local var_2_0 = arg_2_0.activity:getConfig("config_client").story
	local var_2_1 = false

	if arg_2_0.nday == 1 then
		local var_2_2 = arg_2_0.taskProxy:getTaskById(arg_2_0.taskGroup[1][1]) or arg_2_0.taskProxy:getFinishTaskById(arg_2_0.taskGroup[1][1])
		local var_2_3 = arg_2_0.taskProxy:getTaskById(arg_2_0.taskGroup[1][2]) or arg_2_0.taskProxy:getFinishTaskById(arg_2_0.taskGroup[1][2])

		if var_2_2:getTaskStatus() == 2 and var_2_3:getTaskStatus() == 2 and checkExist(var_2_0, {
			1
		}, {
			1
		}) then
			var_2_1 = true
		end
	end

	if arg_2_0.nday == 2 then
		var_2_1 = true
	end

	if arg_2_0.nday == 1 and var_2_1 or arg_2_0.nday == 2 then
		pg.NewStoryMgr.GetInstance():Play(var_2_0[1][1])
	end

	if arg_2_0.nday == 5 then
		local var_2_4 = arg_2_0.nday
		local var_2_5 = arg_2_0.taskProxy:getTaskById(arg_2_0.taskGroup[arg_2_0.nday][1]) or arg_2_0.taskProxy:getFinishTaskById(arg_2_0.taskGroup[arg_2_0.nday][1])
		local var_2_6 = arg_2_0.taskProxy:getTaskById(arg_2_0.taskGroup[arg_2_0.nday][2]) or arg_2_0.taskProxy:getFinishTaskById(arg_2_0.taskGroup[arg_2_0.nday][2])

		if var_2_5:getTaskStatus() == 2 and var_2_6:getTaskStatus() == 2 then
			var_2_4 = var_2_4 + 1
		end

		if checkExist(var_2_0, {
			var_2_4
		}, {
			1
		}) then
			pg.NewStoryMgr.GetInstance():Play(var_2_0[var_2_4][1])
		end
	elseif arg_2_0.nday ~= 1 and checkExist(var_2_0, {
		arg_2_0.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_2_0[arg_2_0.nday][1])
	end

	return
end

function var_0_0.GetProgressColor(arg_3_0)
	return "#98A7D1", "#98A7D1"
end

return var_0_0
