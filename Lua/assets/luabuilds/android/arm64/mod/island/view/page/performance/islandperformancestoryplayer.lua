local var_0_0 = class("IslandPerformanceStoryPlayer", import(".IslandBasePerformancePlayer"))

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2)
	require("nodecanvas.Task.NcPlayStory").New(nil, {}):DoAction(arg_1_1.name, arg_1_1.refreshNpc, arg_1_2)

	return
end

function var_0_0.Update(arg_2_0)
	return
end

function var_0_0.Clear(arg_3_0)
	return
end

return var_0_0
