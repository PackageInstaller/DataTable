ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BossSkillAlert = var_0_10002("BossSkillAlert")
var_0.Battle.BossSkillAlert.__name = "BossSkillAlert"

function var_0.Battle.BossSkillAlert.Ctor(arg_1_0, arg_1_1)
	arg_1_0._alertGO = arg_1_1
	arg_1_0._alertTF = arg_1_1.transform

	local var_1_0 = arg_1_0._alertTF

	Vector3 = var_1_10003
	var_1_0.localPosition = var_1_10003.zero
	LeanTween = var_1_0

	local var_1_1 = var_1_0.alpha(arg_1_1, 0.3, 0.1)
	local var_1_2 = var_2.setDelay(var_1_1, 0.1)

	var_2.setLoopPingPong(var_1_2)

	return
end

function var_0.Battle.BossSkillAlert.SetActive(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._alertGO

	var_2.SetActive(var_2_0, arg_2_1)

	return
end

function var_0.Battle.BossSkillAlert.GetActive(arg_3_0)
	return arg_3_0._alertGO.activeSelf
end

function var_0.Battle.BossSkillAlert.SetScale(arg_4_0, arg_4_1)
	arg_4_0._alertTF.localScale = arg_4_1

	return
end

function var_0.Battle.BossSkillAlert.SetExistTime(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.TimeMgr.GetInstance()

	arg_5_0._timer = var_2.AddBattleTimer(var_5_0, "BossSkillAlert", 0, arg_5_1, function()
		if arg_5_0._alertGO then
			local var_6_0 = arg_5_0

			var_0.Dispose(var_6_0)
		end

		return
	end)

	return
end

function var_0.Battle.BossSkillAlert.Dispose(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_7_0, arg_7_0._timer)

	LeanTween = var_1

	var_1.cancel(arg_7_0._alertGO)

	Object = var_1

	var_1.Destroy(arg_7_0._alertGO)

	arg_7_0._alertGO = nil

	return
end

return
