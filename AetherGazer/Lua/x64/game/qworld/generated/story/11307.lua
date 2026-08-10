BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11307", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11307"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11307"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_10_0)
	arg_10_0:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_10_0:ShowTalkView()
	arg_10_0:SetTalkContent(11307001, "", 9073)
	arg_10_0:SetNeedSkip(false, {
		Invoke = function()
			arg_10_0:Skip("End")
		end
	})
	arg_10_0:SetNeedClick(true, {
		Invoke = function()
			arg_10_0:Next()
		end
	})
	arg_10_0:OnNext(function(arg_14_0)
		arg_10_0:ClearOnNext()
		arg_10_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_15_0)
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(11307002, "", 9073)
	arg_15_0:SetNeedSkip(false, {
		Invoke = function()
			arg_15_0:Skip("End")
		end
	})
	arg_15_0:SetNeedClick(true, {
		Invoke = function()
			arg_15_0:Next()
		end
	})
	arg_15_0:OnNext(function(arg_18_0)
		arg_15_0:ClearOnNext()
		arg_15_0:BlackFadeDialogueNode_4()
	end)
end

function var_0_0.BlackFadeDialogueNode_4(arg_19_0)
	arg_19_0:HideTalkView()
	arg_19_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_19_0:SetCharToTagAction(9073, "9073", function()
			return
		end)
		arg_19_0:SetCharToTagAction(9526, "1", function()
			return
		end)
		arg_19_0:ContinueBlackFade()
		arg_19_0:OnNext(function()
			arg_19_0:ClearOnNext()
			arg_19_0:DialogueNode_5()
		end)
	end, function()
		arg_19_0:Next()
	end)
end

function var_0_0.DialogueNode_5(arg_25_0)
	arg_25_0:ShowTalkView()
	arg_25_0:SetTalkContent(11307003, "", 9526)
	arg_25_0:SetNeedSkip(false, {
		Invoke = function()
			arg_25_0:Skip("End")
		end
	})
	arg_25_0:SetNeedClick(true, {
		Invoke = function()
			arg_25_0:Next()
		end
	})
	arg_25_0:OnNext(function(arg_28_0)
		arg_25_0:ClearOnNext()
		arg_25_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_29_0)
	arg_29_0:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 9073,
		path = "QWWorld/Effect/EmotionBubble/fx_maohan_0301"
	})
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(11307004, "", 9073)
	arg_29_0:SetNeedSkip(false, {
		Invoke = function()
			arg_29_0:Skip("End")
		end
	})
	arg_29_0:SetNeedClick(true, {
		Invoke = function()
			arg_29_0:Next()
		end
	})
	arg_29_0:OnNext(function(arg_32_0)
		arg_29_0:ClearOnNext()
		arg_29_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_33_0)
	arg_33_0:PlayActorAnimationAction(9526, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(11307005, "", 9526)
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
		arg_33_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_38_0)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11307006, "", 9526)
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
	arg_38_0:OnNext(function(arg_41_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_42_0)
	arg_42_0:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 9073,
		path = "QWWorld/Effect/EmotionBubble/fx_liuhan_1801_QW"
	})
	arg_42_0:PlayActorEmoteAction(9073, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11307007, "", 9073)
	arg_42_0:SetNeedSkip(false, {
		Invoke = function()
			arg_42_0:Skip("End")
		end
	})
	arg_42_0:SetNeedClick(true, {
		Invoke = function()
			arg_42_0:Next()
		end
	})
	arg_42_0:OnNext(function(arg_46_0)
		arg_42_0:ClearOnNext()
		arg_42_0:BlackFadeDialogueNode_10()
	end)
end

function var_0_0.BlackFadeDialogueNode_10(arg_47_0)
	arg_47_0:HideTalkView()
	arg_47_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_47_0:HideAllDynamicAction(false, false, 4095, {})
		arg_47_0:DestroyCharAction(9073)
		arg_47_0:EnableCameraByTagAction("", 1, 0)
		arg_47_0:DestroyCharAction(9526)
		arg_47_0:ContinueBlackFade()
		arg_47_0:OnNext(function()
			arg_47_0:ClearOnNext()
			arg_47_0:CloseStoryEventNode_11()
		end)
	end, function()
		arg_47_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_11(arg_51_0)
	arg_51_0:EnableCameraCutAction(false)
	arg_51_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_52_0)
	arg_52_0:RegisterTalkFunction("End", arg_52_0.CloseStoryEventNode_11)
end

return var_0_0
