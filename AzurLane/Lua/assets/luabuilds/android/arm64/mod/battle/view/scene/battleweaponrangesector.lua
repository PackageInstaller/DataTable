ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleWeaponRangeSector = var_0_10002("BattleWeaponRangeSector")
var_0.Battle.BattleWeaponRangeSector.__name = "BattleWeaponRangeSector"

local var_0_2 = var_0.Battle.BattleWeaponRangeSector

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	setActive = var_1_10002

	var_1_10002(arg_1_0._tf, true)
	arg_1_0:initSector()

	return
end

function var_0_2.ConfigHost(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._host = arg_2_1
	arg_2_0._weapon = arg_2_2

	arg_2_0:updateSector(arg_2_0._weapon)

	return
end

function var_0_2.initSector(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0._minRange = var_1.Find(var_3_0, "minSector")

	local var_3_1 = arg_3_0._minRange
	local var_3_2 = var_1.Find(var_3_1, "sector")
	local var_3_3 = var_1.GetComponent

	typeof = var_4
	Renderer = var_1_10006
	arg_3_0._minSector = var_3_3(var_3_2, var_4(var_1_10006)).material

	local var_3_4 = arg_3_0._tf

	arg_3_0._maxRange = var_1.Find(var_3_4, "maxSector")

	local var_3_5 = arg_3_0._maxRange
	local var_3_6 = var_1.Find(var_3_5, "sector")
	local var_3_7 = var_1.GetComponent

	typeof = var_4
	Renderer = var_1_10006
	arg_3_0._maxSector = var_3_7(var_3_6, var_4(var_1_10006)).material

	return
end

function var_0_2.updateSector(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetAttackAngle()
	local var_4_1 = arg_4_1._maxRangeSqr * 2
	local var_4_2 = arg_4_1._minRangeSqr * 2
	local var_4_3 = arg_4_0._maxRange

	Vector3 = var_1_10006
	var_4_3.localScale = var_1_10006(var_4_1, 1, var_4_1)

	local var_4_4 = arg_4_0._minRange

	Vector3 = var_6
	var_4_4.localScale = var_6(var_4_2, 1, var_4_2)

	local var_4_5 = arg_4_0._maxSector

	var_5.SetInt(var_4_5, "_Angle", var_4_0)

	local var_4_6 = arg_4_0._minSector

	var_5.SetInt(var_4_6, "_Angle", var_4_0)

	return
end

function var_0_2.Dispose(arg_5_0)
	Destroy = var_1_10001

	var_1_10001(arg_5_0._tf)

	arg_5_0._host = nil
	arg_5_0._weapon = nil

	return
end

return
