class = var_0_10000

local var_0_0 = "ChapterStoryItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.story_template
end

function var_0_1.GetStoryName(arg_2_0)
	return arg_2_0:getConfig("story")
end

function var_0_1.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_1.GetIcon(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("icon")

	return "StoryPointIcon/" .. var_4_0, var_4_0
end

function var_0_1.GetPosition(arg_5_0)
	return arg_5_0:getConfig("pos")
end

function var_0_1.IsClear(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.NewStoryMgr.GetInstance()

	return var_1.IsPlayed(var_6_0, arg_6_0:GetStoryName())
end

return var_0_1
