local ChapterSubPlotPanelView = class("ChapterSubPlotPanelView", ReduxView)

function ChapterSubPlotPanelView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "lock")
	self.titleTagController_ = self.controllerEx_:GetController("showTag")
end

function ChapterSubPlotPanelView:OnEnter()
	self.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)

	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.COMBAT_SUB_PLOT)
	self:RefreshUI()
end

function ChapterSubPlotPanelView:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.COMBAT_SUB_PLOT)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChapterSubPlotPanelView:Dispose()
	ChapterSubPlotPanelView.super.Dispose(self)
end

function ChapterSubPlotPanelView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		JumpTools.GoToSystem("/chapterSubPlotContent", {}, ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)
	end)
end

function ChapterSubPlotPanelView:RefreshUI()
	local var_7_0 = ChapterTools.GetOpenSubPlotClient()

	if ChapterClientCfg[var_7_0].show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME then
		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		local var_7_1, var_7_2 = ActivityData:GetActivityTime(ChapterCfg[ChapterClientCfg[var_7_0].chapter_list[1]].activity_id)

		self.timeText_.text = manager.time:GetLostTimeStr2(var_7_2)
		self.timer_ = Timer.New(function()
			self.timeText_.text = manager.time:GetLostTimeStr2(var_7_2)
		end, 1, -1)

		self.timer_:Start()
	end

	SetSpriteWithoutAtlasAsync(self.chapterImage_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[var_7_0].chapter_paint_2)
	self.titleTagController_:SetSelectedState(ChapterTools.GetChapterShowTypeData(var_7_0))

	self.chapterNameText_.text = ChapterClientCfg[var_7_0].name
	self.chapterDescText_.text = ChapterClientCfg[var_7_0].desc

	local var_7_3 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)

	if var_7_3 then
		self.lockText_.text = JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT, var_7_3)
	end
end

function ChapterSubPlotPanelView:RefreshLockState()
	if self.isLock_ then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

return ChapterSubPlotPanelView
