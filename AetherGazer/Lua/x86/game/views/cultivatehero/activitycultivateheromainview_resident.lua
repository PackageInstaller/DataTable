local var_0_0 = import("game.views.cultivateHero.ActivityCultivateHeroMainView")
local var_0_1 = class("ActivityCultivateHeroMainView_Resident", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	arg_1_0:InitAccumulateRewardItem()
end

function var_0_1.InitAccumulateRewardItem(arg_2_0)
	arg_2_0.accumulateRewardList_ = {}
	arg_2_0.accumulateRewardDataList_ = {}

	local var_2_0 = arg_2_0.accumulateRewardItemPanelTrs_.childCount

	for iter_2_0 = 1, var_2_0 do
		arg_2_0.accumulateRewardList_[iter_2_0] = CommonItemView.New(arg_2_0.accumulateRewardItemPanelTrs_:GetChild(iter_2_0 - 1).gameObject, true)
		arg_2_0.accumulateRewardDataList_[iter_2_0] = clone(ItemTemplateData)
		arg_2_0.accumulateRewardDataList_[iter_2_0].clickFun = function(arg_3_0)
			ShowPopItem(POP_ITEM, {
				arg_3_0.id,
				arg_3_0.number
			})
		end
	end
end

function var_0_1.InitController(arg_4_0)
	arg_4_0.accumulateRewardState_ = arg_4_0.accumulateRewardControllerEx_:GetController("reward")
	arg_4_0.dailyRewardState_ = arg_4_0.dailyRewardControllerEx_:GetController("reward")
	arg_4_0.allReceiveBtnState_ = arg_4_0.allReceiveControllerEX_:GetController("clear")
	arg_4_0.heroLockState_ = arg_4_0.controllerEx_:GetController("heroLock")
end

function var_0_1.RefreshTotalAccumulateProgress(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = string.format(":%d/%d", arg_5_1, arg_5_2)

	arg_5_0.totalAccumulateProgressText_.text = string.format(GetTips("CULTIVATE_HERO_REWARD"), var_5_0)
end

function var_0_1.RefreshAccumulateRewardItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.reward_item_list

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		arg_6_0.accumulateRewardDataList_[iter_6_0].id = iter_6_1[1]
		arg_6_0.accumulateRewardDataList_[iter_6_0].number = iter_6_1[2]

		if arg_6_0.accumulateStatus_ == 2 then
			arg_6_0.accumulateRewardDataList_[iter_6_0].grayFlag = true
		else
			arg_6_0.accumulateRewardDataList_[iter_6_0].grayFlag = false
		end

		arg_6_0.accumulateRewardList_[iter_6_0]:SetData(arg_6_0.accumulateRewardDataList_[iter_6_0])
	end

	for iter_6_2 = #arg_6_1.reward_item_list + 1, #arg_6_0.accumulateRewardList_ do
		arg_6_0.accumulateRewardList_[iter_6_2]:SetData(nil)
	end

	for iter_6_3 = #var_6_0 + 1, #arg_6_0.accumulateRewardList_ do
		arg_6_0.accumulateRewardList_[iter_6_3]:Show(false)
	end
end

function var_0_1.RefreshAccumulateRewardState(arg_7_0)
	if arg_7_0.accumulateStatus_ == 0 then
		arg_7_0.accumulateRewardState_:SetSelectedState("normal")
	elseif arg_7_0.accumulateStatus_ == 2 then
		arg_7_0.accumulateRewardState_:SetSelectedState("clear")
	else
		arg_7_0.accumulateRewardState_:SetSelectedState("receive")
	end
end

function var_0_1.RefreshDailyProgress(arg_8_0)
	local var_8_0 = 100
	local var_8_1 = ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT)

	arg_8_0.dailyPrograssText_.text = string.format(GetTips("CULTIVATE_HERO_DAILY_PROGRESS"), var_8_1, var_8_0)
end

function var_0_1.RefreshDailyRewardState(arg_9_0)
	local var_9_0 = 100
	local var_9_1 = ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT)

	if CultivateHeroData:GetDailyTaskStatus()[arg_9_0.activityID_] then
		arg_9_0.dailyRewardState_:SetSelectedState("clear")
	elseif var_9_0 <= var_9_1 then
		arg_9_0.canReceiveDaily_ = true

		arg_9_0.dailyRewardState_:SetSelectedState("receive")
	else
		arg_9_0.canReceiveDaily_ = false

		arg_9_0.dailyRewardState_:SetSelectedState("Normal")
	end
end

return var_0_1
