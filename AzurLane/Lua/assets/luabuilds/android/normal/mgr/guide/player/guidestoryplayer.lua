class = var_0_10000

local var_0_0 = "GuideStoryPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuidePlayer"))

function var_0_1.OnExecution(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1:GetStories()
	local var_1_1 = {}

	setActive = var_1_10005

	var_1_10005(arg_1_0._tf, false)

	ipairs = var_1_10005

	for iter_1_0, iter_1_1 in var_1_10005(var_1_0) do
		table = var_1_10010

		var_1_10010.insert(var_1_1, function(arg_2_0)
			pg = var_2_10001

			local var_2_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_2_0, iter_1_1, arg_2_0, true)

			return
		end)
	end

	table = var_5

	var_5.insert(var_1_1, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_1_0._tf, true)

		pg = var_2_10001

		local var_3_0 = var_2_10001.m02
		local var_3_1 = var_1.sendNotification

		GAME = var_3

		var_3_1(var_3_0, var_3.START_GUIDE)
		arg_3_0()

		return
	end)

	seriesAsync = var_5

	var_5(var_1_1, arg_1_2)

	return
end

return var_0_1
