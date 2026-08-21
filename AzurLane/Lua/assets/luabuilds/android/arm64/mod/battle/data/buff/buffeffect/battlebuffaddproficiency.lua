ys = ys or {}

local var_0_0 = class("BattleBuffAddProficiency", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddProficiency = var_0_0
var_0_0.__name = "BattleBuffAddProficiency"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._group = arg_2_0._tempData.arg_list.group or arg_2_2:GetID()
	arg_2_0._weaponLabelList = arg_2_0._tempData.arg_list.label or {}
	arg_2_0._weaponIndexList = arg_2_0._tempData.arg_list.index
	arg_2_0._number = arg_2_0._tempData.arg_list.number
	arg_2_0._numberBase = arg_2_0._number

	return
end

function var_0_0.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:calcEnhancement(arg_3_1)

	return
end

function var_0_0.onStack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:resetEnhancement(arg_4_1)

	arg_4_0._number = arg_4_0._numberBase * arg_4_2._stack

	arg_4_0:calcEnhancement(arg_4_1)

	return
end

function var_0_0.onRemove(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:resetEnhancement(arg_5_1)

	return
end

function var_0_0.calcEnhancement(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs((arg_6_1:GetAllWeapon())) do
		local var_6_0 = 1
		local var_6_1 = iter_6_1:GetEquipmentLabel()

		for iter_6_2, iter_6_3 in ipairs(arg_6_0._weaponLabelList) do
			if not table.contains(var_6_1, iter_6_3) then
				var_6_0 = 0

				break
			end
		end

		if arg_6_0._weaponIndexList and not table.contains(arg_6_0._weaponIndexList, (iter_6_1:GetEquipmentIndex())) then
			var_6_0 = var_6_0 * 0
		end

		if var_6_0 == 1 then
			iter_6_1:SetPotentialFactor(iter_6_1:GetPotential() + arg_6_0._number)
		end
	end

	return
end

function var_0_0.resetEnhancement(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs((arg_7_1:GetAllWeapon())) do
		local var_7_0 = 1
		local var_7_1 = iter_7_1:GetEquipmentLabel()

		for iter_7_2, iter_7_3 in ipairs(arg_7_0._weaponLabelList) do
			if not table.contains(var_7_1, iter_7_3) then
				var_7_0 = 0

				break
			end
		end

		if arg_7_0._weaponIndexList and not table.contains(arg_7_0._weaponIndexList, (iter_7_1:GetEquipmentIndex())) then
			var_7_0 = var_7_0 * 0
		end

		if var_7_0 == 1 then
			iter_7_1:SetPotentialFactor(iter_7_1:GetPotential() + arg_7_0._number * -1)
		end
	end

	return
end

return
