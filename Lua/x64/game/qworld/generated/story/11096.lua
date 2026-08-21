BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11096", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11096"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11096"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:CameraMoveAction("1", 4, 5, 10, 0.7)
		arg_5_0:SetCharToTagAction(907301, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9060, "2", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_11_0)
	arg_11_0:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11036011, "", 0)
	arg_11_0:SetNeedSkip(true, {
		Invoke = function()
			arg_11_0:Skip("End")
		end
	})
	arg_11_0:SetNeedClick(true, {
		Invoke = function()
			arg_11_0:Next()
		end
	})
	arg_11_0:OnNext(function(arg_15_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_16_0)
	arg_16_0:PlayActorAnimationAction(9060, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_16_0:SetLookAtParamsAction(9060, 0.8, 1, 1)
	arg_16_0:LookAtRoleAction(true, 9060, "907301")
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11036012, "", 0)
	arg_16_0:SetNeedSkip(true, {
		Invoke = function()
			arg_16_0:Skip("End")
		end
	})
	arg_16_0:SetNeedClick(true, {
		Invoke = function()
			arg_16_0:Next()
		end
	})
	arg_16_0:OnNext(function(arg_20_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_21_0)
	arg_21_0:PlayActorAnimationAction(907301, "think_end", 0.05, 1.666667, function()
		return
	end)
	arg_21_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_05_alarm", "", "")
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11036013, "", 0)
	arg_21_0:SetNeedSkip(true, {
		Invoke = function()
			arg_21_0:Skip("End")
		end
	})
	arg_21_0:SetNeedClick(true, {
		Invoke = function()
			arg_21_0:Next()
		end
	})
	arg_21_0:OnNext(function(arg_25_0)
		arg_21_0:ClearOnNext()
		arg_21_0:BlackFadeDialogueNode_5()
	end)
end

function var_0_0.BlackFadeDialogueNode_5(arg_26_0)
	arg_26_0:HideTalkView()
	arg_26_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_26_0:HideAllDynamicAction(false, false, 4083, {})
		arg_26_0:DestroyCharAction(907301)
		arg_26_0:DestroyCharAction(9060)
		arg_26_0:EnableCameraByTagAction("", 1, 0)
		arg_26_0:ContinueBlackFade()
		arg_26_0:OnNext(function()
			arg_26_0:ClearOnNext()
			arg_26_0:CloseStoryEventNode_6()
		end)
	end, function()
		arg_26_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_6(arg_30_0)
	arg_30_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_31_0)
	arg_31_0:RegisterTalkFunction("End", arg_31_0.BlackFadeDialogueNode_5)
	arg_31_0:RegisterTalkFunction("End", arg_31_0.CloseStoryEventNode_6)
end

return var_0_0
