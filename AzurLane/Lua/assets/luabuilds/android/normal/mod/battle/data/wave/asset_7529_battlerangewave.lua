ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleRangeWave = var_0_10002("BattleRangeWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleRangeWave.__name = "BattleRangeWave"

local var_0_2 = var_0.Battle.BattleRangeWave

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetWaveData(arg_2_0, arg_2_1)
	var_0_2.super.SetWaveData(arg_2_0, arg_2_1)

	Vector3 = var_2
	arg_2_0._pos = var_2(arg_2_0._param.rect[1], 0, arg_2_0._param.rect[2])
	arg_2_0._width = arg_2_0._param.rect[3]
	arg_2_0._height = arg_2_0._param.rect[4]
	arg_2_0._lifeTime = 31

	return
end

function var_0_2.DoWave(arg_3_0)
	var_0_2.super.DoWave(arg_3_0)
	arg_3_0._spawnFunc(arg_3_0._pos, arg_3_0._width, arg_3_0._height, arg_3_0._lifeTime, function(arg_4_0, arg_4_1)
		ipairs = var_2_10002

		for iter_4_0, iter_4_1 in var_2_10002(arg_4_0) do
			if iter_4_1.IFF ~= arg_4_1:GetCldData().IFF then
				arg_4_1:SetActiveFlag(false)

				local var_4_0 = arg_3_0

				var_7.doPass(var_4_0)

				break
			end
		end

		return
	end)

	return
end

return
