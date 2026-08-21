BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11191", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11191"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11191"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9535, "9535", function()
			return
		end)
		arg_5_0:SetCharToTagAction(907301, "907301", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
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
	arg_11_0:PlayActorAnimationAction(9535, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11191001, "", 0)
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
	arg_16_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11191002, "", 0)
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
	arg_21_0:SetTalkContent(11191003, "", 0)
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
	arg_25_0:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_25_0:ShowTalkView()
	arg_25_0:SetTalkContent(11191004, "", 0)
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
	arg_30_0:PlayActorAnimationAction(9535, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11191005, "", 0)
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
	arg_30_0:OnNext(function(arg_34_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_35_0)
	arg_35_0:PlayActorAnimationAction(907301, "think_end", 0.05, 1.666667, function()
		return
	end)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11191006, "", 0)
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
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11191007, "", 0)
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
		arg_40_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_44_0)
	arg_44_0:PlayActorAnimationAction(9535, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11191008, "", 0)
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
		arg_44_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_49_0)
	arg_49_0:PlayActorAnimationAction(907301, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	arg_49_0:ShowTalkView()
	arg_49_0:SetTalkContent(11191009, "", 0)
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
		arg_49_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_54_0)
	arg_54_0:ShowTalkView()
	arg_54_0:SetTalkContent(11191010, "", 0)
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
	arg_54_0:OnNext(function(arg_57_0)
		arg_54_0:ClearOnNext()
		arg_54_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_58_0)
	arg_58_0:ShowTalkView()
	arg_58_0:SetTalkContent(11191011, "", 0)
	arg_58_0:SetNeedSkip(true, {
		Invoke = function()
			arg_58_0:Skip("End")
		end
	})
	arg_58_0:SetNeedClick(true, {
		Invoke = function()
			arg_58_0:Next()
		end
	})
	arg_58_0:OnNext(function(arg_61_0)
		arg_58_0:ClearOnNext()
		arg_58_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_62_0)
	arg_62_0:PlayActorAnimationAction(907301, "firm_end", 0.05, 0.5000001, function()
		return
	end)
	arg_62_0:ShowTalkView()
	arg_62_0:SetTalkContent(11191012, "", 0)
	arg_62_0:SetNeedSkip(true, {
		Invoke = function()
			arg_62_0:Skip("End")
		end
	})
	arg_62_0:SetNeedClick(true, {
		Invoke = function()
			arg_62_0:Next()
		end
	})
	arg_62_0:OnNext(function(arg_66_0)
		arg_62_0:ClearOnNext()
		arg_62_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_67_0)
	arg_67_0:PlayActorAnimationAction(9535, "stroke02", 0.05, 5.166667, function()
		return
	end)
	arg_67_0:ShowTalkView()
	arg_67_0:SetTalkContent(11191013, "", 0)
	arg_67_0:SetNeedSkip(true, {
		Invoke = function()
			arg_67_0:Skip("End")
		end
	})
	arg_67_0:SetNeedClick(true, {
		Invoke = function()
			arg_67_0:Next()
		end
	})
	arg_67_0:OnNext(function(arg_71_0)
		arg_67_0:ClearOnNext()
		arg_67_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_72_0)
	arg_72_0:PlayActorAnimationAction(907301, "take", 0.05, 1.833333, function()
		return
	end)
	arg_72_0:ShowTalkView()
	arg_72_0:SetTalkContent(11191014, "", 0)
	arg_72_0:SetNeedSkip(true, {
		Invoke = function()
			arg_72_0:Skip("End")
		end
	})
	arg_72_0:SetNeedClick(true, {
		Invoke = function()
			arg_72_0:Next()
		end
	})
	arg_72_0:OnNext(function(arg_76_0)
		arg_72_0:ClearOnNext()
		arg_72_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_77_0)
	arg_77_0:PlayActorAnimationAction(9535, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_77_0:ShowTalkView()
	arg_77_0:SetTalkContent(11191015, "", 0)
	arg_77_0:SetNeedSkip(true, {
		Invoke = function()
			arg_77_0:Skip("End")
		end
	})
	arg_77_0:SetNeedClick(true, {
		Invoke = function()
			arg_77_0:Next()
		end
	})
	arg_77_0:OnNext(function(arg_81_0)
		arg_77_0:ClearOnNext()
		arg_77_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_82_0)
	arg_82_0:ShowTalkView()
	arg_82_0:SetTalkContent(11191016, "", 0)
	arg_82_0:SetNeedSkip(true, {
		Invoke = function()
			arg_82_0:Skip("End")
		end
	})
	arg_82_0:SetNeedClick(true, {
		Invoke = function()
			arg_82_0:Next()
		end
	})
	arg_82_0:OnNext(function(arg_85_0)
		arg_82_0:ClearOnNext()
		arg_82_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_86_0)
	arg_86_0:PlayActorAnimationAction(907301, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_86_0:ShowTalkView()
	arg_86_0:SetTalkContent(11191017, "", 0)
	arg_86_0:SetNeedSkip(true, {
		Invoke = function()
			arg_86_0:Skip("End")
		end
	})
	arg_86_0:SetNeedClick(true, {
		Invoke = function()
			arg_86_0:Next()
		end
	})
	arg_86_0:OnNext(function(arg_90_0)
		arg_86_0:ClearOnNext()
		arg_86_0:BlackFadeDialogueNode_19()
	end)
end

function var_0_0.BlackFadeDialogueNode_19(arg_91_0)
	arg_91_0:HideTalkView()
	arg_91_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_91_0:EnableCameraByTagAction("", 1, 0)
		arg_91_0:HideAllDynamicAction(false, false, 4081, {
			430001
		})
		arg_91_0:DestroyCharAction(907301)
		arg_91_0:DestroyCharAction(9535)
		arg_91_0:ContinueBlackFade()
		arg_91_0:OnNext(function()
			arg_91_0:ClearOnNext()
			arg_91_0:CloseStoryEventNode_20()
		end)
	end, function()
		arg_91_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_20(arg_95_0)
	arg_95_0:EnableCameraCutAction(false)
	arg_95_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_96_0)
	arg_96_0:RegisterTalkFunction("End", arg_96_0.CloseStoryEventNode_20)
end

return var_0_0
