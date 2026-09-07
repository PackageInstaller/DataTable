local ChapterStoryItem = class("ChapterStoryItem", import("model.vo.BaseVO"))

function ChapterStoryItem:bindConfigTable()
	return pg.story_template
end

function ChapterStoryItem:GetStoryName()
	return self:getConfig("story")
end

function ChapterStoryItem:GetName()
	return self:getConfig("name")
end

function ChapterStoryItem:GetIcon()
	local var_4_0 = self:getConfig("icon")

	return "StoryPointIcon/" .. var_4_0, var_4_0
end

function ChapterStoryItem:GetPosition()
	return self:getConfig("pos")
end

function ChapterStoryItem:IsClear()
	return pg.NewStoryMgr.GetInstance():IsPlayed(self:GetStoryName())
end

return ChapterStoryItem
