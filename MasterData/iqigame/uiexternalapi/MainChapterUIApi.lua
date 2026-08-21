-- chunkname: @IQIGame\\UIExternalApi\\MainChapterUIApi.lua

MainChapterUIApi = BaseLangApi:Extend()

function MainChapterUIApi:FormatProgressText(chapterID)
	return string.format("%.f%%", StoryChapterModule:GetChapterProgress(chapterID) * 100)
end

function MainChapterUIApi:GetUnlockedChapterIconImagePath(id)
	return StoryChapterModule.GetChapterByID(id).ChapterPictureOpen
end

function MainChapterUIApi:GetLockedChapterIconImagePath(id)
	return StoryChapterModule.GetChapterByID(id).ChapterPictureClose
end
