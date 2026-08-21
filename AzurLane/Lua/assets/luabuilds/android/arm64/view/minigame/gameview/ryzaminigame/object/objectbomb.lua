local var_0_0 = class("ObjectBomb", import("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function var_0_0.FirePassability(arg_1_0)
	return 0
end

function var_0_0.InTimeRiver(arg_2_0)
	return true
end

function var_0_0.InitUI(arg_3_0, arg_3_1)
	arg_3_0.cooldown = arg_3_1.cooldown or 3
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

function var_0_0.InitRegister(arg_4_0, arg_4_1)
	arg_4_0:Register("burn", function()
		arg_4_0:Burning()

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

function var_0_0.Burning(arg_6_0)
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
	arg_6_0:Calling("feedback", {}, MoveRyza)
	arg_6_0.responder:Create({
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

function var_0_0.TimeUpdate(arg_7_0, arg_7_1)
	if arg_7_0.cooldown > 0 then
		if arg_7_0.cooldown > 2.87 and arg_7_0.cooldown - arg_7_1 <= 2.87 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-blasting fuse")
		end

		arg_7_0.cooldown = arg_7_0.cooldown - arg_7_1

		if arg_7_0.cooldown <= 0 then
			arg_7_0:Burning()
		end
	end

	return
end

function var_0_0.SetHide(arg_8_0, arg_8_1)
	arg_8_0.hide = arg_8_1

	return
end

return var_0_0
