local AutoChessOpenCardInfoPopRecordView = class("AutoChessOpenCardInfoPopRecordView", ReduxView)

function AutoChessOpenCardInfoPopRecordView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()

	self.pageShowCount = 5
end

function AutoChessOpenCardInfoPopRecordView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.recordScrollHelper_ = LuaList.New(handler(self, self.IndexRecordItem), self.recordList_, AutoChessOpenCardPopRecordItem)
	self.leftArrowController_ = self.controllerEx_:GetController("leftArrowGrey")
	self.rightArrowController_ = self.controllerEx_:GetController("rightArrowGrey")
end

function AutoChessOpenCardInfoPopRecordView:AddUIListener()
	self:AddBtnListener(self.rightBtn_, nil, function()
		if self.pageNum_ * self.pageShowCount + 1 <= AutoChessCardData:GetOpenCardRecordNum() then
			self.pageNum_ = self.pageNum_ + 1

			self:RefreshRecordUI()
		end
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		if self.pageNum_ > 1 then
			self.pageNum_ = self.pageNum_ - 1

			self:RefreshRecordUI()
		end
	end)
end

function AutoChessOpenCardInfoPopRecordView:OnEnter()
	self.txtTips_.text = GetTipsF("AUTO_CHESS_2_HISTORY_TIP", GameSetting.auto_chess_2_pack_history_num.value[1])
	self.txtLabel_.text = GetTips("AUTO_CHESS_2_HISTORY_TIP2")
	self.txtTips1_.text = GetTips("AUTO_CHESS_2_HISTORY_TIP3")
	self.txtTips2_.text = GetTips("AUTO_CHESS_2_HISTORY_TIP4")
end

function AutoChessOpenCardInfoPopRecordView:RefreshRecord()
	self.pageNum_ = 1

	self:RefreshRecordUI()
end

function AutoChessOpenCardInfoPopRecordView:RefreshRecordUI()
	self.pagenumText_.text = self.pageNum_
	self.recordItemList_ = {}

	local var_8_0 = AutoChessCardData:GetOpenCardRecordNum()

	for iter_8_0 = (self.pageNum_ - 1) * self.pageShowCount + 1, math.min(self.pageNum_ * self.pageShowCount, var_8_0) do
		table.insert(self.recordItemList_, iter_8_0)
	end

	self.recordScrollHelper_:StartScroll(#self.recordItemList_)
	self.leftArrowController_:SetSelectedState(self.pageNum_ > 1 and "not_grey" or "grey")
	self.rightArrowController_:SetSelectedState(var_8_0 >= self.pageNum_ * self.pageShowCount + 1 and "not_grey" or "grey")
end

function AutoChessOpenCardInfoPopRecordView:IndexRecordItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(self.recordItemList_[arg_9_1], arg_9_1)
end

function AutoChessOpenCardInfoPopRecordView:Dispose()
	self.recordScrollHelper_:Dispose()
	AutoChessOpenCardInfoPopRecordView.super.Dispose(self)
end

return AutoChessOpenCardInfoPopRecordView
