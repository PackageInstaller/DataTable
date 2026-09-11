local SubPlotChessView = class("SubPlotChessView", ReduxView)

function SubPlotChessView:UIName()
	return WarChessTools.GetSubPlotViewName(self.params_.tag)
end

function SubPlotChessView:UIParent()
	return manager.ui.uiMain.transform
end

function SubPlotChessView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function SubPlotChessView:AddUIListener()
	return
end

function SubPlotChessView:InitBtns()
	if not self.chessView_ then
		self.chessView_ = {}

		for iter_5_0, iter_5_1 in ipairs(WarchessLevelCfg.get_id_list_by_tag[self.params_.tag]) do
			self.chessView_[iter_5_1] = self:GetChessItemView().New(self[string.format("goStage%s_", iter_5_0)], iter_5_1)
		end
	end
end

function SubPlotChessView:GetChessItemView()
	return SubPlotChessItem
end

function SubPlotChessView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:InitBtns()

	for iter_7_0, iter_7_1 in pairs(self.chessView_) do
		iter_7_1:OnEnter()
	end

	if self.params_.chapterClientID == ChessConst.SUBPLOT_TAG.HELLA then
		SetActive(self.timeGo_, false)
		SetActive(self.buttonBtn_.gameObject, false)
	end
end

function SubPlotChessView:OnExit()
	manager.windowBar:HideBar()
end

function SubPlotChessView:Dispose()
	for iter_9_0, iter_9_1 in pairs(self.chessView_) do
		iter_9_1:Dispose()
	end

	self.chessView_ = nil

	SubPlotChessView.super.Dispose(self)
end

return SubPlotChessView
