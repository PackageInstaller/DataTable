local ActivityRhythmGameCommandView = class("ActivityRhythmGameCommandView", ReduxView)

function ActivityRhythmGameCommandView:UIName()
	return "Widget/System/Summer2024/Summer2024_MuiscUI/SummerUI_3_4_InstructionsUI"
end

function ActivityRhythmGameCommandView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityRhythmGameCommandView:Init()
	self:InitOwnData()
	self:BindCfgUI()

	self.imageController_ = self.controllerEx_:GetController("stageState")
	self.commandItemList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, ActivityRhythmGameCommandItem)
end

function ActivityRhythmGameCommandView:Dispose()
	if self.commandItemList_ then
		self.commandItemList_:Dispose()
	end

	ActivityRhythmGameCommandView.super.Dispose(self)
end

function ActivityRhythmGameCommandView:InitOwnData()
	self.chapterID_ = -1
	self.activityID_ = -1
	self.commandIDList_ = {}
end

function ActivityRhythmGameCommandView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityRhythmGameCommandView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityRhythmGameCommandView:OnEnter()
	self.chapterID_ = self.params_.chapterID
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
	ActivityRhythmGameCommandView.super.OnEnter(self)
end

function ActivityRhythmGameCommandView:OnExit()
	ActivityRhythmGameCommandView.super.OnExit(self)

	for iter_9_0, iter_9_1 in ipairs(self.commandItemList_) do
		if iter_9_1 and iter_9_1.OnExit then
			iter_9_1:OnExit()
		end
	end
end

function ActivityRhythmGameCommandView:RefreshUI()
	self:RefreshCommandList()
	self:RefreshImage()
end

function ActivityRhythmGameCommandView:RefreshCommandList()
	self.commandIDList_ = ActivityRhythmGameData:GetCommandListByChapterIDForUI(self.chapterID_)

	self.commandItemList_:StartScroll(#self.commandIDList_)
end

function ActivityRhythmGameCommandView:RefreshImage()
	self.imageController_:SetSelectedIndex(self.chapterID_ == ActivityRhythmGameConst.Chapter_ID.ONE and 0 or 1)
end

function ActivityRhythmGameCommandView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, self.commandIDList_[arg_13_1], self.activityID_)
end

return ActivityRhythmGameCommandView
