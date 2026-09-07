ys = ys or {}
ys.Battle.BattleBuffFixRange = class("BattleBuffFixRange", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffFixRange.__name = "BattleBuffFixRange"

local var_0_0 = ys.Battle.BattleBuffFixRange

function ys.Battle.BattleBuffFixRange.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffFixRange:SetArgs(arg_2_1, arg_2_2)
	self._weaponRange = self._tempData.arg_list.weaponRange
	self._bulletRange = self._tempData.arg_list.bulletRange
	self._minRange = self._tempData.arg_list.minRange
	self._bulletRangeOffset = self._tempData.arg_list.bulletRangeOffset

	return
end

function ys.Battle.BattleBuffFixRange:onAttach(arg_3_1)
	if self._weaponRange or self._bulletRange or self._bulletRangeOffset then
		self:updateBulletRange(arg_3_1, self._weaponRange, self._bulletRange, self._minRange, self._bulletRangeOffset)
	end

	return
end

function ys.Battle.BattleBuffFixRange:onRemove(arg_4_1)
	self:updateBulletRange(arg_4_1)

	return
end

function ys.Battle.BattleBuffFixRange:updateBulletRange(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	for iter_5_0, iter_5_1 in ipairs((arg_5_1:GetAllWeapon())) do
		if self._indexRequire == nil or table.contains(self._indexRequire, (iter_5_1:GetEquipmentIndex())) then
			iter_5_1:FixWeaponRange(arg_5_2, arg_5_3, arg_5_4, arg_5_5)
		end
	end

	return
end

return
