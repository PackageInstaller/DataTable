local ChpaterPartBtnItem = class("ChpaterPartBtnItem", ReduxView)

function ChpaterPartBtnItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.choiceController_ = ControllerUtil.GetController(self.transform_, "choice")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function ChpaterPartBtnItem:OnEnter()
	return
end

function ChpaterPartBtnItem:OnExit()
	self:UnBindRedPoint(self.chapterID_)

	self.chapterID_ = nil

	self:StopTimer()
end

function ChpaterPartBtnItem:Dispose()
	ChpaterPartBtnItem.super.Dispose(self)
end

function ChpaterPartBtnItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.selectChapterID_ == self.chapterID_ then
			return
		end

		if self.toggleType_ == BattleConst.TOGGLE.PLOT then
			ChapterTools.GotoChapterSection(self.chapterID_)
		else
			JumpTools.Jump2SubPlotByChapterID(self.chapterID_)
		end
	end)
end

function ChpaterPartBtnItem:SetChapterID(arg_7_1, arg_7_2)
	self.selectChapterID_ = arg_7_2

	self:UnBindRedPoint(self.chapterID_)
	self:BindRedPoint(arg_7_1)

	self.chapterID_ = arg_7_1
	self.toggleType_ = getChapterClientCfgByChapterID(self.chapterID_).toggle

	self.choiceController_:SetSelectedState(tostring(arg_7_1 == arg_7_2))
	self:UpdateNameText()
	self:AddTimer()
end

local var_0_1 = {
	{
		"MAIN_STORY_TAB_1",
		"MAIN_STORY_TAB_2"
	},
	{
		"MAIN_STORY_TAB_1",
		"MAIN_STORY_TAB_3"
	},
	{
		"MAIN_STORY_TAB_1",
		"MAIN_STORY_TAB_2",
		"MAIN_STORY_TAB_3"
	}
}

function ChpaterPartBtnItem:UpdateNameText()
	local var_8_0 = getChapterClientCfgByChapterID(self.chapterID_)

	if var_8_0.id == ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 or var_8_0.id == ChapterConst.CHAPTER_CLIENT_21 then
		local var_8_1 = #var_8_0.chapter_list

		self.nameText_.text = SettingData:GetCurrentLanguage() == "en" and var_8_1 == 2 and GetTips(var_0_1[1][self.index_]) or GetTips(var_0_1[var_8_1][self.index_])
	else
		self.nameText_.text = ChapterCfg[self.chapterID_].subhead
	end
end

function ChpaterPartBtnItem:BindRedPoint(arg_9_1)
	if self.toggleType_ == nil then
		self.toggleType_ = getChapterClientCfgByChapterID(arg_9_1).toggle
	end

	if self.toggleType_ == BattleConst.TOGGLE.PLOT then
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, arg_9_1))
	else
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_9_1))
	end
end

function ChpaterPartBtnItem:UnBindRedPoint(arg_10_1)
	if arg_10_1 then
		if self.toggleType_ == BattleConst.TOGGLE.PLOT then
			manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, arg_10_1))
		else
			manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_10_1))
		end
	end
end

function ChpaterPartBtnItem:AddTimer()
	self:StopTimer()

	local var_11_0 = getChapterClientCfgByChapterID(self.chapterID_)
	local var_11_1 = table.keyof(var_11_0.chapter_list, self.chapterID_)

	if var_11_1 > 1 and not ChapterTools.IsClearChapter(var_11_0.chapter_list[var_11_1 - 1]) then
		self.lockController_:SetSelectedState("lock")

		return
	end

	local var_11_2 = self.toggleType_ == BattleConst.TOGGLE.PLOT and ChapterCfg[self.chapterID_].unlock_activity_id or ChapterCfg[self.chapterID_].activity_id
	local var_11_3 = self.toggleType_ == BattleConst.TOGGLE.PLOT and ActivityData:GetActivityData(var_11_2).startTime or ActivityData:GetActivityRefreshTime(var_11_2)

	if var_11_3 <= manager.time:GetServerTime() then
		self.lockController_:SetSelectedState("unlock")

		return
	end

	self.lockController_:SetSelectedState("lock")

	self.timer_ = Timer.New(function()
		if var_11_3 <= manager.time:GetServerTime() then
			self.lockController_:SetSelectedState("unlock")
			self:StopTimer()

			return
		end
	end, 1, -1)

	self.timer_:Start()
end

function ChpaterPartBtnItem:SetActive(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

function ChpaterPartBtnItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ChpaterPartBtnItem
