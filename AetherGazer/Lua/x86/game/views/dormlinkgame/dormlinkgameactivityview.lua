local var_0_0 = class("DormLinkGameActivityView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_LinkGame/Alone_LGStagePopUI"
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

	arg_5_0.clearController = arg_5_0.controllerExCollection_:GetController("clear")
	arg_5_0.activityScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexActivityItemList), arg_5_0.uilistGo_, DormLinkGameActivityItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.clearBtn_, nil, function()
		DormLinkGameAction:GetMultiplyLevelAward(arg_6_0.completeList)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activity = arg_9_0.params_.activityID

	arg_9_0:RegisterEvents()
	arg_9_0:RefreshView()

	arg_9_0.canGetAward = true
end

function var_0_0.RegisterEvents(arg_10_0)
	arg_10_0:RegistEventListener(DORM_LINK_REFRESH_LEVEL_AWARD, function()
		arg_10_0.canGetAward = true

		arg_10_0:RefreshView()
		DormLinkGameData:CheckUnReciveLevelReward()
	end)
end

function var_0_0.indexActivityItemList(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:RefreshUI(arg_12_0.activityList[arg_12_1])
	arg_12_2:GetLevelAward(function(arg_13_0)
		if arg_12_0.canGetAward then
			arg_12_0.canGetAward = false

			DormLinkGameAction:GetLevelAward(arg_13_0)
		end
	end)
end

function var_0_0.RefreshView(arg_14_0)
	local var_14_0 = {}

	if arg_14_0.activity then
		local var_14_1 = DormLinkGameTools:GetLevelActivityList(arg_14_0.activity)

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			for iter_14_2, iter_14_3 in ipairs(ActivityLinkGameRewardCfg.get_id_list_by_activity_id[iter_14_1]) do
				table.insert(var_14_0, iter_14_3)
			end
		end
	else
		for iter_14_4, iter_14_5 in ipairs(ActivityLinkGameRewardCfg.all) do
			table.insert(var_14_0, iter_14_5)
		end
	end

	local var_14_2 = {}

	for iter_14_6, iter_14_7 in ipairs(var_14_0) do
		if DormLinkGameData:CheckLevelRewardState(iter_14_7) == DormLinkGameConst.RewardItemState.complete then
			table.insert(var_14_2, iter_14_7)
		end
	end

	arg_14_0.activityList = var_14_0
	arg_14_0.completeList = var_14_2

	CommonTools.UniversalSortEx(arg_14_0.activityList, {
		ascend = true,
		map = function(arg_15_0)
			local var_15_0 = DormLinkGameData:CheckLevelRewardState(arg_15_0)

			if var_15_0 == DormLinkGameConst.RewardItemState.unComplete then
				return 2
			elseif var_15_0 == DormLinkGameConst.RewardItemState.complete then
				return 1
			elseif var_15_0 == DormLinkGameConst.RewardItemState.received then
				return 3
			end
		end
	}, {
		ascend = true,
		map = function(arg_16_0)
			return arg_16_0
		end
	})

	if #var_14_2 > 0 then
		arg_14_0.clearController:SetSelectedState("show")
	else
		arg_14_0.clearController:SetSelectedState("hide")
	end

	arg_14_0.activityScroll:StartScroll(#arg_14_0.activityList)
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:RemoveAllEventListener()
end

function var_0_0.OnExitInput(arg_18_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.activityScroll then
		arg_19_0.activityScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
