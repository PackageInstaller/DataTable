local var_0_0 = class("CoreVerificationChallengeIllustratedView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_verification_BadgeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.items = {}
	arg_3_0.list = CoreVerificationChallengeTools.GetBadgeCount()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.UpdateBar(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:UpdateBar()

	for iter_6_0 = 1, #arg_6_0.list do
		if not arg_6_0.items[iter_6_0] then
			local var_6_0 = Object.Instantiate(arg_6_0.itemGo_, arg_6_0.contentTrs_)

			arg_6_0.items[iter_6_0] = CoreVerificationChallengeIllustratedCycleItemView.New(var_6_0, iter_6_0)
		end

		arg_6_0.items[iter_6_0]:Refresh(iter_6_0)
	end

	for iter_6_1 = #arg_6_0.list + 1, #arg_6_0.items do
		arg_6_0.items[iter_6_1]:Show(false)
	end

	if #arg_6_0.list > 1 then
		arg_6_0.scrollView_.horizontalNormalizedPosition = 1
	end
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0 = 1, #arg_8_0.list do
		arg_8_0.items[iter_8_0]:Dispose()

		arg_8_0.items[iter_8_0] = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
