local DragStep = class("DragStep", ComponentStep)

function DragStep:Init()
	DragStep.super.Init(self)

	self._dragGuideComponentCfg = GuideStepCfg[self._stepId].drag_guide_component
	self._dragMaskComponentCfg = GuideStepCfg[self._stepId].drag_mask_component
end

function DragStep:Check()
	return self:Component() ~= nil and self._dragConponent ~= nil
end

function DragStep:Component()
	if self._component == nil then
		self:SetSpecialParams()

		self._component = self:AnalyzeComponentCfg(self._guideComponentCfg)
		self._dragConponent = self:AnalyzeComponentCfg(self._dragGuideComponentCfg)
	end

	return self._component, self._dragConponent
end

function DragStep:EventTrigger(arg_4_1, arg_4_2)
	if arg_4_1 == "beginDrag" then
		self._dragConponent:OnBeginDrag(arg_4_2)
	elseif arg_4_1 == "drag" then
		self._dragConponent:OnDrag(arg_4_2)
	elseif arg_4_1 == "endDrag" then
		self._dragConponent:OnEndDrag(arg_4_2)

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		self.timer_ = Timer.New(function()
			if self:CheckDragSuccess() then
				self:OnStepEnd()
			end

			self.timer_:Stop()

			self.timer_ = nil
		end, 0.33, -1)

		self.timer_:Start()
	end
end

function DragStep:Play()
	manager.guide.view:Init()

	local var_6_0, var_6_1 = self:Component()

	self:ShowTalk()

	local var_6_2 = self:AnalyzeComponentCfg(self._maskComponentCfg)

	manager.guide.view:ShowHoldMask((var_6_2 or nil) and (var_6_2.gameObject or var_6_0.gameObject), self._maskScale, self._params)

	if #self._dragGuideComponentCfg > 0 then
		local var_6_3 = self:AnalyzeComponentCfg(self._dragMaskComponentCfg)

		manager.guide.view:ShowHoldMask2((var_6_3 or nil) and (var_6_3.gameObject or var_6_1.gameObject), self._maskScale, self._params)
	end
end

function DragStep:CheckDragSuccess()
	return true
end

return DragStep
