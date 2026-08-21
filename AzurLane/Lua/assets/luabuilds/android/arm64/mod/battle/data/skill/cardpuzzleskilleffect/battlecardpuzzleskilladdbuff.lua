ys = ys or {}

local var_0_0 = class("BattleCardPuzzleSkillAddBuff", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillAddBuff = var_0_0
var_0_0.__name = "BattleCardPuzzleSkillAddBuff"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._buffID = arg_1_0._tempData.arg_list.buff_id

	return
end

function var_0_0.SkillEffectHandler(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetTarget())) do
		if iter_2_1:IsAlive() then
			iter_2_1:AddBuff((var_0.Battle.BattleBuffUnit.New(arg_2_0._buffID, 1, arg_2_0._caster)))
		end
	end

	arg_2_0:Finale()

	return
end

return
