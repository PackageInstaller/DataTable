local var_0_0 = class("GuideStoryPlayer", import(".GuidePlayer"))

function var_0_0.OnExecution(arg_1_0, arg_1_1, arg_1_2)
	setActive(arg_1_0._tf, false)

	for iter_1_0, iter_1_1 in ipairs((arg_1_1:GetStories())) do
		table.insert({}, function(arg_2_0)
			pg.NewStoryMgr.GetInstance():Play(iter_1_1, arg_2_0, true)

			return
		end)
	end

	table.insert({}, function(arg_3_0)
		setActive(arg_1_0._tf, true)
		pg.m02:sendNotification(GAME.START_GUIDE)
		arg_3_0()

		return
	end)
	seriesAsync({}, arg_1_2)

	return
end

return var_0_0
