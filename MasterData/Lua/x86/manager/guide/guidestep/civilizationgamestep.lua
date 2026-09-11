local CivilizationGameStep = class("CivilizationGameStep", ComponentStep)
local var_0_1 = {
	[12313] = {
		1,
		3,
		1
	},
	[12316] = {
		4,
		4,
		2
	},
	[12321] = {
		3,
		2,
		3
	},
	[12324] = {
		0,
		0,
		0
	}
}

function CivilizationGameStep:Init()
	CivilizationGameStep.super.Init(self)

	self._eventName = GuideStepCfg[self._stepId].params[1]
end

function CivilizationGameStep:EventTrigger(arg_2_1, arg_2_2)
	if self._stepId == 12312 or self._stepId == 12315 or self._stepId == 12320 then
		civilization.CivilizationLuaBridge.SetGameCanDrag(true, true)
		self:OnStepEnd()

		return
	end

	if self._stepId == 12323 and arg_2_1 == "pointerDown" then
		civilization.CivilizationLuaBridge.SetGameCanDrag(true, true)
		self:OnStepEnd()

		return
	end

	if self._stepId == 12603 then
		civilization.CivilizationLuaBridge.SetGameCanDrag(false, false)
		self:OnStepEnd()

		return
	end

	if self._stepId == 12609 then
		civilization.CivilizationLuaBridge.SetGameCanDrag(true, false)
		self:OnStepEnd()

		return
	end

	TimeTools.StartAfterSeconds(0.1, function()
		if self._stepId == nil then
			return
		end

		local var_3_0 = var_0_1[self._stepId]

		if var_0_1[self._stepId] == nil then
			return
		end

		if var_3_0 ~= nil and civilization.CivilizationLuaBridge.CheckBlock(var_3_0[1], var_3_0[2], var_3_0[3]) then
			civilization.CivilizationLuaBridge.SetGameCanDrag(false, false)
			self:OnStepEnd()
		elseif self._stepId == 12324 then
			if self._guide == nil then
				return
			end

			self._guide:AddNextStep(GuideStepCfg[self._stepId])
			self._guide:AddNextStep(GuideStepCfg[self._stepId - 1])
			self:OnStepEnd()
		end
	end, {})
end

return CivilizationGameStep
