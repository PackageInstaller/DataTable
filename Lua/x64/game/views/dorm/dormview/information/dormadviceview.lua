local var_0_0 = class("DormAdviceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormInformationPanelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.page = DormInfomationPage.New(arg_4_0.infomationObj_)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:BuildContext()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnMask_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.Render(arg_8_0)
	arg_8_0.page:Show()
	SetActive(arg_8_0.emptyObj_, arg_8_0.page:NeedEmpty())
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:Render()
end

function var_0_0.Back(arg_10_0)
	var_0_0.super.Back(arg_10_0)
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:Render()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.page:Dispose()

	arg_13_0.page = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
