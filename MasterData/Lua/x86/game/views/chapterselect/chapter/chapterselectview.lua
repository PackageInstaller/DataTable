ChapterSelectBaseView = import("..ChapterSelectBaseView")

local ChapterSelectView = class("ChapterSelectView", ChapterSelectBaseView)

function ChapterSelectView:UIName()
	return "Widget/System/Operation/OperationMainUI"
end

function ChapterSelectView:Init()
	ChapterSelectView.super.Init(self)

	self.changeSelectChapterHandler_ = handler(self, self.ChangeSelectChapterID)
	self.hardLevelView_ = HardLevelChapterView.New(self.selectDifficultBtn_)
	self.chapterToggleItemList_ = {}
	self.groupToggleItemList_ = {}
end

function ChapterSelectView:OnEnter()
	ChapterSelectView.super.OnEnter(self)
	self.hardLevelView_:OnEnter()
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, self.changeSelectChapterHandler_)
end

function ChapterSelectView:OnExit()
	ChapterSelectView.super.OnExit(self)
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, self.changeSelectChapterHandler_)
	self.hardLevelView_:OnExit()
end

function ChapterSelectView:Dispose()
	self.changeSelectChapterHandler_ = nil

	self.hardLevelView_:Dispose()

	self.hardLevelView_ = nil

	for iter_5_0, iter_5_1 in ipairs(self.groupToggleItemList_) do
		iter_5_1:Dispose()
	end

	self.groupToggleItemList_ = nil

	for iter_5_2, iter_5_3 in ipairs(self.chapterToggleItemList_) do
		iter_5_3:Dispose()
	end

	self.chapterToggleItemList_ = nil

	ChapterSelectView.super.Dispose(self)
end

function ChapterSelectView:EndDragFun(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2.position.x - arg_6_2.pressPosition.x

	if ChapterTools.GetNeighborClientID(self.selectChapterClientID_, arg_6_2.position.x - arg_6_2.pressPosition.x < 0) == self.selectChapterClientID_ then
		return
	end

	if math.abs(var_6_0) > ChapterSelectView.MIN_DRAG_LENGTH then
		self.selectChapterClientID_ = self.nextChapterClientID_
		self.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, self.selectChapterClientID_)
		self:RefreshData()

		if math.abs(var_6_0) > ChapterSelectView.MAX_DRAG_LENGTH then
			self:RefreshChapterUI()
			self:SwitchImageOver()
		else
			self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 0, (ChapterSelectView.MAX_DRAG_LENGTH - math.abs(var_6_0)) / ChapterSelectView.MAX_DRAG_LENGTH * ChapterSelectView.SWITCH_STAGE_TIME)

			self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
				self.chapterFrontCanvasGroup_.alpha = arg_7_0
				self.chapterBehindCanvasGroup_.alpha = 1 - arg_7_0
			end))
			self.leanTweenHandler_:setOnComplete(System.Action(function()
				self:RefreshChapterUI()
				self:SwitchImageOver()
				LeanTween.cancel(self.chapterFrontImage_.gameObject)
				self.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

				self.leanTweenHandler_ = nil
			end))
		end
	else
		self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 1, (1 - (ChapterSelectView.MIN_DRAG_LENGTH - math.abs(var_6_0)) / ChapterSelectView.MIN_DRAG_LENGTH) * 0.8)

		self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
			self.chapterFrontCanvasGroup_.alpha = arg_9_0
			self.chapterBehindCanvasGroup_.alpha = 1 - arg_9_0
		end))
		self.leanTweenHandler_:setOnComplete(System.Action(function()
			LeanTween.cancel(self.chapterFrontImage_.gameObject)
			self.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

			self.leanTweenHandler_ = nil
		end))
	end
end

function ChapterSelectView:PointerUpFun(arg_11_1, arg_11_2)
	if arg_11_2.dragging then
		return
	end

	local var_11_0 = BattleFieldData:GetCacheChapter(self.selectChapterClientID_)
	local var_11_1, var_11_2 = ChapterTools.IsFinishPreChapter(var_11_0)

	if not var_11_1 then
		ShowTips(ChapterTools.GetChapterLockText(var_11_0, var_11_2))

		return
	end

	ChapterTools.GotoChapterSection(var_11_0)
end

function ChapterSelectView:RefreshData()
	self.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	self.groupDataList_ = ChapterTools.GetChapterGroupList(self.selectChapterClientID_)
	self.hardLevel_ = ChapterClientCfg[self.selectChapterClientID_].difficulty
end

function ChapterSelectView:RefreshUI()
	self:RefreshChapterUI()
	self:AutoSwitchImage()
	self:RefreshSelectDifficult()
end

function ChapterSelectView:RefreshChapterUI()
	self.chapterSelectTitleView_:OnEnter(self.selectChapterClientID_)
	self:RefreshGroupToggle()
	self:AddActivityTimer()
	self:RefreshActivity()
	self:RefreshLock()
end

function ChapterSelectView:RefreshGroupToggle()
	local var_15_0 = 0
	local var_15_1 = 0
	local var_15_2

	for iter_15_0, iter_15_1 in ipairs(self.groupDataList_) do
		if iter_15_1[1] == 1 then
			var_15_0 = var_15_0 + 1

			if self.groupToggleItemList_[var_15_0] == nil then
				self.groupToggleItemList_[var_15_0] = ChapterSelectGroupToggleItem.New(self.groupToggleItem_, self.toggleItemParent_)
			end

			self.groupToggleItemList_[var_15_0]:SetData(iter_15_1[2])
		else
			var_15_1 = var_15_1 + 1

			if self.chapterToggleItemList_[var_15_1] == nil then
				self.chapterToggleItemList_[var_15_1] = ChapterSelectChapterToggleItem.New(self.chapterToggleItem_, self.toggleItemParent_)
			end

			local var_15_3 = self.selectChapterClientID_ == iter_15_1[2]

			self.chapterToggleItemList_[var_15_1]:SetData(iter_15_1[2], self.selectChapterClientID_ == iter_15_1[2])

			if var_15_3 then
				var_15_2 = self.chapterToggleItemList_[var_15_1]
			end
		end
	end

	for iter_15_2 = var_15_0 + 1, #self.groupToggleItemList_ do
		self.groupToggleItemList_[iter_15_2]:Show(false)
	end

	for iter_15_3 = var_15_1 + 1, #self.chapterToggleItemList_ do
		self.chapterToggleItemList_[iter_15_3]:Show(false)
	end

	if var_15_2 then
		self:AddMoveTimer(var_15_2)
	end
end

function ChapterSelectView:RefreshActivity()
	self.activityController_:SetSelectedState(tostring(ActivityData:GetActivityIsOpen(ChapterCfg[ChapterClientCfg[self.selectChapterClientID_].chapter_list[1]].activity_id)))
end

function ChapterSelectView:RefreshLock()
	return
end

function ChapterSelectView:RefreshSelectDifficult()
	self.hardLevelView_:SetData(self.hardLevel_)
end

function ChapterSelectView:ChangeSelectChapterID()
	self:StopLeanTween()
	self:RefreshData()
	self:RefreshUI()
end

function ChapterSelectView:StopAllTimer()
	ChapterSelectView.super.StopAllTimer(self)
	self:RemoveActivityTimer()
end

function ChapterSelectView:AddActivityTimer()
	self:RemoveActivityTimer()

	local var_21_0 = ChapterClientCfg[self.selectChapterClientID_].chapter_list[1]
	local var_21_1 = ChapterCfg[ChapterClientCfg[self.selectChapterClientID_].chapter_list[1]].activity_id

	if ChapterCfg[ChapterClientCfg[self.selectChapterClientID_].chapter_list[1]].activity_id == 0 then
		return
	end

	local var_21_2 = ActivityData:GetActivityData(ChapterCfg[ChapterClientCfg[self.selectChapterClientID_].chapter_list[1]].activity_id):IsActivitying()

	self.activityTimer_ = Timer.New(function()
		local var_22_0 = ActivityData:GetActivityData(var_21_1):IsActivitying()

		if var_22_0 ~= var_21_2 then
			var_21_2 = var_22_0
			self.isLock_ = not ChapterTools.IsFinishPreChapter(var_21_0)

			self:RefreshLock()
			self:RefreshActivity()
		end
	end, 1, -1)

	self.activityTimer_:Start()
end

function ChapterSelectView:RemoveActivityTimer()
	if self.activityTimer_ then
		self.activityTimer_:Stop()

		self.activityTimer_ = nil
	end
end

return ChapterSelectView
