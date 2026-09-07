local IslandPerformanceStoryPlayer = class("IslandPerformanceStoryPlayer", import(".IslandBasePerformancePlayer"))

function IslandPerformanceStoryPlayer:Play(arg_1_1, arg_1_2)
	require("nodecanvas.Task.NcPlayStory").New(nil, {}):DoAction(arg_1_1.name, arg_1_1.refreshNpc, arg_1_2)

	return
end

function IslandPerformanceStoryPlayer:Update()
	return
end

function IslandPerformanceStoryPlayer:Clear()
	return
end

return IslandPerformanceStoryPlayer
