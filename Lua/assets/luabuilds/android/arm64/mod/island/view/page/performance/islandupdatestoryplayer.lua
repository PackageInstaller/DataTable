local var_0_0 = class("IslandUpdateStoryPlayer", import(".IslandBasePerformancePlayer"))

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2)
	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = arg_1_1.index,
		callback = arg_1_2
	})

	return
end

return var_0_0
