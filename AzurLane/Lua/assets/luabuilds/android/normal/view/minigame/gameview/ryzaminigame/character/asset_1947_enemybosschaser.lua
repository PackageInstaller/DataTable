class = var_0_10000

local var_0_0 = "EnemyBossChaser"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.gameView.RyzaMiniGame.character.EnemyChaser"))

var_0_1.WeaponName = "Laser"
var_0_1.ConfigSkillCD = 10
setmetatable = var_1
var_0_1.StatusOffset = var_1({}, {
	__index = function(arg_1_0, arg_1_1)
		return {
			0,
			0
		}
	end
})

function var_0_1.InitUI(arg_2_0, arg_2_1)
	var_0_1.super.InitUI(arg_2_0, arg_2_1)

	local var_2_0

	if not arg_2_1.hp then
		var_2_0 = 4
	end

	arg_2_0.hp = var_2_0
	arg_2_0.hpMax = arg_2_0.hp

	local var_2_1

	if not arg_2_1.speed then
		var_2_1 = 3
	end

	arg_2_0.speed = var_2_1
	arg_2_0.damageDic = {}

	return
end

function var_0_1.InitRegister(arg_3_0, arg_3_1)
	return
end

function var_0_1.TimeTrigger(arg_4_0, arg_4_1)
	var_0_1.super.TimeTrigger(arg_4_0, arg_4_1)

	ipairs = var_2

	local var_4_0 = arg_4_0.responder

	for iter_4_0, iter_4_1 in var_2(var_3.CollideFire(var_4_0, arg_4_0)) do
		if not arg_4_0.damageDic[iter_4_1] then
			arg_4_0.damageDic[iter_4_1] = true

			arg_4_0:Hurt(1)
		end
	end

	return
end

function var_0_1.GetUIHeight(arg_5_0)
	return 192
end

return var_0_1
