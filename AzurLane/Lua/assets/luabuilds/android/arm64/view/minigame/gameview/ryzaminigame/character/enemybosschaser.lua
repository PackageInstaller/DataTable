local var_0_0 = class("EnemyBossChaser", import("view.miniGame.gameView.RyzaMiniGame.character.EnemyChaser"))

var_0_0.WeaponName = "Laser"
var_0_0.ConfigSkillCD = 10
var_0_0.StatusOffset = setmetatable({}, {
	__index = function(arg_1_0, arg_1_1)
		return {
			0,
			0
		}
	end
})

function var_0_0.InitUI(arg_2_0, arg_2_1)
	var_0_0.super.InitUI(arg_2_0, arg_2_1)

	arg_2_0.hp = arg_2_1.hp or 4
	arg_2_0.hpMax = arg_2_0.hp
	arg_2_0.speed = arg_2_1.speed or 3
	arg_2_0.damageDic = {}

	return
end

function var_0_0.InitRegister(arg_3_0, arg_3_1)
	return
end

function var_0_0.TimeTrigger(arg_4_0, arg_4_1)
	var_0_0.super.TimeTrigger(arg_4_0, arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.responder:CollideFire(arg_4_0)) do
		if not arg_4_0.damageDic[iter_4_1] then
			arg_4_0.damageDic[iter_4_1] = true

			arg_4_0:Hurt(1)
		end
	end

	return
end

function var_0_0.GetUIHeight(arg_5_0)
	return 192
end

return var_0_0
