local var_0_0 = class("ChallengeRogueTeamPointBtn", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.commonItemGo_, true)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.OnEnter(arg_3_0, arg_3_1)
	arg_3_0.activityId_ = arg_3_1
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	arg_4_0.score_ = ItemTools.getItemNum(RogueTeamCfg[var_4_0].point_item)
	arg_4_0.expToLvValue_ = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_PER_VALUE, ChallengeRogueTeamData:GetCacheTemplateID())
	arg_4_0.scoreIDList_ = ChallengeRogueTeamData:GetScoreIDListByActivityID(arg_4_0.activityId_)
	arg_4_0.maxLevel_ = math.floor(ActivityPointRewardCfg[arg_4_0.scoreIDList_[#arg_4_0.scoreIDList_]].need / arg_4_0.expToLvValue_)
	arg_4_0.level_ = math.min(math.floor(arg_4_0.score_ / arg_4_0.expToLvValue_), arg_4_0.maxLevel_)
	arg_4_0.unCompleteIndex_ = ChallengeRogueTeamData:GetUnCompleteIndex(var_4_0, arg_4_0.activityId_)
	arg_4_0.reward_ = ActivityPointRewardCfg[arg_4_0.scoreIDList_[arg_4_0.unCompleteIndex_]].reward_item_list[1]
	arg_4_0.pointText_.text = arg_4_0.level_

	local var_4_1 = clone(ItemTemplateData)

	var_4_1.id = arg_4_0.reward_[1]
	var_4_1.number = arg_4_0.reward_[2]

	function var_4_1.clickFun(arg_5_0)
		if competed then
			if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			TaskAction:SubmitTaskList({
				arg_4_0.taskID_
			}, nil, arg_4_0.callBack_)

			return
		end

		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end

	arg_4_0.commonItem_:SetData(var_4_1)
end

return var_0_0
