class = var_0_10000

local var_0_0 = "TargetItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.Reactor"))
local var_0_2 = {
	hp1 = "4",
	speed = "3",
	spirit = "6",
	power = "2",
	bomb = "1",
	hp2 = "5"
}

function var_0_1.InitUI(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.type

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "Image")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Animator = var_1_10005

	local var_1_3 = var_1_2(var_1_1, var_4(var_1_10005))

	var_2.Play(var_1_3, var_0_2[arg_1_0.type])

	setActive = var_2

	local var_1_4 = arg_1_0._tf

	var_2(var_3.Find(var_1_4, "Burn"), false)

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_2.Find(var_1_5, "Burn")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5

	local var_1_8 = var_1_7(var_1_6, var_4(var_5))

	var_2.SetEndEvent(var_1_8, function()
		local var_2_0 = arg_1_0

		var_0.Destroy(var_2_0, false)

		return
	end)

	eachChild = var_2

	local var_1_9 = arg_1_0._tf

	var_2(var_3.Find(var_1_9, "front"), function(arg_3_0)
		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.GetComponent

		typeof = var_2_10003
		DftAniEvent = var_2_10004

		local var_3_2 = var_3_1(var_3_0, var_2_10003(var_2_10004))

		var_1.SetEndEvent(var_3_2, function()
			setActive = var_3_10000

			var_3_10000(arg_3_0, false)

			return
		end)

		setActive = var_1

		var_1(arg_3_0, arg_3_0.name == arg_1_1.drop)

		return
	end)

	return
end

function var_0_1.InitRegister(arg_5_0, arg_5_1)
	arg_5_0:Register("move", function(arg_6_0)
		isa = var_2_10001

		local var_6_0 = arg_6_0

		MoveRyza = var_2_10003

		if var_2_10001(var_6_0, var_2_10003) then
			arg_6_0:AddItem(arg_5_0.type)

			local var_6_1 = arg_5_0

			var_1.Destroy(var_6_1)
		else
			local var_6_2 = arg_5_0

			var_1.Destroy(var_6_2, false)
		end

		return
	end, {
		{
			0,
			0
		}
	})
	arg_5_0:Register("burn", function()
		local var_7_0 = arg_5_0

		var_0.DeregisterAll(var_7_0)

		setActive = var_0

		local var_7_1 = arg_5_0._tf

		var_0(var_1.Find(var_7_1, "Image"), false)

		setActive = var_0

		local var_7_2 = arg_5_0._tf

		var_0(var_1.Find(var_7_2, "Burn"), true)

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
