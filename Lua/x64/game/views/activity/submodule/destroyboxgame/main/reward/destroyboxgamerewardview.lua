ActivityRewardBaseView = import("game.views.activity.Submodule.destroyBoxGame.rewardBase.ActivityRewardBaseView")

local var_0_0 = class("DestroyBoxGameRewardView", ActivityRewardBaseView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = DestroyBoxGameUICfg.get_id_list_by_main_activity_id[arg_1_0.params_.mainActivityID][1]

	return DestroyBoxGameUICfg[var_1_0].reward_prefab
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.mainActivityID_ = arg_2_0.params_.mainActivityID
	arg_2_0.rewardPanelList_ = DestroyBoxGameTools.GetRewardPanelList(arg_2_0.mainActivityID_)

	var_0_0.super.OnEnter(arg_2_0)
end

function var_0_0.InitData(arg_3_0)
	arg_3_0.sortPanelList_ = DestroyBoxGameTools.GetSortRewardPanel(arg_3_0.mainActivityID_, arg_3_0.rewardPanelList_)

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
	arg_4_0.canReceiveRewardList_ = DestroyBoxGameTools.GetCanReceiveRewardList(arg_4_0.mainActivityID_)
end

function var_0_0.GetMaxTaskCnt(arg_5_0)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.sortPanelList_) do
		var_5_0 = var_5_0 + #arg_5_0.rewardPanelList_[iter_5_1]
	end

	return var_5_0
end

function var_0_0.GetFinishRewardCnt(arg_6_0)
	return DestroyBoxGameTools.GetFinishRewardCnt(arg_6_0.mainActivityID_)
end

function var_0_0.GetTaskItemClass(arg_7_0)
	return DestroyBoxGameRewardItem
end

function var_0_0.OnClickReceiveBtn(arg_8_0)
	DestroyBoxGameAction.RequestReward(arg_8_0.mainActivityID_, arg_8_0.canReceiveRewardList_, function()
		manager.notify:Invoke(ACTIVITY_REWARD_REFRESH)
	end)
end

return var_0_0
