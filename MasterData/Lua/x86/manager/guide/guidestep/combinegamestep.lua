local CombineGameStep = class("CombineGameStep", ComponentStep)
local var_0_1 = {
	[5919] = {
		1,
		3,
		1
	},
	[5924] = {
		3,
		2,
		3
	},
	[5930] = {
		3,
		3,
		2
	},
	[5935] = {
		0,
		0,
		0
	},
	[5939] = {
		4,
		0,
		0
	}
}

function CombineGameStep:Init()
	CombineGameStep.super.Init(self)

	self._eventName = GuideStepCfg[self._stepId].params[1]
end

function CombineGameStep:EventTrigger(arg_2_1, arg_2_2)
	if self._stepId == 5918 or self._stepId == 5923 or self._stepId == 5929 then
		CombineGameWorld.Instance.canDrag = true

		self:OnStepEnd()

		return
	end

	if (self._stepId == 5934 or self._stepId == 5938) and arg_2_1 == "pointerDown" then
		CombineGameWorld.Instance.canDrag = true

		self:OnStepEnd()

		return
	end

	if self._stepId == 5943 then
		CombineGameWorld.Instance.isTeach = false
		CombineGameWorld.Instance.canDrag = true

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

		if CombineGameWorld.Instance:CheckBlock(var_3_0[1], var_3_0[2], var_3_0[3]) then
			CombineGameWorld.Instance.canDrag = false

			self:OnStepEnd()
		elseif self._stepId == 5935 or self._stepId == 5939 then
			if self._guide == nil then
				return
			end

			self._guide:AddNextStep(GuideStepCfg[self._stepId])
			self._guide:AddNextStep(GuideStepCfg[self._stepId - 1])
			self:OnStepEnd()
		end
	end, {})
end

return CombineGameStep
