local ChessBoardBattleChanceView = class("ChessBoardBattleChanceView", ReduxView)

function ChessBoardBattleChanceView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_PlayPopUI"
end

function ChessBoardBattleChanceView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardBattleChanceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardBattleChanceView:InitUI()
	self:BindCfgUI()
end

function ChessBoardBattleChanceView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		if ChessBoardChanceCfg[self.chanceID_].play_start_story > 0 then
			manager.story:StartChessStoryWithBackground(ChessBoardChanceCfg[self.chanceID_].play_start_story, function(arg_7_0)
				manager.ChessBoardManager:BattleStart(self.chanceID_)
				ChessBoardTools.StartChanceGame(self.chanceID_)
			end)
		else
			manager.ChessBoardManager:BattleStart(self.chanceID_)
			ChessBoardTools.StartChanceGame(self.chanceID_)
		end
	end)
end

function ChessBoardBattleChanceView:OnEnter()
	self.chanceID_ = self.params_.chanceID
	self.titleText_.text = ChessBoardChanceCfg[self.chanceID_].params_title[1]
	self.desText_.text = ChessBoardChanceCfg[self.chanceID_].params_des[1]
	self.taskText_.text = ChessBoardChanceCfg[self.chanceID_].target_des

	ChessBoardLuaBridge.SetInputEnable(false)
end

function ChessBoardBattleChanceView:OnTop()
	JumpTools.RefreshGaussianBg()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/chessBoardExploreView")
	end)
end

function ChessBoardBattleChanceView:OnExit()
	manager.windowBar:HideBar()
	ChessBoardLuaBridge.SetInputEnable(true)
end

function ChessBoardBattleChanceView:Dispose()
	self.super.Dispose(self)
end

return ChessBoardBattleChanceView
