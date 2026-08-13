ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleChargeArea = var_0_10002("BattleChargeArea")
var_0.Battle.BattleChargeArea.__name = "BattleChargeArea"

function var_0.Battle.BattleChargeArea.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.gameObject

	var_2.SetActive(var_1_0, false)

	arg_1_0._areaTf = arg_1_1.transform
	arg_1_0._areaGO = arg_1_1

	return
end

function var_0.Battle.BattleChargeArea.InitArea(arg_2_0)
	local var_2_0 = arg_2_0._areaTf

	arg_2_0._controller = var_1.GetComponent(var_2_0, "ChargeArea")

	local var_2_1 = arg_2_0._chargeWeapon
	local var_2_2 = var_2.GetTemplateData(var_2_1).range
	local var_2_3 = arg_2_0._chargeWeapon
	local var_2_4 = var_3.GetTemplateData(var_2_3).angle
	local var_2_5 = var_1.localScale

	var_2_5.x = var_2_2 / 5.5
	var_2_5.y = var_2_2 / 5.5
	var_1.localScale = var_2_5
	arg_2_0._controller.maxAngle = var_2_4

	local var_2_6 = arg_2_0._controller
	local var_2_7 = arg_2_0._chargeWeapon

	var_2_6.minAngle = var_6.GetMinAngle(var_2_7)

	local var_2_8 = var_1
	local var_2_9 = var_1.Find(var_2_8, "UpperEdge").transform

	Vector3 = var_2_8
	var_2_9.localScale = var_2_8(1, 1 / var_2_5.y, 1)

	local var_2_10 = var_1
	local var_2_11 = var_1.Find(var_2_10, "LowerEdge").transform

	Vector3 = var_2_10
	var_2_11.localScale = var_2_10(1, 1 / var_2_5.y, 1)
	arg_2_0._controller.rate = 0.5

	return
end

function var_0.Battle.BattleChargeArea.Update(arg_3_0, arg_3_1)
	arg_3_0._areaTf.position = arg_3_1

	return
end

function var_0.Battle.BattleChargeArea.SetWeapon(arg_4_0, arg_4_1)
	arg_4_0._chargeWeapon = arg_4_1

	arg_4_0:InitArea()

	return
end

function var_0.Battle.BattleChargeArea.SetActive(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._areaGO

	var_2.SetActive(var_5_0, arg_5_1)

	return
end

function var_0.Battle.BattleChargeArea.GetActive(arg_6_0)
	local var_6_0 = arg_6_0._areaGO

	return var_1.GetActive(var_6_0)
end

function var_0.Battle.BattleChargeArea.Reset(arg_7_0)
	arg_7_0._controller.rate = 1

	return
end

return
