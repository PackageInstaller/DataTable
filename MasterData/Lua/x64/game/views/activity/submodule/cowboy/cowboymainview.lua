local CowboyMainView = class("CowboyMainView", ReduxView)

function CowboyMainView:UIName()
	return CowboyTools.GetMainUIName(self.params_.activityID)
end

function CowboyMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CowboyMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyMainView:InitUI()
	self:BindCfgUI()

	self.list_ = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, CowboyItem)
end

function CowboyMainView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.activityID_, self.list_[arg_5_1])
	arg_5_2:RefreshLevelText(arg_5_1)
end

function CowboyMainView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("cowBoyReward", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("cowBoyInfo", {
			activityID = self.activityID_
		})
	end)
end

function CowboyMainView:OnEnter()
	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_entrance_animation", "")
	self:GetActivityData()
	self:RefreshUI()
	self:BindUIRedPoint()
end

function CowboyMainView:GetActivityData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function CowboyMainView:RefreshUI()
	self:RefreshList()
	self:RefreshTime()
end

function CowboyMainView:RefreshList()
	self.list_ = ActivityCfg[self.activityID_].sub_activity_list
	self.lastLevel_ = CowboyData:GetLastLevel(self.activityID_)

	if not self.lastLevel_ or not table.indexof(self.list_, self.lastLevel_) then
		self.scrollHelper_:StartScroll(#self.list_)
	else
		self.scrollHelper_:StartScroll(#self.list_, (table.indexof(self.list_, self.lastLevel_)))
	end
end

function CowboyMainView:RefreshTime()
	local var_14_0
	local var_14_1 = manager.time:GetServerTime()

	self:StopTimer()

	if var_14_1 < self.startTime_ and self.activityData_:IsActivitying() == false then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_14_0 = self.startTime_ - manager.time:GetServerTime()

			if var_14_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_14_1 < self.stopTime_ then
		self.timeTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(self.stopTime_))
		self.timer_ = Timer.New(function()
			var_14_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_14_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(self.stopTime_))
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function CowboyMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function CowboyMainView:BindUIRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.COWBOY_REWARD .. "_" .. self.activityID_)
end

function CowboyMainView:UnBindUIRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.COWBOY_REWARD .. "_" .. self.activityID_)
end

function CowboyMainView:OnTop()
	return
end

function CowboyMainView:OnExit()
	self:StopTimer()
	self:UnBindUIRedPoint()

	for iter_21_0, iter_21_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_21_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function CowboyMainView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	CowboyMainView.super.Dispose(self)
end

return CowboyMainView
