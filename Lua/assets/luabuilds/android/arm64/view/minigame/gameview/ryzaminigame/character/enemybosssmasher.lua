local var_0_0 = class("EnemyBossSmasher", import("view.miniGame.gameView.RyzaMiniGame.character.EnemySmasher"))

var_0_0.ConfigSkillCount = 5

function var_0_0.InitUI(arg_1_0, arg_1_1)
	var_0_0.super.InitUI(arg_1_0, arg_1_1)

	arg_1_0.hp = arg_1_1.hp or 4
	arg_1_0.hpMax = arg_1_0.hp
	arg_1_0.speed = arg_1_1.speed or 3
	arg_1_0.damageDic = {}

	return
end

function var_0_0.InitRegister(arg_2_0, arg_2_1)
	return
end

function var_0_0.TimeTrigger(arg_3_0, arg_3_1)
	var_0_0.super.TimeTrigger(arg_3_0, arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.responder:CollideFire(arg_3_0)) do
		if not arg_3_0.damageDic[iter_3_1] then
			arg_3_0.damageDic[iter_3_1] = true

			arg_3_0:Hurt(1)
		end
	end

	return
end

function var_0_0.GetUIHeight(arg_4_0)
	return 192
end

return var_0_0
