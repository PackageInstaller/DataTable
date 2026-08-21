ys = ys or {}
ys.Battle.BattleBuffFixRange = class("BattleBuffFixRange", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffFixRange.__name = "BattleBuffFixRange"

local var_0_0 = ys.Battle.BattleBuffFixRange

function ys.Battle.BattleBuffFixRange.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffFixRange.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._weaponRange = arg_2_0._tempData.arg_list.weaponRange
	arg_2_0._bulletRange = arg_2_0._tempData.arg_list.bulletRange
	arg_2_0._minRange = arg_2_0._tempData.arg_list.minRange
	arg_2_0._bulletRangeOffset = arg_2_0._tempData.arg_list.bulletRangeOffset

	return
end

function ys.Battle.BattleBuffFixRange.onAttach(arg_3_0, arg_3_1)
	if arg_3_0._weaponRange or arg_3_0._bulletRange or arg_3_0._bulletRangeOffset then
		arg_3_0:updateBulletRange(arg_3_1, arg_3_0._weaponRange, arg_3_0._bulletRange, arg_3_0._minRange, arg_3_0._bulletRangeOffset)
	end

	return
end

function ys.Battle.BattleBuffFixRange.onRemove(arg_4_0, arg_4_1)
	arg_4_0:updateBulletRange(arg_4_1)

	return
end

function ys.Battle.BattleBuffFixRange.updateBulletRange(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	for iter_5_0, iter_5_1 in ipairs((arg_5_1:GetAllWeapon())) do
		local var_5_0 = iter_5_1:GetEquipmentIndex()

		if arg_5_0._indexRequire == nil or table.contains(arg_5_0._indexRequire, var_5_0) then
			iter_5_1:FixWeaponRange(arg_5_2, arg_5_3, arg_5_4, arg_5_5)
		end
	end

	return
end

return
