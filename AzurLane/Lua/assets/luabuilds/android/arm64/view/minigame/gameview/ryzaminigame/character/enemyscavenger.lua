class = var_0_10000

local var_0_0 = "EnemyScavenger"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

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
		var_1_1 = 1
	end

	arg_1_0.speed = var_1_1
	arg_1_0.skillCD = 0
	arg_1_0.skillTime = 0

	local var_1_2

	if not arg_1_1.rate then
		var_1_2 = 1.1
	end

	arg_1_0.rate = var_1_2

	return
end

function var_0_1.GetSpeedDis(arg_2_0)
	local var_2_0 = var_0_1.super.GetSpeedDis(arg_2_0)
	local var_2_1

	if not (arg_2_0.skillTime > 0) or not arg_2_0.rate then
		var_2_1 = 1
	end

	return var_2_0 * var_2_1
end

function var_0_1.PlayMove(arg_3_0, arg_3_1)
	if arg_3_0.skillTime > 0 then
		arg_3_0:PlayAnim("Move2_" .. arg_3_1)
	else
		arg_3_0:PlayAnim("Move_" .. arg_3_1)
	end

	return
end

var_0_1.loopDic = {
	Move = true,
	Move2 = true,
	Wait = true
}

function var_0_1.TimeTrigger(arg_4_0, arg_4_1)
	var_0_1.super.TimeTrigger(arg_4_0, arg_4_1)

	arg_4_0.skillCD = arg_4_0.skillCD - arg_4_1
	arg_4_0.skillTime = arg_4_0.skillTime - arg_4_1

	if not arg_4_0.lock and arg_4_0.skillCD <= 0 then
		local var_4_0 = arg_4_0.responder

		if var_2.SearchRyza(var_4_0, arg_4_0, arg_4_0.search) then
			arg_4_0.skillCD = 10
			arg_4_0.skillTime = 5
		end
	end

	return
end

return var_0_1
