BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11037", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11037"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11037"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true)
		arg_5_0:SetCharToTagAction(907301, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9060, "1", function()
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
	arg_11_0:PlayActorAnimationAction(907301, "take", 0.05, 1.833333, function()
		arg_11_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11037001, "", 0)
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
	arg_17_0:PlayActorAnimationAction(9060, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_17_0:PlayActorEmoteAction(9060, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_17_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11037002, "", 0)
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
	arg_23_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_23_0:EnableCameraByTagAction("3", 1, 0)
	arg_23_0:CameraMoveAction("3", 4, 5, 3, 0.3)
	arg_23_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_23_0:LookAtAction(true, 907301, "3")
	arg_23_0:ShowTalkView()
	arg_23_0:SetTalkContent(11037003, "", 0)
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
	arg_23_0:OnNext(function(arg_27_0)
		arg_23_0:ClearOnNext()
		arg_23_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_28_0)
	arg_28_0:PlayActorAnimationAction(9060, "firm", 0.05, 2.333333, function()
		return
	end)
	arg_28_0:ShowTalkView()
	arg_28_0:SetTalkContent(11037004, "", 0)
	arg_28_0:SetNeedSkip(true, {
		Invoke = function()
			arg_28_0:Skip("End")
		end
	})
	arg_28_0:SetNeedClick(true, {
		Invoke = function()
			arg_28_0:Next()
		end
	})
	arg_28_0:OnNext(function(arg_32_0)
		arg_28_0:ClearOnNext()
		arg_28_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_33_0)
	arg_33_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_33_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_33_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_33_0:LookAtRoleAction(true, 907301, "9060")
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(11037005, "", 0)
	arg_33_0:SetNeedSkip(true, {
		Invoke = function()
			arg_33_0:Skip("End")
		end
	})
	arg_33_0:SetNeedClick(true, {
		Invoke = function()
			arg_33_0:Next()
		end
	})
	arg_33_0:OnNext(function(arg_37_0)
		arg_33_0:ClearOnNext()
		arg_33_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_38_0)
	arg_38_0:PlayActorAnimationAction(9060, "excited_start", 0.05, 0.6666667, function()
		return
	end)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11037006, "", 0)
	arg_38_0:SetNeedSkip(true, {
		Invoke = function()
			arg_38_0:Skip("End")
		end
	})
	arg_38_0:SetNeedClick(true, {
		Invoke = function()
			arg_38_0:Next()
		end
	})
	arg_38_0:OnNext(function(arg_42_0)
		arg_38_0:ClearOnNext()
		arg_38_0:BlackFadeDialogueNode_8()
	end)
end

function var_0_0.BlackFadeDialogueNode_8(arg_43_0)
	arg_43_0:HideTalkView()
	arg_43_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_43_0:HideAllDynamicAction(false, false)
		arg_43_0:DestroyCharAction(9060)
		arg_43_0:EnableCameraByTagAction("", 1, 0)
		arg_43_0:DestroyCharAction(907301)
		arg_43_0:ContinueBlackFade()
		arg_43_0:OnNext(function()
			arg_43_0:ClearOnNext()
			arg_43_0:CloseStoryEventNode_9()
		end)
	end, function()
		arg_43_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_9(arg_47_0)
	arg_47_0:EnableCameraCutAction(false)
	arg_47_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_48_0)
	arg_48_0:RegisterTalkFunction("End", arg_48_0.BlackFadeDialogueNode_8)
	arg_48_0:RegisterTalkFunction("End", arg_48_0.CloseStoryEventNode_9)
end

return var_0_0
