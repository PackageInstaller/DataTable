-- chunkname: @IQIGame\\UIExternalApi\\StoryChapterPassUIApi.lua

StoryChapterPassUIApi = BaseLangApi:Extend()

function StoryChapterPassUIApi:GetChapterImageUrl(name)
	return string.format(self:GetResUrl(1300006), name)
end

function StoryChapterPassUIApi:GetStageIconImageUrl(name)
	return string.format("Assets/05_Images/Chapter/PlotChapter/ChapterPassImg/%s.png", name)
end

function StoryChapterPassUIApi:GetLevelNumberTips()
	return self:GetCfgText(7000008)
end

function StoryChapterPassUIApi:GetChapterBgImagePath(id)
	return StoryChapterModule.GetChapterByID(id).BackPicture
end
