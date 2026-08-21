local var_0_0 = class("EnemyChaser", import("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

var_0_0.WeaponName = "Bullet"
var_0_0.ConfigSkillCD = 10
var_0_0.StatusOffset = {
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

function var_0_0.InitUI(arg_1_0, arg_1_1)
	var_0_0.super.InitUI(arg_1_0, arg_1_1)

	arg_1_0.hp = arg_1_1.hp or 1
	arg_1_0.hpMax = arg_1_0.hp
	arg_1_0.speed = arg_1_1.speed or 2
	arg_1_0.skillCD = 0

	arg_1_0.mainTarget:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		arg_1_0.responder:Create({
			name = arg_1_0.WeaponName,
			pos = {
				arg_1_0.pos.x + arg_1_0.StatusOffset[arg_1_0.status][1],
				arg_1_0.pos.y + arg_1_0.StatusOffset[arg_1_0.status][2]
			},
			realPos = {
				arg_1_0.realPos.x + arg_1_0.StatusOffset[arg_1_0.status][1],
				arg_1_0.realPos.y + arg_1_0.StatusOffset[arg_1_0.status][2]
			},
			mark = string.split(arg_1_0.status, "_")[2]
		})

		return
	end)

	return
end

function var_0_0.TimeTrigger(arg_3_0, arg_3_1)
	var_0_0.super.TimeTrigger(arg_3_0, arg_3_1)

	arg_3_0.skillCD = arg_3_0.skillCD - arg_3_1

	if not arg_3_0.lock and arg_3_0.skillCD <= 0 and arg_3_0.responder:SearchRyza(arg_3_0, arg_3_0.search) then
		if (arg_3_0.responder.reactorRyza.pos.x == arg_3_0.pos.x or arg_3_0.responder.reactorRyza.pos.y == arg_3_0.pos.y) and (arg_3_0.responder.reactorRyza.pos - arg_3_0.pos):SqrMagnitude() >= 9 then
			if (arg_3_0.responder.reactorRyza.pos - arg_3_0.pos).x > 0 then
				arg_3_0:PlayAnim("Attack_E")
			elseif (arg_3_0.responder.reactorRyza.pos - arg_3_0.pos).x < 0 then
				arg_3_0:PlayAnim("Attack_W")
			elseif (arg_3_0.responder.reactorRyza.pos - arg_3_0.pos).y > 0 then
				arg_3_0:PlayAnim("Attack_S")
			elseif (arg_3_0.responder.reactorRyza.pos - arg_3_0.pos).y < 0 then
				arg_3_0:PlayAnim("Attack_N")
			end

			arg_3_0.skillCD = arg_3_0.ConfigSkillCD
		end
	end

	return
end

return var_0_0
