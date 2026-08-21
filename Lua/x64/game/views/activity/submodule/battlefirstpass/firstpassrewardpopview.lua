local var_0_0 = class("FirstPassRewardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/HellaUI/Pop/HellaQuestEewardsPop"
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

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, FirstPassRewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.activityID_, arg_5_0.list_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:RefreshList()
end

function var_0_0.RefreshList(arg_9_0)
	local var_9_0 = BattleFirstPassData:GetBattleFirstPassActivityData(arg_9_0.activityID_).battleInfo
	local var_9_1 = BattleFirstPassData:GetBattleList(arg_9_0.activityID_)

	if var_9_0 == nil then
		return
	end

	local var_9_2 = {}
	local var_9_3 = {}
	local var_9_4 = {}
	local var_9_5 = {}
	local var_9_6

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_7 = var_9_0[iter_9_1]

		if var_9_7.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED then
			table.insert(var_9_3, var_9_7)
		elseif var_9_7.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.SUCCESS then
			table.insert(var_9_4, var_9_7)
		elseif var_9_7.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.REWARDED then
			table.insert(var_9_5, var_9_7)
		end
	end

	table.sort(var_9_3, function(arg_10_0, arg_10_1)
		return arg_10_0.battleID < arg_10_1.battleID
	end)
	table.sort(var_9_4, function(arg_11_0, arg_11_1)
		return arg_11_0.battleID < arg_11_1.battleID
	end)
	table.sort(var_9_5, function(arg_12_0, arg_12_1)
		return arg_12_0.battleID < arg_12_1.battleID
	end)
	table.insertto(var_9_2, var_9_4)
	table.insertto(var_9_2, var_9_3)
	table.insertto(var_9_2, var_9_5)

	arg_9_0.list_ = var_9_2

	arg_9_0.scrollHelper_:StartScroll(#arg_9_0.list_)
end

function var_0_0.OnFirstReward(arg_13_0)
	arg_13_0:RefreshList()
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()
	arg_15_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
