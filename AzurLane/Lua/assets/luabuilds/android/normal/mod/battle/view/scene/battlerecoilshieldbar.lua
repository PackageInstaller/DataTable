ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleRecoilShieldBar = var_0_10002("BattleRecoilShieldBar")
var_0.Battle.BattleRecoilShieldBar.__name = "BattleRecoilShieldBar"

local var_0_2 = var_0.Battle.BattleRecoilShieldBar

var_0_2.WARNING_VALUE = 0.1

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._recoilShieldBar = arg_1_1
	arg_1_0._recoilShieldBarGO = arg_1_0._recoilShieldBar.gameObject

	local var_1_0 = arg_1_0._recoilShieldBar
	local var_1_1 = var_2.Find(var_1_0, "shield")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0._progress = var_1_2(var_1_1, var_4(var_1_10005))
	setActive = var_2

	var_2(arg_1_0._progress, true)

	setActive = var_2

	var_2(arg_1_0._recoilShieldBar, true)

	arg_1_0._lockBlock = false

	return
end

function var_0_2.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._recoilShieldBar, arg_2_1)

	return
end

function var_0_2.ConfigShieldBuff(arg_3_0, arg_3_1)
	arg_3_0._recoilShieldBuffEffect = arg_3_1

	return
end

function var_0_2.UpdateRecoilShieldProgress(arg_4_0)
	local var_4_0 = arg_4_0._recoilShieldBuffEffect
	local var_4_1 = var_1.GetCurrentRate(var_4_0)

	arg_4_0._progress.fillAmount = var_4_1

	return
end

function var_0_2.Dispose(arg_5_0)
	arg_5_0._recoilShieldBar = nil
	arg_5_0._progress = nil
	arg_5_0._recoilShieldBarGO = nil

	return
end

function var_0_2.GetGO(arg_6_0)
	return arg_6_0._aimBiasBarGO
end

return
