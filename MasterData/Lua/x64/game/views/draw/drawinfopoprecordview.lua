local DrawInfoPopRecordView = class("DrawInfoPopRecordView", ReduxView)

function DrawInfoPopRecordView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()

	self.pageShowCount = 5
end

function DrawInfoPopRecordView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.recordScrollHelper_ = LuaList.New(handler(self, self.IndexRecordItem), self.recordList_, DrawInfoPopRecordItem)
	self.leftArrowController_ = self.controllerEx_:GetController("leftArrowGrey")
	self.rightArrowController_ = self.controllerEx_:GetController("rightArrowGrey")
end

function DrawInfoPopRecordView:AddUIListener()
	self:AddBtnListener(self.rightBtn_, nil, function()
		if self.pageNum_ * self.pageShowCount + 1 <= #self.record_list then
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

function DrawInfoPopRecordView:RefreshRecord(arg_6_1, arg_6_2)
	self.poolId = arg_6_1

	local var_6_0 = DrawData:GetDrawRecord(arg_6_1)

	self.pageNum_ = 1

	if var_6_0 then
		self.times = var_6_0.ssr_draw_times
		self.record_list = var_6_0.draw_record_list

		self:RefreshRecordUI()
	else
		DrawAction.RequestRecord(arg_6_1)
	end
end

function DrawInfoPopRecordView:OnRefreshRecord(arg_7_1, arg_7_2)
	local var_7_0 = DrawData:GetDrawRecord(arg_7_2.id)

	if var_7_0 then
		self.times = var_7_0.ssr_draw_times
		self.record_list = var_7_0.draw_record_list or {}

		self:RefreshRecordUI()
	end
end

function DrawInfoPopRecordView:RefreshRecordUI()
	self.pagenumText_.text = self.pageNum_
	self.recordItemList_ = {}

	for iter_8_0 = (self.pageNum_ - 1) * self.pageShowCount + 1, math.min(self.pageNum_ * self.pageShowCount, #self.record_list) do
		table.insert(self.recordItemList_, self.record_list[iter_8_0])
	end

	self.recordScrollHelper_:StartScroll(#self.recordItemList_)
	self.leftArrowController_:SetSelectedState(self.pageNum_ > 1 and "not_grey" or "grey")
	self.rightArrowController_:SetSelectedState(self.pageNum_ * self.pageShowCount + 1 <= #self.record_list and "not_grey" or "grey")
end

function DrawInfoPopRecordView:IndexRecordItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(self.recordItemList_[arg_9_1], self.poolId, arg_9_1)
end

function DrawInfoPopRecordView:Dispose()
	self.recordScrollHelper_:Dispose()
	DrawInfoPopRecordView.super.Dispose(self)
end

return DrawInfoPopRecordView
