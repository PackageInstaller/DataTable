local ActivityCultivateHeroMainView_Resident = class("ActivityCultivateHeroMainView_Resident", (import("game.views.cultivateHero.ActivityCultivateHeroMainView")))

function ActivityCultivateHeroMainView_Resident:Init()
	ActivityCultivateHeroMainView_Resident.super.Init(self)
	self:InitAccumulateRewardItem()
end

function ActivityCultivateHeroMainView_Resident:InitAccumulateRewardItem()
	self.accumulateRewardList_ = {}
	self.accumulateRewardDataList_ = {}

	for iter_2_0 = 1, self.accumulateRewardItemPanelTrs_.childCount do
		self.accumulateRewardList_[iter_2_0] = CommonItemView.New(self.accumulateRewardItemPanelTrs_:GetChild(iter_2_0 - 1).gameObject, true)
		self.accumulateRewardDataList_[iter_2_0] = clone(ItemTemplateData)
		self.accumulateRewardDataList_[iter_2_0].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end
end

function ActivityCultivateHeroMainView_Resident:InitController()
	self.accumulateRewardState_ = self.accumulateRewardControllerEx_:GetController("reward")
	self.dailyRewardState_ = self.dailyRewardControllerEx_:GetController("reward")
	self.allReceiveBtnState_ = self.allReceiveControllerEX_:GetController("clear")
	self.heroLockState_ = self.controllerEx_:GetController("heroLock")
end

function ActivityCultivateHeroMainView_Resident:RefreshTotalAccumulateProgress(arg_5_1, arg_5_2)
	self.totalAccumulateProgressText_.text = string.format(GetTips("CULTIVATE_HERO_REWARD"), (string.format(":%d/%d", arg_5_1, arg_5_2)))
end

function ActivityCultivateHeroMainView_Resident:RefreshAccumulateRewardItem(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.reward_item_list) do
		self.accumulateRewardDataList_[iter_6_0].id = iter_6_1[1]
		self.accumulateRewardDataList_[iter_6_0].number = iter_6_1[2]
		self.accumulateRewardDataList_[iter_6_0].grayFlag = self.accumulateStatus_ == 2

		self.accumulateRewardList_[iter_6_0]:SetData(self.accumulateRewardDataList_[iter_6_0])
	end

	for iter_6_2 = #arg_6_1.reward_item_list + 1, #self.accumulateRewardList_ do
		self.accumulateRewardList_[iter_6_2]:SetData(nil)
	end

	for iter_6_3 = #arg_6_1.reward_item_list + 1, #self.accumulateRewardList_ do
		self.accumulateRewardList_[iter_6_3]:Show(false)
	end
end

function ActivityCultivateHeroMainView_Resident:RefreshAccumulateRewardState()
	if self.accumulateStatus_ == 0 then
		self.accumulateRewardState_:SetSelectedState("normal")
	elseif self.accumulateStatus_ == 2 then
		self.accumulateRewardState_:SetSelectedState("clear")
	else
		self.accumulateRewardState_:SetSelectedState("receive")
	end
end

function ActivityCultivateHeroMainView_Resident:RefreshDailyProgress()
	self.dailyPrograssText_.text = string.format(GetTips("CULTIVATE_HERO_DAILY_PROGRESS"), ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT), 100)
end

function ActivityCultivateHeroMainView_Resident:RefreshDailyRewardState()
	if CultivateHeroData:GetDailyTaskStatus()[self.activityID_] then
		self.dailyRewardState_:SetSelectedState("clear")
	elseif 100 <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) then
		self.canReceiveDaily_ = true

		self.dailyRewardState_:SetSelectedState("receive")
	else
		self.canReceiveDaily_ = false

		self.dailyRewardState_:SetSelectedState("Normal")
	end
end

return ActivityCultivateHeroMainView_Resident
