local var_0_0 = class("EnemyScavenger", import("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

function var_0_0.InitUI(arg_1_0, arg_1_1)
	var_0_0.super.InitUI(arg_1_0, arg_1_1)

	arg_1_0.hp = arg_1_1.hp or 1
	arg_1_0.hpMax = arg_1_0.hp
	arg_1_0.speed = arg_1_1.speed or 1
	arg_1_0.skillCD = 0
	arg_1_0.skillTime = 0
	arg_1_0.rate = arg_1_1.rate or 1.1

	return
end

function var_0_0.GetSpeedDis(arg_2_0)
	local var_2_0 = var_0_0.super.GetSpeedDis(arg_2_0)

	if arg_2_0.skillTime > 0 then
		local var_2_1 = arg_2_0.rate or 1

		return var_2_0 * var_2_1
	end
end

function var_0_0.PlayMove(arg_3_0, arg_3_1)
	if arg_3_0.skillTime > 0 then
		arg_3_0:PlayAnim("Move2_" .. arg_3_1)
	else
		arg_3_0:PlayAnim("Move_" .. arg_3_1)
	end

	return
end

var_0_0.loopDic = {
	Move = true,
	Move2 = true,
	Wait = true
}

function var_0_0.TimeTrigger(arg_4_0, arg_4_1)
	var_0_0.super.TimeTrigger(arg_4_0, arg_4_1)

	arg_4_0.skillCD = arg_4_0.skillCD - arg_4_1
	arg_4_0.skillTime = arg_4_0.skillTime - arg_4_1

	if not arg_4_0.lock and arg_4_0.skillCD <= 0 and arg_4_0.responder:SearchRyza(arg_4_0, arg_4_0.search) then
		arg_4_0.skillCD = 10
		arg_4_0.skillTime = 5
	end

	return
end

return var_0_0
