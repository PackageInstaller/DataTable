local var_0_0 = class("RecallSystemRecallInfoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/RecallUI/RC1stRecordUI"
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

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, RecallSystemRecallNumberInfoItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ActivityRecallData:GetDataByPara("userInfoList")

	arg_5_2:SetData(var_5_0[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.UpdateBar(arg_8_0)
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:UpdateView()
end

function var_0_0.UpdateView(arg_11_0)
	local var_11_0 = ActivityRecallData:GetDataByPara("codeUseNum")

	arg_11_0.list_:StartScroll(var_11_0)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.list_ then
		arg_13_0.list_:Dispose()

		arg_13_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
