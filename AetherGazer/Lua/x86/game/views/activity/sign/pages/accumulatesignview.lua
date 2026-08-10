local var_0_0 = class("AccumulateSignView", ReduxView)
local var_0_1 = {
	[0] = "CUMULATIVE_LOGIN_SALE_0",
	"CUMULATIVE_LOGIN_SALE_1",
	"CUMULATIVE_LOGIN_SALE_2",
	"CUMULATIVE_LOGIN_SALE_3",
	"CUMULATIVE_LOGIN_SALE_3",
	"CUMULATIVE_LOGIN_SALE_3"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ActivitySign/StreakBonusPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.monthCardController_ = arg_3_0.monthCardControllerEx_:GetController("status")
	arg_3_0.passportController_ = arg_3_0.passportControllerEx_:GetController("status")
	arg_3_0.passportNextController_ = arg_3_0.passportControllerEx_:GetController("next")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, AccumulateSignItem)
	arg_3_0.rewardList_ = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		JumpTools.Back(1, {
			check = true
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.mainTitleBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CUMULATIVE_LOGIN_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = GetTips("CUMULATIVE_LOGIN_DESC")
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.discountBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CUMULATIVE_SALE_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = GetTips("CUMULATIVE_SALE_DESC")
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.monthCardBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 1,
			page = 3
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
	arg_5_0:AddBtnListener(arg_5_0.passportBtn_, nil, function()
		if not PassportData:IsOpen() then
			ShowTips("NOT_IN_OPEN_TIME")

			return
		end

		JumpTools.OpenPageByJump("/passportMain", nil, ViewConst.SYSTEM_ID.PASSPORT_MAIN)
	end)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = AccumulateLoginCfg.get_id_list_by_version[arg_11_0.curVersion_][arg_11_1]

	arg_11_2:SetData(var_11_0, function(arg_12_0)
		arg_11_0:OnClickPointReward(arg_12_0)
	end)
end

function var_0_0.OnClickPointReward(arg_13_0, arg_13_1)
	AccumulateSignAction.GetAccumulateRewardView({
		arg_13_1
	})
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:RefreshUI()
	AccumulateSignAction.OpenAccumulateSignView()
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0.curVersion_ = AccumulateSignData:GetVersion()
	arg_15_0.monthCardNum_, arg_15_0.monthcardLv_ = AccumulateSignData:GetMonthCardNumAndLv()
	arg_15_0.passportNum_, arg_15_0.passportLv_ = AccumulateSignData:GetPassportNumAndLv()
	arg_15_0.loginNum_ = AccumulateSignData:GetLoginNum()
	arg_15_0.rewardList_ = AccumulateLoginCfg.get_id_list_by_version[arg_15_0.curVersion_]

	arg_15_0.uiList_:StartScroll(#arg_15_0.rewardList_)

	local var_15_0, var_15_1, var_15_2, var_15_3, var_15_4, var_15_5 = AccumulateSignData:GetShowProgress()

	arg_15_0.uiList_:ScrollToIndex(var_15_5, false, false)
	arg_15_0.monthCardController_:SetSelectedIndex(arg_15_0.monthcardLv_)

	if PassportData:GetPayLevel() > 0 then
		arg_15_0.passportNextController_:SetSelectedIndex(1)
		arg_15_0.passportController_:SetSelectedIndex(math.min(arg_15_0.passportLv_ + 1, 3))
	elseif not PassportData:IsOpen() then
		arg_15_0.passportNextController_:SetSelectedIndex(1)
		arg_15_0.passportController_:SetSelectedIndex(math.min(arg_15_0.passportLv_, 3))
	else
		arg_15_0.passportNextController_:SetSelectedIndex(0)
		arg_15_0.passportController_:SetSelectedIndex(math.min(arg_15_0.passportLv_, 3))
	end

	arg_15_0.accumulateNumText_.text = tostring(arg_15_0.loginNum_) .. GetTips("DAY")
	arg_15_0.mainTitleText_.text = GetTips("CUMULATIVE_LOGIN_TIPS")
	arg_15_0.discountText_.text = GetTips("CUMULATIVE_LOGIN_SALE_NAME")
end

function var_0_0.OnAccumulateLoginRefresh(arg_16_0)
	arg_16_0:RefreshUI()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()

	if arg_17_0.uiList_ then
		arg_17_0.uiList_:Dispose()

		arg_17_0.uiList_ = nil
	end

	arg_17_0.super.Dispose(arg_17_0)
end

return var_0_0
