BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11015", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11015"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11015"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
		arg_5_0:SetCharToTagAction(9510, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
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

function var_0_0.DialogueNode_2(arg_11_0)
	arg_11_0:PlayActorAnimationAction(9510, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_11_0:PlayActorEmoteAction(9510, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11015001, "", 9510)
	arg_11_0:SetNeedSkip(true, {
		Invoke = function()
			arg_11_0:Skip("LastWord")
		end
	})
	arg_11_0:SetNeedClick(true, {
		Invoke = function()
			arg_11_0:Next()
		end
	})
	arg_11_0:OnNext(function(arg_16_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_17_0:PlayActorAnimationAction(9073, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11015002, "", 9073)
	arg_17_0:SetNeedSkip(true, {
		Invoke = function()
			arg_17_0:Skip("LastWord")
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
	arg_22_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_22_0:PlayActorAnimationAction(9510, "summer_doubt", 0, 2, function()
		arg_22_0:PlayActorAnimationAction(9510, "conversation_2", 0, 3.166667, function()
			return
		end)
	end)
	arg_22_0:PlayActorEmoteAction(9510, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11015003, "", 9510)
	arg_22_0:SetNeedSkip(true, {
		Invoke = function()
			arg_22_0:Skip("LastWord")
		end
	})
	arg_22_0:SetNeedClick(true, {
		Invoke = function()
			arg_22_0:Next()
		end
	})
	arg_22_0:OnNext(function(arg_28_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_29_0)
	arg_29_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_29_0:PlayActorAnimationAction(9073, "summer_doubt", 0, 2, function()
		return
	end)
	arg_29_0:PlayActorEmoteAction(9073, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(11015004, "", 9073)
	arg_29_0:SetNeedSkip(true, {
		Invoke = function()
			arg_29_0:Skip("LastWord")
		end
	})
	arg_29_0:SetNeedClick(true, {
		Invoke = function()
			arg_29_0:Next()
		end
	})
	arg_29_0:OnNext(function(arg_34_0)
		arg_29_0:ClearOnNext()
		arg_29_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_35_0)
	arg_35_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_35_0:PlayActorAnimationAction(9510, "think_loop", 0, 2, function()
		return
	end)
	arg_35_0:PlayActorEmoteAction(9510, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11015005, "", 9510)
	arg_35_0:SetNeedSkip(true, {
		Invoke = function()
			arg_35_0:Skip("LastWord")
		end
	})
	arg_35_0:SetNeedClick(true, {
		Invoke = function()
			arg_35_0:Next()
		end
	})
	arg_35_0:OnNext(function(arg_40_0)
		arg_35_0:ClearOnNext()
		arg_35_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_41_0)
	arg_41_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_41_0:PlayActorAnimationAction(9073, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(11015006, "", 9073)
	arg_41_0:SetNeedSkip(true, {
		Invoke = function()
			arg_41_0:Skip("LastWord")
		end
	})
	arg_41_0:SetNeedClick(true, {
		Invoke = function()
			arg_41_0:Next()
		end
	})
	arg_41_0:OnNext(function(arg_45_0)
		arg_41_0:ClearOnNext()
		arg_41_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_46_0)
	arg_46_0:PlayActorAnimationAction(9073, "proud_start", 0.1, 0.6, function()
		return
	end)
	arg_46_0:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_46_0:ShowTalkView()
	arg_46_0:SetTalkContent(11015007, "", 9073)
	arg_46_0:SetNeedSkip(true, {
		Invoke = function()
			arg_46_0:Skip("LastWord")
		end
	})
	arg_46_0:SetNeedClick(true, {
		Invoke = function()
			arg_46_0:Next()
		end
	})
	arg_46_0:OnNext(function(arg_51_0)
		arg_46_0:ClearOnNext()
		arg_46_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_52_0)
	arg_52_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_52_0:PlayActorAnimationAction(9510, "action3_1", 0.1, 2.266667, function()
		return
	end)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11015008, "", 9510)
	arg_52_0:SetNeedSkip(true, {
		Invoke = function()
			arg_52_0:Skip("LastWord")
		end
	})
	arg_52_0:SetNeedClick(true, {
		Invoke = function()
			arg_52_0:Next()
		end
	})
	arg_52_0:OnNext(function(arg_56_0)
		arg_52_0:ClearOnNext()
		arg_52_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_57_0)
	arg_57_0:EnableCameraByTagAction("1", 1, 0)
	arg_57_0:PlayActorAnimationAction(9073, "proud_end", 0.1, 0.7666668, function()
		return
	end)
	arg_57_0:PlayActorAnimationAction(9073, "conversation_1", 0.1, 3, function()
		return
	end)
	arg_57_0:CameraMoveAction("1", 4, 4, 6, 0.5)
	arg_57_0:ShowTalkView()
	arg_57_0:SetTalkContent(11015009, "", 9073)
	arg_57_0:SetNeedSkip(true, {
		Invoke = function()
			arg_57_0:Skip("LastWord")
		end
	})
	arg_57_0:SetNeedClick(true, {
		Invoke = function()
			arg_57_0:Next()
		end
	})
	arg_57_0:OnNext(function(arg_62_0)
		arg_57_0:ClearOnNext()
		arg_57_0:BlackFadeDialogueNode_11()
	end)
end

function var_0_0.BlackFadeDialogueNode_11(arg_63_0)
	arg_63_0:HideTalkView()
	arg_63_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_63_0:DestroyCharAction(9073)
		arg_63_0:DestroyCharAction(9510)
		arg_63_0:HideAllDynamicAction(false, false, 4095, {})
		arg_63_0:Agent_PlayerPosControl("chuansong", function()
			arg_63_0:EnableCameraByTagAction("", 1, 0)
		end)
		arg_63_0:WalkingPeopleGlobleCull(false)
		arg_63_0:ContinueBlackFade()
		arg_63_0:OnNext(function()
			arg_63_0:ClearOnNext()
			arg_63_0:CloseStoryEventNode_12()
		end)
	end, function()
		arg_63_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_12(arg_68_0)
	arg_68_0:EnableCameraCutAction(false)
	arg_68_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_69_0)
	arg_69_0:RegisterTalkFunction("LastWord", arg_69_0.BlackFadeDialogueNode_11)
	arg_69_0:RegisterTalkFunction("End", arg_69_0.CloseStoryEventNode_12)
end

return var_0_0
