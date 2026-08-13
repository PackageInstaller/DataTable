class = var_0_10000

local var_0_0 = "ObjectBomb"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function var_0_1.FirePassability(arg_1_0)
	return 0
end

function var_0_1.InTimeRiver(arg_2_0)
	return true
end

function var_0_1.InitUI(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_1.cooldown then
		var_3_0 = 3
	end

	arg_3_0.cooldown = var_3_0
	arg_3_0.power = arg_3_1.power

	arg_3_0:Calling("move", {
		arg_3_0
	}, {
		{
			0,
			0
		}
	})

	return
end

function var_0_1.InitRegister(arg_4_0, arg_4_1)
	arg_4_0:Register("burn", function()
		local var_5_0 = arg_4_0

		var_0.Burning(var_5_0)

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

function var_0_1.Burning(arg_6_0)
	if arg_6_0.burst then
		return
	else
		arg_6_0.burst = true
	end

	arg_6_0.cooldown = 0

	arg_6_0:DeregisterAll()
	arg_6_0:Calling("leave", {
		arg_6_0
	}, {
		{
			0,
			0
		}
	})

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.Calling
	local var_6_2 = "feedback"
	local var_6_3 = {}

	MoveRyza = var_5

	var_6_1(var_6_0, var_6_2, var_6_3, var_5)

	local var_6_4 = arg_6_0.responder

	var_1.Create(var_6_4, {
		name = "Fire",
		pos = {
			arg_6_0.pos.x,
			arg_6_0.pos.y
		},
		power = arg_6_0.power
	})
	arg_6_0:Destroy()

	return
end

function var_0_1.TimeUpdate(arg_7_0, arg_7_1)
	if arg_7_0.cooldown > 0 then
		if arg_7_0.cooldown > 2.87 and arg_7_0.cooldown - arg_7_1 <= 2.87 then
			pg = var_2

			local var_7_0 = var_2.CriMgr.GetInstance()

			var_2.PlaySoundEffect_V3(var_7_0, "ui-ryza-minigame-blasting fuse")
		end

		arg_7_0.cooldown = arg_7_0.cooldown - arg_7_1

		if arg_7_0.cooldown <= 0 then
			arg_7_0:Burning()
		end
	end

	return
end

function var_0_1.SetHide(arg_8_0, arg_8_1)
	arg_8_0.hide = arg_8_1

	return
end

return var_0_1
