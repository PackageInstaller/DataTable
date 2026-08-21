local var_0_0 = class("ChapterStoryGroup", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.story_group
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	var_0_0.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.id = arg_2_0.configId

	return
end

function var_0_0.GetConfigID(arg_3_0)
	return arg_3_0.configId
end

function var_0_0.GetStoryIds(arg_4_0)
	return arg_4_0:getConfig("list")
end

function var_0_0.isUnlock(arg_5_0)
	return arg_5_0:IsCleanPrevChapter() and arg_5_0:IsCleanPrevStory()
end

function var_0_0.IsCleanPrevChapter(arg_6_0)
	local var_6_0 = arg_6_0:getConfig("pre_chapter")

	if var_6_0 == 0 then
		return true
	end

	return getProxy(ChapterProxy):GetChapterItemById(var_6_0):isClear()
end

function var_0_0.IsCleanPrevStory(arg_7_0)
	local var_7_0 = arg_7_0:getConfig("pre_story")

	if var_7_0 == 0 then
		return true
	end

	return getProxy(ChapterProxy):GetChapterItemById(var_7_0):isClear()
end

function var_0_0.isClear(arg_8_0)
	return _.all(arg_8_0:GetChapterStories(), function(arg_9_0)
		return arg_9_0:IsClear()
	end) and arg_8_0:IsCleanPrevChapter()
end

function var_0_0.GetChapterStories(arg_10_0)
	return (_.map(arg_10_0:GetStoryIds(), function(arg_11_0)
		return ChapterStoryItem.New({
			configId = arg_11_0
		})
	end))
end

function var_0_0.isAllAchieve(arg_12_0)
	return true
end

function var_0_0.activeAlways(arg_13_0)
	return true
end

function var_0_0.ifNeedHide(arg_14_0)
	return false
end

function var_0_0.inActTime(arg_15_0)
	return true
end

return var_0_0
