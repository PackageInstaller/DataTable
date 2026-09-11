local RogueCardGameStep = class("RogueCardGameStep", ComponentStep)
local var_0_1 = {
	24301,
	24306,
	24308,
	24404,
	24502,
	24504,
	24506,
	24601,
	24603,
	24605,
	24702,
	247101
}
local var_0_2 = {
	[var_0_1[1]] = {
		2,
		3,
		4
	},
	[var_0_1[2]] = {
		2,
		3,
		4
	},
	[var_0_1[3]] = {
		0,
		1,
		2
	},
	[var_0_1[4]] = 0,
	[var_0_1[5]] = 100,
	[var_0_1[6]] = 1,
	[var_0_1[7]] = 0,
	[var_0_1[8]] = 101,
	[var_0_1[9]] = 1,
	[var_0_1[10]] = 1,
	[var_0_1[11]] = 0,
	[var_0_1[12]] = 0
}

function RogueCardGameStep:Init()
	RogueCardGameStep.super.Init(self)

	self._eventName = GuideStepCfg[self._stepId].params[1]
end

function RogueCardGameStep:EventTrigger(arg_2_1, arg_2_2)
	return
end

function RogueCardGameStep:Play()
	manager.guide.view:Init()
	self:ShowTalk()

	local var_3_0 = self:AnalyzeComponentCfg(self._maskComponentCfg)

	manager.guide.view:ShowHoldMask((var_3_0 or nil) and (var_3_0.gameObject or self:Component().gameObject), self._maskScale, self._params)

	local var_3_1 = false

	if self._stepId == var_0_1[1] or self._stepId == var_0_1[2] or self._stepId == var_0_1[3] then
		self:SetRayCastTargetActive(false)
		RogueCard.RogueCardGameMain.Instance:LockGuide(1, {
			var_0_2[self._stepId][1],
			var_0_2[self._stepId][2],
			var_0_2[self._stepId][3]
		})

		var_3_1 = true
		self.timer_ = Timer.New(function()
			if self._stepId == nil then
				return
			end

			local var_4_0 = var_0_2[self._stepId]

			if var_0_2[self._stepId] == nil then
				return
			end

			if not RogueCard.RogueCardGameMain.Instance then
				self.timer_:Stop()

				self.timer_ = nil

				return
			end

			if RogueCard.RogueCardGameMain.Instance:CheckSelectCard(var_4_0[1], var_4_0[2], var_4_0[3]) then
				if var_3_1 then
					RogueCard.RogueCardGameMain.Instance:UnlockGuide()

					var_3_1 = false
				end

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
	elseif self._stepId == var_0_1[4] or self._stepId == var_0_1[5] or self._stepId == var_0_1[8] or self._stepId == var_0_1[11] or self._stepId == var_0_1[12] then
		self:SetRayCastTargetActive(false)
		RogueCard.RogueCardGameMain.Instance:LockGuide(3, {
			var_0_2[self._stepId]
		})

		var_3_1 = true
		self.timer_ = Timer.New(function()
			if self._stepId == nil then
				return
			end

			local var_5_0 = var_0_2[self._stepId]

			if var_0_2[self._stepId] == nil then
				return
			end

			if not RogueCard.RogueCardGameMain.Instance then
				self.timer_:Stop()

				self.timer_ = nil

				return
			end

			if RogueCard.RogueCardGameMain.Instance:CheckSelectShopItem(var_5_0) then
				if var_3_1 then
					RogueCard.RogueCardGameMain.Instance:UnlockGuide()

					var_3_1 = false
				end

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
	elseif self._stepId == var_0_1[6] or self._stepId == var_0_1[9] or self._stepId == var_0_1[10] then
		self:SetRayCastTargetActive(false)
		RogueCard.RogueCardGameMain.Instance:LockGuide(4, {
			var_0_2[self._stepId]
		})

		var_3_1 = true
		self.timer_ = Timer.New(function()
			if self._stepId == nil then
				return
			end

			local var_6_0 = var_0_2[self._stepId]

			if var_0_2[self._stepId] == nil then
				return
			end

			if not RogueCard.RogueCardGameMain.Instance then
				self.timer_:Stop()

				self.timer_ = nil

				return
			end

			if RogueCard.RogueCardGameMain.Instance:CheckSelectPackageItem(var_6_0) then
				if var_3_1 then
					RogueCard.RogueCardGameMain.Instance:UnlockGuide()

					var_3_1 = false
				end

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
	elseif self._stepId == var_0_1[7] then
		self:SetRayCastTargetActive(false)
		RogueCard.RogueCardGameMain.Instance:LockGuide(2, {
			var_0_2[self._stepId]
		})

		var_3_1 = true
		self.timer_ = Timer.New(function()
			if self._stepId == nil then
				return
			end

			local var_7_0 = var_0_2[self._stepId]

			if var_0_2[self._stepId] == nil then
				return
			end

			if not RogueCard.RogueCardGameMain.Instance then
				self.timer_:Stop()

				self.timer_ = nil

				return
			end

			if RogueCard.RogueCardGameMain.Instance:CheckSelectJokerItem(var_7_0) then
				if var_3_1 then
					RogueCard.RogueCardGameMain.Instance:UnlockGuide()

					var_3_1 = false
				end

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
	else
		self:SetRayCastTargetActive(true)
	end
end

function RogueCardGameStep:SetRayCastTargetActive(arg_8_1)
	manager.guide.view.maskImage1_:GetComponent("AdditionMask").raycastTarget = arg_8_1
	manager.guide.view.maskImage2_:GetComponent("AdditionMask").raycastTarget = arg_8_1
	manager.guide.view.mask_.transform:GetComponent(typeof(Image)).raycastTarget = arg_8_1
	manager.guide.view.maskUI_.transform:GetComponent(typeof(Image)).raycastTarget = arg_8_1
	manager.guide.view.btnMaskCom_:GetComponent(typeof(Image)).raycastTarget = arg_8_1
	manager.guide.view.mask_.transform:Find("HoleImage"):GetComponent("HoleImage").raycastTarget = arg_8_1
end

function RogueCardGameStep:Component()
	if self._component == nil then
		self:SetSpecialParams()

		self._component = self:AnalyzeComponentCfg(self._guideComponentCfg)
	end

	return self._component
end

return RogueCardGameStep
