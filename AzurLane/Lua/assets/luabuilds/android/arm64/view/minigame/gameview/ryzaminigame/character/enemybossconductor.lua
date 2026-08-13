class = var_0_10000

local var_0_0 = "EnemyBossConductor"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.character.EnemyConductor"))

var_0_1.ConfigShildList = {
	4,
	0,
	0,
	0
}
var_0_1.BlockRange = 2

function var_0_1.InitUI(arg_1_0, arg_1_1)
	var_0_1.super.InitUI(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_1.hp then
		var_1_0 = 4
	end

	arg_1_0.hp = var_1_0
	arg_1_0.hpMax = arg_1_0.hp

	local var_1_1

	if not arg_1_1.speed then
		var_1_1 = 4
	end

	arg_1_0.speed = var_1_1
	arg_1_0.damageDic = {}

	return
end

function var_0_1.InitRegister(arg_2_0, arg_2_1)
	var_0_1.super.InitRegister(arg_2_0, arg_2_1)
	arg_2_0:Deregister("burn")

	return
end

function var_0_1.TimeTrigger(arg_3_0, arg_3_1)
	var_0_1.super.TimeTrigger(arg_3_0, arg_3_1)

	ipairs = var_2

	local var_3_0 = arg_3_0.responder

	for iter_3_0, iter_3_1 in var_2(var_4.CollideFire(var_3_0, arg_3_0)) do
		if not arg_3_0.damageDic[iter_3_1] then
			arg_3_0.damageDic[iter_3_1] = true

			arg_3_0:Hurt(1)
		end
	end

	return
end

function var_0_1.GetUIHeight(arg_4_0)
	return 192
end

return var_0_1
