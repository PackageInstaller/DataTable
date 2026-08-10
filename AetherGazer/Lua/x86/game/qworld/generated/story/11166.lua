BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11166", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11166"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11166"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9520, "9520", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "9073", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {
			410001
		})
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
	arg_11_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11166001, "", 0)
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
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11166002, "", 0)
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
	arg_16_0:OnNext(function(arg_19_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_20_0)
	arg_20_0:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_20_0:ShowTalkView()
	arg_20_0:SetTalkContent(11166003, "", 0)
	arg_20_0:SetNeedSkip(true, {
		Invoke = function()
			arg_20_0:Skip("End")
		end
	})
	arg_20_0:SetNeedClick(true, {
		Invoke = function()
			arg_20_0:Next()
		end
	})
	arg_20_0:OnNext(function(arg_24_0)
		arg_20_0:ClearOnNext()
		arg_20_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_25_0)
	arg_25_0:ShowTalkView()
	arg_25_0:SetTalkContent(11166004, "", 0)
	arg_25_0:SetNeedSkip(true, {
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
	arg_29_0:PlayActorAnimationAction(9520, "speechless", 0.05, 3.333333, function()
		return
	end)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(11166005, "", 0)
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
	arg_29_0:OnNext(function(arg_33_0)
		arg_29_0:ClearOnNext()
		arg_29_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_34_0)
	arg_34_0:ShowTalkView()
	arg_34_0:SetTalkContent(11166006, "", 0)
	arg_34_0:SetNeedSkip(true, {
		Invoke = function()
			arg_34_0:Skip("End")
		end
	})
	arg_34_0:SetNeedClick(true, {
		Invoke = function()
			arg_34_0:Next()
		end
	})
	arg_34_0:OnNext(function(arg_37_0)
		arg_34_0:ClearOnNext()
		arg_34_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_38_0)
	arg_38_0:InstEffectAction({
		delayTime = 2,
		createMode = "Point",
		destroyMode = "DelayTime",
		pointTag = "liuhan",
		path = "QWWorld/Effect/EmotionBubble/fx_liuhan_1801_QW.prefab"
	})
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11166007, "", 0)
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
	arg_38_0:OnNext(function(arg_41_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_42_0)
	arg_42_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11166008, "", 0)
	arg_42_0:SetNeedSkip(true, {
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
		arg_47_0:EnableCameraByTagAction("", 1, 0)
		arg_47_0:HideAllDynamicAction(false, false, 4081, {
			410016
		})
		arg_47_0:DestroyCharAction(9073)
		arg_47_0:DestroyCharAction(9520)
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
