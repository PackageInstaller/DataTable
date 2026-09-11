local ChapterMainPanelView = class("ChapterMainPanelView", ReduxView)

function ChapterMainPanelView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.chapterImage_.immediate = true

	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "early")
end

function ChapterMainPanelView:OnEnter()
	self.showChapterClientID_, self.activityID_ = ChapterTools.GetOptimalChapterClientID()

	self:RefreshUI()
end

function ChapterMainPanelView:OnExit()
	return
end

function ChapterMainPanelView:Dispose()
	ChapterMainPanelView.super.Dispose(self)
end

function ChapterMainPanelView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		JumpTools.GoToSystem("/chapterMapContent")
	end)
end

function ChapterMainPanelView:RefreshUI()
	self.chapterImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.showChapterClientID_].chapter_paint_2
	self.chapterNameText_.text = ChapterClientCfg[self.showChapterClientID_].name
	self.chapterDescText_.text = ChapterClientCfg[self.showChapterClientID_].desc

	self:RefreshActivityState()
end

function ChapterMainPanelView:RefreshActivityState()
	if self.activityID_ ~= 0 then
		self.controller_:SetSelectedState("yes")
	else
		self.controller_:SetSelectedState("no")
	end
end

return ChapterMainPanelView
