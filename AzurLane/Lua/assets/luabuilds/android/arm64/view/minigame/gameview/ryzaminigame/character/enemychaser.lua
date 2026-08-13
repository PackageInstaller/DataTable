class = var_0_10000

local var_0_0 = "EnemyChaser"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

var_0_1.WeaponName = "Bullet"
var_0_1.ConfigSkillCD = 10
var_0_1.StatusOffset = {
	Attack_E = {
		1,
		0
	},
	Attack_N = {
		0,
		-1
	},
	Attack_W = {
		-1,
		0
	},
	Attack_S = {
		0,
		1
	}
}

function var_0_1.InitUI(arg_1_0, arg_1_1)
	var_0_1.super.InitUI(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_1.hp then
		var_1_0 = 1
	end

	arg_1_0.hp = var_1_0
	arg_1_0.hpMax = arg_1_0.hp

	local var_1_1

	if not arg_1_1.speed then
		var_1_1 = 2
	end

	arg_1_0.speed = var_1_1
	arg_1_0.skillCD = 0

	local var_1_2 = arg_1_0.mainTarget
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10007

	local var_1_4 = var_1_3(var_1_2, var_5(var_1_10007))

	var_2.SetTriggerEvent(var_1_4, function()
		local var_2_0 = arg_1_0.StatusOffset[arg_1_0.status]
		local var_2_1 = arg_1_0.responder
		local var_2_2 = var_1.Create
		local var_2_3 = {
			name = arg_1_0.WeaponName,
			pos = {
				arg_1_0.pos.x + var_2_0[1],
				arg_1_0.pos.y + var_2_0[2]
			},
			realPos = {
				arg_1_0.realPos.x + var_2_0[1],
				arg_1_0.realPos.y + var_2_0[2]
			}
		}

		string = var_5
		var_2_3.mark = var_5.split(arg_1_0.status, "_")[2]

		var_2_2(var_2_1, var_2_3)

		return
	end)

	return
end

function var_0_1.TimeTrigger(arg_3_0, arg_3_1)
	var_0_1.super.TimeTrigger(arg_3_0, arg_3_1)

	arg_3_0.skillCD = arg_3_0.skillCD - arg_3_1

	if not arg_3_0.lock and arg_3_0.skillCD <= 0 then
		local var_3_0 = arg_3_0.responder

		if var_2.SearchRyza(var_3_0, arg_3_0, arg_3_0.search) and (arg_3_0.responder.reactorRyza.pos.x == arg_3_0.pos.x or var_2.y == arg_3_0.pos.y) then
			local var_3_1 = var_2 - arg_3_0.pos

			if var_3.SqrMagnitude(var_3_1) >= 9 then
				if (var_2 - arg_3_0.pos).x > 0 then
					arg_3_0:PlayAnim("Attack_E")
				elseif var_3.x < 0 then
					arg_3_0:PlayAnim("Attack_W")
				elseif var_3.y > 0 then
					arg_3_0:PlayAnim("Attack_S")
				elseif var_3.y < 0 then
					arg_3_0:PlayAnim("Attack_N")
				end

				arg_3_0.skillCD = arg_3_0.ConfigSkillCD
			end
		end
	end

	return
end

return var_0_1
