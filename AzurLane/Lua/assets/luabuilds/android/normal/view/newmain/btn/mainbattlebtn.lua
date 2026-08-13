class = var_0_10000

local var_0_0 = "MainBattleBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getActiveChapter(var_1_0)
	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.emit

	NewMainMediator = var_1_10005

	local var_1_4 = var_1_10005.GO_SCENE

	SCENE = var_1_10006

	var_1_3(var_1_2, var_1_4, var_1_10006.LEVEL, {
		chapterId = var_1_1 and var_1_1.id,
		mapIdx = var_1_1 and var_1_1:getConfig("map")
	})

	return
end

function var_0_1.IsFixed(arg_2_0)
	return true
end

return var_0_1
