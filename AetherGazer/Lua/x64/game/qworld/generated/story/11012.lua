BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11012", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11012"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11012"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
		arg_5_0:SetCharToTagAction(9523, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "3", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_12_0)
	arg_12_0:PlayActorAnimationAction(9523, "angry01", 0, 4.333333, function()
		return
	end)
	arg_12_0:PlayActorEmoteAction(9523, "complaint02_start", 0, 0.4, function()
		return
	end, true, true)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(11012001, "", 0)
	arg_12_0:SetNeedSkip(true, {
		Invoke = function()
			arg_12_0:Skip("End")
		end
	})
	arg_12_0:SetNeedClick(true, {
		Invoke = function()
			arg_12_0:Next()
		end
	})
	arg_12_0:OnNext(function(arg_17_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_18_0)
	arg_18_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_18_0:PlayActorAnimationAction(9073, "summer_doubt", 0, 2, function()
		return
	end)
	arg_18_0:ShowTalkView()
	arg_18_0:SetTalkContent(11012002, "", 0)
	arg_18_0:SetNeedSkip(true, {
		Invoke = function()
			arg_18_0:Skip("End")
		end
	})
	arg_18_0:SetNeedClick(true, {
		Invoke = function()
			arg_18_0:Next()
		end
	})
	arg_18_0:OnNext(function(arg_22_0)
		arg_18_0:ClearOnNext()
		arg_18_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_23_0)
	arg_23_0:EnableCameraByTagAction("3", 1, 0)
	arg_23_0:PlayActorEmoteAction(9523, "complaint02_end", 0, 0.5000001, function()
		return
	end, true, true)
	arg_23_0:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_23_0:CameraMoveAction("3", 4, 4, 6, 0.4)
	arg_23_0:SetLookAtParamsAction(9523, 0.8, 1, 1)
	arg_23_0:LookAtRoleAction(true, 9523, "9073")
	arg_23_0:ShowTalkView()
	arg_23_0:SetTalkContent(11012003, "", 0)
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
	arg_23_0:OnNext(function(arg_28_0)
		arg_23_0:ClearOnNext()
		arg_23_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_29_0)
	arg_29_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_29_0:PlayActorAnimationAction(9073, "win", 0, 1.933333, function()
		return
	end)
	arg_29_0:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(11012004, "", 0)
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
	arg_29_0:OnNext(function(arg_34_0)
		arg_29_0:ClearOnNext()
		arg_29_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_35_0)
	arg_35_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_35_0:PlayActorAnimationAction(9523, "happy01", 0, 2.333333, function()
		arg_35_0:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
			return
		end)
	end)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11012005, "", 0)
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
	arg_35_0:OnNext(function(arg_40_0)
		arg_35_0:ClearOnNext()
		arg_35_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_41_0)
	arg_41_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_41_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_41_0:LookAtRoleAction(true, 9073, "9074")
	arg_41_0:PlayActorEmoteAction(9073, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_41_0:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
		return
	end)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(11012006, "", 0)
	arg_41_0:SetNeedSkip(true, {
		Invoke = function()
			arg_41_0:Skip("End")
		end
	})
	arg_41_0:SetNeedClick(true, {
		Invoke = function()
			arg_41_0:Next()
		end
	})
	arg_41_0:OnNext(function(arg_46_0)
		arg_41_0:ClearOnNext()
		arg_41_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_47_0)
	arg_47_0:PlayActorAnimationAction(9074, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_47_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_47_0:LookAtRoleAction(true, 9074, "9073")
	arg_47_0:PlayActorEmoteAction(9074, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11012007, "", 0)
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
	arg_47_0:OnNext(function(arg_52_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_53_0)
	arg_53_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_53_0:PlayActorAnimationAction(9074, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_53_0:PlayActorEmoteAction(9523, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_53_0:SetLookAtParamsAction(9523, 0.8, 1, 1)
	arg_53_0:LookAtRoleAction(true, 9523, "9074")
	arg_53_0:ShowTalkView()
	arg_53_0:SetTalkContent(11012008, "", 0)
	arg_53_0:SetNeedSkip(true, {
		Invoke = function()
			arg_53_0:Skip("End")
		end
	})
	arg_53_0:SetNeedClick(true, {
		Invoke = function()
			arg_53_0:Next()
		end
	})
	arg_53_0:OnNext(function(arg_58_0)
		arg_53_0:ClearOnNext()
		arg_53_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_59_0)
	arg_59_0:EnableCameraByTagAction("3", 1, 0)
	arg_59_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_59_0:LookAtRoleAction(true, 9073, "9523")
	arg_59_0:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	arg_59_0:CameraMoveAction("3", 4, 3, 6, 0.4)
	arg_59_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_59_0:LookAtRoleAction(true, 9074, "9523")
	arg_59_0:ShowTalkView()
	arg_59_0:SetTalkContent(11012009, "", 0)
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
		arg_59_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_64_0)
	arg_64_0:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_64_0:SetLookAtParamsAction(9523, 0.8, 1, 1)
	arg_64_0:LookAtRoleAction(true, 9523, "9073")
	arg_64_0:ShowTalkView()
	arg_64_0:SetTalkContent(11012010, "", 0)
	arg_64_0:SetNeedSkip(true, {
		Invoke = function()
			arg_64_0:Skip("End")
		end
	})
	arg_64_0:SetNeedClick(true, {
		Invoke = function()
			arg_64_0:Next()
		end
	})
	arg_64_0:OnNext(function(arg_68_0)
		arg_64_0:ClearOnNext()
		arg_64_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_69_0)
	arg_69_0:PlayActorAnimationAction(9523, "proud", 0, 2.333333, function()
		return
	end)
	arg_69_0:SetLookAtParamsAction(9523, 0.8, 1, 1)
	arg_69_0:LookAtRoleAction(true, 9523, "9074")
	arg_69_0:ShowTalkView()
	arg_69_0:SetTalkContent(11012011, "", 0)
	arg_69_0:SetNeedSkip(true, {
		Invoke = function()
			arg_69_0:Skip("End")
		end
	})
	arg_69_0:SetNeedClick(true, {
		Invoke = function()
			arg_69_0:Next()
		end
	})
	arg_69_0:OnNext(function(arg_73_0)
		arg_69_0:ClearOnNext()
		arg_69_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_74_0)
	arg_74_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_74_0:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	arg_74_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_74_0:LookAtRoleAction(true, 9074, "9523")
	arg_74_0:PlayActorEmoteAction(9073, "", 0, 0, function()
		return
	end, false, false)
	arg_74_0:PlayActorEmoteAction(9074, "", 0, 0, function()
		return
	end, false, false)
	arg_74_0:ShowTalkView()
	arg_74_0:SetTalkContent(11012012, "", 0)
	arg_74_0:SetNeedSkip(true, {
		Invoke = function()
			arg_74_0:Skip("End")
		end
	})
	arg_74_0:SetNeedClick(true, {
		Invoke = function()
			arg_74_0:Next()
		end
	})
	arg_74_0:OnNext(function(arg_80_0)
		arg_74_0:ClearOnNext()
		arg_74_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_81_0)
	arg_81_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_81_0:PlayActorAnimationAction(9523, "take", 0, 1.833333, function()
		return
	end)
	arg_81_0:ShowTalkView()
	arg_81_0:SetTalkContent(11012013, "", 0)
	arg_81_0:SetNeedSkip(true, {
		Invoke = function()
			arg_81_0:Skip("End")
		end
	})
	arg_81_0:SetNeedClick(true, {
		Invoke = function()
			arg_81_0:Next()
		end
	})
	arg_81_0:OnNext(function(arg_85_0)
		arg_81_0:ClearOnNext()
		arg_81_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_86_0)
	arg_86_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_86_0:PlayActorAnimationAction(9073, "summer_doubt", 0, 2, function()
		return
	end)
	arg_86_0:ShowTalkView()
	arg_86_0:SetTalkContent(11012014, "", 0)
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
		arg_86_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_91_0)
	arg_91_0:EnableCameraByTagAction("4", 1, 0)
	arg_91_0:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_91_0:ShowTalkView()
	arg_91_0:SetTalkContent(11012015, "", 0)
	arg_91_0:SetNeedSkip(true, {
		Invoke = function()
			arg_91_0:Skip("End")
		end
	})
	arg_91_0:SetNeedClick(true, {
		Invoke = function()
			arg_91_0:Next()
		end
	})
	arg_91_0:OnNext(function(arg_95_0)
		arg_91_0:ClearOnNext()
		arg_91_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_96_0)
	arg_96_0:ShowTalkView()
	arg_96_0:SetTalkContent(11012016, "", 0)
	arg_96_0:SetNeedSkip(true, {
		Invoke = function()
			arg_96_0:Skip("End")
		end
	})
	arg_96_0:SetNeedClick(true, {
		Invoke = function()
			arg_96_0:Next()
		end
	})
	arg_96_0:OnNext(function(arg_99_0)
		arg_96_0:ClearOnNext()
		arg_96_0:BlackFadeDialogueNode_18()
	end)
end

function var_0_0.BlackFadeDialogueNode_18(arg_100_0)
	arg_100_0:HideTalkView()
	arg_100_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_100_0:DestroyCharAction(9073)
		arg_100_0:EnableCameraByTagAction("", 1, 0)
		arg_100_0:DestroyCharAction(9074)
		arg_100_0:DestroyCharAction(9523)
		arg_100_0:HideAllDynamicAction(false, false, 4095, {})
		arg_100_0:ContinueBlackFade()
		arg_100_0:OnNext(function()
			arg_100_0:ClearOnNext()
			arg_100_0:CloseStoryEventNode_19()
		end)
	end, function()
		arg_100_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_19(arg_104_0)
	arg_104_0:EnableCameraCutAction(false)
	arg_104_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_105_0)
	arg_105_0:RegisterTalkFunction("End", arg_105_0.BlackFadeDialogueNode_18)
	arg_105_0:RegisterTalkFunction("End", arg_105_0.CloseStoryEventNode_19)
end

return var_0_0
