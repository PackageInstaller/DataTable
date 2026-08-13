class = var_0_10000

local var_0_0 = "ObjectRockB"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.object.ObjectBreakable"))

function var_0_1.FirePassability(arg_1_0)
	return arg_1_0.isWater and 2 or 1
end

function var_0_1.InTimeRiver(arg_2_0)
	return true
end

function var_0_1.InitUI(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_2.Find(var_3_0, "Image")
	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_3.Find(var_3_2, "Image")
	local var_3_4 = var_3.GetComponent

	typeof = var_5
	Animator = var_1_10006
	arg_3_0.comAnimator = var_3_4(var_3_3, var_5(var_1_10006))

	local var_3_5 = var_3_1
	local var_3_6 = var_3_1.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10006

	local var_3_7 = var_3_6(var_3_5, var_5(var_1_10006))

	var_3.SetTriggerEvent(var_3_7, function()
		local var_4_0 = arg_3_0
		local var_4_1

		if not arg_3_1.waterTime then
			var_4_1 = 4
		end

		var_4_0.waterTime = var_4_1

		return
	end)
	var_3:SetEndEvent(function()
		local var_5_0 = arg_3_0

		var_0.Destroy(var_5_0)

		return
	end)

	arg_3_0.waterTime = 0

	return
end

function var_0_1.Break(arg_6_0)
	arg_6_0:DeregisterAll()

	local var_6_0 = arg_6_0.comAnimator

	var_1.Play(var_6_0, "B2")

	return
end

function var_0_1.TimeUpdate(arg_7_0, arg_7_1)
	if arg_7_0.waterTime > 0 then
		arg_7_0.waterTime = arg_7_0.waterTime - arg_7_1

		if arg_7_0.waterTime <= 0 then
			local var_7_0 = arg_7_0.comAnimator

			var_2.Play(var_7_0, "B4")
		end
	end

	return
end

return var_0_1
