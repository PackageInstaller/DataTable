ActivityRewardBaseView = import("game.views.activity.Submodule.destroyBoxGame.rewardBase.ActivityRewardBaseView")

local SequentialBattleRewardView = class("SequentialBattleRewardView", ActivityRewardBaseView)

function SequentialBattleRewardView:UIName()
	return SequentialBattleUICfg[SequentialBattleUICfg.get_id_list_by_main_activity_id[self.params_.rewardActivityID][1]].reward_prefab
end

function SequentialBattleRewardView:OnEnter()
	self.mainActivityID_ = self.params_.rewardActivityID
	self.rewardPanelList_ = SequentialBattleTools.GetRewardPanelList(self.mainActivityID_)

	SequentialBattleRewardView.super.OnEnter(self)
end

function SequentialBattleRewardView:InitData()
	self.sortPanelList_ = SequentialBattleChapterCfg.get_id_list_by_main_id[self.mainActivityID_]

	self:GetUnReceiveData()

	self.uiDataList_ = {}

	for iter_3_0, iter_3_1 in ipairs(self.sortPanelList_) do
		table.insert(self.uiDataList_, {
			objectType = ActivityRewardBaseView.OBJECT_TYPE.TITLE,
			data = iter_3_1
		})

		for iter_3_2, iter_3_3 in ipairs(self.rewardPanelList_[iter_3_1]) do
			table.insert(self.uiDataList_, {
				objectType = ActivityRewardBaseView.OBJECT_TYPE.ITEM,
				data = iter_3_3
			})
		end
	end
end

function SequentialBattleRewardView:GetUnReceiveData()
	self.canReceiveRewardList_ = SequentialBattleTools.GetCanReceiveRewardList(self.mainActivityID_)
end

function SequentialBattleRewardView:RefreshScroll()
	self.loopScrollView_:NavigateIndex(((table.keyof(SequentialBattleChapterCfg.get_id_list_by_main_id[self.mainActivityID_], (#self.canReceiveRewardList_ > 0 or nil) and SequentialBattleRewardCfg[self.canReceiveRewardList_[1]].activity_id) or 1) - 1) * 4 + 1 or 1)
end

function SequentialBattleRewardView:GetMaxTaskCnt()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(self.sortPanelList_) do
		var_6_0 = var_6_0 + #self.rewardPanelList_[iter_6_1]
	end

	return var_6_0
end

function SequentialBattleRewardView:GetFinishRewardCnt()
	return SequentialBattleTools.GetFinishRewardCnt(self.mainActivityID_)
end

function SequentialBattleRewardView:GetTaskItemClass()
	return SequentialBattleRewardItem
end

function SequentialBattleRewardView:OnClickReceiveBtn()
	SequentialBattleAction.ReceiveReward(self.mainActivityID_, self.canReceiveRewardList_, function()
		manager.notify:Invoke(ACTIVITY_REWARD_REFRESH)
	end)
end

return SequentialBattleRewardView
