local var_0_0 = class("CoreVerificationTeamCheckView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_Verification/CoreVerificationTeamCheckUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.tabList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, CoreVerificationTeamInfoItem)

	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.list[arg_7_1], arg_7_1)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.list = arg_8_0.params_.dataList or {}

	arg_8_0.tabList_:StartScroll(#arg_8_0.list)

	arg_8_0.layerLabel_.text = GetTips("CORE_VERIFICATION_TAB_DES_2")
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.tabList_ then
		arg_10_0.tabList_:Dispose()

		arg_10_0.tabList_ = nil
	end
end

return var_0_0
