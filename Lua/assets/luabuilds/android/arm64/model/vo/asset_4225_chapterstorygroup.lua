local ChapterStoryGroup = class("ChapterStoryGroup", import("model.vo.BaseVO"))

function ChapterStoryGroup:bindConfigTable()
	return pg.story_group
end

function ChapterStoryGroup:Ctor(arg_2_1)
	ChapterStoryGroup.super.Ctor(self, arg_2_1)

	self.id = self.configId

	return
end

function ChapterStoryGroup:GetConfigID()
	return self.configId
end

function ChapterStoryGroup:GetStoryIds()
	return self:getConfig("list")
end

function ChapterStoryGroup:isUnlock()
	return self:IsCleanPrevChapter() and self:IsCleanPrevStory()
end

function ChapterStoryGroup:IsCleanPrevChapter()
	local var_6_0 = self:getConfig("pre_chapter")

	if var_6_0 == 0 then
		return true
	end

	return getProxy(ChapterProxy):GetChapterItemById(var_6_0):isClear()
end

function ChapterStoryGroup:IsCleanPrevStory()
	local var_7_0 = self:getConfig("pre_story")

	if var_7_0 == 0 then
		return true
	end

	return getProxy(ChapterProxy):GetChapterItemById(var_7_0):isClear()
end

function ChapterStoryGroup:isClear()
	return _.all(self:GetChapterStories(), function(arg_9_0)
		return arg_9_0:IsClear()
	end) and self:IsCleanPrevChapter()
end

function ChapterStoryGroup:GetChapterStories()
	return (_.map(self:GetStoryIds(), function(arg_11_0)
		return ChapterStoryItem.New({
			configId = arg_11_0
		})
	end))
end

function ChapterStoryGroup:isAllAchieve()
	return true
end

function ChapterStoryGroup:activeAlways()
	return true
end

function ChapterStoryGroup:ifNeedHide()
	return false
end

function ChapterStoryGroup:inActTime()
	return true
end

return ChapterStoryGroup
