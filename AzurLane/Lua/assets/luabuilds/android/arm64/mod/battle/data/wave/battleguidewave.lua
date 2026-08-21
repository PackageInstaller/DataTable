ys = ys or {}
ys.Battle.BattleGuideWave = class("BattleGuideWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleGuideWave.__name = "BattleGuideWave"

local var_0_0 = ys.Battle.BattleGuideWave

function ys.Battle.BattleGuideWave.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleGuideWave.SetWaveData(arg_2_0, arg_2_1)
	var_0_0.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._guideType = arg_2_0._param.type or 0
	arg_2_0._guideStep = arg_2_0._param.id
	arg_2_0._event = arg_2_0._param.event

	return
end

function ys.Battle.BattleGuideWave.DoWave(arg_3_0)
	var_0_0.super.DoWave(arg_3_0)

	if not pg.NewGuideMgr.ENABLE_GUIDE then
		arg_3_0:doPass()
	else
		if arg_3_0._guideType == 1 then
			if pg.SeriesGuideMgr.GetInstance():isEnd() then
				arg_3_0:doFail()

				goto label_3_0
			end
		end

		pg.NewGuideMgr.GetInstance():Play(arg_3_0._guideStep, {
			arg_3_0._event
		}, function()
			arg_3_0:doPass()

			return
		end)
	end

	::label_3_0::

	return
end

return
