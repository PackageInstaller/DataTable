ys = ys or {}
ys.Battle.BattleBuffOverHealingShield = class("BattleBuffOverHealingShield", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffOverHealingShield.__name = "BattleBuffOverHealingShield"

local var_0_0 = ys.Battle.BattleBuffOverHealingShield

function ys.Battle.BattleBuffOverHealingShield.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffOverHealingShield.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._shieldDuration = arg_2_0._tempData.arg_list.shield_duration
	arg_2_0._shieldRate = arg_2_0._tempData.arg_list.shield_rate
	arg_2_0._shieldLabel = arg_2_0._tempData.arg_list.shield_tag_list or {}
	arg_2_0._shieldList = {}

	return
end

function ys.Battle.BattleBuffOverHealingShield.onOverHealing(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = math.ceil(arg_3_3.overHealing * arg_3_0._shieldRate)

	if var_3_0 > 0 then
		table.insert(arg_3_0._shieldList, {
			timeStamp = pg.TimeMgr.GetInstance():GetCombatTime(),
			value = var_3_0
		})
	end

	arg_3_0:updateLabelTag(arg_3_1)

	return
end

function ys.Battle.BattleBuffOverHealingShield.onUpdate(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = pg.TimeMgr.GetInstance():GetCombatTime() - arg_4_0._shieldDuration

	while #arg_4_0._shieldList > 0 do
		if var_4_0 >= arg_4_0._shieldList[#arg_4_0._shieldList].timeStamp then
			table.remove(arg_4_0._shieldList, #arg_4_0._shieldList)
		end
	end

	arg_4_0:updateLabelTag(arg_4_1)

	return
end

function ys.Battle.BattleBuffOverHealingShield.onTakeDamage(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0:damageCheck(arg_5_3) and #arg_5_0._shieldList > 0 then
		local var_5_0 = arg_5_3.damage
		local var_5_1 = 0

		while var_5_0 > 0 and var_5_1 < #arg_5_0._shieldList do
			var_5_1 = var_5_1 + 1

			if var_5_0 <= arg_5_0._shieldList[var_5_1].value then
				arg_5_0._shieldList[var_5_1].value = arg_5_0._shieldList[var_5_1].value - var_5_0
				var_5_0 = 0
			else
				var_5_0 = var_5_0 - arg_5_0._shieldList[var_5_1].value
				arg_5_0._shieldList[var_5_1].value = 0
			end
		end

		arg_5_3.damage = var_5_0

		while #arg_5_0._shieldList > 0 do
			if arg_5_0._shieldList[#arg_5_0._shieldList].value <= 0 then
				table.remove(arg_5_0._shieldList, #arg_5_0._shieldList)
			end
		end

		arg_5_0:updateLabelTag(arg_5_1)
	end

	return
end

function ys.Battle.BattleBuffOverHealingShield.updateLabelTag(arg_6_0, arg_6_1)
	if #arg_6_0._shieldList <= 0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._shieldLabel) do
			arg_6_1:RemoveLabelTag(iter_6_1)
		end
	elseif not arg_6_1:ContainsLabelTag(arg_6_0._shieldLabel) then
		for iter_6_2, iter_6_3 in ipairs(arg_6_0._shieldLabel) do
			arg_6_1:AddLabelTag(iter_6_3)
		end
	end

	return
end

return
