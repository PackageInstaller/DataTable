class = var_0_10000

local var_0_0 = "EffectImpack"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function var_0_1.InitUI(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "Lockon")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10005

	local var_1_3 = var_1_2(var_1_1, var_4(var_1_10005))

	var_2.SetEndEvent(var_1_3, function()
		setActive = var_2_10000

		local var_2_0 = arg_1_0._tf

		var_2_10000(var_1.Find(var_2_0, "Lockon"), false)

		setActive = var_2_10000

		local var_2_1 = arg_1_0._tf

		var_2_10000(var_1.Find(var_2_1, "impack"), true)

		return
	end)

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "impack")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10005

	local var_1_7 = var_1_6(var_1_5, var_4(var_1_10005))
	local var_1_8 = var_2.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10006

	local var_1_9 = var_1_8(var_1_7, var_1_10005(var_1_10006))

	var_3.SetTriggerEvent(var_1_9, function()
		local var_3_0 = arg_1_0.responder

		if var_0.CollideRyza(var_3_0, arg_1_0) then
			local var_3_1 = arg_1_0
			local var_3_2 = var_0.Calling
			local var_3_3 = "hit"
			local var_3_4 = {
				1,
				arg_1_0.realPos
			}

			MoveRyza = var_4

			var_3_2(var_3_1, var_3_3, var_3_4, var_4)
		end

		return
	end)

	local var_1_10 = var_2
	local var_1_11 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10006

	local var_1_12 = var_1_11(var_1_10, var_5(var_1_10006))

	var_3.SetEndEvent(var_1_12, function()
		local var_4_0 = arg_1_0

		var_0.Destroy(var_4_0)

		return
	end)

	return
end

return var_0_1
