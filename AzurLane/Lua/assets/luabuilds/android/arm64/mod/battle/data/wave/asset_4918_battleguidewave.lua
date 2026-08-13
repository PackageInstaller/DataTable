ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleGuideWave = var_0_10002("BattleGuideWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleGuideWave.__name = "BattleGuideWave"

local var_0_2 = var_0.Battle.BattleGuideWave

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetWaveData(arg_2_0, arg_2_1)
	var_0_2.super.SetWaveData(arg_2_0, arg_2_1)

	local var_2_0

	if not arg_2_0._param.type then
		var_2_0 = 0
	end

	arg_2_0._guideType = var_2_0
	arg_2_0._guideStep = arg_2_0._param.id
	arg_2_0._event = arg_2_0._param.event

	return
end

function var_0_2.DoWave(arg_3_0)
	var_0_2.super.DoWave(arg_3_0)

	pg = var_1

	if not var_1.NewGuideMgr.ENABLE_GUIDE then
		arg_3_0:doPass()
	else
		if arg_3_0._guideType == 1 then
			pg = var_1

			local var_3_0 = var_1.SeriesGuideMgr.GetInstance()

			if var_1.isEnd(var_3_0) then
				arg_3_0:doFail()

				goto label_3_0
			end
		end

		pg = var_1

		local var_3_1 = var_1.NewGuideMgr.GetInstance()

		var_1.Play(var_3_1, arg_3_0._guideStep, {
			arg_3_0._event
		}, function()
			local var_4_0 = arg_3_0

			var_0.doPass(var_4_0)

			return
		end)
	end

	::label_3_0::

	return
end

return
