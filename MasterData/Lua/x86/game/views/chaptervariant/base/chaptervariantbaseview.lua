local ChapterVariantBaseView = class("ChapterVariantBaseView", ReduxView)

function ChapterVariantBaseView:UIName()
	return "UI/Stage/ChaptePlot/ChaptePlot12UI"
end

function ChapterVariantBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function ChapterVariantBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.chapterItemList_ = {}
end

function ChapterVariantBaseView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.chapterClientID_ = self.params_.chapterClientID

	for iter_4_0, iter_4_1 in ipairs(ChapterClientCfg[self.chapterClientID_].chapter_list) do
		if self.chapterItemList_[iter_4_0] == nil then
			self.chapterItemList_[iter_4_0] = self:GetItemClass().New(self[string.format("chapterBtn%s_", iter_4_0)], iter_4_1)
		end

		self.chapterItemList_[iter_4_0]:OnEnter(iter_4_1)
	end

	for iter_4_2 = #self.chapterItemList_, #ChapterClientCfg[self.chapterClientID_].chapter_list + 1, -1 do
		self.chapterItemList_[iter_4_2]:Dispose()

		self.chapterItemList_[iter_4_2] = nil
	end
end

function ChapterVariantBaseView:OnExit()
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in ipairs(self.chapterItemList_) do
		iter_5_1:OnExit()
	end
end

function ChapterVariantBaseView:Dispose()
	ChapterVariantBaseView.super.Dispose(self)

	for iter_6_0, iter_6_1 in ipairs(self.chapterItemList_) do
		iter_6_1:Dispose()
	end

	self.chapterItemList_ = nil
end

function ChapterVariantBaseView:GetItemClass()
	return ChapterVariantBaseItem
end

function ChapterVariantBaseView:AddListeners()
	return
end

return ChapterVariantBaseView
