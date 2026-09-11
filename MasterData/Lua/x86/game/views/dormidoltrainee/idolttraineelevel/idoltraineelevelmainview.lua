local IdolTraineeLevelMainView = class("IdolTraineeLevelMainView", ReduxView)

function IdolTraineeLevelMainView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleLevelView"
end

function IdolTraineeLevelMainView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolTraineeLevelMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeLevelMainView:InitUI()
	self:BindCfgUI()

	self.curChapterID_ = 0
	self.levelList_ = {}
	self.chapterTitleItem_ = IdolTraineeChapterListItem.New(self.chapter)
	self.levelUIList_ = LuaList.New(handler(self, self.IndexItem), self.levelUIList_, IdolTraineeLevelListItem)
end

function IdolTraineeLevelMainView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self.curChapterID_ then
			JumpTools.OpenPageByJump("/idolTraineeChapterRewardView", {
				chapterID = self.curChapterID_
			})
		end
	end)
end

function IdolTraineeLevelMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.curChapterID_ = self.params_.chapterID
	self.levelList_ = IdolTraineeChapterCfg[self.curChapterID_].section_id_list

	self.chapterTitleItem_:SetData(self.curChapterID_, true)
	self.levelUIList_:StartScroll(#self.levelList_)

	self.titleText_.text = IdolTraineeChapterCfg[self.curChapterID_].title

	manager.redPoint:bindUIandKey(self.redpointTrs_, string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, self.curChapterID_))
end

function IdolTraineeLevelMainView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.redpointTrs_, string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, self.curChapterID_))
end

function IdolTraineeLevelMainView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.levelList_[arg_9_1], arg_9_1, self.curChapterID_)
end

function IdolTraineeLevelMainView:Dispose()
	if self.chapterTitleItem_ then
		self.chapterTitleItem_:Dispose()

		self.chapterTitleItem_ = nil
	end

	self.levelUIList_:Dispose()

	self.levelUIList_ = nil

	IdolTraineeLevelMainView.super.Dispose(self)
end

return IdolTraineeLevelMainView
