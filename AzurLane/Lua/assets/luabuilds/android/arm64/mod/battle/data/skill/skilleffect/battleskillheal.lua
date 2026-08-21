ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSkillHeal = class("BattleSkillHeal", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillHeal.__name = "BattleSkillHeal"

function ys.Battle.BattleSkillHeal.Ctor(arg_1_0, arg_1_1)
	var_0_0.Battle.BattleSkillHeal.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._number = arg_1_0._tempData.arg_list.number or 0
	arg_1_0._maxHPRatio = arg_1_0._tempData.arg_list.maxHPRatio or 0
	arg_1_0._incorruptible = arg_1_0._tempData.arg_list.incorrupt

	return
end

function ys.Battle.BattleSkillHeal.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:UpdateHP(math.max(0, math.floor((arg_2_2:GetMaxHP() * arg_2_0._maxHPRatio + math.floor(arg_2_0._number * var_0_0.Battle.BattleFormulas.HealFixer(var_0_0.Battle.BattleDataProxy.GetInstance():GetInitData().battleType, arg_2_2:GetAttr()))) * (arg_2_1:GetAttrByName("healingEnhancement") + 1) * arg_2_1:GetAttrByName("healingRate"))), {
		isMiss = false,
		isCri = false,
		isHeal = true,
		incorrupt = arg_2_0._incorruptible
	})

	return
end

return
