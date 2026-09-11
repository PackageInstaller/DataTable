local matrixBeaconOperateView = class("matrixBeaconOperateView", ReduxView)

function matrixBeaconOperateView:UIName()
	return "UI/Matrix/Prepare/MatrixBeaconOperateUI"
end

function matrixBeaconOperateView:UIParent()
	return manager.ui.uiMain.transform
end

function matrixBeaconOperateView:Init()
	self:InitUI()
end

function matrixBeaconOperateView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, MatrixBeaconOperateItem)
end

function matrixBeaconOperateView:OnTop()
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

function matrixBeaconOperateView:OnEnter()
	self:Refresh()
end

function matrixBeaconOperateView:Refresh()
	self.data = MatrixBeaconCfg.all

	table.sort(self.data, function(arg_8_0, arg_8_1)
		local var_8_0 = MatrixData:GetBeaconIsLock(arg_8_1)

		if MatrixData:GetBeaconIsLock(arg_8_0) == var_8_0 then
			local var_8_1 = MatrixTools.GetBeaconIsUnlockCondition(arg_8_0)

			if var_8_1 == MatrixTools.GetBeaconIsUnlockCondition(arg_8_1) then
				return arg_8_0 < arg_8_1
			else
				return var_8_1
			end
		else
			return var_8_0
		end
	end)
	self.list_:StartScroll(#self.data)
end

function matrixBeaconOperateView:OnExit()
	manager.windowBar:HideBar()
end

function matrixBeaconOperateView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:Refresh(self.data[arg_10_1])
end

function matrixBeaconOperateView:Dispose()
	self.list_:Dispose()
	matrixBeaconOperateView.super.Dispose(self)
end

function matrixBeaconOperateView:OnMatrixUserUpdate()
	for iter_12_0, iter_12_1 in pairs((self.list_:GetItemList())) do
		iter_12_1:UpdateView()
	end
end

return matrixBeaconOperateView
