local MatrixTreasureMiniView = class("MatrixTreasureMiniView", ReduxView)

function MatrixTreasureMiniView:UIBackCount()
	return 3
end

function MatrixTreasureMiniView:UIName()
	return "UI/Matrix/Prepare/MatrixTreasureMiniUI"
end

function MatrixTreasureMiniView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixTreasureMiniView:Init()
	self:InitUI()
end

function MatrixTreasureMiniView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, MatrixTreasureAtlasItem)
end

function MatrixTreasureMiniView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
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
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function MatrixTreasureMiniView:OnEnter()
	self.data = self:GetArtifactList()

	table.sort(self.data, function(arg_9_0, arg_9_1)
		if MatrixItemCfg[arg_9_0.id].rare ~= MatrixItemCfg[arg_9_1.id].rare then
			return MatrixItemCfg[arg_9_0.id].rare > MatrixItemCfg[arg_9_1.id].rare
		end

		return arg_9_0.id < arg_9_1.id
	end)
	self.list_:StartScroll(#self.data)
end

function MatrixTreasureMiniView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:Refresh(self.data[arg_10_1].id, self.data[arg_10_1].wins)
end

function MatrixTreasureMiniView:Dispose()
	self.list_:Dispose()
	MatrixTreasureMiniView.super.Dispose(self)
end

function MatrixTreasureMiniView:GetArtifactList()
	return MatrixData:GetArtifactList()
end

return MatrixTreasureMiniView
