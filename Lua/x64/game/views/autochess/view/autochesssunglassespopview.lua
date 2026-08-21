local var_0_0 = class("AutoChessSunglassesPopView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.UIName(arg_4_0)
	return "Widget/System/Activity_AutoChess_Main/Com/Activity_AutoChess_SunglassesPopUI"
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()

		local var_6_0 = AutoChessCardData:GetDesireInfo()

		if var_6_0.CardID > 0 then
			if var_6_0.State == AutoChessCardConst.DESIRE_STATE.YES then
				JumpTools.OpenPageByJump("autoChessWishPopView", {
					callback = arg_5_0.backCallback_
				})
			end
		else
			arg_5_0.backCallback_()
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.txtContent_.text = GetTips("AUTO_CHESS_2_SUNGLASS_POP_TIP")
	arg_7_0.backCallback_ = arg_7_0.params_.callback
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
