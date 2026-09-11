local SubPlotSwitchChapterView = class("SubPlotSwitchChapterView", ReduxView)

function SubPlotSwitchChapterView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterItemList_ = {}

	self:BindCfgUI()
	self:AddListeners()
end

function SubPlotSwitchChapterView:OnEnter()
	BattleStageAction.ClickSubPlot(self.chapterID_)

	for iter_2_0, iter_2_1 in pairs(self.chapterItemList_) do
		iter_2_1:OnEnter()
	end

	manager.redPoint:bindUIandKey(self.selectResourceBtn_.transform, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, getChapterClientCfgByChapterID(self.chapterID_).id))
end

function SubPlotSwitchChapterView:OnExit()
	self:StopTimer()
	SetActive(self.selectResourcePanel_, false)

	for iter_3_0, iter_3_1 in pairs(self.chapterItemList_) do
		iter_3_1:OnExit()
	end

	manager.redPoint:unbindUIandKey(self.selectResourceBtn_.transform, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, getChapterClientCfgByChapterID(self.chapterID_).id))
end

function SubPlotSwitchChapterView:Dispose()
	SubPlotSwitchChapterView.super.Dispose(self)

	for iter_4_0, iter_4_1 in ipairs(self.chapterItemList_) do
		iter_4_1:Dispose()
	end

	self.chapterItemList_ = nil
end

function SubPlotSwitchChapterView:SetData(arg_5_1)
	self.chapterID_ = arg_5_1
end

function SubPlotSwitchChapterView:RefreshUI()
	self:RefreshChapterBtn()
	self:RefreshChapterItemBtn()
end

function SubPlotSwitchChapterView:AddListeners()
	self:AddBtnListener(self.selectResourceBtn_, nil, function()
		SetActive(self.selectResourcePanel_, true)
		self:ClickListener()
	end)
end

function SubPlotSwitchChapterView:RefreshChapterItemBtn()
	self.selectResourceText_.text = GetI18NText(ChapterCfg[self.chapterID_].subhead)
end

function SubPlotSwitchChapterView:RefreshChapterBtn()
	local var_10_0 = getChapterClientCfgByChapterID(self.chapterID_)
	local var_10_1 = var_10_0.chapter_list

	SetActive(self.gameObject_, (var_10_0.id == 6010010 or nil) and false)

	for iter_10_0, iter_10_1 in pairs(var_10_1) do
		if self.chapterItemList_[iter_10_0] then
			self.chapterItemList_[iter_10_0]:SetData(iter_10_1)
		else
			self.chapterItemList_[iter_10_0] = SubPlotBtnView.New(self.selectResourceItem_, self.selectResourcePanel_, iter_10_1)
		end
	end

	for iter_10_2 = #var_10_1 + 1, #self.chapterItemList_ do
		self.chapterItemList_[iter_10_2]:Show(false)
	end
end

function SubPlotSwitchChapterView:ClickListener()
	if not self.clickTimer_ then
		self.buttonUp_ = 0
		self.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if Input.GetMouseButtonUp(0) then
				self.buttonUp_ = self.buttonUp_ + 1

				if self.buttonUp_ >= 2 then
					SetActive(self.selectResourcePanel_, false)
					FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

					self.clickTimer_ = nil
				end
			end
		end, -1, true)
	end
end

function SubPlotSwitchChapterView:StopTimer()
	if self.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

		self.clickTimer_ = nil
	end
end

return SubPlotSwitchChapterView
