ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleDataFunction
local BattleBuffNewWeapon = class("BattleBuffNewWeapon", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffNewWeapon = BattleBuffNewWeapon
BattleBuffNewWeapon.__name = "BattleBuffNewWeapon"

function BattleBuffNewWeapon:Ctor(arg_1_1)
	BattleBuffNewWeapon.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffNewWeapon:SetArgs(arg_2_1, arg_2_2)
	self._weaponID = self._tempData.arg_list.weapon_id
	self._reverse = self._tempData.arg_list.reverse

	return
end

function BattleBuffNewWeapon:onAttach(arg_3_1, arg_3_2)
	if self._reverse then
		arg_3_1:RemoveAutoWeaponByWeaponID(self._weaponID)
	elseif var_0_1.GetWeaponPropertyDataFromID(self._weaponID).type == var_0_0.EquipmentType.FLEET_ANTI_AIR then
		arg_3_1:AddWeapon(self._weaponID)
		arg_3_1:GetFleetVO():GetFleetAntiAirWeapon():FlushCrewUnit(arg_3_1)
	else
		self._weapon = arg_3_1:AddNewAutoWeapon(self._weaponID)
	end

	return
end

function BattleBuffNewWeapon:onRemove(arg_4_1, arg_4_2)
	if self._reverse then
		arg_4_1:AddNewAutoWeapon(self._weaponID)
	elseif self._weapon then
		if var_0_1.GetWeaponPropertyDataFromID(self._weaponID).type == var_0_0.EquipmentType.FLEET_ANTI_AIR then
			arg_4_1:RemoveWeapon(self._weaponID)
			arg_4_1:RemoveFleetAntiAirWeapon(self._weapon)
			arg_4_1:GetFleetVO():GetFleetAntiAirWeapon():FlushCrewUnit(arg_4_1)
		else
			self._weapon:Clear()
			arg_4_1:RemoveAutoWeapon(self._weapon)
		end
	end

	return
end

function BattleBuffNewWeapon:Dispose()
	BattleBuffNewWeapon.super.Dispose(self)

	self._weapon = nil

	return
end

return
