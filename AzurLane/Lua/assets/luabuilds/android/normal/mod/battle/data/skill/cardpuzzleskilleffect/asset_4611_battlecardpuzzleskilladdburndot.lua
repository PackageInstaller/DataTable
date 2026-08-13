ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = "BattleCardPuzzleSkillAddBurnDot"

class = var_0_10002

local var_0_2 = var_0_10002(var_0_1, var_0.Battle.BattleCardPuzzleSkillAddBuff)

var_0.Battle[var_0_1] = var_0_2
var_0_2.__name = var_0_1

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._buffID = arg_1_0._tempData.arg_list.buff_id

	local var_1_0

	if not arg_1_0._tempData.arg_list.stack_count then
		var_1_0 = 0
	end

	arg_1_0._stack_count = var_1_0

	local var_1_1

	if not arg_1_0._tempData.arg_list.stack_ratio then
		var_1_1 = 0
	end

	arg_1_0._stack_ratio = var_1_1

	return
end

function var_0_2.SkillEffectHandler(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetTarget(var_2_0)

	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
		if iter_2_1:IsAlive() then
			local var_2_2 = arg_2_0._stack_count

			if iter_2_1:GetBuff(arg_2_0._buffID) then
				local var_2_3 = var_8
				local var_2_4

				if not var_8.GetStack(var_2_3) then
					var_2_4 = 0
				end

				math = var_2_3

				local var_2_5 = var_2_2 + var_2_3.floor(var_2_4 * arg_2_0._stack_ratio)
				local var_2_6 = var_0.Battle.BattleStackableBuffUnit.New(arg_2_0._buffID, 1, arg_2_0._caster, var_2_5)
				local var_2_7 = arg_2_0:GetCardPuzzleComponent()
				local var_2_8 = var_11.GetAttrManager(var_2_7)

				var_2_6:SetStackCount(var_2_8:GetCurrent("BurnStackCount"))
				var_2_6:SetUnstackCount(var_2_8:GetCurrent("BurnUnStackCount"))
				iter_2_1:AddBuff(var_2_6)
			end
		end
	end

	arg_2_0:Finale()

	return
end

return
