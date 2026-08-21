local var_0_0 = class("AutoChessShopLevelUpPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_UpgradeShopPopUI"
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

	arg_4_0.beforeGradeController_ = arg_4_0.controllerEx_:GetController("beforeGrade")
	arg_4_0.afterGradeController_ = arg_4_0.controllerEx_:GetController("afterGrade")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()

		if arg_5_0.params_.backFunc then
			arg_5_0.params_.backFunc()
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.lastLevel_ = arg_7_0.params_.lastShopLevel
	arg_7_0.nowLevel_ = arg_7_0.params_.nowShopLevel

	arg_7_0.beforeGradeController_:SetSelectedIndex(arg_7_0.lastLevel_ - 1)
	arg_7_0.afterGradeController_:SetSelectedIndex(arg_7_0.nowLevel_ - 1)
end

return var_0_0
