local SailLotteryItem = class("SailLotteryItem", ReduxView)

function SailLotteryItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function SailLotteryItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.resultController_ = ControllerUtil.GetController(self.transform_, "result")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.pointController_ = ControllerUtil.GetController(self.transform_, "point")
	self.originPos_ = self.transform_.localPosition
end

function SailLotteryItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.selectCallback_ then
			self.selectCallback_(self.index_)
		end
	end)
end

function SailLotteryItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil
	self.selectCallback_ = nil

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.posLeanTween_ then
		self.posLeanTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.posLeanTween_.id)

		self.posLeanTween_ = nil
	end

	SailLotteryItem.super.Dispose(self)
end

function SailLotteryItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.activityID_ = arg_6_2

	self:Recover()
end

function SailLotteryItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function SailLotteryItem:SetPoint(arg_8_1, arg_8_2)
	self.point_ = arg_8_1
	self.isMine_ = arg_8_2
	self.pointText_.text = arg_8_1

	self.pointController_:SetSelectedState(arg_8_1)
end

function SailLotteryItem:Recover()
	self:SetActive(true)

	if self.originPos_ then
		self.transform_.localPosition = self.originPos_
	end

	self.statusController_:SetSelectedState("origin")
	self.resultController_:SetSelectedState("none")
	self.selectController_:SetSelectedState("false")
	self.animator_:Play("cardItem_normal", -1, 0)
	self.animator_:Update(0)
end

function SailLotteryItem:SetResult(arg_10_1)
	self.win_ = arg_10_1
end

function SailLotteryItem:SetSelecteCallback(arg_11_1)
	self.selectCallback_ = arg_11_1
end

function SailLotteryItem:SetTargetPos(arg_12_1)
	self.targetPos_ = arg_12_1

	self:PlayMoveAnim()
end

function SailLotteryItem:PlayExitAnim()
	local var_13_0 = "cardItem_ex"

	self.animator_:Play("cardItem_ex", -1, 0)
	self.animator_:Update(0)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.timer_ = Timer.New(function()
		local var_14_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if var_14_0:IsName(var_13_0) and var_14_0.normalizedTime >= 1 then
			if self.timer_ ~= nil then
				self.timer_:Stop()

				self.timer_ = nil
			end

			self:SetActive(false)
		end
	end, 0.033, -1)

	self.timer_:Start()
end

function SailLotteryItem:PlayMoveAnim()
	self.posLeanTween_ = LeanTween.moveLocal(self.gameObject_, self.targetPos_, 0.25):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		if self.posLeanTween_ then
			self.posLeanTween_:setOnComplete(nil)

			self.posLeanTween_ = nil
		end

		self:PlayRotaAnim()
	end))
end

function SailLotteryItem:PlayRotaAnim()
	local var_17_0 = "cardItem"

	self.animator_:Play("cardItem", -1, 0)
	self.animator_:Update(0)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	local var_17_1 = false

	self.timer_ = Timer.New(function()
		local var_18_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if var_18_0:IsName(var_17_0) then
			if not var_17_1 and var_18_0.normalizedTime >= 0.5 then
				var_17_1 = true

				self.statusController_:SetSelectedState(self.isMine_ and "selfPoint" or "oppositePoint")
				self.selectController_:SetSelectedState(self.isMine_ and "true" or "false")
			elseif var_18_0.normalizedTime >= 1 then
				if self.timer_ ~= nil then
					self.timer_:Stop()

					self.timer_ = nil
				end

				if self.isMine_ then
					self.resultController_:SetSelectedState(self.win_ and "victory" or "lose")
					manager.notify:CallUpdateFunc(SAIL_EVENT_LOTTERY_WAIT_END)
				end
			end
		end
	end, 0.033, -1)

	self.timer_:Start()

	if self.isMine_ == true then
		if self.win_ == true then
			manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_win", "")
		else
			manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_fail", "")
		end
	end
end

return SailLotteryItem
