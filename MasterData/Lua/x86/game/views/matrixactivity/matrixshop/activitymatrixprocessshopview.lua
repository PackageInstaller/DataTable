local ActivityMatrixProcessShopView = class("ActivityMatrixProcessShopView", MatrixProcessShopView)

function ActivityMatrixProcessShopView:InitUI()
	self:BindCfgUI()

	self.matrixShopList_ = LuaList.New(handler(self, self.indexItem), self.m_list, ActivityMatrixProcessShopItem)
	self.emptyController = ControllerUtil.GetController(self.transform_, "empty")
end

function ActivityMatrixProcessShopView:AddUIListener()
	self:AddBtnListener(self.m_sellerBtn, nil, function()
		self:RandomDialog(1)
	end)
	self:AddBtnListener(self.m_refreshBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					self:GetSwitchItemIcon(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN),
					self.refreshCost
				},
				(GetTips("MATRIX_SHOP_REFRESH"))
			},
			OkCallback = function()
				ActivityMatrixAction.QueryRefreshShopItem(self.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function ActivityMatrixProcessShopView:indexItem(arg_7_1, arg_7_2)
	arg_7_2:SetMatrixActivityId(self.matrix_activity_id)
	ActivityMatrixProcessShopView.super.indexItem(self, arg_7_1, arg_7_2)
end

function ActivityMatrixProcessShopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MATRIX_SURE_GET_OUT_SHOP"),
			OkCallback = function()
				if ActivityMatrixData:GetGameState(self.matrix_activity_id) == MatrixConst.STATE_TYPE.STARTED then
					ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id)
				end

				JumpTools.OpenPageByJump("/matrixBlank/activityMatrixOrigin", {
					matrix_activity_id = self.matrix_activity_id
				})
			end
		})
	end)
end

function ActivityMatrixProcessShopView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	ActivityMatrixProcessShopView.super.OnEnter(self)
end

function ActivityMatrixProcessShopView:GetGameState()
	return ActivityMatrixData:GetGameState(self.matrix_activity_id)
end

function ActivityMatrixProcessShopView:GetMatrixPhaseData()
	return ActivityMatrixData:GetMatrixPhaseData(self.matrix_activity_id)
end

function ActivityMatrixProcessShopView:GetShoRefreshTimes()
	return ActivityMatrixData:GetShoRefreshTimes(self.matrix_activity_id)
end

function ActivityMatrixProcessShopView:GetShopFressRefreshTimes()
	return ActivityMatrixData:GetShopFressRefreshTimes(self.matrix_activity_id)
end

function ActivityMatrixProcessShopView:GetSwitchItemIcon(arg_16_1)
	if arg_16_1 == 26 then
		return ActivityMatrixTools.GetCoinItem(self.matrix_activity_id)
	end

	return arg_16_1
end

return ActivityMatrixProcessShopView
