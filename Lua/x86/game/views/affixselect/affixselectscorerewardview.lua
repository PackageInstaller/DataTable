local var_0_0 = class("AffixSelectScoreRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, AffixSelectRewardItemView)
	arg_5_0.btnController_ = arg_5_0.btnCon_:GetController("state")
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.rewardIdList_[arg_6_1], arg_6_0.activityId, false)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnReceiveAll_, nil, function()
		ActivityAction.ReceivePointReward(arg_7_0.canReceiveRewards)
	end)
end

function var_0_0.OnReceivePointReward(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if table.indexof(arg_10_0.rewardIdList_, iter_10_1) then
			arg_10_0:UpdateList()

			break
		end
	end
end

function var_0_0.AddEventListeners(arg_11_0)
	return
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.activityId = arg_15_0.params_.affixActivityId

	arg_15_0:AddEventListeners()
	arg_15_0:UpdateList()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateList(arg_17_0)
	arg_17_0.scoreLabel_.text = ActivityAffixSelectData:GetTotalScore(arg_17_0.activityId)
	arg_17_0.rewardIdList_ = deepClone(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_17_0.activityId])
	arg_17_0.haveGetLabel_.text = ActivityAffixSelectData:ScoreRewardGetCount(arg_17_0.activityId) .. "/" .. #arg_17_0.rewardIdList_

	table.sort(arg_17_0.rewardIdList_, function(arg_18_0, arg_18_1)
		local var_18_0 = ActivityAffixSelectData:GetRewardStatus(arg_17_0.activityId, arg_18_0)
		local var_18_1 = ActivityAffixSelectData:GetRewardStatus(arg_17_0.activityId, arg_18_1)

		if var_18_0 ~= var_18_1 then
			return var_18_1 < var_18_0
		end

		return arg_18_0 < arg_18_1
	end)

	local var_17_0

	arg_17_0.canReceiveRewards = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.rewardIdList_) do
		local var_17_1 = ActivityAffixSelectData:GetRewardStatus(arg_17_0.activityId, iter_17_1)

		if var_17_0 == nil and var_17_1 ~= 3 then
			var_17_0 = iter_17_0
		end

		if var_17_1 == 2 then
			table.insert(arg_17_0.canReceiveRewards, iter_17_1)
		elseif var_17_1 == 1 then
			break
		end
	end

	var_17_0 = var_17_0 or 1

	arg_17_0.uiList_:StartScroll(#arg_17_0.rewardIdList_, var_17_0)
	arg_17_0.btnController_:SetSelectedState(#arg_17_0.canReceiveRewards <= 0 and "hide" or "show")
end

function var_0_0.OnMainHomeViewTop(arg_19_0)
	return
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.uiList_ then
		arg_20_0.uiList_:Dispose()

		arg_20_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
