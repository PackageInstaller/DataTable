local ActivityPushBoxRewardPreView = class("ActivityPushBoxRewardPreView", ReduxView)

function ActivityPushBoxRewardPreView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryRewardPopup"
end

function ActivityPushBoxRewardPreView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityPushBoxRewardPreView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxRewardPreView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, CommonItem)
end

function ActivityPushBoxRewardPreView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = ActivityCelebrationCakeCfg[self.list_[arg_5_1]].award_list[1]

	arg_5_2:RefreshData({
		id = ActivityCelebrationCakeCfg[self.list_[arg_5_1]].award_list[1][1],
		number = ActivityCelebrationCakeCfg[self.list_[arg_5_1]].award_list[1][2]
	})
	arg_5_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_5_0)
	end)
	ControllerUtil.GetController(arg_5_2.transform_, "completed"):SetSelectedState(arg_5_1 > self.curIndex_ and "false" or "true")
end

function ActivityPushBoxRewardPreView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ActivityPushBoxRewardPreView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.curIndex_ = ActivityPushBoxData:GetCurIndex(self.activityID_)
	self.list_ = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[self.activityID_]

	self.scrollHelper_:StartScroll(#self.list_)
end

function ActivityPushBoxRewardPreView:OnExit()
	for iter_10_0, iter_10_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_10_1:OnExit()
	end
end

function ActivityPushBoxRewardPreView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityPushBoxRewardPreView
