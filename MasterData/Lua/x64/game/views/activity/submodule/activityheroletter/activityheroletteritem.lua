local ActivityHeroLetterItem = class("ActivityHeroLetterItem", ReduxView)

function ActivityHeroLetterItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityHeroLetterItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityHeroLetterItem:InitUI()
	self:BindCfgUI()

	self.lockCon_ = self.conCollecter_:GetController("lock")
	self.rewardCon_ = self.conCollecter_:GetController("reward")
end

function ActivityHeroLetterItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. self.activityID_, 0)

		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 >= self.startTime_ and var_5_0 < self.stopTime_ then
			JumpTools.OpenPageByJump("/activityHeroLetterTask", {
				id = self.id_,
				activityID = self.cfg_.main_activity_id
			})
		end
	end)
end

function ActivityHeroLetterItem:OnEnter()
	return
end

function ActivityHeroLetterItem:Refresh(arg_7_1)
	self.id_ = arg_7_1
	self.cfg_ = ActivityHeroTaskCfg[self.id_]

	self:RefreshData()
	self:RefreshUI()
end

function ActivityHeroLetterItem:RefreshData()
	self.activityID_ = self.cfg_.activity_id
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityHeroLetterItem:RefreshUI()
	self.name_.text = HeroCfg[self.cfg_.hero_id].suffix
	self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. self.cfg_.hero_id)

	if ActivityHeroLetterTools.IsReward(self.id_) then
		self.rewardCon_:SetSelectedState("on")
	else
		self.taskID_ = self.cfg_.task_id

		local var_9_0 = TaskData2:GetTask(self.taskID_)

		if var_9_0 and AssignmentCfg[self.taskID_].need <= var_9_0.progress then
			self.rewardCon_:SetSelectedState("off")
		end

		local var_9_2
		local var_9_1

		do
			self.rewardCon_:SetSelectedState("none")

			var_9_1 = SetActive
			var_9_2 = self.redGo_
		end
	end

	var_9_1(var_9_2, manager.redPoint:getTipValue(RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. self.activityID_) > 0)
end

function ActivityHeroLetterItem:RefreshTime(arg_10_1)
	if arg_10_1 < self.startTime_ then
		self.lockCon_:SetSelectedState("off")

		self.timeLable_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(self.startTime_))
	elseif arg_10_1 >= self.stopTime_ then
		self.lockCon_:SetSelectedState("off")

		self.timeLable_.text = GetTips("TIME_OVER")
	else
		self.lockCon_:SetSelectedState("on")
	end
end

function ActivityHeroLetterItem:OnExit()
	self:RemoveAllEventListener()
end

function ActivityHeroLetterItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityHeroLetterItem
