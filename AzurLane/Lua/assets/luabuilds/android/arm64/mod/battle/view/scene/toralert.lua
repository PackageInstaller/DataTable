ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.TorAlert = var_0_10002("TorAlert")
var_0.Battle.TorAlert.__name = "TorAlert"

function var_0.Battle.TorAlert.Ctor(arg_1_0, arg_1_1)
	arg_1_0._alertGO = arg_1_1
	arg_1_0._alertTF = arg_1_1.transform

	local var_1_0 = arg_1_0._alertTF

	Vector3 = var_1_10003
	var_1_0.localScale = var_1_10003(20, 5, 1)
	LeanTween = var_1_0

	local var_1_1 = var_1_0.scaleY(arg_1_1, 0, 0.5)

	var_2.setDelay(var_1_1, 0.1)

	return
end

function var_0.Battle.TorAlert.SetPosition(arg_2_0, arg_2_1, arg_2_2)
	pg = var_1_10003

	local var_2_0 = var_1_10003.EffectMgr.GetInstance()

	var_3.PlayBattleEffect(var_2_0, arg_2_0._alertGO, arg_2_1)

	local var_2_1 = arg_2_0._alertTF

	Vector3 = var_1_10004
	var_2_1.eulerAngles = var_1_10004(0, 180 - arg_2_2, 0)

	return
end

function var_0.Battle.TorAlert.Dispose(arg_3_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_3_0._alertGO)

	local var_3_0 = var_0.Battle.BattleResourceManager.GetInstance()

	var_1.DestroyOb(var_3_0, arg_3_0._alertGO)

	return
end

return
