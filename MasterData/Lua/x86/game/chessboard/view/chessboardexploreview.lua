local ChessBoardExploreView = class("ChessBoardExploreView", ReduxView)

function ChessBoardExploreView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_ExplorePopUI"
end

function ChessBoardExploreView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardExploreView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardExploreView:InitUI()
	self:BindCfgUI()
end

function ChessBoardExploreView:AddUIListener()
	self:AddBtnListener(self.summer2024_redbtnBtn_, nil, function()
		ChessBoardTools.ChessBoardMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CHESSBOARD_CHOOSE_EXIT_MAP_CHECK"),
			OkCallback = function()
				ChessBoardTools.ExitChessBoardScene(false)
				ChessBoardAction.FinishCurrentBoard()
			end
		})
	end)
	self:AddBtnListener(self.summer2024_cancelbtnBtn_, nil, function()
		ChessBoardTools.ExitChessBoardScene(false)
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.Back()

		if self.blockState then
			manager.ChessBoardManager.blockerManager_:ShowBlocker()
		end
	end)
end

function ChessBoardExploreView:OnTop()
	self:OnChessBoardBlockShow()
end

function ChessBoardExploreView:OnChessBoardBlockShow()
	self.blockState = manager.ChessBoardManager.blockerManager_:CheckIsShowBlocker()

	if self.blockState then
		manager.ChessBoardManager.blockerManager_:HideBlocker()
	end
end

function ChessBoardExploreView:OnEnter()
	self:Refresh()
end

function ChessBoardExploreView:Refresh()
	self.titleText_.text = ChessBoardLevelCfg[ChessBoardData:GetCurrentPlayingChessBoardLevelID()].name_level

	local var_13_0 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_PROGRESS")

	self.progressValueText_.text = math.floor(math.min(manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_CURRENT_PROGRESS"), var_13_0) / var_13_0 * 100)
	self.sliexploreImg_.fillAmount = math.min(manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_CURRENT_PROGRESS"), var_13_0) / var_13_0
end

function ChessBoardExploreView:Dispose()
	self.super.Dispose(self)
end

return ChessBoardExploreView
