class = var_0_10000

local var_0_0 = "EnemyNavigator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

var_0_1.SkillDistance = 7

function var_0_1.InitUI(arg_1_0, arg_1_1)
	var_0_1.super.InitUI(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_1.hp then
		var_1_0 = 2
	end

	arg_1_0.hp = var_1_0
	arg_1_0.hpMax = arg_1_0.hp

	local var_1_1

	if not arg_1_1.speed then
		var_1_1 = 3
	end

	arg_1_0.speed = var_1_1
	arg_1_0.skillCD = 0
	arg_1_0.skillDis = 0

	local var_1_2

	if not arg_1_1.rate then
		var_1_2 = 2
	end

	arg_1_0.rate = var_1_2

	return
end

local var_0_2 = {
	x = "y",
	y = "x"
}

function var_0_1.TimeUpdate(arg_2_0, arg_2_1)
	if arg_2_0.skillDis > 0 then
		local var_2_0 = arg_2_0:GetSpeedDis() * arg_2_1 * arg_2_0.rate
		local var_2_1 = arg_2_0.dir * var_2_0
		local var_2_2 = arg_2_0.realPos - arg_2_0.pos
		local var_2_3
		local var_2_4

		if var_2_1.x ~= 0 then
			var_2_3 = "x"
		elseif var_2_1.y ~= 0 then
			var_2_3 = "y"
		else
			assert = var_7

			var_7(false)
		end

		local var_2_5 = var_0_2[var_2_3]
		local var_2_6 = true
		local var_2_7 = {}

		local function var_2_8(arg_3_0)
			local var_3_0 = arg_2_0.responder
			local var_3_1, var_3_2 = var_1.GetCellPassability(var_3_0, arg_3_0)

			if not var_3_1 then
				if var_3_2 then
					isa = var_3_0

					local var_3_3 = var_3_2

					ObjectBreakable = var_2_10006

					if var_3_0(var_3_3, var_2_10006) then
						table = var_3

						var_3.insert(var_2_7, var_3_2)

						goto label_3_0
					end
				end

				var_2_6 = false
			end

			::label_3_0::

			return
		end

		if var_2_2[var_2_3] * (var_2_2[var_2_3] + var_2_1[var_2_3]) <= 0 then
			NewPos = var_10
			var_10[var_2_3] = var_10(arg_2_0.pos.x, arg_2_0.pos.y)[var_2_3] + (var_2_1[var_2_3] < 0 and -1 or 1)

			var_2_8(var_10)

			if var_2_6 and var_2_2[var_2_5] ~= 0 then
				var_10[var_2_5] = var_10[var_2_5] + (var_2_2[var_2_5] < 0 and -1 or 1)

				var_2_8(var_10)
			end
		end

		if var_2_6 then
			ipairs = var_10

			for iter_2_0, iter_2_1 in var_10(var_2_7) do
				arg_2_0:Calling("break", {}, iter_2_1)
			end

			local var_2_9 = arg_2_0.skillDis

			math = var_11
			arg_2_0.skillDis = var_2_9 - var_11.abs(var_2_1[var_2_3])
		end

		if not var_2_6 or arg_2_0.skillDis <= 0 then
			var_2_1[var_2_3] = -var_2_2[var_2_3]
			arg_2_0.skillDis = 0

			arg_2_0:PlayAnim("Attack3_" .. arg_2_0.assaultMark)
		end

		arg_2_0:MoveUpdate(var_2_1)
		arg_2_0:TimeTrigger(arg_2_1)
	else
		var_0_1.super.TimeUpdate(arg_2_0, arg_2_1)
	end

	return
end

local var_0_3 = {
	["0_1"] = "S",
	["0_-1"] = "N",
	["-1_0"] = "W",
	["1_0"] = "E"
}
local var_0_4 = {
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

function var_0_1.TimeTrigger(arg_4_0, arg_4_1)
	var_0_1.super.TimeTrigger(arg_4_0, arg_4_1)

	arg_4_0.skillCD = arg_4_0.skillCD - arg_4_1

	if not arg_4_0.lock and arg_4_0.skillCD <= 0 then
		local var_4_0 = arg_4_0.responder

		if var_2.SearchRyza(var_4_0, arg_4_0, arg_4_0.search) then
			local var_4_1 = arg_4_0.responder.reactorRyza.pos

			if (arg_4_0.pos.x - var_4_1.x) * (arg_4_0.pos.y - var_4_1.y) == 0 then
				arg_4_0.skillCD = 10
				arg_4_0.skillDis = arg_4_0.SkillDistance
				string = var_3
				arg_4_0.assaultMark = var_3.split(arg_4_0.status, "_")[2]
				NewPos = var_3
				unpack = var_5
				arg_4_0.dir = var_3(var_5(var_0_4[arg_4_0.assaultMark]))

				arg_4_0:PlayAnim("Attack1_" .. arg_4_0.assaultMark)
			end
		end
	end

	return
end

return var_0_1
