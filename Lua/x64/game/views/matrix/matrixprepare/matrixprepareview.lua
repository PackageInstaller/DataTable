local var_0_0 = class("MatrixPrepareView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Prepare/MatrixPrepareUI"
end

function var_0_0.UIBackCount(arg_2_0)
	return 2
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_startButton, nil, function()
		local var_7_0 = MatrixData:GetGameState()

		if MatrixConst.STATE_TYPE.STARTED == var_7_0 then
			JumpTools.GoToSystem("/matrixBlank/matrixOrigin")
		elseif MatrixAction.CheckTerminalGiftRedPoint(MatrixData:GetTerminalGift()) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("MATRIX_PREPARE_ADJUST_TERMINAL"),
				BtnText = {
					GetTips("MATRIX_PREPARE_GO_ADJUST"),
					GetTips("MATRIX_PREPARE_START_CHALLENGE"),
					GetTips("MATRIX_PREPARE_GO_ADJUST")
				},
				OkCallback = function()
					JumpTools.GoToSystem("/matrixTerminalTalent")
				end,
				CancelCallback = function()
					JumpTools.OpenPageByJump("matrixSelect")
				end
			})
		else
			JumpTools.OpenPageByJump("matrixSelect")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_beaconButton, nil, function()
		JumpTools.GoToSystem("/matrixTreasureAtlas")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_shopButton, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.OLD_DUO_WEI
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_scoreButton, nil, function()
		JumpTools.OpenPageByJump("matrixScoreExchange", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_roleButton, nil, function()
		JumpTools.OpenPageByJump("/matrixHero", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_terminalBtn, nil, function()
		JumpTools.GoToSystem("/matrixTerminalTalent")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_artifactlBtn, nil, function()
		JumpTools.GoToSystem("/matrixBeaconOperate")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_rankBtn, nil, function()
		JumpTools.OpenPageByJump("/matrixRank", {
			type = MatrixConst.MatirxRankType.ALL
		}, ViewConst.SYSTEM_ID.MATRIX_RANK)
	end)
end

function var_0_0.UpdateBar(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function var_0_0.OnTop(arg_18_0)
	arg_18_0:UpdateBar()
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0:Refresh()
	manager.redPoint:bindUIandKey(arg_19_0.m_scoreButton.gameObject.transform, RedPointConst.MATRIX_EXCHANGE_BONUS, {
		x = 125.9,
		y = 31.3
	})
	manager.redPoint:bindUIandKey(arg_19_0.m_artifactlBtn.gameObject.transform, RedPointConst.MATRIX_BEACON_UNLOCK, {
		x = 166,
		y = 41.3
	})
	manager.redPoint:bindUIandKey(arg_19_0.m_terminalBtn.gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT, {
		x = 166,
		y = 41.3
	})

	if arg_19_0.params_.isTimeOut == true then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_TIME_LIMIT_EXCEEDED"),
			OkCallback = function()
				arg_19_0:CheckMail()
			end
		})

		arg_19_0.params_.isTimeOut = false
	else
		arg_19_0:CheckMail()
	end

	if not MatrixData:GetCurRank(MatrixConst.MatirxRankSubType.COMMON) then
		MatrixAction.QueryCurRank(MatrixConst.MatirxRankSubType.COMMON)
	end
end

function var_0_0.CheckMail(arg_21_0)
	if PlayerData:GetUnclaimed(1) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(1)
			end
		})
	end
end

function var_0_0.OnExit(arg_23_0)
	manager.redPoint:unbindUIandKey(arg_23_0.m_scoreButton.gameObject.transform, RedPointConst.MATRIX_EXCHANGE_BONUS)
	manager.redPoint:unbindUIandKey(arg_23_0.m_artifactlBtn.gameObject.transform, RedPointConst.MATRIX_BEACON_UNLOCK)
	manager.redPoint:unbindUIandKey(arg_23_0.m_terminalBtn.gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT)
	manager.windowBar:HideBar()

	if arg_23_0.countdownTimer_ then
		arg_23_0.countdownTimer_:Stop()

		arg_23_0.countdownTimer_ = nil
	end
end

function var_0_0.Refresh(arg_24_0)
	arg_24_0:RefreshTimer()

	if arg_24_0.countdownTimer_ then
		arg_24_0.countdownTimer_:Stop()

		arg_24_0.countdownTimer_ = nil
	end

	arg_24_0.countdownTimer_ = Timer.New(function()
		arg_24_0:RefreshTimer()
	end, 1, -1)

	arg_24_0.countdownTimer_:Start()
	arg_24_0:RefreshRank()
end

function var_0_0.OnMatrixSystemUpdate(arg_26_0)
	arg_26_0:Refresh()
end

function var_0_0.OnMatrixSystemOverdue(arg_27_0)
	ShowMessageBox({
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = GetTips("MATRIX_TIME_LIMIT_EXCEEDED")
	})
end

function var_0_0.RefreshTimer(arg_28_0)
	local var_28_0 = MatrixData:GetNextRefreshTime()

	arg_28_0.m_timer.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(var_28_0))
end

function var_0_0.RefreshRank(arg_29_0)
	local var_29_0 = MatrixData:GetCurRank(MatrixConst.MatirxRankSubType.COMMON)

	if var_29_0 and var_29_0.rank ~= 0 then
		arg_29_0.m_score.text = var_29_0.score
	else
		arg_29_0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function var_0_0.OnMatrixCurRankUpdate(arg_30_0)
	arg_30_0:RefreshRank()
end

function var_0_0.Dispose(arg_31_0)
	var_0_0.super.Dispose(arg_31_0)
end

return var_0_0
