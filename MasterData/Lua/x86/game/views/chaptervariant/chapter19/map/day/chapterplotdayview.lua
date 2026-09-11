local ChapterPlotDayView = class("ChapterPlotDayView", BaseView)

function ChapterPlotDayView:Ctor(arg_1_1, arg_1_2)
	self.parentView_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:BindCfgUI()
	self:AddListeners()

	self.dayItemList_ = {}
	self.dayController_ = self.controllerEx_:GetController("dayList")
	self.guildController_ = self.controllerEx_:GetController("guildState")
	self.dayImageController_ = self.dayControllerEx_:GetController("default0")
	self.isExpandDay_ = false
end

function ChapterPlotDayView:OnEnter()
	if ChapterTools.IsNeedExpandDay(self.chapterID_) then
		self.isExpandDay_ = true

		self:SwitchUI()
	end
end

function ChapterPlotDayView:OnUpdate()
	return
end

function ChapterPlotDayView:OnExit()
	self.isExpandDay_ = false
end

function ChapterPlotDayView:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.dayItemList_) do
		iter_5_1:Dispose()
	end

	self.dayItemList_ = nil

	ChapterPlotDayView.super.Dispose(self)
end

function ChapterPlotDayView:AddListeners()
	self:AddBtnListener(self.dayBtn_, nil, function()
		if not self.parentView_:IsTop() then
			JumpTools:Back()

			return
		end

		self.isExpandDay_ = true

		self:SwitchUI()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		self.isExpandDay_ = false

		self:SwitchUI()
		manager.notify:Invoke(CHAPTER_CLOSE_DAY_LIST)
	end)
end

function ChapterPlotDayView:SetData(arg_9_1, arg_9_2)
	self.selectDay_ = arg_9_1
	self.chapterID_ = arg_9_2

	self:RefreshUI()
end

function ChapterPlotDayView:RefreshUI()
	local var_10_0 = ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]]

	if ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]].icon_id ~= "" then
		self.dayImage_.sprite = getSprite("Atlas/OperationAtlas", var_10_0.icon_id)

		self.dayImageController_:SetSelectedState("image")
	else
		self.selectDayText_.text = self.selectDay_

		self.dayImageController_:SetSelectedState("num")
	end

	self.dayBottomText_.text = var_10_0.name ~= "" and var_10_0.name or GetTips("DATE")

	self:SwitchUI()
	self:RefreshDayItemList()
end

function ChapterPlotDayView:SwitchUI()
	self.dayController_:SetSelectedState(tostring(self.isExpandDay_))

	if self.isExpandDay_ then
		self.animator_:Play("dayList1")
	else
		self.animator_:Play("dayList2")
	end

	if ChapterTools.IsNeedExpandDay(self.chapterID_) then
		self.guildController_:SetSelectedState(tostring(true))
	else
		self.guildController_:SetSelectedState(tostring(false))
	end
end

function ChapterPlotDayView:RefreshDayItemList()
	for iter_12_0, iter_12_1 in ipairs((ChapterTools.GetChapterDayList(self.chapterID_))) do
		if self.dayItemList_[iter_12_1] == nil then
			self.dayItemList_[iter_12_1] = ChapterPlotDayItem.New(self.dayItem_, self.dayParent_, self.chapterID_, iter_12_1)
		end

		self.dayItemList_[iter_12_1]:SetData(iter_12_1, self.selectDay_)
	end
end

return ChapterPlotDayView
