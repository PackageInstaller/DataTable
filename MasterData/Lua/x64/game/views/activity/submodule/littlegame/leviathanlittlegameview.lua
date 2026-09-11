local LeviathanLittleGameView = class("LeviathanLittleGameView", ReduxView)

function LeviathanLittleGameView:UIName()
	return "UI/VersionUI/SummerUI/SummerzoawdUI"
end

function LeviathanLittleGameView:UIParent()
	return manager.ui.uiMain.transform
end

function LeviathanLittleGameView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_, true)
end

function LeviathanLittleGameView:AddUIListener()
	self:AddBtnListener(self.buttonBtn_, nil, function()
		if self:IsOpenSectionInfo() then
			JumpTools.Back()
		else
			JumpTools.OpenPageByJump("leviathanGameReward")
		end
	end)
end

function LeviathanLittleGameView:IsOpenSectionInfo()
	return self:IsOpenRoute("leviathanSectionInfo")
end

function LeviathanLittleGameView:InitBtns()
	if not self.itemView_ then
		self.itemView_ = {}

		for iter_7_0, iter_7_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
			self.itemView_[iter_7_1] = LeviathanLittleGameItem.New(self[string.format("itemGo_%d", iter_7_0)], iter_7_1, self.activityID_, iter_7_0)

			self.itemView_[iter_7_1]:AddClickFunc(function(arg_8_0)
				self.selIndex_ = arg_8_0

				self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
			end)
		end
	end
end

function LeviathanLittleGameView:OnUpdate()
	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
end

function LeviathanLittleGameView:OnEnter()
	self.activityID_ = ActivityConst.LEVIATHAN_GAME

	local var_10_0 = ActivityTools.GetGameHelpKey(self.activityID_)

	if var_10_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_10_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	self:InitBtns()

	for iter_10_0, iter_10_1 in pairs(self.itemView_) do
		iter_10_1:OnEnter()
	end

	self.descText_.text = GetTips("ACTIVITY__BUBBLES_CONTENT")
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()
	manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_LEVEL, 0)
	manager.redPoint:bindUIandKey(self.buttonBtn_.transform, RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD)
	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
end

function LeviathanLittleGameView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
	self.scrollMoveView_:OnExit()

	for iter_11_0, iter_11_1 in pairs(self.itemView_) do
		iter_11_1:OnExit()
	end

	manager.redPoint:unbindUIandKey(self.buttonBtn_.transform, RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD)
end

function LeviathanLittleGameView:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.itemView_) do
		iter_12_1:Dispose()
	end

	self.itemView_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil

	LeviathanLittleGameView.super.Dispose(self)
end

function LeviathanLittleGameView:GetScrollWidth()
	return 2777
end

function LeviathanLittleGameView:GetScrollPos()
	return self.selIndex_ and self[string.format("itemGo_%d", self.selIndex_)].transform.localPosition.x or 0
end

function LeviathanLittleGameView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.remainText_.text = GetTips("TIME_OVER")

		return
	end

	self.remainText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainText_.text = GetTips("TIME_OVER")

			return
		end

		self.remainText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 0.33, -1)

	self.timer_:Start()
end

function LeviathanLittleGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return LeviathanLittleGameView
