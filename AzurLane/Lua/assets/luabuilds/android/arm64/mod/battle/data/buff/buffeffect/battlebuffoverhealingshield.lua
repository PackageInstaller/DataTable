ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffOverHealingShield = var_0_10002("BattleBuffOverHealingShield", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffOverHealingShield.__name = "BattleBuffOverHealingShield"

local var_0_2 = var_0.Battle.BattleBuffOverHealingShield

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._tempData.arg_list

	arg_2_0._shieldDuration = arg_2_0._tempData.arg_list.shield_duration
	arg_2_0._shieldRate = arg_2_0._tempData.arg_list.shield_rate

	local var_2_1

	if not arg_2_0._tempData.arg_list.shield_tag_list then
		var_2_1 = {}
	end

	arg_2_0._shieldLabel = var_2_1
	arg_2_0._shieldList = {}

	return
end

function var_0_2.onOverHealing(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3.overHealing

	math = var_1_10005

	local var_3_1 = var_1_10005.ceil(var_3_0 * arg_3_0._shieldRate)

	if 0 < var_3_1 then
		pg = var_6

		local var_3_2 = var_6.TimeMgr.GetInstance()
		local var_3_3 = var_6.GetCombatTime(var_3_2)

		table = var_7

		var_7.insert(arg_3_0._shieldList, {
			timeStamp = var_3_3,
			value = var_3_1
		})
	end

	arg_3_0:updateLabelTag(arg_3_1)

	return
end

function var_0_2.onUpdate(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = #arg_4_0._shieldList

	pg = var_1_10004

	local var_4_1 = var_1_10004.TimeMgr.GetInstance()
	local var_4_2 = var_4.GetCombatTime(var_4_1) - arg_4_0._shieldDuration

	while var_4_0 > 0 do
		if arg_4_0._shieldList[var_4_0].timeStamp <= var_4_2 then
			table = var_6

			var_6.remove(arg_4_0._shieldList, var_4_0)
		end

		var_4_0 = var_4_0 - 1
	end

	arg_4_0:updateLabelTag(arg_4_1)

	return
end

function var_0_2.onTakeDamage(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = #arg_5_0._shieldList

	if arg_5_0:damageCheck(arg_5_3) and var_5_0 > 0 then
		local var_5_1 = arg_5_3.damage
		local var_5_2 = 0

		while var_5_1 > 0 and var_5_2 < var_5_0 do
			var_5_2 = var_5_2 + 1

			if var_5_1 <= arg_5_0._shieldList[var_5_2].value then
				arg_5_0._shieldList[var_5_2].value = var_7 - var_5_1
				var_5_1 = 0
			else
				var_5_1 = var_5_1 - var_7
				arg_5_0._shieldList[var_5_2].value = 0
			end
		end

		arg_5_3.damage = var_5_1

		while var_5_0 > 0 do
			if arg_5_0._shieldList[var_5_0].value <= 0 then
				table = var_7

				var_7.remove(arg_5_0._shieldList, var_5_0)
			end

			var_5_0 = var_5_0 - 1
		end

		arg_5_0:updateLabelTag(arg_5_1)
	end

	return
end

function var_0_2.updateLabelTag(arg_6_0, arg_6_1)
	if #arg_6_0._shieldList <= 0 then
		ipairs = var_2

		for iter_6_0, iter_6_1 in var_2(arg_6_0._shieldLabel) do
			arg_6_1:RemoveLabelTag(iter_6_1)
		end
	elseif not arg_6_1:ContainsLabelTag(arg_6_0._shieldLabel) then
		ipairs = var_2

		for iter_6_2, iter_6_3 in var_2(arg_6_0._shieldLabel) do
			arg_6_1:AddLabelTag(iter_6_3)
		end
	end

	return
end

return
