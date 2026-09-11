local ChessDebuffPop = class("ChessDebuffPop", ReduxView)

function ChessDebuffPop:UIName()
	return "Widget/System/WarChess_Battle/WarChessDeBuffUI"
end

function ChessDebuffPop:UIParent()
	return manager.ui.uiMain.transform
end

function ChessDebuffPop:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessDebuffPop:InitUI()
	self:BindCfgUI()

	self.showItem_ = ChessChooseItem.New(self.battleflagitemGo_)
end

function ChessDebuffPop:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
		manager.ChessManager:DoNextEvent()
	end)
end

function ChessDebuffPop:RefreshUI()
	self.showItem_:RefreshUI(1, self.params_.data)
end

function ChessDebuffPop:OnEnter()
	self.data_ = self.params_.data

	self:RefreshUI()
end

function ChessDebuffPop:OnExit()
	return
end

function ChessDebuffPop:Dispose()
	self.showItem_:Dispose()
	ChessDebuffPop.super.Dispose(self)
end

return ChessDebuffPop
