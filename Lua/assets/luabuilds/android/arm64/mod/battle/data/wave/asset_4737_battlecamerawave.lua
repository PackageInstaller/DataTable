ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig

ys.Battle.BattleCameraWave = class("BattleCameraWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleCameraWave.__name = "BattleCameraWave"

local var_0_2 = ys.Battle.BattleCameraWave

function ys.Battle.BattleCameraWave.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleCameraWave:SetWaveData(arg_2_1)
	var_0_2.super.SetWaveData(self, arg_2_1)

	self._pause = self._param.pause
	self._cameraType = self._param.type or 0
	self._modelID = self._param.model or 900006
	self._duration = self._param.duration or 1
	self._zoomSize = self._param.zoomSize
	self._zoomBounce = self._param.zoomBounce

	return
end

function ys.Battle.BattleCameraWave:DoWave()
	var_0_2.super.DoWave(self)

	local var_3_0 = var_0_0.Battle.BattleCameraUtil.GetInstance()

	if self._cameraType == 1 then
		local var_3_1

		for iter_3_0, iter_3_1 in pairs((var_0_0.Battle.BattleDataProxy.GetInstance():GetUnitList())) do
			if iter_3_1:GetTemplateID() == self._modelID then
				var_3_1 = iter_3_1

				break
			end
		end

		var_3_0:FocusCharacter(var_3_1, self._duration, 0, true, not self._zoomBounce)

		if self._zoomSize then
			local var_3_2 = self._duration * 0.5

			if self._zoomBounce then
				var_3_0:ZoomCamara(nil, var_0_1.CAST_CAM_OVERLOOK_SIZE, self._duration * 0.5)
				LeanTween.delayedCall(self._duration * 0.5, System.Action(function()
					var_3_0:ZoomCamara(var_0_1.CAST_CAM_OVERLOOK_SIZE, self._zoomSize, var_3_2)

					return
				end))
			else
				var_3_0:ZoomCamara(nil, self._zoomSize, self._duration, true)
			end
		end
	elseif self._cameraType == 0 then
		var_3_0:FocusCharacter(nil, self._duration, 0)
		var_3_0:ZoomCamara(nil, nil, self._duration)
	end

	var_3_0:BulletTime(var_0_1.SPEED_FACTOR_FOCUS_CHARACTER, nil)
	self:doPass()

	return
end

return
