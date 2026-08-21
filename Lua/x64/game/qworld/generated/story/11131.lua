BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11131", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11131"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11131"
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
		arg_5_0:HideAllDynamicAction(true, true, 4081, {
			390001
		})
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
	arg_11_0:PlayActorAnimationAction(907301, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11131001, "", 9073)
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
	arg_16_0:PlayActorAnimationAction(9521, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11131002, "", 9521)
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
	arg_21_0:PlayActorAnimationAction(907301, "take", 0.05, 1.833333, function()
		return
	end)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11131003, "", 9073)
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
	arg_26_0:PlayActorAnimationAction(9521, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(11131004, "", 9521)
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
	arg_31_0:SetTalkContent(11131005, "", 9073)
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
	arg_35_0:PlayActorAnimationAction(9521, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11131006, "", 9521)
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
	arg_40_0:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11131007, "", 9073)
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
	arg_40_0:OnNext(function(arg_44_0)
		arg_40_0:ClearOnNext()
		arg_40_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_45_0)
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(11131008, "", 9521)
	arg_45_0:SetNeedSkip(true, {
		Invoke = function()
			arg_45_0:Skip("End")
		end
	})
	arg_45_0:SetNeedClick(true, {
		Invoke = function()
			arg_45_0:Next()
		end
	})
	arg_45_0:OnNext(function(arg_48_0)
		arg_45_0:ClearOnNext()
		arg_45_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_49_0)
	arg_49_0:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_49_0:ShowTalkView()
	arg_49_0:SetTalkContent(11131009, "", 9073)
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
	arg_54_0:PlayActorAnimationAction(907301, "think_end", 0.05, 1.666667, function()
		return
	end)
	arg_54_0:ShowTalkView()
	arg_54_0:SetTalkContent(11131010, "", 9073)
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
		arg_54_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_59_0)
	arg_59_0:ShowTalkView()
	arg_59_0:SetTalkContent(11131011, "", 9521)
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
	arg_59_0:OnNext(function(arg_62_0)
		arg_59_0:ClearOnNext()
		arg_59_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_63_0)
	arg_63_0:ShowTalkView()
	arg_63_0:SetTalkContent(11131012, "", 9073)
	arg_63_0:SetNeedSkip(true, {
		Invoke = function()
			arg_63_0:Skip("End")
		end
	})
	arg_63_0:SetNeedClick(true, {
		Invoke = function()
			arg_63_0:Next()
		end
	})
	arg_63_0:OnNext(function(arg_66_0)
		arg_63_0:ClearOnNext()
		arg_63_0:BlackFadeDialogueNode_14()
	end)
end

function var_0_0.BlackFadeDialogueNode_14(arg_67_0)
	arg_67_0:HideTalkView()
	arg_67_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_67_0:HideAllDynamicAction(false, false, 4081, {
			390001
		})
		arg_67_0:EnableCameraByTagAction("", 1, 0)
		arg_67_0:DestroyCharAction(907301)
		arg_67_0:DestroyCharAction(9521)
		arg_67_0:ContinueBlackFade()
		arg_67_0:OnNext(function()
			arg_67_0:ClearOnNext()
			arg_67_0:CloseStoryEventNode_15()
		end)
	end, function()
		arg_67_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_15(arg_71_0)
	arg_71_0:EnableCameraCutAction(false)
	arg_71_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_72_0)
	arg_72_0:RegisterTalkFunction("End", arg_72_0.CloseStoryEventNode_15)
end

return var_0_0
