ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAddProficiency", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffAddProficiency = var_0_1
var_0_1.__name = "BattleBuffAddProficiency"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.group then
		var_2_0 = arg_2_2:GetID()
	end

	arg_2_0._group = var_2_0

	local var_2_1

	if not arg_2_0._tempData.arg_list.label then
		var_2_1 = {}
	end

	arg_2_0._weaponLabelList = var_2_1
	arg_2_0._weaponIndexList = arg_2_0._tempData.arg_list.index
	arg_2_0._number = arg_2_0._tempData.arg_list.number
	arg_2_0._numberBase = arg_2_0._number

	return
end

function var_0_1.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:calcEnhancement(arg_3_1)

	return
end

function var_0_1.onStack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:resetEnhancement(arg_4_1)

	arg_4_0._number = arg_4_0._numberBase * arg_4_2._stack

	arg_4_0:calcEnhancement(arg_4_1)

	return
end

function var_0_1.onRemove(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:resetEnhancement(arg_5_1)

	return
end

function var_0_1.calcEnhancement(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:GetAllWeapon()
	local var_6_1 = arg_6_0._number

	ipairs = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10005(var_6_0) do
		local var_6_2 = 1
		local var_6_3 = iter_6_1
		local var_6_4 = iter_6_1.GetEquipmentLabel(var_6_3)

		ipairs = var_6_3

		for iter_6_2, iter_6_3 in var_6_3(arg_6_0._weaponLabelList) do
			table = var_1_10017

			if not var_1_10017.contains(var_6_4, iter_6_3) then
				var_6_2 = 0

				break
			end
		end

		if arg_6_0._weaponIndexList then
			local var_6_5 = iter_6_1
			local var_6_6 = iter_6_1.GetEquipmentIndex(var_6_5)

			table = var_6_5

			if not var_6_5.contains(arg_6_0._weaponIndexList, var_6_6) then
				var_6_2 = var_6_2 * 0
			end
		end

		if var_6_2 == 1 then
			local var_6_7 = iter_6_1:GetPotential() + var_6_1

			iter_6_1:SetPotentialFactor(var_6_7)
		end
	end

	return
end

function var_0_1.resetEnhancement(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._number * -1
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.GetAllWeapon(var_7_1)

	ipairs = var_7_1

	for iter_7_0, iter_7_1 in var_7_1(var_7_2) do
		local var_7_3 = 1
		local var_7_4 = iter_7_1
		local var_7_5 = iter_7_1.GetEquipmentLabel(var_7_4)

		ipairs = var_7_4

		for iter_7_2, iter_7_3 in var_7_4(arg_7_0._weaponLabelList) do
			table = var_1_10016

			if not var_1_10016.contains(var_7_5, iter_7_3) then
				var_7_3 = 0

				break
			end
		end

		if arg_7_0._weaponIndexList then
			local var_7_6 = iter_7_1
			local var_7_7 = iter_7_1.GetEquipmentIndex(var_7_6)

			table = var_7_6

			if not var_7_6.contains(arg_7_0._weaponIndexList, var_7_7) then
				var_7_3 = var_7_3 * 0
			end
		end

		if var_7_3 == 1 then
			local var_7_8 = iter_7_1:GetPotential() + var_7_0

			iter_7_1:SetPotentialFactor(var_7_8)
		end
	end

	return
end

return
