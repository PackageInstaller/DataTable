local NewWarChessTestLevelView = class("NewWarChessTestLevelView", ReduxView)

function NewWarChessTestLevelView:UIName()
	return "UI/NewWarChess/NewWarChessEntryUI"
end

function NewWarChessTestLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function NewWarChessTestLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessTestLevelView:InitUI()
	self:BindCfgUI()

	self.newChessList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, NewWarChessLevelItem)
end

function NewWarChessTestLevelView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(NewWarChessLevelCfg.all[arg_5_1])
	arg_5_2:SetEventListener()
end

function NewWarChessTestLevelView:AddUIListener()
	return
end

function NewWarChessTestLevelView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_NEWWARCHESS_MOVEPOINT_PACKAGE
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_NEWWARCHESS_MOVEPOINT_PACKAGE, true)
	self:RefreshUI()
end

function NewWarChessTestLevelView:RefreshUI()
	self.newChessList_:StartScroll(#NewWarChessLevelCfg.all)

	self.tipsText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_RECOVER"), NewChessTools.GetNewWarChessGameSetting("new_warchess_recover")[1])
end

function NewWarChessTestLevelView:OnNewWarChessLevelInfoUpdate()
	self.newChessList_:Refresh()
end

function NewWarChessTestLevelView:OnExit()
	manager.windowBar:HideBar()

	for iter_10_0, iter_10_1 in pairs((self.newChessList_:GetItemList())) do
		iter_10_1:RemoveEventListener()
	end
end

function NewWarChessTestLevelView:Dispose()
	if self.newChessList_ then
		self.newChessList_:Dispose()

		self.newChessList_ = nil
	end

	self.super.Dispose(self)
end

return NewWarChessTestLevelView
