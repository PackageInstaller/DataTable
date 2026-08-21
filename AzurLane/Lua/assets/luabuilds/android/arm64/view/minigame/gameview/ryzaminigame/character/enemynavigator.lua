local var_0_0 = class("EnemyNavigator", import("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

var_0_0.SkillDistance = 7

function var_0_0.InitUI(arg_1_0, arg_1_1)
	var_0_0.super.InitUI(arg_1_0, arg_1_1)

	arg_1_0.hp = arg_1_1.hp or 2
	arg_1_0.hpMax = arg_1_0.hp
	arg_1_0.speed = arg_1_1.speed or 3
	arg_1_0.skillCD = 0
	arg_1_0.skillDis = 0
	arg_1_0.rate = arg_1_1.rate or 2

	return
end

local var_0_1 = {
	x = "y",
	y = "x"
}

function var_0_0.TimeUpdate(arg_2_0, arg_2_1)
	if arg_2_0.skillDis > 0 then
		local var_2_0 = arg_2_0.dir * (arg_2_0:GetSpeedDis() * arg_2_1 * arg_2_0.rate)
		local var_2_1 = arg_2_0.realPos - arg_2_0.pos
		local var_2_2

		if var_2_0.x ~= 0 then
			var_2_2 = "x"
		elseif var_2_0.y ~= 0 then
			var_2_2 = "y"
		else
			assert(false)
		end

		local var_2_4 = var_0_1[var_2_2]
		local var_2_5 = true
		local var_2_6 = {}

		if var_2_1[var_2_2] * (var_2_1[var_2_2] + var_2_0[var_2_2]) <= 0 then
			local var_2_8 = NewPos(arg_2_0.pos.x, arg_2_0.pos.y)

			var_2_8[var_2_2] = var_2_8[var_2_2] + (var_2_0[var_2_2] < 0 and -1 or 1)

			var_2_7(var_2_8)

			if var_2_5 and var_2_1[var_2_4] ~= 0 then
				var_2_8[var_2_4] = var_2_8[var_2_4] + (var_2_1[var_2_4] < 0 and -1 or 1)

				var_2_7(var_2_8)
			end
		end

		if var_2_5 then
			for iter_2_0, iter_2_1 in ipairs({}) do
				arg_2_0:Calling("break", {}, iter_2_1)
			end

			arg_2_0.skillDis = arg_2_0.skillDis - math.abs(var_2_0[var_2_2])
		end

		if not var_2_5 or arg_2_0.skillDis <= 0 then
			var_2_0[var_2_2] = -var_2_1[var_2_2]
			arg_2_0.skillDis = 0

			arg_2_0:PlayAnim("Attack3_" .. arg_2_0.assaultMark)
		end

		arg_2_0:MoveUpdate(var_2_0)
		arg_2_0:TimeTrigger(arg_2_1)
	else
		var_0_0.super.TimeUpdate(arg_2_0, arg_2_1)
	end

	return
end

local var_0_3 = {
	S = {
		0,
		1
	},
	E = {
		1,
		0
	},
	N = {
		0,
		-1
	},
	W = {
		-1,
		0
	}
}

function var_0_0.TimeTrigger(arg_4_0, arg_4_1)
	var_0_0.super.TimeTrigger(arg_4_0, arg_4_1)

	arg_4_0.skillCD = arg_4_0.skillCD - arg_4_1

	if not arg_4_0.lock and arg_4_0.skillCD <= 0 and arg_4_0.responder:SearchRyza(arg_4_0, arg_4_0.search) and (arg_4_0.pos.x - arg_4_0.responder.reactorRyza.pos.x) * (arg_4_0.pos.y - arg_4_0.responder.reactorRyza.pos.y) == 0 then
		arg_4_0.skillCD = 10
		arg_4_0.skillDis = arg_4_0.SkillDistance
		arg_4_0.assaultMark = string.split(arg_4_0.status, "_")[2]
		arg_4_0.dir = NewPos(unpack(var_0_3[arg_4_0.assaultMark]))

		arg_4_0:PlayAnim("Attack1_" .. arg_4_0.assaultMark)
	end

	return
end

return var_0_0
