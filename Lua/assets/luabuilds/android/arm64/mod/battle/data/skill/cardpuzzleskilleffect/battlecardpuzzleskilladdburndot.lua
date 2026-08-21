ys = ys or {}

local var_0_0 = class("BattleCardPuzzleSkillAddBurnDot", ys.Battle.BattleCardPuzzleSkillAddBuff)

ys.Battle.BattleCardPuzzleSkillAddBurnDot = var_0_0
var_0_0.__name = "BattleCardPuzzleSkillAddBurnDot"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._buffID = arg_1_0._tempData.arg_list.buff_id
	arg_1_0._stack_count = arg_1_0._tempData.arg_list.stack_count or 0
	arg_1_0._stack_ratio = arg_1_0._tempData.arg_list.stack_ratio or 0

	return
end

function var_0_0.SkillEffectHandler(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetTarget())) do
		if iter_2_1:IsAlive() then
			local var_2_0 = iter_2_1:GetBuff(arg_2_0._buffID)
			local var_2_1 = var_2_0 and var_2_0:GetStack() or 0
			local var_2_2 = var_0.Battle.BattleStackableBuffUnit.New(arg_2_0._buffID, 1, arg_2_0._caster, arg_2_0._stack_count + math.floor(var_2_1 * arg_2_0._stack_ratio))
			local var_2_3 = arg_2_0:GetCardPuzzleComponent():GetAttrManager()

			var_2_2:SetStackCount(var_2_3:GetCurrent("BurnStackCount"))
			var_2_2:SetUnstackCount(var_2_3:GetCurrent("BurnUnStackCount"))
			iter_2_1:AddBuff(var_2_2)
		end
	end

	arg_2_0:Finale()

	return
end

return
