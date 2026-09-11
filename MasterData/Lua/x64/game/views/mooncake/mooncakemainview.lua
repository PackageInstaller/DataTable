local MoonCakeMainView = class("MoonCakeMainView", ReduxView)

function MoonCakeMainView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeMainUI"
end

function MoonCakeMainView:UIParent()
	return manager.ui.uiMain.transform
end

function MoonCakeMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonCakeMainView:InitUI()
	self:BindCfgUI()
end

function MoonCakeMainView:AddUIListener()
	self:AddBtnListener(self.makeFillingBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectMakeFillingBtn(self.activityID_)
		MoonCakeAction.UpdateFillingMakeRedPoint(self.activityID_)
		JumpTools.OpenPageByJump("moonFillingMake", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.makeMoonCakeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectMakeCakeBtn(self.activityID_)
		MoonCakeAction.UpdateCakeMakeRedPoint(self.activityID_)
		JumpTools.OpenPageByJump("moonCakeMake", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.bagBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/moonCakeBag", {
			activityID = self.activityID_,
			mainActivityID = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.delegateBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.RefreshRecommendDelegate(self.activityID_, function()
			JumpTools.OpenPageByJump("moonCakeDelegate", {
				activityID = self.activityID_
			})
		end)
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeTask", {
			stage = 1,
			activityID = self.activityID_
		})
	end)
end

function MoonCakeMainView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.activityID_ = self.params_.activityID
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()
	self:RefreshUI()
	self:BindRedPoint()
end

function MoonCakeMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MoonCakeMainView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:UnBindRedPoint()
end

function MoonCakeMainView:RefreshUI()
	return
end

function MoonCakeMainView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)

	self:StopTimer()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function MoonCakeMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function MoonCakeMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activityID_)))
	manager.redPoint:bindUIandKey(self.makeFillingBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, self.activityID_)))
	manager.redPoint:bindUIandKey(self.makeMoonCakeBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, self.activityID_)))
	manager.redPoint:bindUIandKey(self.bagBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, self.activityID_)))
	manager.redPoint:bindUIandKey(self.delegateBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_DELEGATE, self.activityID_)))
end

function MoonCakeMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.makeFillingBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.makeMoonCakeBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.bagBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.delegateBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_DELEGATE, self.activityID_)))
end

return MoonCakeMainView
