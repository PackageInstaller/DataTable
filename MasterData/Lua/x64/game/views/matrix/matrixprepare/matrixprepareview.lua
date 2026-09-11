local MatrixPrepareView = class("MatrixPrepareView", ReduxView)

function MatrixPrepareView:UIName()
	return "UI/Matrix/Prepare/MatrixPrepareUI"
end

function MatrixPrepareView:UIBackCount()
	return 2
end

function MatrixPrepareView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixPrepareView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixPrepareView:InitUI()
	self:BindCfgUI()
end

function MatrixPrepareView:AddUIListener()
	self:AddBtnListener(self.m_startButton, nil, function()
		if MatrixConst.STATE_TYPE.STARTED == MatrixData:GetGameState() then
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
	self:AddBtnListener(self.m_beaconButton, nil, function()
		JumpTools.GoToSystem("/matrixTreasureAtlas")
	end)
	self:AddBtnListener(self.m_shopButton, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.OLD_DUO_WEI
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.m_scoreButton, nil, function()
		JumpTools.OpenPageByJump("matrixScoreExchange", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	self:AddBtnListener(self.m_roleButton, nil, function()
		JumpTools.OpenPageByJump("/matrixHero", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	self:AddBtnListener(self.m_terminalBtn, nil, function()
		JumpTools.GoToSystem("/matrixTerminalTalent")
	end)
	self:AddBtnListener(self.m_artifactlBtn, nil, function()
		JumpTools.GoToSystem("/matrixBeaconOperate")
	end)
	self:AddBtnListener(self.m_rankBtn, nil, function()
		JumpTools.OpenPageByJump("/matrixRank", {
			type = MatrixConst.MatirxRankType.ALL
		}, ViewConst.SYSTEM_ID.MATRIX_RANK)
	end)
end

function MatrixPrepareView:UpdateBar()
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

function MatrixPrepareView:OnTop()
	self:UpdateBar()
end

function MatrixPrepareView:OnEnter()
	self:Refresh()
	manager.redPoint:bindUIandKey(self.m_scoreButton.gameObject.transform, RedPointConst.MATRIX_EXCHANGE_BONUS, {
		x = 125.9,
		y = 31.3
	})
	manager.redPoint:bindUIandKey(self.m_artifactlBtn.gameObject.transform, RedPointConst.MATRIX_BEACON_UNLOCK, {
		x = 166,
		y = 41.3
	})
	manager.redPoint:bindUIandKey(self.m_terminalBtn.gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT, {
		x = 166,
		y = 41.3
	})

	if self.params_.isTimeOut == true then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_TIME_LIMIT_EXCEEDED"),
			OkCallback = function()
				self:CheckMail()
			end
		})

		self.params_.isTimeOut = false
	else
		self:CheckMail()
	end

	if not MatrixData:GetCurRank(MatrixConst.MatirxRankSubType.COMMON) then
		MatrixAction.QueryCurRank(MatrixConst.MatirxRankSubType.COMMON)
	end
end

function MatrixPrepareView:CheckMail()
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

function MatrixPrepareView:OnExit()
	manager.redPoint:unbindUIandKey(self.m_scoreButton.gameObject.transform, RedPointConst.MATRIX_EXCHANGE_BONUS)
	manager.redPoint:unbindUIandKey(self.m_artifactlBtn.gameObject.transform, RedPointConst.MATRIX_BEACON_UNLOCK)
	manager.redPoint:unbindUIandKey(self.m_terminalBtn.gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT)
	manager.windowBar:HideBar()

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end
end

function MatrixPrepareView:Refresh()
	self:RefreshTimer()

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	self.countdownTimer_ = Timer.New(function()
		self:RefreshTimer()
	end, 1, -1)

	self.countdownTimer_:Start()
	self:RefreshRank()
end

function MatrixPrepareView:OnMatrixSystemUpdate()
	self:Refresh()
end

function MatrixPrepareView:OnMatrixSystemOverdue()
	ShowMessageBox({
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = GetTips("MATRIX_TIME_LIMIT_EXCEEDED")
	})
end

function MatrixPrepareView:RefreshTimer()
	self.m_timer.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr((MatrixData:GetNextRefreshTime())))
end

function MatrixPrepareView:RefreshRank()
	local var_29_0 = MatrixData:GetCurRank(MatrixConst.MatirxRankSubType.COMMON)

	self.m_score.text = var_29_0 and var_29_0.rank ~= 0 and var_29_0.score or GetTips("MATRIX_RANK_NO_INFO")
end

function MatrixPrepareView:OnMatrixCurRankUpdate()
	self:RefreshRank()
end

function MatrixPrepareView:Dispose()
	MatrixPrepareView.super.Dispose(self)
end

return MatrixPrepareView
