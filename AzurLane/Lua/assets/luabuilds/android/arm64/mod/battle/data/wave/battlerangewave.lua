ys = ys or {}
ys.Battle.BattleRangeWave = class("BattleRangeWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleRangeWave.__name = "BattleRangeWave"

local var_0_0 = ys.Battle.BattleRangeWave

function ys.Battle.BattleRangeWave.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleRangeWave.SetWaveData(arg_2_0, arg_2_1)
	var_0_0.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._pos = Vector3(arg_2_0._param.rect[1], 0, arg_2_0._param.rect[2])
	arg_2_0._width = arg_2_0._param.rect[3]
	arg_2_0._height = arg_2_0._param.rect[4]
	arg_2_0._lifeTime = 31

	return
end

function ys.Battle.BattleRangeWave.DoWave(arg_3_0)
	var_0_0.super.DoWave(arg_3_0)
	arg_3_0._spawnFunc(arg_3_0._pos, arg_3_0._width, arg_3_0._height, arg_3_0._lifeTime, function(arg_4_0, arg_4_1)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1.IFF ~= arg_4_1:GetCldData().IFF then
				arg_4_1:SetActiveFlag(false)
				arg_3_0:doPass()

				break
			end
		end

		return
	end)

	return
end

return
