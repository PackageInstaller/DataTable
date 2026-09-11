local ChapterClueView = class("ChapterClueView", ReduxView)

function ChapterClueView:UIName()
	return "Widget/System/Operation/OperationVerClueUI"
end

function ChapterClueView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterClueView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, ChapterClueItem)
end

function ChapterClueView:OnEnter()
	self.chapterID_ = self.params_.chapterID

	self:RefreshUI()
end

function ChapterClueView:OnExit()
	return
end

function ChapterClueView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function ChapterClueView:RefreshUI()
	local var_8_0, var_8_1 = ChapterTools.GetChapterClueCnt(self.chapterID_)

	self.collectClueIDList_ = ChapterTools.GetChapterCollectClueList(self.chapterID_)

	self.uiList_:StartScroll(var_8_1)

	local var_8_2, var_8_3 = ChapterTools.GetChapterClueCnt(self.chapterID_)

	self.cntText_.text = string.format("%s/%s", var_8_2, var_8_3)
end

function ChapterClueView:IndexItem(arg_9_1, arg_9_2)
	if arg_9_1 > #self.collectClueIDList_ then
		arg_9_2:SetData(0, arg_9_1)
	else
		arg_9_2:SetData(self.collectClueIDList_[arg_9_1], arg_9_1)
	end
end

function ChapterClueView:Dispose()
	self.uiList_:Dispose()

	self.uiList_ = nil

	ChapterClueView.super.Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChapterClueView
