ys = ys or {}
ys.Battle.BattleWeaponRangeSector = class("BattleWeaponRangeSector")
ys.Battle.BattleWeaponRangeSector.__name = "BattleWeaponRangeSector"

function ys.Battle.BattleWeaponRangeSector.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	setActive(arg_1_0._tf, true)
	arg_1_0:initSector()

	return
end

function ys.Battle.BattleWeaponRangeSector.ConfigHost(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._host = arg_2_1
	arg_2_0._weapon = arg_2_2

	arg_2_0:updateSector(arg_2_0._weapon)

	return
end

function ys.Battle.BattleWeaponRangeSector.initSector(arg_3_0)
	arg_3_0._minRange = arg_3_0._tf:Find("minSector")
	arg_3_0._minSector = arg_3_0._minRange:Find("sector"):GetComponent(typeof(Renderer)).material
	arg_3_0._maxRange = arg_3_0._tf:Find("maxSector")
	arg_3_0._maxSector = arg_3_0._maxRange:Find("sector"):GetComponent(typeof(Renderer)).material

	return
end

function ys.Battle.BattleWeaponRangeSector.updateSector(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetAttackAngle()

	arg_4_0._maxRange.localScale = Vector3(arg_4_1._maxRangeSqr * 2, 1, arg_4_1._maxRangeSqr * 2)
	arg_4_0._minRange.localScale = Vector3(arg_4_1._minRangeSqr * 2, 1, arg_4_1._minRangeSqr * 2)

	arg_4_0._maxSector:SetInt("_Angle", var_4_0)
	arg_4_0._minSector:SetInt("_Angle", var_4_0)

	return
end

function ys.Battle.BattleWeaponRangeSector.Dispose(arg_5_0)
	Destroy(arg_5_0._tf)

	arg_5_0._host = nil
	arg_5_0._weapon = nil

	return
end

return
