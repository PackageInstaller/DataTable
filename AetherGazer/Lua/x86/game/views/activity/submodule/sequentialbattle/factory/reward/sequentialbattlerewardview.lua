ActivityRewardBaseView = import("game.views.activity.Submodule.destroyBoxGame.rewardBase.ActivityRewardBaseView")

local var_0_0 = class("SequentialBattleRewardView", ActivityRewardBaseView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = SequentialBattleUICfg.get_id_list_by_main_activity_id[arg_1_0.params_.rewardActivityID][1]

	return SequentialBattleUICfg[var_1_0].reward_prefab
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.mainActivityID_ = arg_2_0.params_.rewardActivityID
	arg_2_0.rewardPanelList_ = SequentialBattleTools.GetRewardPanelList(arg_2_0.mainActivityID_)

	var_0_0.super.OnEnter(arg_2_0)
end

function var_0_0.InitData(arg_3_0)
	arg_3_0.sortPanelList_ = SequentialBattleChapterCfg.get_id_list_by_main_id[arg_3_0.mainActivityID_]

	arg_3_0:GetUnReceiveData()

	arg_3_0.uiDataList_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.sortPanelList_) do
		table.insert(arg_3_0.uiDataList_, {
			objectType = ActivityRewardBaseView.OBJECT_TYPE.TITLE,
			data = iter_3_1
		})

		for iter_3_2, iter_3_3 in ipairs(arg_3_0.rewardPanelList_[iter_3_1]) do
			table.insert(arg_3_0.uiDataList_, {
				objectType = ActivityRewardBaseView.OBJECT_TYPE.ITEM,
				data = iter_3_3
			})
		end
	end
end

function var_0_0.GetUnReceiveData(arg_4_0)
	arg_4_0.canReceiveRewardList_ = SequentialBattleTools.GetCanReceiveRewardList(arg_4_0.mainActivityID_)
end

function var_0_0.RefreshScroll(arg_5_0)
	local var_5_0 = arg_5_0.params_.selectID

	if #arg_5_0.canReceiveRewardList_ > 0 then
		local var_5_1 = arg_5_0.canReceiveRewardList_[1]

		var_5_0 = SequentialBattleRewardCfg[var_5_1].activity_id
	end

	local var_5_2 = ((table.keyof(SequentialBattleChapterCfg.get_id_list_by_main_id[arg_5_0.mainActivityID_], var_5_0) or 1) - 1) * 4 + 1

	arg_5_0.loopScrollView_:NavigateIndex(var_5_2 or 1)
end

function var_0_0.GetMaxTaskCnt(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.sortPanelList_) do
		var_6_0 = var_6_0 + #arg_6_0.rewardPanelList_[iter_6_1]
	end

	return var_6_0
end

function var_0_0.GetFinishRewardCnt(arg_7_0)
	return SequentialBattleTools.GetFinishRewardCnt(arg_7_0.mainActivityID_)
end

function var_0_0.GetTaskItemClass(arg_8_0)
	return SequentialBattleRewardItem
end

function var_0_0.OnClickReceiveBtn(arg_9_0)
	SequentialBattleAction.ReceiveReward(arg_9_0.mainActivityID_, arg_9_0.canReceiveRewardList_, function()
		manager.notify:Invoke(ACTIVITY_REWARD_REFRESH)
	end)
end

return var_0_0
