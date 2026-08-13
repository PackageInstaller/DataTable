class = var_0_10000

local var_0_0 = "EffectBullet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function var_0_1.GetBaseOrder(arg_1_0)
	if arg_1_0.mark == "N" then
		return var_0_1.super.GetBaseOrder(arg_1_0)
	else
		return 500
	end

	return
end

function var_0_1.InTimeRiver(arg_2_0)
	return true
end

local var_0_2 = {
	S = {
		0,
		1
	},
	N = {
		0,
		-1
	},
	E = {
		1,
		0
	},
	W = {
		-1,
		0
	}
}

function var_0_1.InitUI(arg_3_0, arg_3_1)
	arg_3_0.mark = arg_3_1.mark

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_2.Find(var_3_0, "Image")
	local var_3_2 = var_2.GetComponent

	typeof = var_5
	Animator = var_1_10007

	local var_3_3 = var_3_2(var_3_1, var_5(var_1_10007))

	var_2.Play(var_3_3, "Bullet_" .. arg_3_0.mark)

	NewPos = var_2
	unpack = var_3_3
	arg_3_0.dir = var_2(var_3_3(var_0_2[arg_3_0.mark]))

	return
end

function var_0_1.GetSpeedDis(arg_4_0)
	return 2
end

function var_0_1.TimeUpdate(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.dir * arg_5_0:GetSpeedDis() * arg_5_1
	local var_5_1 = arg_5_0.responder

	if not var_3.InRange(var_5_1, arg_5_0.realPos + var_5_0) then
		arg_5_0:Destroy()

		return
	end

	arg_5_0:MoveUpdate(var_5_0)
	arg_5_0:TimeTrigger(arg_5_1)

	return
end

function var_0_1.MoveUpdate(arg_6_0, arg_6_1)
	if arg_6_1.x == 0 and arg_6_1.y == 0 then
		return arg_6_1
	end

	arg_6_0.realPos = arg_6_0.realPos + arg_6_1

	arg_6_0:UpdatePosition()

	local var_6_0 = arg_6_0.realPos - arg_6_0.pos + arg_6_1

	math = var_3

	if not (var_3.abs(var_6_0.x) >= 0.5) then
		math = var_3

		if var_3.abs(var_6_0.y) >= 0.5 then
			math = var_3
			var_6_0.x = var_3.abs(var_6_0.x) < 0.5 and 0 or var_6_0.x < 0 and -1 or 1
			math = var_3
			var_6_0.y = var_3.abs(var_6_0.y) < 0.5 and 0 or var_6_0.y < 0 and -1 or 1

			arg_6_0:UpdatePos(arg_6_0.pos + var_6_0)
		end

		return
	end
end

function var_0_1.UpdatePos(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.responder

	var_2.UpdatePos(var_7_0, arg_7_0, arg_7_1)
	var_0_1.super.UpdatePos(arg_7_0, arg_7_1)

	return
end

function var_0_1.TimeTrigger(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.responder

	if var_2.CollideRyza(var_8_0, arg_8_0) then
		local var_8_1 = arg_8_0
		local var_8_2 = arg_8_0.Calling
		local var_8_3 = "hit"
		local var_8_4 = {
			1,
			arg_8_0.realPos
		}

		MoveRyza = var_7

		var_8_2(var_8_1, var_8_3, var_8_4, var_7)
		arg_8_0:Destroy()
	end

	return
end

function var_0_1.GetCollideRange(arg_9_0)
	local var_9_0 = {
		{
			-0.1875,
			0.1875
		},
		{
			-0.1875,
			0.1875
		}
	}

	if arg_9_0.dir.x < 0 then
		var_9_0[1] = {
			-0.5,
			0.25
		}
	elseif arg_9_0.dir.x > 0 then
		var_9_0[1] = {
			-0.25,
			0.5
		}
	elseif arg_9_0.dir.y < 0 then
		var_9_0[2] = {
			-0.5,
			0.25
		}
	elseif arg_9_0.dir.y > 0 then
		var_9_0[1] = {
			-0.25,
			0.5
		}
	else
		assert = var_2

		var_2(false)
	end

	return {
		var_9_0
	}
end

return var_0_1
