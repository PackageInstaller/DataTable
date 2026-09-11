ActivityRewardBaseView = import("game.views.activity.Submodule.destroyBoxGame.rewardBase.ActivityRewardBaseView")

local DestroyBoxGameRewardView = class("DestroyBoxGameRewardView", ActivityRewardBaseView)

function DestroyBoxGameRewardView:UIName()
	return DestroyBoxGameUICfg[DestroyBoxGameUICfg.get_id_list_by_main_activity_id[self.params_.mainActivityID][1]].reward_prefab
end

function DestroyBoxGameRewardView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.rewardPanelList_ = DestroyBoxGameTools.GetRewardPanelList(self.mainActivityID_)

	DestroyBoxGameRewardView.super.OnEnter(self)
end

function DestroyBoxGameRewardView:InitData()
	self.sortPanelList_ = DestroyBoxGameTools.GetSortRewardPanel(self.mainActivityID_, self.rewardPanelList_)

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

function DestroyBoxGameRewardView:GetUnReceiveData()
	self.canReceiveRewardList_ = DestroyBoxGameTools.GetCanReceiveRewardList(self.mainActivityID_)
end

function DestroyBoxGameRewardView:GetMaxTaskCnt()
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(self.sortPanelList_) do
		var_5_0 = var_5_0 + #self.rewardPanelList_[iter_5_1]
	end

	return var_5_0
end

function DestroyBoxGameRewardView:GetFinishRewardCnt()
	return DestroyBoxGameTools.GetFinishRewardCnt(self.mainActivityID_)
end

function DestroyBoxGameRewardView:GetTaskItemClass()
	return DestroyBoxGameRewardItem
end

function DestroyBoxGameRewardView:OnClickReceiveBtn()
	DestroyBoxGameAction.RequestReward(self.mainActivityID_, self.canReceiveRewardList_, function()
		manager.notify:Invoke(ACTIVITY_REWARD_REFRESH)
	end)
end

return DestroyBoxGameRewardView
