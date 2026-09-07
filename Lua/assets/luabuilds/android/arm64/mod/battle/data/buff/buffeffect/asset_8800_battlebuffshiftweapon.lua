ys = ys or {}
ys.Battle.BattleBuffShiftWeapon = class("BattleBuffShiftWeapon", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShiftWeapon.__name = "BattleBuffShiftWeapon"

local var_0_0 = ys.Battle.BattleBuffShiftWeapon

function ys.Battle.BattleBuffShiftWeapon.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShiftWeapon:SetArgs(arg_2_1, arg_2_2)
	self._detachID = self._tempData.arg_list.detach_id
	self._attachID = self._tempData.arg_list.weapon_id
	self._detachLabel = self._tempData.arg_list.detach_labelList
	self._fixedEnabled = self._tempData.arg_list.fixed
	self._initCD = self._tempData.arg_list.initial_over_heat

	return
end

function ys.Battle.BattleBuffShiftWeapon:onAttach(arg_3_1, arg_3_2)
	self:shiftWeapon(arg_3_1)

	return
end

function ys.Battle.BattleBuffShiftWeapon:shiftWeapon(arg_4_1)
	local var_4_0 = self:removeWeapon(arg_4_1)

	if not var_4_0 or var_4_0:IsFixedWeapon() and not self._fixedEnabled then
		return
	end

	local var_4_1 = var_4_0:GetEquipmentLabel()
	local var_4_2 = var_4_0:GetSkinID()
	local var_4_3 = var_4_0:GetPotential()
	local var_4_4 = var_4_0:GetEquipmentIndex()
	local var_4_5 = 0
	local var_4_6 = {}

	while var_4_0 ~= nil do
		table.insert(var_4_6, var_4_0:GetModifyInitialCD())

		var_4_5 = var_4_5 + 1
		var_4_0 = self:removeWeapon(arg_4_1)
	end

	for iter_4_0 = 1, var_4_5 do
		if var_4_6[iter_4_0] then
			arg_4_1:AddWeapon(self._attachID, var_4_1, var_4_2, var_4_3, var_4_4):SetModifyInitialCD()
		end
	end

	return
end

function ys.Battle.BattleBuffShiftWeapon:removeWeapon(arg_5_1)
	local var_5_0

	if self._detachID then
		var_5_0 = arg_5_1:RemoveWeapon(self._detachID)
	elseif self._detachLabel then
		var_5_0 = arg_5_1:RemoveWeaponByLabel(self._detachLabel)
	end

	return var_5_0
end

return
