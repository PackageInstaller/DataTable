local BloodCardGameStep = class("BloodCardGameStep", ComponentStep)
local var_0_1 = {
	[10807] = 6
}

function BloodCardGameStep:Init()
	BloodCardGameStep.super.Init(self)

	self._eventName = GuideStepCfg[self._stepId].params[1]
end

function BloodCardGameStep:EventTrigger(arg_2_1, arg_2_2)
	if self._stepId == 10806 and arg_2_1 == "pointerDown" then
		self:OnStepEnd()

		return
	end
end

function BloodCardGameStep:Play()
	manager.guide.view:Init()
	self:ShowTalk()

	local var_3_0 = self:AnalyzeComponentCfg(self._maskComponentCfg)

	manager.guide.view:ShowHoldMask((var_3_0 or nil) and (var_3_0.gameObject or self:Component().gameObject), self._maskScale, self._params)

	if self._stepId == 10807 then
		self:SetRayCastTargetActive(false)
		BloodCardManager.Instance:LockCell(true, 5)

		self.timer_ = Timer.New(function()
			if self._stepId == nil then
				return
			end

			local var_4_0 = var_0_1[self._stepId]

			if var_0_1[self._stepId] == nil then
				return
			end

			if not BloodCardManager.Instance then
				self.timer_:Stop()

				self.timer_ = nil

				return
			end

			if BloodCardManager.Instance:CheckCell(var_4_0) then
				BloodCardManager.Instance:LockCell(false, -1)
				self:SetRayCastTargetActive(true)
				self:OnStepEnd()

				if self.timer_ then
					self.timer_:Stop()

					self.timer_ = nil
				end
			else
				return
			end
		end, 0.1, -1)

		self.timer_:Start()
	elseif self._stepId == 10901 then
		self:SetRayCastTargetActive(false)
		BloodCardManager.Instance:LockCardLisener(true)

		self.timer_ = Timer.New(function()
			if not BloodCardManager.Instance then
				self.timer_:Stop()

				self.timer_ = nil

				return
			end

			if BloodCardManager.Instance.sufferCardIndexs.Count > 0 then
				self:SetRayCastTargetActive(true)
				BloodCardManager.Instance:LockCardLisener(false)
				self:OnStepEnd()

				if self.timer_ then
					self.timer_:Stop()

					self.timer_ = nil
				end
			else
				return
			end
		end, 0.1, -1)

		self.timer_:Start()
	else
		self:SetRayCastTargetActive(true)
	end
end

function BloodCardGameStep:SetRayCastTargetActive(arg_6_1)
	manager.guide.view.maskImgCom1_:GetComponent("AdditionMask").raycastTarget = arg_6_1
	manager.guide.view.maskImgCom2_:GetComponent("AdditionMask").raycastTarget = arg_6_1
	manager.guide.view.mask_.transform:GetComponent(typeof(Image)).raycastTarget = arg_6_1
	manager.guide.view.maskUI_.transform:GetComponent(typeof(Image)).raycastTarget = arg_6_1
	manager.guide.view.btnMaskCom_:GetComponent(typeof(Image)).raycastTarget = arg_6_1
	manager.guide.view.mask_.transform:Find("HoleImage"):GetComponent("HoleImage").raycastTarget = arg_6_1
end

function BloodCardGameStep:Component()
	if self._component == nil then
		self:SetSpecialParams()

		self._component = self:AnalyzeComponentCfg(self._guideComponentCfg)
	end

	return self._component
end

return BloodCardGameStep
