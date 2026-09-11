local BilliardGameDragStep = class("BilliardGameDragStep", DragStep)

function BilliardGameDragStep:Init()
	BilliardGameDragStep.super.Init(self)
end

function BilliardGameDragStep:Component()
	if self._component == nil then
		self:SetSpecialParams()

		self._component = self:AnalyzeComponentCfg(self._guideComponentCfg)
		self._dragConponent = BilliardGameLuaBridge.GetTrigger()
	end

	return self._component, self._dragConponent
end

function BilliardGameDragStep:EventTrigger(arg_3_1, arg_3_2)
	if arg_3_1 == "beginDrag" then
		self._dragConponent:OnBeginDrag(arg_3_2)
	elseif arg_3_1 == "drag" then
		self._dragConponent:OnDrag(arg_3_2)
	elseif arg_3_1 == "endDrag" then
		self._dragConponent:OnEndDrag(arg_3_2)

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		self.timer_ = Timer.New(function()
			if self:CheckDragSuccess() then
				SetActive(self:GetViewComponent(self._guideComponentCfg[2], {
					"guideGo_"
				}), false)
				self:OnStepEnd()
			end

			self.timer_:Stop()

			self.timer_ = nil
		end, 0.4, 1)

		self.timer_:Start()
	end
end

function BilliardGameDragStep:Play()
	manager.guide.view:Init()

	local var_5_0, var_5_1 = self:Component()

	self:ShowTalk()

	local var_5_2 = self:AnalyzeComponentCfg(self._maskComponentCfg)

	manager.guide.view:ShowHoldMask((var_5_2 or nil) and (var_5_2.gameObject or var_5_0.gameObject), self._maskScale, self._params)

	if #self._dragGuideComponentCfg > 0 then
		local var_5_3 = self:AnalyzeComponentCfg(self._dragMaskComponentCfg)

		manager.guide.view:ShowHoldMask2((var_5_3 or nil) and (var_5_3.gameObject or var_5_1.gameObject), self._maskScale, self._params)
	end

	BilliardGameLuaBridge.SetGuideInfo(self._params[1], self._params[2])
	SetActive(self:GetViewComponent(self._guideComponentCfg[2], {
		"guideGo_"
	}), true)
end

function BilliardGameDragStep:CheckDragSuccess()
	return BilliardGameLuaBridge.CheckDrag(self._params[1], self._params[2])
end

return BilliardGameDragStep
