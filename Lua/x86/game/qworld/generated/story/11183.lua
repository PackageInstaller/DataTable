BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11183", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11183"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11183"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9525, "1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {
			430001
		})
		arg_5_0:SetCharToTagAction(907301, "5", function()
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

function var_0_0.DialogueNode_2(arg_11_0)
	arg_11_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11183001, "", 0)
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
	arg_16_0:PlayActorAnimationAction(9525, "summer_shock_start", 0.05, 0.3333333, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11183002, "", 0)
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
	arg_21_0:PlayActorAnimationAction(9525, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11183003, "", 0)
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
		arg_21_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_26_0)
	arg_26_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(11183004, "", 0)
	arg_26_0:SetNeedSkip(true, {
		Invoke = function()
			arg_26_0:Skip("End")
		end
	})
	arg_26_0:SetNeedClick(true, {
		Invoke = function()
			arg_26_0:Next()
		end
	})
	arg_26_0:OnNext(function(arg_30_0)
		arg_26_0:ClearOnNext()
		arg_26_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_31_0)
	arg_31_0:ShowTalkView()
	arg_31_0:SetTalkContent(11183005, "", 0)
	arg_31_0:SetNeedSkip(true, {
		Invoke = function()
			arg_31_0:Skip("End")
		end
	})
	arg_31_0:SetNeedClick(true, {
		Invoke = function()
			arg_31_0:Next()
		end
	})
	arg_31_0:OnNext(function(arg_34_0)
		arg_31_0:ClearOnNext()
		arg_31_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_35_0)
	arg_35_0:ActorSeekerAction(9525, {
		"2",
		"3"
	}, 2.5, function()
		return
	end)
	arg_35_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_35_0:LookAtAction(true, 907301, "4")
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11183006, "", 0)
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
		arg_35_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_40_0)
	arg_40_0:InstEffectAction({
		attachFollow = false,
		delayTime = 2,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 907301,
		path = "QWWorld/Effect/EmotionBubble/fx_liuhan_1801_QW"
	})
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11183007, "", 0)
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
	arg_40_0:OnNext(function(arg_43_0)
		arg_40_0:ClearOnNext()
		arg_40_0:BlackFadeDialogueNode_9()
	end)
end

function var_0_0.BlackFadeDialogueNode_9(arg_44_0)
	arg_44_0:HideTalkView()
	arg_44_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_44_0:DestroyCharAction(9525)
		arg_44_0:DestroyCharAction(907301)
		arg_44_0:HideAllDynamicAction(false, false, 4095, {})
		arg_44_0:EnableCameraByTagAction("", 1, 0)
		arg_44_0:ContinueBlackFade()
		arg_44_0:OnNext(function()
			arg_44_0:ClearOnNext()
			arg_44_0:CloseStoryEventNode_10()
		end)
	end, function()
		arg_44_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_10(arg_48_0)
	arg_48_0:EnableCameraCutAction(false)
	arg_48_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_49_0)
	arg_49_0:RegisterTalkFunction("End", arg_49_0.CloseStoryEventNode_10)
end

return var_0_0
