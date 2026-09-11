local ChapterV2MapEmptyTrackItemView = class("ChapterV2MapEmptyTrackItemView", ReduxView)

function ChapterV2MapEmptyTrackItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.hasNextChapterCon_ = self.conEx_:GetController("hasNextChapter")
end

function ChapterV2MapEmptyTrackItemView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.hasNextChapter_ then
			return
		end

		ChapterV2MapTools.GoMap(self.nextChapterMapID_)
	end)
end

function ChapterV2MapEmptyTrackItemView:OnTop()
	self:RefreshUI()
end

function ChapterV2MapEmptyTrackItemView:SetData(arg_5_1)
	self.mapId_ = arg_5_1
	self.chapterClientId_ = ChapterV2MapTools.GetChapterClientIDByMap(arg_5_1)
	self.hasNextChapter_, self.nextChapterClientID_ = ChapterV2MapTools.HasNextChapterClient(self.chapterClientId_)

	if self.hasNextChapter_ and self.nextChapterClientID_ then
		self.nextChapterMapID_ = ChapterV2MapTools.GetChapterClientWorkingMap(self.nextChapterClientID_)
	end

	self:RefreshUI()
end

function ChapterV2MapEmptyTrackItemView:RefreshUI()
	self.hasNextChapterCon_:SetSelectedState(tostring(self.hasNextChapter_))
end

function ChapterV2MapEmptyTrackItemView:Dispose()
	ChapterV2MapEmptyTrackItemView.super.Dispose(self)
end

return ChapterV2MapEmptyTrackItemView
