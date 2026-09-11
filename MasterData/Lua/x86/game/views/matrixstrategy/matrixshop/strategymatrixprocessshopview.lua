local StrategyMatrixProcessShopView = class("StrategyMatrixProcessShopView", MatrixProcessShopView)

function StrategyMatrixProcessShopView:InitUI()
	self:BindCfgUI()

	self.matrixShopList_ = LuaList.New(handler(self, self.indexItem), self.m_list, StrategyMatrixProcessShopItem)
	self.emptyController = ControllerUtil.GetController(self.transform_, "empty")
end

function StrategyMatrixProcessShopView:AddUIListener()
	self:AddBtnListener(self.m_sellerBtn, nil, function()
		self:RandomDialog(1)
	end)
	self:AddBtnListener(self.m_refreshBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("MATRIX_SHOP_REFRESH"), ItemTools.getItemName(CurrencyConst.CURRENCY_STRATEGYMATRIX_TICKET_3_5), self.refreshCost),
			OkCallback = function()
				StrategyMatrixAction.QueryRefreshShopItem(self.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function StrategyMatrixProcessShopView:indexItem(arg_7_1, arg_7_2)
	arg_7_2:SetMatrixActivityId(self.matrix_activity_id)
	StrategyMatrixProcessShopView.super.indexItem(self, arg_7_1, arg_7_2)
end

function StrategyMatrixProcessShopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(self.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MATRIX_SURE_GET_OUT_SHOP"),
			OkCallback = function()
				if StrategyMatrixData:GetGameState(self.matrix_activity_id) == MatrixConst.STATE_TYPE.STARTED then
					StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id)
				end
			end
		})
	end)
end

function StrategyMatrixProcessShopView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	StrategyMatrixProcessShopView.super.OnEnter(self)
end

function StrategyMatrixProcessShopView:GetGameState()
	return StrategyMatrixData:GetGameState(self.matrix_activity_id)
end

function StrategyMatrixProcessShopView:GetMatrixPhaseData()
	return StrategyMatrixData:GetMatrixPhaseData(self.matrix_activity_id)
end

function StrategyMatrixProcessShopView:GetShoRefreshTimes()
	return StrategyMatrixData:GetShoRefreshTimes(self.matrix_activity_id)
end

function StrategyMatrixProcessShopView:GetShopFressRefreshTimes()
	return StrategyMatrixData:GetShopFressRefreshTimes(self.matrix_activity_id)
end

function StrategyMatrixProcessShopView:GetSwitchItemIcon(arg_16_1)
	if arg_16_1 == 26 then
		return StrategyMatrixTools.GetCoinItem(self.matrix_activity_id)
	end

	return arg_16_1
end

return StrategyMatrixProcessShopView
