local var_0_0 = class("MatrixScoreExchangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.exchangeList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.scoreListGo_, MatrixScoreExchangeItem)
	arg_4_0.passController = ControllerUtil.GetController(arg_4_0.transform_, "pass")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.oneKeyGetBtn_, nil, function()
		local var_6_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT)
		local var_6_1 = false

		for iter_6_0, iter_6_1 in pairs(MatrixData:GetPointRewardList()) do
			if var_6_0 >= MatrixPointRankCfg[iter_6_1.rank].point and iter_6_1.is_got_reward == 0 then
				var_6_1 = true

				break
			end
		end

		if var_6_1 then
			MatrixAction.OneKeyGetBonus()
		end
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(CURRENCY_UPDATE, function(arg_8_0)
		if arg_8_0 == CurrencyConst.CURRENCY_TYPE_MATRIX_PT then
			arg_7_0:UpdateView()

			for iter_8_0, iter_8_1 in pairs(arg_7_0.exchangeList_:GetItemList()) do
				iter_8_1:UpdateView()
			end
		end
	end)
end

function var_0_0.indexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = MatrixData:GetPointRewardList()

	arg_9_2:SetData(arg_9_1, var_9_0[arg_9_1].rank, var_9_0[arg_9_1].item_list, var_9_0[arg_9_1].is_got_reward, var_9_0[arg_9_1].need_level)
end

function var_0_0.UpdateBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnMatrixSystemUpdate(arg_11_0)
	arg_11_0:UpdateView()
end

function var_0_0.OnMatrixUserUpdate(arg_12_0)
	arg_12_0:UpdateView()
end

function var_0_0.OnGetMatrixExchangeBonus(arg_13_0)
	arg_13_0:UpdateView()
	arg_13_0.exchangeList_:StartScrollWithoutAnimator(#MatrixData:GetPointRewardList())
end

function var_0_0.UpdateView(arg_14_0)
	local var_14_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT)

	arg_14_0.myScoreText_.text = string.format("%d", var_14_0)

	local var_14_1 = false
	local var_14_2 = MatrixData:GetTerminalLevel()

	for iter_14_0, iter_14_1 in pairs(MatrixData:GetPointRewardList()) do
		if var_14_0 >= MatrixPointRankCfg[iter_14_1.rank].point and iter_14_1.is_got_reward == 0 and var_14_2 >= iter_14_1.need_level then
			var_14_1 = true

			break
		end
	end

	if var_14_0 == 0 then
		arg_14_0.passController:SetSelectedIndex(0)
	elseif var_14_1 then
		arg_14_0.passController:SetSelectedIndex(1)
	else
		arg_14_0.passController:SetSelectedIndex(2)
	end
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:UpdateView()

	for iter_15_0, iter_15_1 in pairs(arg_15_0.exchangeList_:GetItemList()) do
		iter_15_1:UpdateView()
	end
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:UpdateBar()
	arg_16_0.exchangeList_:StartScroll(#MatrixData:GetPointRewardList())

	arg_16_0.timer_ = Timer.New(function()
		local var_17_0 = MatrixData:GetNextRefreshTime()

		arg_16_0.countdownText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_17_0))
	end, 0.2, -1)

	arg_16_0.timer_:Start()
	arg_16_0:UpdateView()

	arg_16_0.terminalLv = MatrixData:GetTerminalLevel()

	arg_16_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_16_0, arg_16_0.OnTerminalExpChange))
end

function var_0_0.OnTerminalExpChange(arg_18_0, arg_18_1)
	if arg_18_1 == CurrencyConst.CURRENCY_TYPE_MATRIX_TERMINAL_EXP then
		MatrixData:UpdateTerminalLevel()

		local var_18_0 = MatrixData:GetTerminalLevel()

		if arg_18_0.terminalLv ~= var_18_0 then
			arg_18_0.terminalLv = var_18_0

			JumpTools.OpenPageByJump("matrixTerminalLevelUpgrade", {
				newLv = var_18_0
			})
		end
	end
end

function var_0_0.OnExit(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end

	arg_19_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.exchangeList_ then
		arg_20_0.exchangeList_:Dispose()

		arg_20_0.exchangeList_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.OnMatrixSystemOverdue(arg_21_0)
	arg_21_0:Back()
end

return var_0_0
