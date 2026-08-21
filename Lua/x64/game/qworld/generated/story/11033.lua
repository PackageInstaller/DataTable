BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11033", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11033"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11033"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(true, 11045001, 2.5, 0.5, 0.5, function()
		arg_5_0:Agent_PlayerPosControl("1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_9073_cloth", "", "")
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:PureActorDialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_2(arg_11_0)
	arg_11_0:PlayActorAnimationAction(9073, "dressingroom_1", 0.05, 1.433333, function()
		arg_11_0:SetCharToTagAction(907301, "1", function()
			return
		end)
		arg_11_0:DestroyCharAction(9073)
		arg_11_0:PlayActorAnimationAction(907301, "dressingroom_2", 0.05, 2.3, function()
			arg_11_0:EventAction(function()
				arg_11_0:ImmediateNextFlag(-1)
			end)
		end)
	end)
	arg_11_0:EnableCameraByTagAction("1", 1, 0)
	arg_11_0:HideTalkView()
	arg_11_0:OnNext(function()
		arg_11_0:ClearOnNext()
		arg_11_0:BlackFadeDialogueNode_3()
	end)
end

function var_0_0.BlackFadeDialogueNode_3(arg_17_0)
	arg_17_0:HideTalkView()
	arg_17_0:OnBlackFade(false, 0, 0.5, 0.5, 0.5, function()
		arg_17_0:EnableCameraByTagAction("", 1, 0)
		arg_17_0:DestroyCharAction(907301)
		arg_17_0:HideAllDynamicAction(false, false, 4095, {})
		arg_17_0:ContinueBlackFade()
		arg_17_0:OnNext(function()
			arg_17_0:ClearOnNext()
			arg_17_0:CloseStoryEventNode_4()
		end)
	end, function()
		arg_17_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_4(arg_21_0)
	arg_21_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_22_0)
	arg_22_0:RegisterTalkFunction("End", arg_22_0.CloseStoryEventNode_4)
end

return var_0_0
