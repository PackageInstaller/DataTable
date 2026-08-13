ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleCardPuzzleFormulas

class = var_0_10002

local var_0_2 = var_0_10002("BattleCardPuzzleFleetBuffAddFleetAttr", var_0.Battle.BattleFleetBuffEffect)

var_0.Battle.BattleCardPuzzleFleetBuffAddFleetAttr = var_0_2
var_0_2.__name = "BattleCardPuzzleFleetBuffAddFleetAttr"
var_0_2.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR

function var_0_2.Ctor(arg_1_0, arg_1_1)
	Clone = var_1_10002
	arg_1_0._tempData = var_1_10002(arg_1_1)
	arg_1_0._type = arg_1_0._tempData.type

	arg_1_0:SetActive()

	return
end

function var_0_2.GetEffectType(arg_2_0)
	return var_0_2.FX_TYPE
end

function var_0_2.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	var_0_2.super.SetArgs(arg_3_0, arg_3_1, arg_3_2)

	local var_3_1

	if not arg_3_0._tempData.arg_list.group then
		local var_3_0 = arg_3_0._fleetBuff

		var_3_1 = var_3.GetID(var_3_0)
	end

	arg_3_0._group = var_3_1
	arg_3_0._attr = arg_3_0._tempData.arg_list.attr
	arg_3_0._number = arg_3_0._tempData.arg_list.number

	if arg_3_0._tempData.arg_list.enhance_formula then
		local var_3_2 = arg_3_0._tempData.arg_list.enhance_formula

		arg_3_0._number = var_0_1.parseFormula(var_3_2, arg_3_1:GetAttrManager()) + arg_3_0._number
	end

	arg_3_0._cache = arg_3_0._tempData.arg_list.maintain
	arg_3_0._numberBase = arg_3_0._number

	return
end

function var_0_2.onRemove(arg_4_0)
	if arg_4_0._cache then
		arg_4_0._number = 0
	end

	arg_4_0:onTrigger()

	return
end

function var_0_2.GetGroup(arg_5_0)
	return arg_5_0._group
end

function var_0_2.GetNumber(arg_6_0)
	local var_6_0 = arg_6_0._number
	local var_6_1 = arg_6_0._fleetBuff

	return var_6_0 * var_2.GetStack(var_6_1)
end

function var_0_2.IsSameAttr(arg_7_0, arg_7_1)
	return arg_7_0._attr == arg_7_1
end

function var_0_2.onTrigger(arg_8_0)
	local var_8_0 = arg_8_0._cardPuzzleComponent

	if arg_8_0._cache then
		local var_8_1 = var_8_0:GetBuffManager()
		local var_8_2 = var_2.GetCardPuzzleBuffList(var_8_1)
		local var_8_3 = 0
		local var_8_4 = 0
		local var_8_5 = {}
		local var_8_6 = {}

		pairs = var_1_10007

		for iter_8_0, iter_8_1 in var_1_10007(var_8_2) do
			ipairs = var_1_10012

			for iter_8_2, iter_8_3 in var_1_10012(iter_8_1._effectList) do
				if iter_8_3:GetEffectType() == var_0_2.FX_TYPE and iter_8_3:IsSameAttr(arg_8_0._attr) then
					local var_8_7 = iter_8_3:GetNumber()
					local var_8_8

					if not var_8_5[iter_8_3:GetGroup()] then
						var_8_8 = 0
					end

					local var_8_9

					if not var_8_6[var_18] then
						var_8_9 = 0
					end

					if var_8_8 < var_8_7 and var_8_7 > 0 then
						var_8_3 = var_8_3 + var_8_7 - var_8_8
						var_8_8 = var_8_7
					end

					if var_8_7 < var_8_9 and var_8_7 < 0 then
						var_8_4 = var_8_4 + var_8_7 - var_8_9
						var_8_9 = var_8_7
					end

					var_8_5[var_18] = var_8_8
					var_8_6[var_18] = var_8_9
				end
			end
		end

		local var_8_10 = var_8_3 + var_8_4

		var_8_0:UpdateAttrByBuff(arg_8_0._attr, var_8_10)
	else
		var_8_0:AddAttrBySkill(arg_8_0._attr, arg_8_0:GetNumber())
	end

	return
end

return
