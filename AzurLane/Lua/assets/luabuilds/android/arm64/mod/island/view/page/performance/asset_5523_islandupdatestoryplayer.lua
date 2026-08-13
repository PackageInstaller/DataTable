class = var_0_10000

local var_0_0 = "IslandUpdateStoryPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBasePerformancePlayer"))

function var_0_1.Play(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	local var_1_0 = var_1_10003.m02
	local var_1_1 = var_3.sendNotification

	GAME = var_1_10006

	var_1_1(var_1_0, var_1_10006.STORY_UPDATE, {
		storyId = arg_1_1.index,
		callback = arg_1_2
	})

	return
end

return var_0_1
