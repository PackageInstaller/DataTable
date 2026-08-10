BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11270", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11270"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11270"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9521, "9521", function()
			return
		end)
		arg_5_0:SetCharToTagAction(907301, "9073", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {
			420004
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
	arg_11_0:PlayActorAnimationAction(9521, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11170001, "", 9521)
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
	arg_16_0:PlayActorAnimationAction(907301, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11170002, "", 9073)
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
	arg_21_0:SetTalkContent(11170003, "", 0)

	local var_21_0 = {
		[0] = {
			id = 11170004,
			icon = "",
			Invoke = function()
				arg_21_0:Next(11170004)
			end
		},
		{
			id = 11170005,
			icon = "",
			Invoke = function()
				arg_21_0:Next(11170005)
			end
		},
		Length = 2
	}

	arg_21_0:SetChoice(var_21_0, false)
	arg_21_0:SetNeedSkip(false, nil)
	arg_21_0:SetNeedClick(false, nil)
	arg_21_0:OnNext(function(arg_24_0)
		arg_21_0:ClearOnNext()
		arg_21_0:CloseChoice()

		if arg_24_0 == 11170004 then
			arg_21_0:DialogueBranchNode_5()
		elseif arg_24_0 == 11170005 then
			arg_21_0:DialogueBranchNode_6()
		end
	end)
end

function var_0_0.DialogueBranchNode_5(arg_25_0)
	arg_25_0:OnNext(function()
		arg_25_0:ClearOnNext()
		arg_25_0:DialogueNode_7()
	end)
	arg_25_0:Next()
end

function var_0_0.DialogueNode_7(arg_27_0)
	arg_27_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11170006, "", 0)
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
		arg_27_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_32_0)
	arg_32_0:PlayActorAnimationAction(9521, "speechless_start", 0.05, 0.5333334, function()
		return
	end)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11170007, "", 0)
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
	arg_32_0:OnNext(function(arg_36_0)
		arg_32_0:ClearOnNext()
		arg_32_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_37_0)
	arg_37_0:PlayActorAnimationAction(907301, "summer_shock", 0.05, 1.166667, function()
		return
	end)
	arg_37_0:ShowTalkView()
	arg_37_0:SetTalkContent(11170008, "", 0)
	arg_37_0:SetNeedSkip(true, {
		Invoke = function()
			arg_37_0:Skip("End")
		end
	})
	arg_37_0:SetNeedClick(true, {
		Invoke = function()
			arg_37_0:Next()
		end
	})
	arg_37_0:OnNext(function(arg_41_0)
		arg_37_0:ClearOnNext()
		arg_37_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_42_0)
	arg_42_0:PlayActorAnimationAction(9521, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11170009, "", 0)
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
		arg_42_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_47_0)
	arg_47_0:PlayActorAnimationAction(9521, "action2_3", 0.05, 1.333333, function()
		return
	end)
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11170010, "", 0)
	arg_47_0:SetNeedSkip(true, {
		Invoke = function()
			arg_47_0:Skip("End")
		end
	})
	arg_47_0:SetNeedClick(true, {
		Invoke = function()
			arg_47_0:Next()
		end
	})
	arg_47_0:OnNext(function(arg_51_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_52_0)
	arg_52_0:PlayActorAnimationAction(907301, "summer_shock", 0.05, 1.166667, function()
		return
	end)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11170011, "", 0)
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
		arg_52_0:BlackFadeDialogueNode_13()
	end)
end

function var_0_0.BlackFadeDialogueNode_13(arg_57_0)
	arg_57_0:HideTalkView()
	arg_57_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_57_0:EnableCameraByTagAction("", 1, 0)
		arg_57_0:HideAllDynamicAction(false, false, 4081, {
			420004
		})
		arg_57_0:DestroyCharAction(907301)
		arg_57_0:DestroyCharAction(9521)
		arg_57_0:ContinueBlackFade()
		arg_57_0:OnNext(function()
			arg_57_0:ClearOnNext()
			arg_57_0:CloseStoryEventNode_14()
		end)
	end, function()
		arg_57_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_14(arg_61_0)
	arg_61_0:EnableCameraCutAction(false)
	arg_61_0:EndStory()
end

function var_0_0.DialogueBranchNode_6(arg_62_0)
	arg_62_0:OnNext(function()
		arg_62_0:ClearOnNext()
		arg_62_0:DialogueNode_7()
	end)
	arg_62_0:Next()
end

function var_0_0.RegisterFuncMap(arg_64_0)
	arg_64_0:RegisterTalkFunction("End", arg_64_0.CloseStoryEventNode_14)
end

return var_0_0
