SummerChessView = import("game.views.activity.Submodule.Chess.summer.SummerChessView")

local SummerChessRemasteredView = class("SummerChessRemasteredView", SummerChessView)

function SummerChessRemasteredView:GetChessItemView()
	return SummerChessRemasteredItem
end

function SummerChessRemasteredView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:InitBtns()

	for iter_2_0, iter_2_1 in pairs(self.chessView_) do
		iter_2_1:OnEnter()
	end

	SetActive(self.goTime_, false)
end

function SummerChessRemasteredView:InitBtns()
	if not self.chessView_ then
		self.chessView_ = {}

		for iter_3_0, iter_3_1 in ipairs(WarchessLevelCfg.get_id_list_by_tag[self.params_.tag]) do
			self.chessView_[iter_3_1] = self:GetChessItemView().New(self[string.format("goStage%s_", iter_3_0)], iter_3_1)
		end
	end
end

function SummerChessRemasteredView:OnExit()
	manager.windowBar:HideBar()

	for iter_4_0, iter_4_1 in pairs(self.chessView_) do
		iter_4_1:OnExit()
	end
end

return SummerChessRemasteredView
