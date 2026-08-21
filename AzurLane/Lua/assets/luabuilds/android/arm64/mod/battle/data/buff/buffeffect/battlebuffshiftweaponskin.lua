ys = ys or {}
ys.Battle.BattleBuffShiftWeaponSkin = class("BattleBuffShiftWeaponSkin", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShiftWeaponSkin.__name = "BattleBuffShiftWeaponSkin"

local var_0_0 = ys.Battle.BattleBuffShiftWeaponSkin

function ys.Battle.BattleBuffShiftWeaponSkin.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShiftWeaponSkin.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._weaponIndex = arg_2_0._tempData.arg_list.index
	arg_2_0._skinID = arg_2_0._tempData.arg_list.skin_id

	return
end

function ys.Battle.BattleBuffShiftWeaponSkin.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:shiftWeaponSkin(arg_3_1)

	return
end

function ys.Battle.BattleBuffShiftWeaponSkin.onRemove(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.BattleBuffShiftWeaponSkin.shiftWeaponSkin(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetAllWeapon()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._indexRequire) do
		for iter_5_2, iter_5_3 in ipairs(var_5_0) do
			if iter_5_3:GetEquipmentIndex() == iter_5_1 then
				iter_5_3:SetSkinData(arg_5_0._skinID)
			end
		end
	end

	return
end

return
