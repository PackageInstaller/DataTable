class = var_0_10000

local var_0_0 = "ChapterStoryGroup"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.story_group
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	var_0_1.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.id = arg_2_0.configId

	return
end

function var_0_1.GetConfigID(arg_3_0)
	return arg_3_0.configId
end

function var_0_1.GetStoryIds(arg_4_0)
	return arg_4_0:getConfig("list")
end

function var_0_1.isUnlock(arg_5_0)
	local var_5_0

	if arg_5_0:IsCleanPrevChapter() then
		var_5_0 = arg_5_0:IsCleanPrevStory()
	end

	return var_5_0
end

function var_0_1.IsCleanPrevChapter(arg_6_0)
	if arg_6_0:getConfig("pre_chapter") == 0 then
		return true
	end

	getProxy = var_1_10002
	ChapterProxy = var_4

	local var_6_0 = var_1_10002(var_4)
	local var_6_1 = var_2.GetChapterItemById(var_6_0, var_1)

	return var_2.isClear(var_6_1)
end

function var_0_1.IsCleanPrevStory(arg_7_0)
	if arg_7_0:getConfig("pre_story") == 0 then
		return true
	end

	getProxy = var_1_10002
	ChapterProxy = var_4

	local var_7_0 = var_1_10002(var_4)
	local var_7_1 = var_2.GetChapterItemById(var_7_0, var_1)

	return var_2.isClear(var_7_1)
end

function var_0_1.isClear(arg_8_0)
	_ = var_1_10001

	local var_8_0

	if var_1_10001.all(arg_8_0:GetChapterStories(), function(arg_9_0)
		return arg_9_0:IsClear()
	end) then
		var_8_0 = arg_8_0:IsCleanPrevChapter()
	end

	return var_8_0
end

function var_0_1.GetChapterStories(arg_10_0)
	_ = var_1_10001

	return (var_1_10001.map(arg_10_0:GetStoryIds(), function(arg_11_0)
		ChapterStoryItem = var_2_10001

		return var_2_10001.New({
			configId = arg_11_0
		})
	end))
end

function var_0_1.isAllAchieve(arg_12_0)
	return true
end

function var_0_1.activeAlways(arg_13_0)
	return true
end

function var_0_1.ifNeedHide(arg_14_0)
	return false
end

function var_0_1.inActTime(arg_15_0)
	return true
end

return var_0_1
