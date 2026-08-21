ys = ys or {}
ys.Battle.BattleBuffShiftWeapon = class("BattleBuffShiftWeapon", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShiftWeapon.__name = "BattleBuffShiftWeapon"

local var_0_0 = ys.Battle.BattleBuffShiftWeapon

function ys.Battle.BattleBuffShiftWeapon.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShiftWeapon.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._detachID = arg_2_0._tempData.arg_list.detach_id
	arg_2_0._attachID = arg_2_0._tempData.arg_list.weapon_id
	arg_2_0._detachLabel = arg_2_0._tempData.arg_list.detach_labelList
	arg_2_0._fixedEnabled = arg_2_0._tempData.arg_list.fixed
	arg_2_0._initCD = arg_2_0._tempData.arg_list.initial_over_heat

	return
end

function ys.Battle.BattleBuffShiftWeapon.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:shiftWeapon(arg_3_1)

	return
end

function ys.Battle.BattleBuffShiftWeapon.shiftWeapon(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:removeWeapon(arg_4_1)

	if not var_4_0 or var_4_0:IsFixedWeapon() and not arg_4_0._fixedEnabled then
		return
	end

	local var_4_1 = var_4_0:GetEquipmentLabel()
	local var_4_2 = var_4_0:GetSkinID()
	local var_4_3 = var_4_0:GetPotential()
	local var_4_4 = var_4_0:GetEquipmentIndex()
	local var_4_5 = 0

	while var_4_0 ~= nil do
		table.insert({}, var_4_0:GetModifyInitialCD())

		var_4_5 = var_4_5 + 1
		var_4_0 = arg_4_0:removeWeapon(arg_4_1)
	end

	for iter_4_0 = 1, var_4_5 do
		local var_4_6 = arg_4_1:AddWeapon(arg_4_0._attachID, var_4_1, var_4_2, var_4_3, var_4_4)

		if ({})[iter_4_0] then
			var_4_6:SetModifyInitialCD()
		end
	end

	return
end

function ys.Battle.BattleBuffShiftWeapon.removeWeapon(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_0._detachID then
		var_5_0 = arg_5_1:RemoveWeapon(arg_5_0._detachID)
	elseif arg_5_0._detachLabel then
		var_5_0 = arg_5_1:RemoveWeaponByLabel(arg_5_0._detachLabel)
	end

	return var_5_0
end

return
