local var_0_0 = class("ActivityPtScrollPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityPtScrollTools.GetBuffPopUIName(arg_1_0.params_.mainActivityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityPtScrollPopItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.list_[arg_5_1]
	local var_5_1 = ActivityPtScrollData:GetAffixInfo(arg_5_0.activityID_, var_5_0)

	arg_5_2:RefreshData(var_5_1, arg_5_0.contentRect_, arg_5_0.viewRect_.rect.height)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.mainActivityID

	arg_8_0:RefreshData()
	arg_8_0:RefreshList()
end

function var_0_0.RefreshData(arg_9_0)
	arg_9_0.list_ = {}

	local var_9_0 = ActivityPtScrollData:GetAffixList(arg_9_0.activityID_)

	table.insertto(arg_9_0.list_, var_9_0)
	table.insertto(arg_9_0.list_, var_9_0)

	arg_9_0.chooseIndex_ = #var_9_0 + (#var_9_0 - 1) / 2 + 1
end

function var_0_0.RefreshList(arg_10_0)
	if arg_10_0.params_.isScroll then
		arg_10_0.params_.isScroll = false

		manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_pt1_rotate", "")
		arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_, arg_10_0.chooseIndex_, true, true, 3.5)
	else
		manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_pt1_platform", "")
		arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_, arg_10_0.chooseIndex_, true)
	end
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.scrollHelper_:RemoveTween()
	arg_11_0.scrollHelper_:SetScrolledPosition(Vector2.one)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.scrollHelper_.itemOfInstanceID_) do
		iter_11_1:OnExit()
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	arg_12_0.scrollHelper_:Dispose()
	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
