local IdolTraineeChapterMainView = class("IdolTraineeChapterMainView", ReduxView)

function IdolTraineeChapterMainView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleChapterView"
end

function IdolTraineeChapterMainView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolTraineeChapterMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeChapterMainView:InitUI()
	self:BindCfgUI()

	self.chapterList_ = IdolTraineeChapterCfg.all
	self.chapterUIList_ = LuaList.New(handler(self, self.IndexItem), self.chapterUIList_, IdolTraineeChapterListItem)
end

function IdolTraineeChapterMainView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function IdolTraineeChapterMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self.chapterUIList_:StartScroll(#self.chapterList_)
end

function IdolTraineeChapterMainView:OnExit()
	manager.windowBar:HideBar()
end

function IdolTraineeChapterMainView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.chapterList_[arg_9_1])
	manager.redPoint:SetRedPointIndependent(arg_9_2.transform_, (manager.redPoint:getTipBoolean((string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, self.chapterList_[arg_9_1])))))
end

function IdolTraineeChapterMainView:Dispose()
	self.chapterUIList_:Dispose()

	self.chapterUIList_ = nil

	IdolTraineeChapterMainView.super.Dispose(self)
end

return IdolTraineeChapterMainView
