ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleJammingWave = var_0_10002("BattleJammingWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleJammingWave.__name = "BattleJammingWave"

local var_0_2 = var_0.Battle.BattleJammingWave

var_0_2.JAMMING_ENGAGE = 1
var_0_2.JAMMING_DODGE = 2

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.DoWave(arg_2_0)
	var_0_2.super.DoWave(arg_2_0)

	local var_2_0 = var_0.Battle.BattleDataProxy.GetInstance()

	if var_1.GetInitData(var_2_0).KizunaJamming then
		table = var_1_10004

		if var_1_10004.contains(var_3, var_0_2.JAMMING_ENGAGE) then
			var_1:KizunaJamming()
		end
	end

	arg_2_0:doFinish()

	return
end

return
