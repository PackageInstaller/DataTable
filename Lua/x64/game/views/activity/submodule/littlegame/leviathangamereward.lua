local var_0_0 = class("LeviathanGameReward", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerQuestEewardsPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.itemList_ = {}

	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.scrollerHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, LeviathanGameRewardItem)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityID_ = arg_6_0.params_.activityID

	arg_6_0:UpdateDate()
	arg_6_0.scrollerHelper_:StartScroll(#arg_6_0.itemList_)
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_0.itemList_[arg_8_1])
end

function var_0_0.UpdateDate(arg_9_0)
	arg_9_0.itemList_ = deepClone(ActivityBubblesCfg.all)

	table.sort(arg_9_0.itemList_, function(arg_10_0, arg_10_1)
		local var_10_0 = SummerLittleGameData:GetLeviathanState(arg_10_0)
		local var_10_1 = SummerLittleGameData:GetLeviathanState(arg_10_1)

		if var_10_0 == var_10_1 then
			return arg_10_0 < arg_10_1
		end

		local var_10_2 = {
			[0] = 2,
			1,
			3
		}

		return var_10_2[var_10_0] < var_10_2[var_10_1]
	end)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.scrollerHelper_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnGetLeviathanReward(arg_12_0)
	arg_12_0:UpdateDate()
	arg_12_0.scrollerHelper_:Refresh()
end

return var_0_0
