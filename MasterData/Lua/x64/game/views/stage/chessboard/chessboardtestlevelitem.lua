local ChessBoardTestLevelItem = class("ChessBoardTestLevelItem", ReduxView)

function ChessBoardTestLevelItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.isOpen_ = false

	self:BindCfgUI()
	self:AddListeners()
end

function ChessBoardTestLevelItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_3_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

		if var_3_0 == 0 or var_3_0 == self.chapterID_ then
			ChessBoardTools.EnterChessMap(self.chapterID_)
		else
			ChessBoardTools.ChessBoardMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CHESSBOARD_ENTER_NEW_MAP"), ChessBoardLevelCfg[var_3_0].name_level),
				OkCallback = function()
					ChessBoardTools.EnterChessMap(self.chapterID_)
				end
			})
		end
	end)
end

function ChessBoardTestLevelItem:SetData(arg_5_1)
	self.chapterID_ = arg_5_1
	self.cfg_ = ChessBoardLevelCfg[arg_5_1]

	self:RefreshUI()
end

function ChessBoardTestLevelItem:RefreshUI()
	self.nametext_.text = self.cfg_.name_level
end

function ChessBoardTestLevelItem:Dispose()
	ChessBoardTestLevelItem.super.Dispose(self)
end

return ChessBoardTestLevelItem
