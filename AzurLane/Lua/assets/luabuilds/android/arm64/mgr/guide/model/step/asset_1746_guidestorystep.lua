class = var_0_10000

local var_0_0 = "GuideStoryStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuideStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.stories = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.stories) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.stories, iter_1_1)
	end

	return
end

function var_0_1.GetType(arg_2_0)
	GuideStep = var_1_10001

	return var_1_10001.TYPE_STORY
end

function var_0_1.GetStories(arg_3_0)
	return arg_3_0.stories
end

return var_0_1
