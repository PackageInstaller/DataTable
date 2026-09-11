ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityUseDunDunView = class("ActivityUseDunDunView", ActivityMainBasePanel)
local var_0_1 = "USE_DUNDUN_INFO"

function ActivityUseDunDunView:GetUIName()
	return ActivityUseDunDunTools.GetUINameKey(self.activityID_)
end

function ActivityUseDunDunView:Init()
	ActivityUseDunDunView.super.Init(self)

	self.rewardController1_ = self.rewardControllerEx1_:GetController("reward")
	self.rewardController2_ = self.rewardControllerEx2_:GetController("reward")
	self.pointList_ = {}
end

function ActivityUseDunDunView:OnEnter()
	ActivityUseDunDunView.super.OnEnter(self)
	self:RefreshUI()
end

function ActivityUseDunDunView:BindRedPoint()
	for iter_4_0, iter_4_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]) do
		manager.redPoint:bindUIandKey(self["rewardBtn" .. iter_4_0 .. "_"], RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_4_1)
	end
end

function ActivityUseDunDunView:RefreshTimeText()
	self.timeText_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
end

function ActivityUseDunDunView:RefreshUI()
	self.desText_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc
	self.activityNameText_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name

	local var_6_0 = ActivityPointData:GetCurDunDunPoint(self.activityID_)

	self.sliderText_.text = var_6_0
	self.heroText_.text = HeroTools.GetHeroFullName(ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_][1]].reward_item_list[1][1])

	local var_6_1 = 0
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]) do
		if var_6_1 < ActivityPointRewardCfg[iter_6_1].need then
			var_6_1 = ActivityPointRewardCfg[iter_6_1].need
		end

		table.insert(var_6_2, ActivityPointRewardCfg[iter_6_1].need)
	end

	table.sort(var_6_2)

	self.pointList_ = var_6_2
	self.slider_.value = var_6_0 / var_6_1
	self.rewardText1_.text = self.pointList_[1]

	if var_6_0 >= self.pointList_[1] then
		local var_6_3

		for iter_6_2, iter_6_3 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]) do
			if ActivityPointRewardCfg[iter_6_3].need == self.pointList_[1] then
				var_6_3 = iter_6_3
			end
		end

		if ActivityPointData:GetUseDunDunRewardIsGet(self.activityID_, var_6_3) then
			self.rewardController1_:SetSelectedState("received")
		else
			self.rewardController1_:SetSelectedState("select")
		end
	else
		self.rewardController1_:SetSelectedState("normal")
	end

	self.rewardText2_.text = self.pointList_[2]

	if var_6_0 >= self.pointList_[2] then
		local var_6_4

		for iter_6_4, iter_6_5 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]) do
			if ActivityPointRewardCfg[iter_6_5].need == self.pointList_[2] then
				var_6_4 = iter_6_5
			end
		end

		if ActivityPointData:GetUseDunDunRewardIsGet(self.activityID_, var_6_4) then
			self.rewardController2_:SetSelectedState("received")
		else
			self.rewardController2_:SetSelectedState("select")
		end
	else
		self.rewardController2_:SetSelectedState("normal")
	end

	local var_6_5, var_6_6 = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(2, nil)

	if var_6_5 > 0 then
		local var_6_7, var_6_8 = ActivityMultiRewardData:GetCountByActivityID(var_6_6)

		self.multiCountText_.text = var_6_7 .. "/" .. var_6_8
		self.multiRatioText_.text = var_6_5 / 100

		SetActive(self.multiGo_, true)
	else
		SetActive(self.multiGo_, false)
	end
end

function ActivityUseDunDunView:OnExit()
	ActivityUseDunDunView.super.OnExit(self)
end

function ActivityUseDunDunView:UnBindRedPoint()
	for iter_8_0, iter_8_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]) do
		manager.redPoint:unbindUIandKey(self["rewardBtn" .. iter_8_0 .. "_"], RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_8_1)
	end
end

function ActivityUseDunDunView:AddListeners()
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_0_1),
			key = var_0_1
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		JumpTools.OpenPageByJump("/chapterMap", {
			chapterToggle = 2
		})
		OperationRecorder.RecordButtonTouch("activity" .. self.activityID_ .. "_jump_combat")
	end)
	self:AddBtnListener(self.rewardBtn1_, nil, function()
		local var_12_0

		for iter_12_0, iter_12_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]) do
			if ActivityPointRewardCfg[iter_12_1].need == self.pointList_[1] then
				var_12_0 = iter_12_1
			end
		end

		if ActivityPointData:GetCurDunDunPoint(self.activityID_) >= self.pointList_[1] then
			if ActivityPointData:GetUseDunDunRewardIsGet(self.activityID_, var_12_0) then
				return
			else
				ActivityAction.ReceivePointRewardWithCallBack({
					var_12_0
				}, function(arg_13_0)
					self:OnReceivePointReward(arg_13_0)
				end)
			end
		end
	end)
	self:AddBtnListener(self.rewardBtn2_, nil, function()
		local var_14_0

		for iter_14_0, iter_14_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]) do
			if ActivityPointRewardCfg[iter_14_1].need == self.pointList_[2] then
				var_14_0 = iter_14_1
			end
		end

		if ActivityPointData:GetCurDunDunPoint(self.activityID_) >= self.pointList_[2] then
			if ActivityPointData:GetUseDunDunRewardIsGet(self.activityID_, var_14_0) then
				return
			else
				ActivityAction.ReceivePointRewardWithCallBack({
					var_14_0
				}, function(arg_15_0)
					self:OnReceivePointReward(arg_15_0)
				end)
			end
		end
	end)
end

function ActivityUseDunDunView:OnReceivePointReward(arg_16_1)
	ActivityPointData:GetUseDunDunReward(self.activityID_, arg_16_1)
	self:RefreshUI()
end

return ActivityUseDunDunView
