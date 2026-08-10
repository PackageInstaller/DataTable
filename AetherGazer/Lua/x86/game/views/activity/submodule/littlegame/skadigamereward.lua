local var_0_0 = class("SkadiGameReward", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummeChallengePop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.itemList_ = {}

	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.scrollerHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uilistGo_, SkadiGameRewardItem)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgmaskBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:HideBar()

	arg_6_0.activityID_ = arg_6_0.params_.activityID

	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:UpdateDate()
	arg_8_0.scrollerHelper_:StartScroll(#arg_8_0.itemList_)

	local var_8_0 = #arg_8_0.itemList_ * 3
	local var_8_1 = SummerLittleGameData:GetSkadiRewardNum()

	arg_8_0.numText_.text = var_8_1 .. "/" .. var_8_0
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(arg_9_0.itemList_[arg_9_1])
end

function var_0_0.UpdateDate(arg_10_0)
	arg_10_0.itemList_ = deepClone(ActivityCrossWaveCfg.all)

	table.sort(arg_10_0.itemList_, function(arg_11_0, arg_11_1)
		local var_11_0 = SummerLittleGameData:GetSkadiReward(arg_11_0)
		local var_11_1 = SummerLittleGameData:GetSkadiReward(arg_11_1)
		local var_11_2 = SummerLittleGameData:GetSkadiStars(arg_11_0)
		local var_11_3 = SummerLittleGameData:GetSkadiStars(arg_11_1)
		local var_11_4 = #var_11_0 < #var_11_2
		local var_11_5 = #var_11_1 < #var_11_3

		if var_11_4 and not var_11_5 then
			return true
		end

		if not var_11_4 and var_11_5 then
			return false
		end

		return arg_11_0 < arg_11_1
	end)
end

function var_0_0.OnGetSkadiReward(arg_12_0)
	arg_12_0.scrollerHelper_:Refresh()

	local var_12_0 = #arg_12_0.itemList_ * 3
	local var_12_1 = SummerLittleGameData:GetSkadiRewardNum()

	arg_12_0.numText_.text = var_12_1 .. "/" .. var_12_0
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.scrollerHelper_:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
