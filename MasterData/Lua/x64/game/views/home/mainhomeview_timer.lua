local var_0_0 = partialClass("MainHomeView", ReduxView)

function var_0_0:StartRefreshUITimer()
	if self.updateTimer == nil then
		self.updateTimer = Timer.New(function()
			self:RefreshRealtimeUI()
		end, 1, -1)
	end

	self.updateTimer:Start()
end

function var_0_0:StartShowTimer(arg_3_1)
	if self.showTimer_ or not (arg_3_1 and #arg_3_1 > 0) then
		return
	end

	local var_3_0 = Timer.New(function()
		self.showTimer_ = nil

		if manager.guide:IsPlaying() then
			return
		end

		if arg_3_1 then
			arg_3_1[1]()

			return
		end
	end, 1, 1)

	self.showTimer_ = var_3_0

	var_3_0:Start()
end

function var_0_0:ClearMsgTimer()
	if self.msgTimer_ then
		self.msgTimer_:Stop()

		self.msgTimer_ = nil
	end
end

function var_0_0:StartViewHideTimer()
	self:StopViewHideTimer()
	self:SetPureModeBtnActive(true, true)

	self.viewHideTimer_ = Timer.New(function()
		self:StopViewHideTimer()
		self:SetPureModeBtnActive(false, true)
	end, 3, 1)

	self.viewHideTimer_:Start()
end

function var_0_0:StopViewHideTimer()
	if self.viewHideTimer_ then
		self.viewHideTimer_:Stop()

		self.viewHideTimer_ = nil
	end
end

function var_0_0:StopAllTimers()
	self:ClearMsgTimer()
	self:StopViewHideTimer()

	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	if self.showTimer_ then
		self.showTimer_:Stop()

		self.showTimer_ = nil
	end

	if self.activiteTime_ then
		self.activiteTime_:Stop()

		self.activiteTime_ = nil
	end

	if self.multiTouchTimer_ then
		self.multiTouchTimer_:Stop()

		self.multiTouchTimer_ = nil
	end
end
