BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11032", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11032"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11032"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:SetCharToTagAction(9510, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9072, "3", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("4", 1, 0)
		arg_5_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
			return
		end)
		arg_5_0:WalkingPeopleGlobleCull(true)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_13_0)
	arg_13_0:ShowTalkView()
	arg_13_0:SetTalkContent(11032001, "", 9510)
	arg_13_0:SetNeedSkip(true, {
		Invoke = function()
			arg_13_0:Skip("End")
		end
	})
	arg_13_0:SetNeedClick(true, {
		Invoke = function()
			arg_13_0:Next()
		end
	})
	arg_13_0:OnNext(function(arg_16_0)
		arg_13_0:ClearOnNext()
		arg_13_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:PlayActorAnimationAction(9073, "excited_start", 0.05, 0.6666667, function()
		return
	end)
	arg_17_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11032002, "", 9073)
	arg_17_0:SetNeedSkip(true, {
		Invoke = function()
			arg_17_0:Skip("End")
		end
	})
	arg_17_0:SetNeedClick(true, {
		Invoke = function()
			arg_17_0:Next()
		end
	})
	arg_17_0:OnNext(function(arg_21_0)
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11032003, "", 9072)
	arg_22_0:SetNeedSkip(true, {
		Invoke = function()
			arg_22_0:Skip("End")
		end
	})
	arg_22_0:SetNeedClick(true, {
		Invoke = function()
			arg_22_0:Next()
		end
	})
	arg_22_0:OnNext(function(arg_26_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_27_0)
	arg_27_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11032004, "", 9510)
	arg_27_0:SetNeedSkip(true, {
		Invoke = function()
			arg_27_0:Skip("End")
		end
	})
	arg_27_0:SetNeedClick(true, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_31_0)
		arg_27_0:ClearOnNext()
		arg_27_0:BlackFadeDialogueNode_6()
	end)
end

function var_0_0.BlackFadeDialogueNode_6(arg_32_0)
	arg_32_0:HideTalkView()
	arg_32_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_32_0:HideAllDynamicAction(false, false, 4095, {})
		arg_32_0:DestroyCharAction(9072)
		arg_32_0:DestroyCharAction(9510)
		arg_32_0:DestroyCharAction(9073)
		arg_32_0:EnableCameraByTagAction("", 1, 0)
		arg_32_0:WalkingPeopleGlobleCull(false)
		arg_32_0:ContinueBlackFade()
		arg_32_0:OnNext(function()
			arg_32_0:ClearOnNext()
			arg_32_0:CloseStoryEventNode_7()
		end)
	end, function()
		arg_32_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_7(arg_36_0)
	arg_36_0:EnableCameraCutAction(false)
	arg_36_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_37_0)
	arg_37_0:RegisterTalkFunction("End", arg_37_0.BlackFadeDialogueNode_6)
	arg_37_0:RegisterTalkFunction("End", arg_37_0.CloseStoryEventNode_7)
end

return var_0_0
