BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10013", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10013"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10013"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.3, function()
		arg_5_0:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9072, "9072_1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true)
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
	arg_11_0:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
		return
	end)
	arg_11_0:CameraMoveAction("1", 1, 4, 5, 0.15)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(10013001, "", 0)
	arg_11_0:SetNeedSkip(false, {
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
	arg_16_0:EnableCameraByTagAction("2", 1, 0)
	arg_16_0:PlayActorEmoteAction(9072, "blink", 0.2, 0.3333333, function()
		return
	end, true, false)
	arg_16_0:PlayActorAnimationAction(9072, "action2_1", 0.1, 1.666667, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(10013002, "", 0)
	arg_16_0:SetNeedSkip(false, {
		Invoke = function()
			arg_16_0:Skip("End")
		end
	})
	arg_16_0:SetNeedClick(true, {
		Invoke = function()
			arg_16_0:Next()
		end
	})
	arg_16_0:OnNext(function(arg_21_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:EnableCameraByTagAction("3", 1, 0)
	arg_22_0:DelayTimeAction(1.2, function()
		arg_22_0:PlayActorEmoteAction(9070, "shocked01", 0.2, 1.4, function()
			return
		end, true, false)
	end)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(10013003, "", 0)
	arg_22_0:SetNeedSkip(false, {
		Invoke = function()
			arg_22_0:Skip("End")
		end
	})
	arg_22_0:SetNeedClick(true, {
		Invoke = function()
			arg_22_0:Next()
		end
	})
	arg_22_0:OnNext(function(arg_27_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_28_0)
	arg_28_0:PlayActorAnimationAction(9072, "action2_3", 0.2, 0, function()
		return
	end)
	arg_28_0:EnableCameraByTagAction("2", 1, 0)
	arg_28_0:ShowTalkView()
	arg_28_0:SetTalkContent(10013004, "", 0)
	arg_28_0:SetNeedSkip(false, {
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
	arg_33_0:PlayActorAnimationAction(9072, "action3_1", 0.1, 0, function()
		return
	end)
	arg_33_0:CameraMoveAction("2", 10, 1, 5, 0.1)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(10013005, "", 0)
	arg_33_0:SetNeedSkip(false, {
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
	arg_38_0:PlayActorAnimationAction(9070, "cheer", 0, 2.333333, function()
		return
	end)
	arg_38_0:EnableCameraByTagAction("4", 1, 0)
	arg_38_0:CameraMoveAction("4", 10, 5, 5, 0.1)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(10013006, "", 0)
	arg_38_0:SetNeedSkip(false, {
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
		arg_43_0:EnableCameraByTagAction("", 1, 0)
		arg_43_0:EnableCameraCutAction(true)
		arg_43_0:HideAllDynamicAction(false, false)
		arg_43_0:DestroyCharAction(9070)
		arg_43_0:DestroyCharAction(9072)
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
	arg_47_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_48_0)
	arg_48_0:RegisterTalkFunction("End", arg_48_0.CloseStoryEventNode_9)
end

return var_0_0
