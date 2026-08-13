class = var_0_10000

local var_0_0 = "ObjectTreasureN"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.object.ObjectBreakable"))

function var_0_1.InitRegister(arg_1_0, arg_1_1)
	var_0_1.super.InitRegister(arg_1_0, arg_1_1)
	arg_1_0:Register("touch", function()
		local var_2_0 = arg_1_0

		var_0.DeregisterAll(var_2_0)

		local var_2_1 = arg_1_0._tf
		local var_2_2 = var_0.Find(var_2_1, "Image")
		local var_2_3 = var_0.GetComponent

		typeof = var_3
		Animator = var_2_10005

		local var_2_4 = var_2_3(var_2_2, var_3(var_2_10005))

		var_0.Play(var_2_4, "Open")

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
