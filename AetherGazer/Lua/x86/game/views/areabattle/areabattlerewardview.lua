local var_0_0 = class("AreaBattleRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityAreaBattleData:GetPrefabByActivityID(arg_1_0.params_.mainActivityID) .. "NormalfightingSeizuresTipsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetListItem), arg_4_0.uiList_, AreaBattleRewardItem)
	arg_4_0.controller = arg_4_0.controller_:GetController("show")
end

function var_0_0.SetListItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.taskList[arg_5_1], arg_5_0.areaData, arg_5_0.activityID)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveAllBtn_, nil, function()
		AreaBattleAction.GetReward(arg_6_0.activityID, arg_6_0.completeTaskList)
	end)
end

function var_0_0.UpdateData(arg_9_0)
	arg_9_0.activityID = arg_9_0.params_.activityID
	arg_9_0.mainActivityID = arg_9_0.params_.mainActivityID
	arg_9_0.completeTaskList = {}
	arg_9_0.cfg = ActivityAreaBattleCfg[arg_9_0.activityID]
	arg_9_0.areaData = ActivityAreaBattleData:GetDataByActivityID(arg_9_0.mainActivityID)[arg_9_0.activityID]
	arg_9_0.taskList = deepClone(arg_9_0.cfg.reward_list)

	table.sort(arg_9_0.taskList, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_9_0.areaData.gotChallengeRewardList[arg_10_0[1]] and 100000 or 1
		local var_10_1 = arg_9_0.areaData.gotChallengeRewardList[arg_10_1[1]] and 100000 or 1

		return var_10_0 + arg_10_0[1] / 10000 < var_10_1 + arg_10_1[1] / 10000
	end)
end

function var_0_0.UpdateView(arg_11_0)
	arg_11_0.passtext_.text = string.format(GetTips("ACTIVITY_AREA_BATTLE_REWARD_SUM_POINT"), math.min(arg_11_0.areaData.allChallengeValue, arg_11_0.cfg.reward_list[#arg_11_0.cfg.reward_list][1]) .. "/" .. arg_11_0.cfg.reward_list[#arg_11_0.cfg.reward_list][1])

	arg_11_0.list:StartScroll(#arg_11_0.cfg.reward_list)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.cfg.reward_list) do
		if arg_11_0.areaData.allChallengeValue >= arg_11_0.taskList[iter_11_0][1] and arg_11_0.areaData.gotChallengeRewardList[arg_11_0.taskList[iter_11_0][1]] ~= true then
			table.insert(arg_11_0.completeTaskList, arg_11_0.taskList[iter_11_0][1])
		end
	end

	arg_11_0.controller:SetSelectedState(tostring(#arg_11_0.completeTaskList ~= 0))
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:UpdateData()
	arg_12_0:UpdateView()
end

function var_0_0.OnAreaBattleGetReward(arg_13_0)
	arg_13_0:OnEnter()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0.completeTaskList = nil

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.list then
		arg_15_0.list:Dispose()

		arg_15_0.list = nil
	end

	var_0_0.super.Dispose(arg_15_0)
	Object.Destroy(arg_15_0.gameObject_)
end

return var_0_0
