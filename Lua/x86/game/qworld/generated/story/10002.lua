BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10002", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10002"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10002"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:EnableCameraByTagAction("lookyingzhao", 2, 2)
	arg_5_0:DelayTimeAction(3, function()
		arg_5_0:DelayTimeAction(2.3, function()
			arg_5_0:EventAction(function()
				arg_5_0:ImmediateNextFlag(-1)
			end)
		end)
		arg_5_0:Agent_CameraControl("2", function()
			arg_5_0:EnableCameraByTagAction("", 2, 2)
		end)
	end)
	arg_5_0:HideTalkView()
	arg_5_0:OnNext(function()
		arg_5_0:ClearOnNext()
		arg_5_0:CloseStoryEventNode_2()
	end)
end

function var_0_0.CloseStoryEventNode_2(arg_11_0)
	arg_11_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_12_0)
	arg_12_0:RegisterTalkFunction("End", arg_12_0.CloseStoryEventNode_2)
end

return var_0_0
