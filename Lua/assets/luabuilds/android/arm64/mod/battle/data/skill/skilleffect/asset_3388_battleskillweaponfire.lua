ys = ys or {}

local BattleSkillWeaponFire = class("BattleSkillWeaponFire", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillWeaponFire = BattleSkillWeaponFire
BattleSkillWeaponFire.__name = "BattleSkillWeaponFire"

function BattleSkillWeaponFire:Ctor(arg_1_1)
	BattleSkillWeaponFire.super.Ctor(self, arg_1_1, lv)

	self._weaponType = self._tempData.arg_list.weaponType
	self._useTempBullet = self._tempData.arg_list.preShiftBullet

	return
end

function BattleSkillWeaponFire:DoDataEffect(arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in ipairs((self:_GetWeapon(arg_2_1))) do
		iter_2_1:SingleFire(arg_2_2, nil, nil, self._useTempBullet)
	end

	return
end

function BattleSkillWeaponFire:DoDataEffectWithoutTarget(arg_3_1)
	self:DoDataEffect(arg_3_1, nil)

	return
end

function BattleSkillWeaponFire:_GetWeapon(arg_4_1)
	local var_4_0 = {}

	if self._weaponType == "ChargeWeapon" then
		table.insert(var_4_0, arg_4_1:GetChargeList()[1])
	elseif self._weaponType == "TorpedoWeapon" then
		table.insert(var_4_0, arg_4_1:GetTorpedoList()[1])
	elseif self._weaponType == "AirAssist" then
		table.insert(var_4_0, arg_4_1:GetAirAssistList()[1])
	elseif self._weaponType == "Aircraft" then
		for iter_4_0, iter_4_1 in ipairs((arg_4_1:GetHiveList())) do
			table.insert(var_4_0, iter_4_1)
		end
	else
		table.insert(var_4_0, arg_4_1:GetAutoWeapons()[1])
	end

	return var_4_0
end

return
