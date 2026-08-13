ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffShiftWeapon = var_0_10002("BattleBuffShiftWeapon", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffShiftWeapon.__name = "BattleBuffShiftWeapon"

local var_0_2 = var_0.Battle.BattleBuffShiftWeapon

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._detachID = arg_2_0._tempData.arg_list.detach_id
	arg_2_0._attachID = arg_2_0._tempData.arg_list.weapon_id
	arg_2_0._detachLabel = arg_2_0._tempData.arg_list.detach_labelList
	arg_2_0._fixedEnabled = arg_2_0._tempData.arg_list.fixed
	arg_2_0._initCD = arg_2_0._tempData.arg_list.initial_over_heat

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:shiftWeapon(arg_3_1)

	return
end

function var_0_2.shiftWeapon(arg_4_0, arg_4_1)
	if not arg_4_0:removeWeapon(arg_4_1) or var_4_6:IsFixedWeapon() and not arg_4_0._fixedEnabled then
		return
	end

	local var_4_0 = var_4_6:GetEquipmentLabel()
	local var_4_1 = var_4_6:GetSkinID()
	local var_4_2 = var_4_6:GetPotential()
	local var_4_3 = var_4_6:GetEquipmentIndex()
	local var_4_4 = 0
	local var_4_5 = {}

	while var_4_6 ~= nil do
		table = var_1_10009

		var_1_10009.insert(var_4_5, var_4_6:GetModifyInitialCD())

		var_4_4 = var_4_4 + 1

		local var_4_6 = arg_4_0:removeWeapon(arg_4_1)
	end

	for iter_4_0 = 1, var_4_4 do
		local var_4_7 = arg_4_1:AddWeapon(arg_4_0._attachID, var_4_0, var_4_1, var_4_2, var_4_3)

		if var_4_5[iter_4_0] then
			var_4_7:SetModifyInitialCD()
		end
	end

	return
end

function var_0_2.removeWeapon(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_0._detachID then
		var_5_0 = arg_5_1:RemoveWeapon(arg_5_0._detachID)
	elseif arg_5_0._detachLabel then
		var_5_0 = arg_5_1:RemoveWeaponByLabel(arg_5_0._detachLabel)
	end

	return var_5_0
end

return
