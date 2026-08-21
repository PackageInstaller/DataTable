BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11097", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11097"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11097"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:SetCharToTagAction(9073, "1", function()
		arg_5_0:PlayActorAnimationAction(9073, "dressingroom_1", 0.05, 1.433333, function()
			arg_5_0:DestroyCharAction(9073)
			arg_5_0:SetCharToTagAction(907301, "1", function()
				arg_5_0:EventAction(function()
					arg_5_0:ImmediateNextFlag(-1)
				end)
			end)
		end)
	end)
	arg_5_0:EnableCameraByTagAction("1", 1, 0)
	arg_5_0:HideAllDynamicAction(true, true, 4081, {})
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
