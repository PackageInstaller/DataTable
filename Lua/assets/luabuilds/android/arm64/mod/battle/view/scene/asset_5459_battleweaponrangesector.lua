ys = ys or {}
ys.Battle.BattleWeaponRangeSector = class("BattleWeaponRangeSector")
ys.Battle.BattleWeaponRangeSector.__name = "BattleWeaponRangeSector"

function ys.Battle.BattleWeaponRangeSector:Ctor(arg_1_1)
	self._tf = arg_1_1

	setActive(self._tf, true)
	self:initSector()

	return
end

function ys.Battle.BattleWeaponRangeSector:ConfigHost(arg_2_1, arg_2_2)
	self._host = arg_2_1
	self._weapon = arg_2_2

	self:updateSector(self._weapon)

	return
end

function ys.Battle.BattleWeaponRangeSector:initSector()
	self._minRange = self._tf:Find("minSector")
	self._minSector = self._minRange:Find("sector"):GetComponent(typeof(Renderer)).material
	self._maxRange = self._tf:Find("maxSector")
	self._maxSector = self._maxRange:Find("sector"):GetComponent(typeof(Renderer)).material

	return
end

function ys.Battle.BattleWeaponRangeSector:updateSector(arg_4_1)
	local var_4_0 = arg_4_1:GetAttackAngle()

	self._maxRange.localScale = Vector3(arg_4_1._maxRangeSqr * 2, 1, arg_4_1._maxRangeSqr * 2)
	self._minRange.localScale = Vector3(arg_4_1._minRangeSqr * 2, 1, arg_4_1._minRangeSqr * 2)

	self._maxSector:SetInt("_Angle", var_4_0)
	self._minSector:SetInt("_Angle", var_4_0)

	return
end

function ys.Battle.BattleWeaponRangeSector:Dispose()
	Destroy(self._tf)

	self._host = nil
	self._weapon = nil

	return
end

return
