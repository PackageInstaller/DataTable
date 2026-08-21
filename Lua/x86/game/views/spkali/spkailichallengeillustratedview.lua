local var_0_0 = class("SPKailiChallengeIllustratedView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.nodeList = {}

	arg_1_0:AddListeners()

	arg_1_0.stageList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uilistUilist_, SpKaliTreasureItem)
end

function var_0_0.IndexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:SetData(arg_2_0.pointlist[arg_2_1])
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	return
end

function var_0_0.UIName(arg_5_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kaliFistAffixPopUI"
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnbackBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.UpdateData(arg_8_0, arg_8_1)
	arg_8_0.pointlist = SPKaliChallengeData:GetShowTreasureList(arg_8_0.activityID) or {}
end

function var_0_0.RefreshStageList(arg_9_0)
	arg_9_0.stageList_:StartScroll(#arg_9_0.pointlist)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID = arg_10_0.params_ and arg_10_0.params_.activityID_ or ActivityConst.ACTIVITY_3_6_KALI_FIGHT

	var_0_0.super.OnEnter(arg_10_0)
	arg_10_0:UpdateData(arg_10_0.activityID)
	arg_10_0:RefreshStageList()
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:ChangeBar()
end

function var_0_0.OnExit(arg_12_0)
	var_0_0.super.OnExit(arg_12_0)
end

function var_0_0.ChangeBar(arg_13_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.RefreshAffixDes(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
	arg_15_0.stageList_:Dispose()

	arg_15_0.stageList_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
