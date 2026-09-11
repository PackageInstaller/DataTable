local SubPlotBtnView = class("SubPlotBtnView", ReduxView)

function SubPlotBtnView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")

	self:SetData(arg_1_3)
	self:RefreshItem()
	self:Show(true)
end

function SubPlotBtnView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function SubPlotBtnView:OnEnter()
	return
end

function SubPlotBtnView:OnExit()
	self:UnBindRedPoint(self.chapterID_)
	self:StopTimer()
end

function SubPlotBtnView:Dispose()
	SubPlotBtnView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.btn_ = nil
	self.gameObject_ = nil
	self.text_ = nil
	self.canvasGroup_ = nil
	self.unsubscribeFun = nil
	self.selector_ = nil
	self.lockGo_ = nil
end

function SubPlotBtnView:SetData(arg_6_1)
	self:UnBindRedPoint(self.chapterID_)
	self:BindRedPoint(arg_6_1)

	self.chapterID_ = arg_6_1

	self:RefreshItem()
	self:Show(true)
	self:AddTimer()
end

function SubPlotBtnView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not ChapterTools.IsUnlockChapter(self.chapterID_) then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ChapterCfg[self.chapterID_].activity_id).startTime)))

			return
		end

		local var_8_0 = getChapterClientCfgByChapterID(self.chapterID_)
		local var_8_1 = table.keyof(var_8_0.chapter_list, self.chapterID_)

		if var_8_1 > 1 then
			if not ChapterTools.IsClearChapter(var_8_0.chapter_list[var_8_1 - 1]) then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", ChapterCfg[var_8_0.chapter_list[var_8_1 - 1]].subhead))

				return
			end
		end

		BattleStageAction.ClickSubPlot(self.chapterID_)
		manager.notify:Invoke(CHANGE_CHAPTER, self.chapterID_)
	end)
end

function SubPlotBtnView:BindRedPoint(arg_9_1)
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_9_1))
end

function SubPlotBtnView:UnBindRedPoint(arg_10_1)
	if arg_10_1 then
		manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_10_1))
	end
end

function SubPlotBtnView:RefreshItem()
	self.text_.text = GetI18NText(ChapterCfg[self.chapterID_].subhead)
	self.text2_.text = GetI18NText(ChapterCfg[self.chapterID_].subhead)
end

function SubPlotBtnView:Show(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function SubPlotBtnView:SetSiblingIndex(arg_13_1)
	self.transform_:SetSiblingIndex(arg_13_1)
end

function SubPlotBtnView:AddTimer()
	self:StopTimer()

	local var_14_0 = getChapterClientCfgByChapterID(self.chapterID_)
	local var_14_1 = table.keyof(var_14_0.chapter_list, self.chapterID_)

	if var_14_1 > 1 and not ChapterTools.IsClearChapter(var_14_0.chapter_list[var_14_1 - 1]) then
		self.lockController_:SetSelectedState("off")

		return
	end

	local var_14_2 = ActivityData:GetActivityData(ChapterCfg[self.chapterID_].activity_id)

	if var_14_2.startTime <= manager.time:GetServerTime() then
		self.lockController_:SetSelectedState("on")

		return
	end

	self.lockController_:SetSelectedState("off")

	self.timer_ = Timer.New(function()
		if var_14_2.startTime <= manager.time:GetServerTime() then
			self.lockController_:SetSelectedState("on")
			self:StopTimer()

			return
		end
	end, 1, -1)

	self.timer_:Start()
end

function SubPlotBtnView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SubPlotBtnView
