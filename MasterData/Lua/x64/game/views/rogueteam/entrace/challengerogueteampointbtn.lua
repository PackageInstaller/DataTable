local ChallengeRogueTeamPointBtn = class("ChallengeRogueTeamPointBtn", ReduxView)

function ChallengeRogueTeamPointBtn:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.commonItemGo_, true)
end

function ChallengeRogueTeamPointBtn:Dispose()
	ChallengeRogueTeamPointBtn.super.Dispose(self)
end

function ChallengeRogueTeamPointBtn:OnEnter(arg_3_1)
	self.activityId_ = arg_3_1
end

function ChallengeRogueTeamPointBtn:RefreshUI()
	local var_4_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	self.score_ = ItemTools.getItemNum(RogueTeamCfg[var_4_0].point_item)
	self.expToLvValue_ = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_PER_VALUE, ChallengeRogueTeamData:GetCacheTemplateID())
	self.scoreIDList_ = ChallengeRogueTeamData:GetScoreIDListByActivityID(self.activityId_)
	self.maxLevel_ = math.floor(ActivityPointRewardCfg[self.scoreIDList_[#self.scoreIDList_]].need / self.expToLvValue_)
	self.level_ = math.min(math.floor(self.score_ / self.expToLvValue_), self.maxLevel_)
	self.unCompleteIndex_ = ChallengeRogueTeamData:GetUnCompleteIndex(var_4_0, self.activityId_)
	self.reward_ = ActivityPointRewardCfg[self.scoreIDList_[self.unCompleteIndex_]].reward_item_list[1]
	self.pointText_.text = self.level_

	local var_4_1 = clone(ItemTemplateData)

	var_4_1.id = self.reward_[1]
	var_4_1.number = self.reward_[2]

	function var_4_1:clickFun()
		if competed then
			if not ActivityData:GetActivityIsOpen(self.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			TaskAction:SubmitTaskList({
				self.taskID_
			}, nil, self.callBack_)

			return
		end

		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	self.commonItem_:SetData(var_4_1)
end

return ChallengeRogueTeamPointBtn
