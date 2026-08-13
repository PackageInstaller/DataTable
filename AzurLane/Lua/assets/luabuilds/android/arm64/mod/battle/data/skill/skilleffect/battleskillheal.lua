ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSkillHeal = var_0_10002("BattleSkillHeal", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillHeal.__name = "BattleSkillHeal"

function var_0.Battle.BattleSkillHeal.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0.Battle.BattleSkillHeal.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006)

	local var_1_3

	if not arg_1_0._tempData.arg_list.number then
		var_1_3 = 0
	end

	arg_1_0._number = var_1_3

	local var_1_4

	if not arg_1_0._tempData.arg_list.maxHPRatio then
		var_1_4 = 0
	end

	arg_1_0._maxHPRatio = var_1_4
	arg_1_0._incorruptible = arg_1_0._tempData.arg_list.incorrupt

	return
end

function var_0.Battle.BattleSkillHeal.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.GetAttrByName(var_2_0, "healingEnhancement") + 1
	local var_2_2 = var_0.Battle.BattleFormulas.HealFixer
	local var_2_3 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_2_4 = var_2_2(var_6.GetInitData(var_2_3).battleType, arg_2_2:GetAttr())

	math = var_2_0

	local var_2_5 = var_2_0.floor(arg_2_0._number * var_2_4)
	local var_2_6 = arg_2_1:GetAttrByName("healingRate")

	math = var_7

	local var_2_7 = var_7.max
	local var_2_8 = 0

	math = var_1_10010

	local var_2_9 = var_2_7(var_2_8, var_1_10010.floor((arg_2_2:GetMaxHP() * arg_2_0._maxHPRatio + var_2_5) * var_2_1 * var_2_6))
	local var_2_10 = {
		isMiss = false,
		isCri = false,
		isHeal = true,
		incorrupt = arg_2_0._incorruptible
	}

	arg_2_2:UpdateHP(var_2_9, var_2_10)

	return
end

return
