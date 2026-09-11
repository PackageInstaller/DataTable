local AutoChessScoreBoardPopView = class("AutoChessScoreBoardPopView", ReduxView)

function AutoChessScoreBoardPopView:UIName()
	return "Widget/System/Activity_AutoChess_Battle/Activity_AutoChess_PVP_POPUI_ScoreBoard"
end

function AutoChessScoreBoardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessScoreBoardPopView:Init()
	self:InitUI()

	self.clickChessHandler_ = handler(self, self.OnClickChess)
end

function AutoChessScoreBoardPopView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.autoChessCountDownView_ = AutoChessCountDownView.New(self.timerGo_)
	self.playerList_ = LuaList.New(handler(self, self.IndexItem), self.playerListGo_, AutoChessScoreBoardPopItemView)
	self.tipsPanelView_ = AutoChessTipsPanelView.New(self.tipsPanelGo_)
	self.startPos_ = 164
	self.itemHeight_ = 180
end

function AutoChessScoreBoardPopView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnCloseTips()
	end)
	self.scrollView_.onValueChanged:AddListener(function()
		self:OnCloseTips()
	end)
end

function AutoChessScoreBoardPopView:OnEnter()
	self:OnCloseTips()
	self.autoChessCountDownView_:UpdateCountDownTime()

	self.scoreBoardDataList_ = AutoChessData:GetScoreBoardDataList()

	for iter_9_0, iter_9_1 in ipairs(self.scoreBoardDataList_) do
		if iter_9_1.isSelf then
			self.battleUserId_ = iter_9_1.battleUserId
		end
	end

	self.playerList_:StartScroll(#self.scoreBoardDataList_)
	self:ScrollJump()
	self:RegistEventListener("AUTO_CHESS_SCORE_BOARD_CHESS_CLICK", self.clickChessHandler_)
end

function AutoChessScoreBoardPopView:OnClickChess(arg_10_1, arg_10_2)
	self.isShowTips_ = true

	SetActive(self.maskBtn_.gameObject, self.isShowTips_)
	self.tipsPanelView_:SetActive(self.isShowTips_)
	self.tipsPanelView_:SetData(arg_10_1)
	self.tipsPanelView_:SetGoldState(false)
	self.tipsPanelView_:SetPos((arg_10_2:GetPos()))
	AutoChessTools.ScreenAdapter(arg_10_2, self.tipsPanelView_)
end

function AutoChessScoreBoardPopView:OnCloseTips()
	if not self.isShowTips_ then
		return
	end

	self.isShowTips_ = false

	SetActive(self.maskBtn_.gameObject, self.isShowTips_)
	self.tipsPanelView_:SetActive(self.isShowTips_)
end

function AutoChessScoreBoardPopView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.scoreBoardDataList_[arg_12_1], self.scrollView_, false)
	arg_12_2:UpdateTipsState(arg_12_2.scoreBoardData_.userId == self.battleUserId_)
end

function AutoChessScoreBoardPopView:ScrollJump()
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in ipairs(self.scoreBoardDataList_) do
		if iter_13_1.isSelf then
			var_13_0 = iter_13_0

			break
		end
	end

	if var_13_0 >= 6 then
		self.playerList_:SetScrolledPosition(Vector2.New(0, (self.startPos_ + self.itemHeight_ * (#self.scoreBoardDataList_ - 6) - (self.startPos_ + self.itemHeight_ * (var_13_0 - 6))) / (self.startPos_ + self.itemHeight_ * (#self.scoreBoardDataList_ - 6))))
	end
end

function AutoChessScoreBoardPopView:OnExit()
	self:RemoveAllEventListener()
	AutoChessScoreBoardPopView.super.OnExit(self)
end

function AutoChessScoreBoardPopView:Dispose()
	self.autoChessCountDownView_:Dispose()
	self.playerList_:Dispose()
	self.tipsPanelView_:Dispose()
	AutoChessScoreBoardPopView.super.Dispose(self)
end

return AutoChessScoreBoardPopView
