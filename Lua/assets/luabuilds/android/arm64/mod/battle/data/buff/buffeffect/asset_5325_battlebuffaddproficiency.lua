ys = ys or {}

local BattleBuffAddProficiency = class("BattleBuffAddProficiency", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddProficiency = BattleBuffAddProficiency
BattleBuffAddProficiency.__name = "BattleBuffAddProficiency"

function BattleBuffAddProficiency:Ctor(arg_1_1)
	BattleBuffAddProficiency.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddProficiency:SetArgs(arg_2_1, arg_2_2)
	self._group = self._tempData.arg_list.group or arg_2_2:GetID()
	self._weaponLabelList = self._tempData.arg_list.label or {}
	self._weaponIndexList = self._tempData.arg_list.index
	self._number = self._tempData.arg_list.number
	self._numberBase = self._number

	return
end

function BattleBuffAddProficiency:onAttach(arg_3_1, arg_3_2)
	self:calcEnhancement(arg_3_1)

	return
end

function BattleBuffAddProficiency:onStack(arg_4_1, arg_4_2)
	self:resetEnhancement(arg_4_1)

	self._number = self._numberBase * arg_4_2._stack

	self:calcEnhancement(arg_4_1)

	return
end

function BattleBuffAddProficiency:onRemove(arg_5_1, arg_5_2)
	self:resetEnhancement(arg_5_1)

	return
end

function BattleBuffAddProficiency:calcEnhancement(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs((arg_6_1:GetAllWeapon())) do
		local var_6_0 = 1
		local var_6_1 = iter_6_1:GetEquipmentLabel()

		for iter_6_2, iter_6_3 in ipairs(self._weaponLabelList) do
			if not table.contains(var_6_1, iter_6_3) then
				var_6_0 = 0

				break
			end
		end

		if self._weaponIndexList and not table.contains(self._weaponIndexList, (iter_6_1:GetEquipmentIndex())) then
			var_6_0 = var_6_0 * 0
		end

		if var_6_0 == 1 then
			iter_6_1:SetPotentialFactor(iter_6_1:GetPotential() + self._number)
		end
	end

	return
end

function BattleBuffAddProficiency:resetEnhancement(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs((arg_7_1:GetAllWeapon())) do
		local var_7_0 = 1
		local var_7_1 = iter_7_1:GetEquipmentLabel()

		for iter_7_2, iter_7_3 in ipairs(self._weaponLabelList) do
			if not table.contains(var_7_1, iter_7_3) then
				var_7_0 = 0

				break
			end
		end

		if self._weaponIndexList and not table.contains(self._weaponIndexList, (iter_7_1:GetEquipmentIndex())) then
			var_7_0 = var_7_0 * 0
		end

		if var_7_0 == 1 then
			iter_7_1:SetPotentialFactor(iter_7_1:GetPotential() + self._number * -1)
		end
	end

	return
end

return
