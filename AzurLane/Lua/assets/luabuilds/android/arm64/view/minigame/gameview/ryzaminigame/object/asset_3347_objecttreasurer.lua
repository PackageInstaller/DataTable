class = var_0_10000

local var_0_0 = "ObjectTreasureR"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function var_0_1.FirePassability(arg_1_0)
	return 2
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

		var_0.TryDrop(var_3_0, arg_2_1.drop, "Drop_Treasure_R")

		local var_3_1 = arg_2_0

		var_0.Destroy(var_3_1)

		return
	end)

	return
end

function var_0_1.InitRegister(arg_4_0, arg_4_1)
	arg_4_0:Register("touch", function()
		local var_5_0 = arg_4_0

		var_0.DeregisterAll(var_5_0)

		local var_5_1 = arg_4_0._tf
		local var_5_2 = var_0.Find(var_5_1, "Image")
		local var_5_3 = var_0.GetComponent

		typeof = var_3
		Animator = var_2_10005

		local var_5_4 = var_5_3(var_5_2, var_3(var_2_10005))

		var_0.Play(var_5_4, "Open")

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

return var_0_1
