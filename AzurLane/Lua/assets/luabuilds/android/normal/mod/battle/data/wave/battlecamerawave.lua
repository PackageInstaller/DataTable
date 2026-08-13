ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleCameraWave = var_0_10003("BattleCameraWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleCameraWave.__name = "BattleCameraWave"

local var_0_3 = var_0.Battle.BattleCameraWave

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetWaveData(arg_2_0, arg_2_1)
	var_0_3.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._pause = arg_2_0._param.pause

	local var_2_0

	if not arg_2_0._param.type then
		var_2_0 = 0
	end

	arg_2_0._cameraType = var_2_0

	local var_2_1

	if not arg_2_0._param.model then
		var_2_1 = 900006
	end

	arg_2_0._modelID = var_2_1

	local var_2_2

	if not arg_2_0._param.duration then
		var_2_2 = 1
	end

	arg_2_0._duration = var_2_2
	arg_2_0._zoomSize = arg_2_0._param.zoomSize
	arg_2_0._zoomBounce = arg_2_0._param.zoomBounce

	return
end

function var_0_3.DoWave(arg_3_0)
	var_0_3.super.DoWave(arg_3_0)

	local var_3_0 = var_0.Battle.BattleCameraUtil.GetInstance()

	if arg_3_0._cameraType == 1 then
		local var_3_1 = var_0.Battle.BattleDataProxy.GetInstance()
		local var_3_2 = var_2.GetUnitList(var_3_1)
		local var_3_3

		pairs = var_1_10004

		for iter_3_0, iter_3_1 in var_1_10004(var_3_2) do
			if iter_3_1:GetTemplateID() == arg_3_0._modelID then
				var_3_3 = iter_3_1

				break
			end
		end

		var_3_0:FocusCharacter(var_3_3, arg_3_0._duration, 0, true, not arg_3_0._zoomBounce)

		if arg_3_0._zoomSize then
			local var_3_4 = arg_3_0._duration * 0.5

			if arg_3_0._zoomBounce then
				var_3_0:ZoomCamara(nil, var_0_1.CAST_CAM_OVERLOOK_SIZE, var_3_4)

				LeanTween = var_5

				local var_3_5 = var_5.delayedCall
				local var_3_6 = var_3_4

				System = var_7

				var_3_5(var_3_6, var_7.Action(function()
					local var_4_0 = var_3_0

					var_0.ZoomCamara(var_4_0, var_0_1.CAST_CAM_OVERLOOK_SIZE, arg_3_0._zoomSize, var_3_4)

					return
				end))
			else
				var_3_0:ZoomCamara(nil, arg_3_0._zoomSize, arg_3_0._duration, true)
			end
		end
	elseif arg_3_0._cameraType == 0 then
		var_3_0:FocusCharacter(nil, arg_3_0._duration, 0)
		var_3_0:ZoomCamara(nil, nil, arg_3_0._duration)
	end

	var_3_0:BulletTime(var_0_1.SPEED_FACTOR_FOCUS_CHARACTER, nil)
	arg_3_0:doPass()

	return
end

return
