local ChapterSelectTitleView = class("ChapterSelectTitleView", ReduxView)

function ChapterSelectTitleView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.titleTagController_ = self.titleControllerEx_:GetController("showTag")
end

function ChapterSelectTitleView:OnEnter(arg_2_1)
	if self.chapterClientID_ then
		self:UnBindRedPoint()
	end

	self.chapterClientID_ = arg_2_1

	self:BindRedPoint()
	self:RefreshUI()
end

function ChapterSelectTitleView:OnExit()
	self:UnBindRedPoint()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.chapterClientID_ = nil
end

function ChapterSelectTitleView:Dispose()
	ChapterSelectTitleView.super.Dispose(self)
end

function ChapterSelectTitleView:BindRedPoint()
	if ChapterClientCfg[self.chapterClientID_].toggle == BattleConst.TOGGLE.PLOT then
		manager.redPoint:bindUIandKey(self.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, self.chapterClientID_))
	elseif ChapterClientCfg[self.chapterClientID_].toggle == BattleConst.TOGGLE.SUB_PLOT then
		manager.redPoint:bindUIandKey(self.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, self.chapterClientID_))
	end
end

function ChapterSelectTitleView:UnBindRedPoint()
	if ChapterClientCfg[self.chapterClientID_].toggle == BattleConst.TOGGLE.PLOT then
		manager.redPoint:unbindUIandKey(self.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, self.chapterClientID_))
	elseif ChapterClientCfg[self.chapterClientID_].toggle == BattleConst.TOGGLE.SUB_PLOT then
		manager.redPoint:unbindUIandKey(self.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, self.chapterClientID_))
	end
end

function ChapterSelectTitleView:RefreshUI()
	self.chapterIndexText_.text = ChapterClientCfg[self.chapterClientID_].desc
	self.chapterNameText_.text = ChapterClientCfg[self.chapterClientID_].name

	local var_7_0 = ChapterTools.GetChapterShowTypeData(self.chapterClientID_)

	self.titleTagController_:SetSelectedState(var_7_0)

	if var_7_0 == "limitTime" then
		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		local var_7_1, var_7_2 = ActivityData:GetActivityTime(ChapterCfg[ChapterClientCfg[self.chapterClientID_].chapter_list[1]].activity_id)

		self.timeText_.text = manager.time:GetLostTimeStr2(var_7_2)
		self.timer_ = Timer.New(function()
			self.timeText_.text = manager.time:GetLostTimeStr2(var_7_2)
		end, 1, -1)

		self.timer_:Start()
	end

	local var_7_3 = ChapterTools.GetChapterClientFinishPercentage(self.chapterClientID_)

	self.percentageImage_.fillAmount = var_7_3
	self.percentageText_.text = string.format("%s<size=28>%%</size>", math.floor(var_7_3 * 100))
end

return ChapterSelectTitleView
