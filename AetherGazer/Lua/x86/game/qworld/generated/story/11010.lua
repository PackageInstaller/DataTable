BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11010", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11010"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11010"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9512, "3", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_12_0)
	arg_12_0:PlayActorAnimationAction(9073, "happy01", 0, 2.333333, function()
		return
	end)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(11010001, "", 9073)
	arg_12_0:SetNeedSkip(true, {
		Invoke = function()
			arg_12_0:Skip("LastWord")
		end
	})
	arg_12_0:SetNeedClick(true, {
		Invoke = function()
			arg_12_0:Next()
		end
	})
	arg_12_0:OnNext(function(arg_16_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_17_0:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11010002, "", 9074)
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
	arg_22_0:EnableCameraByTagAction("4", 1, 0)
	arg_22_0:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
		return
	end)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11010003, "", 9073)
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
	arg_22_0:OnNext(function(arg_26_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_27_0)
	arg_27_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_27_0:PlayActorAnimationAction(9512, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11010004, "", 9512)
	arg_27_0:SetNeedSkip(true, {
		Invoke = function()
			arg_27_0:Skip("LastWord")
		end
	})
	arg_27_0:SetNeedClick(true, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_31_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_32_0)
	arg_32_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_32_0:PlayActorAnimationAction(9073, "embarrassed", 0, 2.6, function()
		return
	end)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11010005, "", 9073)
	arg_32_0:SetNeedSkip(true, {
		Invoke = function()
			arg_32_0:Skip("LastWord")
		end
	})
	arg_32_0:SetNeedClick(true, {
		Invoke = function()
			arg_32_0:Next()
		end
	})
	arg_32_0:OnNext(function(arg_36_0)
		arg_32_0:ClearOnNext()
		arg_32_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_37_0)
	arg_37_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_37_0:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	arg_37_0:PlayActorAnimationAction(9512, "action2_3", 0, 1.333333, function()
		return
	end)
	arg_37_0:ShowTalkView()
	arg_37_0:SetTalkContent(11010006, "", 9074)
	arg_37_0:SetNeedSkip(true, {
		Invoke = function()
			arg_37_0:Skip("LastWord")
		end
	})
	arg_37_0:SetNeedClick(true, {
		Invoke = function()
			arg_37_0:Next()
		end
	})
	arg_37_0:OnNext(function(arg_42_0)
		arg_37_0:ClearOnNext()
		arg_37_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_43_0)
	arg_43_0:EnableCameraByTagAction("3", 1, 0)
	arg_43_0:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	arg_43_0:CameraMoveAction("3", 4, 4, 6, 0.4)
	arg_43_0:ShowTalkView()
	arg_43_0:SetTalkContent(11010007, "", 9073)
	arg_43_0:SetNeedSkip(true, {
		Invoke = function()
			arg_43_0:Skip("LastWord")
		end
	})
	arg_43_0:SetNeedClick(true, {
		Invoke = function()
			arg_43_0:Next()
		end
	})
	arg_43_0:OnNext(function(arg_47_0)
		arg_43_0:ClearOnNext()
		arg_43_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_48_0)
	arg_48_0:ShowTalkView()
	arg_48_0:SetTalkContent(11010008, "", 9512)
	arg_48_0:SetNeedSkip(true, {
		Invoke = function()
			arg_48_0:Skip("LastWord")
		end
	})
	arg_48_0:SetNeedClick(true, {
		Invoke = function()
			arg_48_0:Next()
		end
	})
	arg_48_0:OnNext(function(arg_51_0)
		arg_48_0:ClearOnNext()
		arg_48_0:BlackFadeDialogueNode_10()
	end)
end

function var_0_0.BlackFadeDialogueNode_10(arg_52_0)
	arg_52_0:HideTalkView()
	arg_52_0:OnBlackFade(false, 0, 0.4, 0.2, 0.2, function()
		arg_52_0:DestroyCharAction(9073)
		arg_52_0:DestroyCharAction(9074)
		arg_52_0:DestroyCharAction(9512)
		arg_52_0:HideAllDynamicAction(false, false, 4095, {})
		arg_52_0:Agent_PlayerPosControl("chuansong", function()
			arg_52_0:EnableCameraByTagAction("", 1, 0)
		end)
		arg_52_0:ContinueBlackFade()
		arg_52_0:OnNext(function()
			arg_52_0:ClearOnNext()
			arg_52_0:CloseStoryEventNode_11()
		end)
	end, function()
		arg_52_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_11(arg_57_0)
	arg_57_0:EnableCameraCutAction(false)
	arg_57_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_58_0)
	arg_58_0:RegisterTalkFunction("LastWord", arg_58_0.BlackFadeDialogueNode_10)
	arg_58_0:RegisterTalkFunction("End", arg_58_0.CloseStoryEventNode_11)
end

return var_0_0
