local var_0_0 = class("ValentineGameRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ValentineGameTools.GetRewardUIName(arg_1_0.params_.activityID)
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

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ValentineGameRewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.list_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.list_ = {}

	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = ActivityCfg[arg_9_0.activityID_].sub_activity_list

	for iter_9_0, iter_9_1 in ipairs(var_9_3) do
		local var_9_4 = ValentineGameData:GetData(iter_9_1)

		if var_9_4 then
			if var_9_4.isReward then
				table.insert(var_9_2, iter_9_1)
			elseif var_9_4.isClear then
				table.insert(var_9_0, iter_9_1)
			else
				table.insert(var_9_1, iter_9_1)
			end
		else
			table.insert(var_9_1, iter_9_1)
		end
	end

	table.insertto(arg_9_0.list_, var_9_0)
	table.insertto(arg_9_0.list_, var_9_1)
	table.insertto(arg_9_0.list_, var_9_2)
	arg_9_0.scrollHelper_:StartScroll(#arg_9_0.list_)
end

function var_0_0.OnValentineGameReward(arg_10_0)
	arg_10_0:RefreshUI()
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()

	if arg_13_0.scrollHelper_ then
		arg_13_0.scrollHelper_:Dispose()

		arg_13_0.scrollHelper_ = nil
	end

	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
