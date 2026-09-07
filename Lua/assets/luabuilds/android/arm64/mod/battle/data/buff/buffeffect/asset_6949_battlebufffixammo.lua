ys = ys or {}
ys.Battle.BattleBuffFixAmmo = class("BattleBuffFixAmmo", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffFixAmmo.__name = "BattleBuffFixAmmo"

local var_0_0 = ys.Battle.BattleBuffFixAmmo

function ys.Battle.BattleBuffFixAmmo.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffFixAmmo:SetArgs(arg_2_1, arg_2_2)
	self._damageRate = self._tempData.arg_list.damage_rate

	return
end

function ys.Battle.BattleBuffFixAmmo:onAttach(arg_3_1, arg_3_2)
	self:updateAmmo(arg_3_1, self._damageRate)

	return
end

function ys.Battle.BattleBuffFixAmmo:onRemove(arg_4_1, arg_4_2)
	self:updateAmmo(arg_4_1)

	return
end

function ys.Battle.BattleBuffFixAmmo:updateAmmo(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetAllWeapon()

	for iter_5_0, iter_5_1 in ipairs(self._indexRequire) do
		for iter_5_2, iter_5_3 in ipairs(var_5_0) do
			if iter_5_3:GetEquipmentIndex() == iter_5_1 then
				iter_5_3:FixAmmo(arg_5_2)
			end
		end
	end

	return
end

return
