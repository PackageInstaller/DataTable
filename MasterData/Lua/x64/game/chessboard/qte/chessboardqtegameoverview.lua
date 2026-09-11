local ChessBoardQTEGameOverView = class("ChessBoardQTEGameOverView", ReduxView)

function ChessBoardQTEGameOverView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_QTEGameResultPopUI"
end

function ChessBoardQTEGameOverView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardQTEGameOverView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardQTEGameOverView:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controllerexcollection_:GetController("winState")
end

function ChessBoardQTEGameOverView:AddUIListener()
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		if self.isCanClose then
			manager.ChessBoardManager:SetSmallGamePoint(0, self.resultType)
			manager.ChessBoardManager:BattleFinish()
		end
	end)
end

function ChessBoardQTEGameOverView:OnEnter()
	self:RefreshUi()

	self.isCanClose = false
	self.timer = Timer.New(function()
		self.isCanClose = true
	end, 0.5)

	self.timer:Start()
end

function ChessBoardQTEGameOverView:RefreshUi()
	self.resultType = self.params_.resultType
	self.scoreValue = self.params_.scoreValue
	self.textscoreText_.text = self.scoreValue

	if self.resultType == ChessBoardQTEGameConst.QTEGameResult.Lose then
		self.controller_:SetSelectedState("lose")
	elseif self.resultType == ChessBoardQTEGameConst.QTEGameResult.Win then
		self.controller_:SetSelectedState("win")
	else
		self.controller_:SetSelectedState("perfect")
	end
end

function ChessBoardQTEGameOverView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function ChessBoardQTEGameOverView:Dispose()
	self:StopTimer()
	self.super.Dispose(self)
end

return ChessBoardQTEGameOverView
