BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11016", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11016"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11016"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9513, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
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
	arg_11_0:PlayActorAnimationAction(9073, "conversation_1", 0, 3, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11016001, "", 9073)
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
	arg_16_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_16_0:PlayActorAnimationAction(9513, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_16_0:CameraMoveAction("LookAtCamera_2_2_R", 4, 4, 5, 0.3)
	arg_16_0:DelayTimeAction(1, function()
		arg_16_0:BlackFadeAction(0.2, 0.2, 0.2, function()
			return
		end, function()
			arg_16_0:EnableCameraByTagAction("2", 1, 0)
			arg_16_0:CameraMoveAction("2", 4, 6, 5, 0.3)
		end)
		arg_16_0:DelayTimeAction(3, function()
			arg_16_0:BlackFadeAction(0.2, 0.2, 0.2, function()
				return
			end, function()
				arg_16_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
			end)
		end)
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11016002, "", 9513)
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
	arg_16_0:OnNext(function(arg_26_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_27_0)
	arg_27_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_27_0:PlayActorAnimationAction(9073, "stroke01", 0, 9.066668, function()
		return
	end)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11016003, "", 9073)
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
		arg_27_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_32_0)
	arg_32_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_32_0:PlayActorEmoteAction(9513, "shocked01", 0, 1.4, function()
		arg_32_0:PlayActorAnimationAction(9513, "conversation_1", 0, 3, function()
			return
		end)
	end, true, false)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11016004, "", 9513)
	arg_32_0:SetNeedSkip(true, {
		Invoke = function()
			arg_32_0:Skip("End")
		end
	})
	arg_32_0:SetNeedClick(true, {
		Invoke = function()
			arg_32_0:Next()
		end
	})
	arg_32_0:OnNext(function(arg_37_0)
		arg_32_0:ClearOnNext()
		arg_32_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_38_0)
	arg_38_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_38_0:PlayActorAnimationAction(9073, "action2_1", 0, 1.666667, function()
		arg_38_0:PlayActorAnimationAction(9073, "embarrassed", 0.1, 2.6, function()
			return
		end)
	end)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11016005, "", 9073)
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
	arg_38_0:OnNext(function(arg_43_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_44_0)
	arg_44_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_44_0:PlayActorEmoteAction(9513, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11016006, "", 9513)
	arg_44_0:SetNeedSkip(true, {
		Invoke = function()
			arg_44_0:Skip("End")
		end
	})
	arg_44_0:SetNeedClick(true, {
		Invoke = function()
			arg_44_0:Next()
		end
	})
	arg_44_0:OnNext(function(arg_48_0)
		arg_44_0:ClearOnNext()
		arg_44_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_49_0)
	arg_49_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_49_0:PlayActorAnimationAction(9073, "firm", 0, 2.333333, function()
		return
	end)
	arg_49_0:ShowTalkView()
	arg_49_0:SetTalkContent(11016007, "", 9073)
	arg_49_0:SetNeedSkip(true, {
		Invoke = function()
			arg_49_0:Skip("End")
		end
	})
	arg_49_0:SetNeedClick(true, {
		Invoke = function()
			arg_49_0:Next()
		end
	})
	arg_49_0:OnNext(function(arg_53_0)
		arg_49_0:ClearOnNext()
		arg_49_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_54_0)
	arg_54_0:EnableCameraByTagAction("1", 1, 0)
	arg_54_0:PlayActorAnimationAction(9073, "happy04", 0, 2.2, function()
		return
	end)
	arg_54_0:ShowTalkView()
	arg_54_0:SetTalkContent(11016008, "", 9073)
	arg_54_0:SetNeedSkip(true, {
		Invoke = function()
			arg_54_0:Skip("End")
		end
	})
	arg_54_0:SetNeedClick(true, {
		Invoke = function()
			arg_54_0:Next()
		end
	})
	arg_54_0:OnNext(function(arg_58_0)
		arg_54_0:ClearOnNext()
		arg_54_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_59_0)
	arg_59_0:PlayActorAnimationAction(9513, "conversation_1", 0, 3, function()
		return
	end)
	arg_59_0:ShowTalkView()
	arg_59_0:SetTalkContent(11016009, "", 9513)
	arg_59_0:SetNeedSkip(true, {
		Invoke = function()
			arg_59_0:Skip("End")
		end
	})
	arg_59_0:SetNeedClick(true, {
		Invoke = function()
			arg_59_0:Next()
		end
	})
	arg_59_0:OnNext(function(arg_63_0)
		arg_59_0:ClearOnNext()
		arg_59_0:BlackFadeDialogueNode_11()
	end)
end

function var_0_0.BlackFadeDialogueNode_11(arg_64_0)
	arg_64_0:HideTalkView()
	arg_64_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_64_0:DestroyCharAction(9513)
		arg_64_0:DestroyCharAction(9073)
		arg_64_0:EnableCameraByTagAction("", 1, 0)
		arg_64_0:HideAllDynamicAction(false, false, 4095, {})
		arg_64_0:WalkingPeopleGlobleCull(false)
		arg_64_0:ContinueBlackFade()
		arg_64_0:OnNext(function()
			arg_64_0:ClearOnNext()
			arg_64_0:CloseStoryEventNode_12()
		end)
	end, function()
		arg_64_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_12(arg_68_0)
	arg_68_0:EnableCameraCutAction(false)
	arg_68_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_69_0)
	arg_69_0:RegisterTalkFunction("End", arg_69_0.BlackFadeDialogueNode_11)
	arg_69_0:RegisterTalkFunction("End", arg_69_0.CloseStoryEventNode_12)
end

return var_0_0
