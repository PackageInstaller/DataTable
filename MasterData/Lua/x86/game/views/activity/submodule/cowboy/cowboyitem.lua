local CowboyItem = class("CowboyItem", ReduxView)

function CowboyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CowboyItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyItem:InitUI()
	self:BindCfgUI()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function CowboyItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 < self.stopTime_ and var_5_0 >= self.startTime_ then
			CowboyData:SetOpen(self.activityID_)
			SetActive(self.redGo_, false)
			CowboyAction:RefreshOpen(self.activityID_)
			JumpTools.OpenPageByJump("cowboyReady", {
				mainActivityID = self.mainActivityID_,
				activityID = self.activityID_,
				index = self.index_
			})
		elseif manager.time:GetServerTime() < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function CowboyItem:OnEnter()
	return
end

function CowboyItem:RefreshUI(arg_7_1, arg_7_2)
	self.mainActivityID_ = arg_7_1
	self.activityID_ = arg_7_2

	self:RefreshData()
	self:RefreshTime()
end

function CowboyItem:RefreshData()
	self.data_ = CowboyData:GetData(self.activityID_)
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)

	if self.data_ and self.activityData_:IsActivitying() and not CowboyData:GetOpen(self.activityID_) then
		SetActive(self.redGo_, true)
	else
		SetActive(self.redGo_, false)
	end

	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function CowboyItem:RefreshTime()
	local var_9_0

	self:StopTimer()

	if manager.time:GetServerTime() < self.startTime_ and self.activityData_:IsActivitying() == false then
		self.stateCon_:SetSelectedState("close")

		self.timeTxt_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
		self.timer_ = Timer.New(function()
			var_9_0 = self.startTime_ - manager.time:GetServerTime()

			if var_9_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeTxt_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
		end, 1, -1)

		self.timer_:Start()
	elseif self.data_ and self.data_.score > -10000 then
		self.stateCon_:SetSelectedState("finish")

		self.score_.text = self.data_.score
	else
		self.stateCon_:SetSelectedState("open")
	end
end

function CowboyItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function CowboyItem:RefreshLevelText(arg_12_1)
	self.index_ = arg_12_1
	self.levelText_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), arg_12_1)
end

function CowboyItem:OnExit()
	self:StopTimer()
end

function CowboyItem:Dispose()
	self:RemoveAllListeners()
	CowboyItem.super.Dispose(self)
end

return CowboyItem
