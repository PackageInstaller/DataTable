BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11211", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11211"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11211"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(907301, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(951801, "1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
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
	arg_11_0:PlayActorAnimationAction(951801, "sad_03", 0, 9.533334, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11111001, "", 9518)
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
	arg_16_0:PlayActorAnimationAction(907301, "conversation_1", 0, 3, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11111002, "", 9073)
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
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11111003, "", 9518)
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
	arg_21_0:OnNext(function(arg_24_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_25_0)
	arg_25_0:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_25_0:ShowTalkView()
	arg_25_0:SetTalkContent(11111004, "", 9073)
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
	arg_25_0:OnNext(function(arg_29_0)
		arg_25_0:ClearOnNext()
		arg_25_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_30_0)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11111005, "", 9518)
	arg_30_0:SetNeedSkip(true, {
		Invoke = function()
			arg_30_0:Skip("End")
		end
	})
	arg_30_0:SetNeedClick(true, {
		Invoke = function()
			arg_30_0:Next()
		end
	})
	arg_30_0:OnNext(function(arg_33_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_34_0)
	arg_34_0:PlayActorAnimationAction(951801, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_34_0:ShowTalkView()
	arg_34_0:SetTalkContent(11111006, "", 9518)
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
	arg_34_0:OnNext(function(arg_38_0)
		arg_34_0:ClearOnNext()
		arg_34_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_39_0)
	arg_39_0:ShowTalkView()
	arg_39_0:SetTalkContent(11111007, "", 9073)
	arg_39_0:SetNeedSkip(true, {
		Invoke = function()
			arg_39_0:Skip("End")
		end
	})
	arg_39_0:SetNeedClick(true, {
		Invoke = function()
			arg_39_0:Next()
		end
	})
	arg_39_0:OnNext(function(arg_42_0)
		arg_39_0:ClearOnNext()
		arg_39_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_43_0)
	arg_43_0:PlayActorAnimationAction(951801, "sad_02", 0.05, 6.733334, function()
		return
	end)
	arg_43_0:ShowTalkView()
	arg_43_0:SetTalkContent(11111008, "", 9518)
	arg_43_0:SetNeedSkip(true, {
		Invoke = function()
			arg_43_0:Skip("End")
		end
	})
	arg_43_0:SetNeedClick(true, {
		Invoke = function()
			arg_43_0:Next()
		end
	})
	arg_43_0:OnNext(function(arg_47_0)
		arg_43_0:ClearOnNext()
		arg_43_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_48_0)
	arg_48_0:PlayActorAnimationAction(907301, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_48_0:ShowTalkView()
	arg_48_0:SetTalkContent(11111009, "", 9073)
	arg_48_0:SetNeedSkip(true, {
		Invoke = function()
			arg_48_0:Skip("End")
		end
	})
	arg_48_0:SetNeedClick(true, {
		Invoke = function()
			arg_48_0:Next()
		end
	})
	arg_48_0:OnNext(function(arg_52_0)
		arg_48_0:ClearOnNext()
		arg_48_0:BlackFadeDialogueNode_11()
	end)
end

function var_0_0.BlackFadeDialogueNode_11(arg_53_0)
	arg_53_0:HideTalkView()
	arg_53_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_53_0:DestroyCharAction(907301)
		arg_53_0:DestroyCharAction(951801)
		arg_53_0:EnableCameraByTagAction("", 1, 0)
		arg_53_0:HideAllDynamicAction(false, false, 4083, {})
		arg_53_0:ContinueBlackFade()
		arg_53_0:OnNext(function()
			arg_53_0:ClearOnNext()
			arg_53_0:CloseStoryEventNode_12()
		end)
	end, function()
		arg_53_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_12(arg_57_0)
	arg_57_0:EnableCameraCutAction(false)
	arg_57_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_58_0)
	arg_58_0:RegisterTalkFunction("End", arg_58_0.CloseStoryEventNode_12)
end

return var_0_0
