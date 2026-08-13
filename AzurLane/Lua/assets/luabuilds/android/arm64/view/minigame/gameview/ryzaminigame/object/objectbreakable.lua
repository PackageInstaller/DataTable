class = var_0_10000

local var_0_0 = "ObjectBreakable"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function var_0_1.FirePassability(arg_1_0)
	return 1
end

function var_0_1.InitUI(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "Image")
	local var_2_2 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10007

	local var_2_3 = var_2_2(var_2_1, var_5(var_1_10007))

	var_2.SetEndEvent(var_2_3, function()
		local var_3_0 = arg_2_0

		var_0.TryDrop(var_3_0, arg_2_1.drop, "Drop")

		local var_3_1 = arg_2_0

		var_0.Destroy(var_3_1)

		return
	end)

	return
end

function var_0_1.InitRegister(arg_4_0, arg_4_1)
	arg_4_0:Register("burn", function()
		local var_5_0 = arg_4_0

		var_0.Break(var_5_0)

		return
	end, {
		{
			0,
			0
		}
	})
	arg_4_0:Register("break", function()
		local var_6_0 = arg_4_0

		var_0.Break(var_6_0)

		return
	end, {})

	return
end

function var_0_1.Break(arg_7_0)
	arg_7_0:DeregisterAll()

	local var_7_0 = arg_7_0._tf
	local var_7_1 = var_1.Find(var_7_0, "Image")
	local var_7_2 = var_1.GetComponent

	typeof = var_4
	Animator = var_1_10006

	local var_7_3 = var_7_2(var_7_1, var_4(var_1_10006))

	var_1.Play(var_7_3, "Break")

	return
end

return var_0_1
