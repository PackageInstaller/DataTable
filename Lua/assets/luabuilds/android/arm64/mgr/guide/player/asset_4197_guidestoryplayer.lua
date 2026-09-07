local GuideStoryPlayer = class("GuideStoryPlayer", import(".GuidePlayer"))

function GuideStoryPlayer:OnExecution(arg_1_1, arg_1_2)
	local var_1_0 = {}

	setActive(self._tf, false)

	for iter_1_0, iter_1_1 in ipairs((arg_1_1:GetStories())) do
		table.insert(var_1_0, function(arg_2_0)
			pg.NewStoryMgr.GetInstance():Play(iter_1_1, arg_2_0, true)

			return
		end)
	end

	table.insert(var_1_0, function(arg_3_0)
		setActive(self._tf, true)
		pg.m02:sendNotification(GAME.START_GUIDE)
		arg_3_0()

		return
	end)
	seriesAsync(var_1_0, arg_1_2)

	return
end

return GuideStoryPlayer
