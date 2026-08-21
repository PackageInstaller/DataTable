BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11020", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11020"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11020"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true)
		arg_5_0:SetCharToTagAction(9510, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
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
	arg_11_0:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_11_0:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11020001, "", 0)
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
	arg_11_0:OnNext(function(arg_16_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:PlayActorEmoteAction(9510, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_17_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_17_0:PlayActorAnimationAction(9510, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11020002, "", 0)
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
	arg_17_0:OnNext(function(arg_22_0)
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_23_0)
	arg_23_0:PlayActorAnimationAction(9073, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_23_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_23_0:PlayActorEmoteAction(9073, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	arg_23_0:ShowTalkView()
	arg_23_0:SetTalkContent(11020003, "", 0)
	arg_23_0:SetNeedSkip(true, {
		Invoke = function()
			arg_23_0:Skip("End")
		end
	})
	arg_23_0:SetNeedClick(true, {
		Invoke = function()
			arg_23_0:Next()
		end
	})
	arg_23_0:OnNext(function(arg_28_0)
		arg_23_0:ClearOnNext()
		arg_23_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_29_0)
	arg_29_0:PlayActorAnimationAction(9510, "action2_3", 0.05, 1.333333, function()
		return
	end)
	arg_29_0:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_29_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(11020004, "", 0)
	arg_29_0:SetNeedSkip(true, {
		Invoke = function()
			arg_29_0:Skip("End")
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
	arg_35_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11020005, "", 0)
	arg_35_0:SetNeedSkip(true, {
		Invoke = function()
			arg_35_0:Skip("End")
		end
	})
	arg_35_0:SetNeedClick(true, {
		Invoke = function()
			arg_35_0:Next()
		end
	})
	arg_35_0:OnNext(function(arg_39_0)
		arg_35_0:ClearOnNext()
		arg_35_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_40_0)
	arg_40_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_40_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_40_0:CameraMoveAction("LookAtCamera_2_2_R", 4, 1, 0.7, 0.3)
	arg_40_0:PlayActorAnimationAction(9073, "summer_shock_start", 0.05, 0.3333333, function()
		return
	end)
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11020006, "", 0)
	arg_40_0:SetNeedSkip(true, {
		Invoke = function()
			arg_40_0:Skip("End")
		end
	})
	arg_40_0:SetNeedClick(true, {
		Invoke = function()
			arg_40_0:Next()
		end
	})
	arg_40_0:OnNext(function(arg_45_0)
		arg_40_0:ClearOnNext()
		arg_40_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_46_0)
	arg_46_0:PlayActorEmoteAction(9510, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_46_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_46_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_46_0:ShowTalkView()
	arg_46_0:SetTalkContent(11020007, "", 0)
	arg_46_0:SetNeedSkip(true, {
		Invoke = function()
			arg_46_0:Skip("End")
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
	arg_52_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_52_0:EnableCameraByTagAction("1", 1, 0)
	arg_52_0:CameraMoveAction("1", 4, 4, 5, 0.4)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11020008, "", 0)
	arg_52_0:SetNeedSkip(true, {
		Invoke = function()
			arg_52_0:Skip("End")
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
	arg_57_0:ShowTalkView()
	arg_57_0:SetTalkContent(11020009, "", 0)
	arg_57_0:SetNeedSkip(true, {
		Invoke = function()
			arg_57_0:Skip("End")
		end
	})
	arg_57_0:SetNeedClick(true, {
		Invoke = function()
			arg_57_0:Next()
		end
	})
	arg_57_0:OnNext(function(arg_60_0)
		arg_57_0:ClearOnNext()
		arg_57_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_61_0)
	arg_61_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_61_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_61_0:ShowTalkView()
	arg_61_0:SetTalkContent(11020010, "", 0)
	arg_61_0:SetNeedSkip(true, {
		Invoke = function()
			arg_61_0:Skip("End")
		end
	})
	arg_61_0:SetNeedClick(true, {
		Invoke = function()
			arg_61_0:Next()
		end
	})
	arg_61_0:OnNext(function(arg_65_0)
		arg_61_0:ClearOnNext()
		arg_61_0:BlackFadeDialogueNode_12()
	end)
end

function var_0_0.BlackFadeDialogueNode_12(arg_66_0)
	arg_66_0:HideTalkView()
	arg_66_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_66_0:HideAllDynamicAction(false, false)
		arg_66_0:EnableCameraByTagAction("", 1, 0)
		arg_66_0:DestroyCharAction(9073)
		arg_66_0:DestroyCharAction(9510)
		arg_66_0:ContinueBlackFade()
		arg_66_0:OnNext(function()
			arg_66_0:ClearOnNext()
			arg_66_0:CloseStoryEventNode_13()
		end)
	end, function()
		arg_66_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_13(arg_70_0)
	arg_70_0:EnableCameraCutAction(false)
	arg_70_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_71_0)
	arg_71_0:RegisterTalkFunction("End", arg_71_0.BlackFadeDialogueNode_12)
end

return var_0_0
