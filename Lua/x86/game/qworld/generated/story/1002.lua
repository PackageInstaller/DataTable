BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("1002", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "1002"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/1002"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnNext(function()
		arg_5_0:ClearOnNext()
		arg_5_0:CloseStoryEventNode_2()
	end)
end

function var_0_0.CloseStoryEventNode_2(arg_7_0)
	arg_7_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_8_0)
	arg_8_0:RegisterTalkFunction("End", arg_8_0.CloseStoryEventNode_2)
end

return var_0_0
