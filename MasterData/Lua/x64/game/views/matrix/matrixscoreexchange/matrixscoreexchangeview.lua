local MatrixScoreExchangeView = class("MatrixScoreExchangeView", ReduxView)

function MatrixScoreExchangeView:UIName()
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeUI"
end

function MatrixScoreExchangeView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixScoreExchangeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixScoreExchangeView:InitUI()
	self:BindCfgUI()

	self.exchangeList_ = LuaList.New(handler(self, self.indexItem), self.scoreListGo_, MatrixScoreExchangeItem)
	self.passController = ControllerUtil.GetController(self.transform_, "pass")
end

function MatrixScoreExchangeView:AddUIListener()
	self:AddBtnListener(self.oneKeyGetBtn_, nil, function()
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

function MatrixScoreExchangeView:AddEventListeners()
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_8_0)
		if arg_8_0 == CurrencyConst.CURRENCY_TYPE_MATRIX_PT then
			self:UpdateView()

			for iter_8_0, iter_8_1 in pairs(self.exchangeList_:GetItemList()) do
				iter_8_1:UpdateView()
			end
		end
	end)
end

function MatrixScoreExchangeView:indexItem(arg_9_1, arg_9_2)
	local var_9_0 = MatrixData:GetPointRewardList()

	arg_9_2:SetData(arg_9_1, var_9_0[arg_9_1].rank, var_9_0[arg_9_1].item_list, var_9_0[arg_9_1].is_got_reward, var_9_0[arg_9_1].need_level)
end

function MatrixScoreExchangeView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MatrixScoreExchangeView:OnMatrixSystemUpdate()
	self:UpdateView()
end

function MatrixScoreExchangeView:OnMatrixUserUpdate()
	self:UpdateView()
end

function MatrixScoreExchangeView:OnGetMatrixExchangeBonus()
	self:UpdateView()
	self.exchangeList_:StartScrollWithoutAnimator(#MatrixData:GetPointRewardList())
end

function MatrixScoreExchangeView:UpdateView()
	local var_14_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT)

	self.myScoreText_.text = string.format("%d", var_14_0)

	local var_14_1 = false
	local var_14_2 = MatrixData:GetTerminalLevel()

	for iter_14_0, iter_14_1 in pairs(MatrixData:GetPointRewardList()) do
		if var_14_0 >= MatrixPointRankCfg[iter_14_1.rank].point and iter_14_1.is_got_reward == 0 and var_14_2 >= iter_14_1.need_level then
			var_14_1 = true

			break
		end
	end

	if var_14_0 == 0 then
		self.passController:SetSelectedIndex(0)
	elseif var_14_1 then
		self.passController:SetSelectedIndex(1)
	else
		self.passController:SetSelectedIndex(2)
	end
end

function MatrixScoreExchangeView:OnTop()
	self:UpdateView()

	for iter_15_0, iter_15_1 in pairs(self.exchangeList_:GetItemList()) do
		iter_15_1:UpdateView()
	end
end

function MatrixScoreExchangeView:OnEnter()
	self:UpdateBar()
	self.exchangeList_:StartScroll(#MatrixData:GetPointRewardList())

	self.timer_ = Timer.New(function()
		self.countdownText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr((MatrixData:GetNextRefreshTime())))
	end, 0.2, -1)

	self.timer_:Start()
	self:UpdateView()

	self.terminalLv = MatrixData:GetTerminalLevel()

	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnTerminalExpChange))
end

function MatrixScoreExchangeView:OnTerminalExpChange(arg_18_1)
	if arg_18_1 == CurrencyConst.CURRENCY_TYPE_MATRIX_TERMINAL_EXP then
		MatrixData:UpdateTerminalLevel()

		local var_18_0 = MatrixData:GetTerminalLevel()

		if self.terminalLv ~= var_18_0 then
			self.terminalLv = var_18_0

			JumpTools.OpenPageByJump("matrixTerminalLevelUpgrade", {
				newLv = var_18_0
			})
		end
	end
end

function MatrixScoreExchangeView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self:RemoveAllEventListener()
end

function MatrixScoreExchangeView:Dispose()
	if self.exchangeList_ then
		self.exchangeList_:Dispose()

		self.exchangeList_ = nil
	end

	MatrixScoreExchangeView.super.Dispose(self)
end

function MatrixScoreExchangeView:OnMatrixSystemOverdue()
	self:Back()
end

return MatrixScoreExchangeView
