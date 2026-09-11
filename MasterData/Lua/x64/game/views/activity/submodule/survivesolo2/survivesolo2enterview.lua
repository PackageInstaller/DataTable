ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SurviveSolo2EnterView = class("SurviveSolo2EnterView", ActivityMainBasePanel)

function SurviveSolo2EnterView:GetUIName()
	return SurviveSolo2Tools.GetEnterUIName(self.activityID_)
end

function SurviveSolo2EnterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SurviveSolo2EnterView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SurviveSolo2EnterItem)
end

function SurviveSolo2EnterView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshData(self.activityID_, self.activityList_[arg_4_1])
	arg_4_2:RefreshTime((manager.time:GetServerTime()))
end

function SurviveSolo2EnterView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("surviveSoloReward2", {
			activityId = self.activityID_
		})
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_7_0 = SurviveSolo2Tools.GetGameHelpKey(self.activityID_)

		if var_7_0 ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(var_7_0),
				key = var_7_0
			})
		end
	end)
end

function SurviveSolo2EnterView:OnEnter()
	self:BindUIRedPoint()
	self:RefreshUI()
end

function SurviveSolo2EnterView:RefreshUI()
	self:RefreshActivityData()
	self:RefreshTime()
	self:RefreshList()
end

function SurviveSolo2EnterView:RefreshActivityData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function SurviveSolo2EnterView:RefreshTime()
	local var_11_0
	local var_11_1 = manager.time:GetServerTime()

	self:StopTimer()

	if var_11_1 < self.startTime_ then
		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_11_0 = self.startTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_11_1 < self.stopTime_ then
		self.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
		self.timer_ = Timer.New(function()
			var_11_1 = manager.time:GetServerTime()

			if self.stopTime_ <= var_11_1 then
				self:StopTimer()
				self:RefreshTime()

				return
			else
				self.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLable_.text = GetTips("TIME_OVER")
	end
end

function SurviveSolo2EnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SurviveSolo2EnterView:RefreshList()
	self.activityList_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[self.activityID_]

	self.scrollHelper_:StartScroll(#self.activityList_)
	self:StartItemTimer()
end

function SurviveSolo2EnterView:StartItemTimer()
	self:StopItemTimer()

	self.itemTimer_ = Timer.New(function()
		local var_17_0 = manager.time:GetServerTime()

		for iter_17_0, iter_17_1 in pairs(self.scrollHelper_:GetItemList()) do
			iter_17_1:RefreshTime(var_17_0)
		end
	end, 1, -1)

	self.itemTimer_:Start()
end

function SurviveSolo2EnterView:StopItemTimer()
	if self.itemTimer_ then
		self.itemTimer_:Stop()

		self.itemTimer_ = nil
	end
end

function SurviveSolo2EnterView:Show(arg_19_1)
	SurviveSolo2EnterView.super.Show(self, arg_19_1)

	if arg_19_1 then
		self:RefreshList()
	end
end

function SurviveSolo2EnterView:BindUIRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. self.activityID_)
end

function SurviveSolo2EnterView:UnbindUIRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.gameObject.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. self.activityID_)
end

function SurviveSolo2EnterView:OnExit()
	self:RemoveAllEventListener()
	self:UnbindUIRedPoint()
	self:StopItemTimer()
	self:StopTimer()

	for iter_22_0, iter_22_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_22_1:OnExit()
	end
end

function SurviveSolo2EnterView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return SurviveSolo2EnterView
