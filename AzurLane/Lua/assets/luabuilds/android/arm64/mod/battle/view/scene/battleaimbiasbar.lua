ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleAimbiasBar = var_0_10002("BattleAimbiasBar")
var_0.Battle.BattleAimbiasBar.__name = "BattleAimbiasBar"

local var_0_2 = var_0.Battle.BattleAimbiasBar

var_0_2.WARNING_VALUE = 0.1

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._aimBiasBar = arg_1_1
	arg_1_0._aimBiasBarGO = arg_1_0._aimBiasBar.gameObject

	local var_1_0 = arg_1_0._aimBiasBar
	local var_1_1 = var_2.Find(var_1_0, "bias")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0._progress = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0._aimBiasBar

	arg_1_0._warning = var_2.Find(var_1_3, "warning")

	local var_1_4 = arg_1_0._aimBiasBar

	arg_1_0._lock = var_2.Find(var_1_4, "lock")

	local var_1_5 = arg_1_0._aimBiasBar

	arg_1_0._recovery = var_2.Find(var_1_5, "recovery")
	setActive = var_2

	var_2(arg_1_0._lock, false)

	setActive = var_2

	var_2(arg_1_0._warning, false)

	setActive = var_2

	var_2(arg_1_0._progress, true)

	setActive = var_2

	var_2(arg_1_0._aimBiasBar, true)

	setActive = var_2

	var_2(arg_1_0._recovery, true)

	arg_1_0._cacheSpeed = 0
	arg_1_0._cacheWarningFlag = 0
	arg_1_0._lockBlock = false

	return
end

function var_0_2.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._aimBiasBar, arg_2_1)

	return
end

function var_0_2.ConfigAimBias(arg_3_0, arg_3_1)
	arg_3_0._aimBiasComponent = arg_3_1
	arg_3_0._hostile = arg_3_1:IsHostile()

	return
end

function var_0_2.UpdateLockStateView(arg_4_0)
	local var_4_0 = arg_4_0._aimBiasComponent
	local var_4_1 = var_1.GetCurrentState(var_4_0) == arg_4_0._aimBiasComponent.STATE_SKILL_EXPOSE

	setActive = var_2

	var_2(arg_4_0._lock, var_4_1)

	if var_4_1 then
		setActive = var_2

		var_2(arg_4_0._recovery, false)

		setActive = var_2

		var_2(arg_4_0._warning, false)
	else
		local var_4_2 = arg_4_0._aimBiasComponent

		if var_2.GetDecayRatioSpeed(var_4_2) < 0 then
			setActive = var_3

			var_3(arg_4_0._recovery, true)
		elseif not arg_4_0._hostile then
			local var_4_3 = arg_4_0._aimBiasComponent

			if var_3.GetCurrentRate(var_4_3) < var_0_2.WARNING_VALUE and 0 < var_3 then
				setActive = var_4

				var_4(arg_4_0._warning, true)
			end
		end
	end

	arg_4_0._lockBlock = var_4_1

	return
end

function var_0_2.UpdateAimBiasProgress(arg_5_0)
	local var_5_0 = arg_5_0._aimBiasComponent
	local var_5_1 = var_1.GetCurrentRate(var_5_0)

	arg_5_0._progress.fillAmount = var_5_1

	local var_5_2 = arg_5_0._aimBiasComponent
	local var_5_3 = var_2.GetDecayRatioSpeed(var_5_2)
	local var_5_4 = var_5_1 - var_0_2.WARNING_VALUE

	if not arg_5_0._lockBlock then
		local var_5_5 = var_5_3 < 0

		if var_5_3 * arg_5_0._cacheSpeed <= 0 then
			setActive = var_5

			var_5(arg_5_0._recovery, var_5_5)
		end

		if not arg_5_0._hostile then
			if var_5_1 <= 0 then
				setActive = var_5

				var_5(arg_5_0._warning, false)
			elseif not var_5_5 and var_5_4 * arg_5_0._cacheWarningFlag < 0 then
				setActive = var_5

				var_5(arg_5_0._warning, var_5_1 < var_0_2.WARNING_VALUE)
			end
		end
	end

	if arg_5_0._hostile and var_5_1 <= 0 then
		setActive = var_4

		var_4(arg_5_0._aimBiasBar, false)
	end

	arg_5_0._cacheSpeed = var_5_3
	arg_5_0._cacheWarningFlag = var_5_4

	return
end

function var_0_2.UpdateAimBiasConfig(arg_6_0)
	return
end

function var_0_2.Dispose(arg_7_0)
	arg_7_0._aimBiasBar = nil
	arg_7_0._progress = nil
	arg_7_0._warning = nil
	arg_7_0._lock = nil
	arg_7_0._aimBiasBarGO = nil

	return
end

function var_0_2.GetGO(arg_8_0)
	return arg_8_0._aimBiasBarGO
end

return
