local var_0_0 = class("ObjectRockB", import("view.miniGame.gameView.RyzaMiniGame.object.ObjectBreakable"))

function var_0_0.FirePassability(arg_1_0)
	return arg_1_0.isWater and 2 or 1
end

function var_0_0.InTimeRiver(arg_2_0)
	return true
end

function var_0_0.InitUI(arg_3_0, arg_3_1)
	arg_3_0.comAnimator = arg_3_0._tf:Find("Image"):GetComponent(typeof(Animator))

	local var_3_0 = arg_3_0._tf:Find("Image"):GetComponent(typeof(DftAniEvent))

	var_3_0:SetTriggerEvent(function()
		arg_3_0.waterTime = arg_3_1.waterTime or 4

		return
	end)
	var_3_0:SetEndEvent(function()
		arg_3_0:Destroy()

		return
	end)

	arg_3_0.waterTime = 0

	return
end

function var_0_0.Break(arg_6_0)
	arg_6_0:DeregisterAll()
	arg_6_0.comAnimator:Play("B2")

	return
end

function var_0_0.TimeUpdate(arg_7_0, arg_7_1)
	if arg_7_0.waterTime > 0 then
		arg_7_0.waterTime = arg_7_0.waterTime - arg_7_1

		if arg_7_0.waterTime <= 0 then
			arg_7_0.comAnimator:Play("B4")
		end
	end

	return
end

return var_0_0
