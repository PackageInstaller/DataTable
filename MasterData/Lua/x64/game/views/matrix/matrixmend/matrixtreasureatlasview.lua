local MatrixTreasureAtlasView = class("MatrixTreasureAtlasView", ReduxView)

function MatrixTreasureAtlasView:UIName()
	return "UI/Matrix/Prepare/MatrixTreasureAtlasUI"
end

function MatrixTreasureAtlasView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixTreasureAtlasView:Init()
	self:InitUI()

	self.data = {}

	for iter_3_0, iter_3_1 in ipairs(MatrixItemCfg.get_id_list_by_matrix_item_type[MatrixConst.ITEM_TYPE.TREASURE]) do
		if MatrixItemCfg[iter_3_1].show_altas then
			table.insert(self.data, iter_3_1)
		end
	end

	table.sort(self.data, function(arg_4_0, arg_4_1)
		if MatrixItemCfg[arg_4_0].rare ~= MatrixItemCfg[arg_4_1].rare then
			return MatrixItemCfg[arg_4_0].rare > MatrixItemCfg[arg_4_1].rare
		end

		return arg_4_0 < arg_4_1
	end)
end

function MatrixTreasureAtlasView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, MatrixTreasureAtlasItem)
end

function MatrixTreasureAtlasView:OnTop()
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

function MatrixTreasureAtlasView:OnEnter()
	self.list_:StartScroll(#self.data)
end

function MatrixTreasureAtlasView:OnExit()
	manager.windowBar:HideBar()
end

function MatrixTreasureAtlasView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:Refresh(self.data[arg_9_1])
end

function MatrixTreasureAtlasView:Dispose()
	self.list_:Dispose()
	MatrixTreasureAtlasView.super.Dispose(self)
end

return MatrixTreasureAtlasView
