local ChessBoardBuffView = class("ChessBoardBuffView", ReduxView)

function ChessBoardBuffView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_StatusPopUI"
end

function ChessBoardBuffView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardBuffView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardBuffView:InitUI()
	self:BindCfgUI()
end

function ChessBoardBuffView:AddUIListener()
	self:AddBtnListener(self.summer2024_cancelbtnBtn_, nil, function()
		gameContext:Go("/chessBoardHomeView")
	end)
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		gameContext:Go("/chessBoardHomeView")
	end)
end

function ChessBoardBuffView:OnEnter()
	self.buffData_ = self.params_.buffData
	self.buffID = self.buffData_:GetBuffPoolID()

	self:Refresh()
end

function ChessBoardBuffView:Refresh()
	self.descText_.text = ChessBoardBuffPoolCfg[self.buffID].description
	self.nameText_.text = ChessBoardBuffPoolCfg[self.buffID].name
	self.iconImg_.sprite = ChessBoardTools.GetBuffImage(self.buffID)

	local var_9_0 = self.buffData_:GetRemainRound()

	if var_9_0 > 0 then
		SetActive(self.remainRoundGo_, true)

		self.remainRoundText_.text = string.format(GetTips("CHESSBOARD_BUFF_REMAINROUND"), var_9_0)
	else
		SetActive(self.remainRoundGo_, false)
	end
end

function ChessBoardBuffView:Dispose()
	self.super.Dispose(self)
end

return ChessBoardBuffView
