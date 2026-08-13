ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleAlert = var_0_10002("BattleAlert")
var_0.Battle.BattleAlert.__name = "BattleAlert"

function var_0.Battle.BattleAlert.Ctor(arg_1_0, arg_1_1)
	arg_1_0._alertGO = arg_1_1
	arg_1_0._alertTf = arg_1_1.transform

	local var_1_0 = arg_1_0._alertGO.transform

	arg_1_0._diskTf = var_2.Find(var_1_0, "Disk")

	arg_1_0:UpdateRate(0)

	local var_1_1 = arg_1_0._alertGO

	var_2.SetActive(var_1_1, true)

	return
end

function var_0.Battle.BattleAlert.SetPosition(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._alertTf

	Vector3 = var_1_10003
	var_2_0.localPosition = var_1_10003(arg_2_1.x, 0, arg_2_1.z)

	return
end

function var_0.Battle.BattleAlert.Zoom(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._alertTf

	Vector3 = var_1_10003
	var_3_0.localScale = var_1_10003(arg_3_1 * 2, arg_3_1 * 2, 1)

	return
end

function var_0.Battle.BattleAlert.UpdateRate(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._diskTf

	Vector3 = var_1_10003
	var_4_0.localScale = var_1_10003(arg_4_1, arg_4_1, 1)

	return
end

function var_0.Battle.BattleAlert.Dispose(arg_5_0)
	Object = var_1_10001

	var_1_10001.Destroy(arg_5_0._alertGO)

	return
end

return
