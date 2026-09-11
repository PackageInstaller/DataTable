local ChapterPlot19StoryCollectView = class("ChapterPlot19StoryCollectView", ReduxView)

function ChapterPlot19StoryCollectView:UIName()
	return "Widget/System/Operation/OperationVerStoryUI"
end

function ChapterPlot19StoryCollectView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterPlot19StoryCollectView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
end

function ChapterPlot19StoryCollectView:OnEnter()
	self.chapterID_ = self.params_.chapterID

	self:RefreshItemList()
end

function ChapterPlot19StoryCollectView:OnExit()
	return
end

function ChapterPlot19StoryCollectView:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.itemList_ = nil

	ChapterPlot19StoryCollectView.super.Dispose(self)
end

function ChapterPlot19StoryCollectView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function ChapterPlot19StoryCollectView:RefreshItemList()
	local var_9_0 = self:GetItemDataList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if self.itemList_[iter_9_0] == nil then
			self.itemList_[iter_9_0] = ChapterPlot19StoryCollectItem.New(self.item_, self.itemParent_)
		end

		self.itemList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #self.itemList_, #var_9_0 + 1, -1 do
		self.itemList_[iter_9_2]:Dispose()

		self.itemList_[iter_9_2] = nil
	end
end

function ChapterPlot19StoryCollectView:GetItemDataList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(ChapterStoryCollectCfg.get_id_list_by_chapter_id[self.chapterID_]) do
		if ChapterTools.HasReadEvent(iter_10_1) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

return ChapterPlot19StoryCollectView
