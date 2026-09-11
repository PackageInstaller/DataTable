local ChessBoardOverView = class("ChessBoardOverView", ReduxView)

function ChessBoardOverView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_OverPopUI"
end

function ChessBoardOverView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardOverView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardOverView:InitUI()
	self:BindCfgUI()
end

function ChessBoardOverView:OnEnter()
	ChessBoardLuaBridge.SetInputEnable(false)

	local var_5_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

	self.title_.text = string.format(GetTips("CHESSBOARD_FINISH_MAP"), GetI18NText(ChessBoardLevelCfg[ChessBoardData:GetCurrentPlayingChessBoardLevelID()].name_level))

	SetActive(self.newMapText_.gameObject, false)

	if ChessBoardLevelCfg[var_5_0].next_level > 0 then
		if ChessBoardLevelCfg[ChessBoardLevelCfg[var_5_0].next_level].unlock_condition > 0 then
			local var_5_1 = HistoryData:GetHistoryData(ChessBoardLevelCfg[ChessBoardLevelCfg[var_5_0].next_level].unlock_condition)

			if var_5_1 == 0 or var_5_1 == nil then
				SetActive(self.newMapText_.gameObject, true)

				self.newMapText_.text = string.format(GetTips("CHESSBOARD_UNLOCK_NEW_MAP"), GetI18NText(ChessBoardLevelCfg[ChessBoardLevelCfg[var_5_0].next_level].name_level))
			end
		end
	end
end

function ChessBoardOverView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		ChessBoardAction.FinishCurrentBoard(function()
			local var_8_0 = ChessBoardData:GetTemporaryData("urlParams")

			if var_8_0 and var_8_0.selectLevelID then
				var_8_0.selectLevelID = nil
			end

			ChessBoardData:SetTemporaryData("urlParams", var_8_0)
			ChessBoardTools.ExitChessBoardScene(false)
		end)
	end)
end

function ChessBoardOverView:OnExitInput()
	ChessBoardAction.FinishCurrentBoard(function()
		local var_10_0 = ChessBoardData:GetTemporaryData("urlParams")

		if var_10_0 and var_10_0.selectLevelID then
			var_10_0.selectLevelID = nil
		end

		ChessBoardData:SetTemporaryData("urlParams", var_10_0)
		ChessBoardTools.ExitChessBoardScene(false)
	end)

	return true
end

function ChessBoardOverView:Dispose()
	self.super.Dispose(self)
end

return ChessBoardOverView
