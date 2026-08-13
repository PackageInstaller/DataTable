ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleCardPuzzleSkillAddBuff", var_0.Battle.BattleCardPuzzleSkillEffect)

var_0.Battle.BattleCardPuzzleSkillAddBuff = var_0_1
var_0_1.__name = "BattleCardPuzzleSkillAddBuff"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._buffID = arg_1_0._tempData.arg_list.buff_id

	return
end

function var_0_1.SkillEffectHandler(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetTarget(var_2_0)

	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
		if iter_2_1:IsAlive() then
			local var_2_2 = var_0.Battle.BattleBuffUnit.New(arg_2_0._buffID, 1, arg_2_0._caster)

			iter_2_1:AddBuff(var_2_2)
		end
	end

	arg_2_0:Finale()

	return
end

return
