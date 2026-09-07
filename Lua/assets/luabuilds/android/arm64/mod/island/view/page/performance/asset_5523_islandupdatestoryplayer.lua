local IslandUpdateStoryPlayer = class("IslandUpdateStoryPlayer", import(".IslandBasePerformancePlayer"))

function IslandUpdateStoryPlayer:Play(arg_1_1, arg_1_2)
	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = arg_1_1.index,
		callback = arg_1_2
	})

	return
end

return IslandUpdateStoryPlayer
