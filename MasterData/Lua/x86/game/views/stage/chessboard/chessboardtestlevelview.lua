local ChessBoardTestLevelView = class("ChessBoardTestLevelView", ReduxView)

function ChessBoardTestLevelView:UIName()
	return "UI/NewWarChess/NewWarChessEntryUI"
end

function ChessBoardTestLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function ChessBoardTestLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardTestLevelView:InitUI()
	self:BindCfgUI()

	self.newChessList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ChessBoardTestLevelItem)
end

function ChessBoardTestLevelView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(ChessBoardLevelCfg.all[arg_5_1])
end

function ChessBoardTestLevelView:AddUIListener()
	return
end

function ChessBoardTestLevelView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
end

function ChessBoardTestLevelView:RefreshUI()
	self.newChessList_:StartScroll(#ChessBoardLevelCfg.all)
end

function ChessBoardTestLevelView:OnExit()
	manager.windowBar:HideBar()
end

function ChessBoardTestLevelView:Dispose()
	if self.newChessList_ then
		self.newChessList_:Dispose()

		self.newChessList_ = nil
	end

	self.super.Dispose(self)
end

return ChessBoardTestLevelView
