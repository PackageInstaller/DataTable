local ChessBoardTipsWindowView = class("ChessBoardTipsWindowView", ReduxView)

function ChessBoardTipsWindowView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_TeachingPopUI"
end

function ChessBoardTipsWindowView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardTipsWindowView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardTipsWindowView:InitUI()
	self:BindCfgUI()
end

function ChessBoardTipsWindowView:OnEnter()
	self.tipsWindowID_ = self.params_.tipsWindowID
	self.callBack_ = self.params_.callBack
	self.titleText_.text = ChessBoardTipsWindowCfg[self.tipsWindowID_].title
	self.desText_.text = ChessBoardTipsWindowCfg[self.tipsWindowID_].description
	self.tipsText_.text = ChessBoardTipsWindowCfg[self.tipsWindowID_].tips
	self.isCanClick_ = false
	self.timer_ = Timer.New(function()
		self.isCanClick_ = true

		self:StopTimer()
	end, 1, 1)

	self.timer_:Start()
end

function ChessBoardTipsWindowView:OnExit()
	self:StopTimer()
end

function ChessBoardTipsWindowView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChessBoardTipsWindowView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.isCanClick_ and self.callBack_ then
			self.callBack_()

			self.callBack_ = nil
		end
	end)
end

function ChessBoardTipsWindowView:Dispose()
	self.super.Dispose(self)
	self:StopTimer()
end

return ChessBoardTipsWindowView
