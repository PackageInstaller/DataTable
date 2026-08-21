BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11022", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11022"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11022"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:SetCharToTagAction(9510, "3", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9515, "4", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:ActorSeekerAction(9073, {
			"6"
		}, 0.5, function()
			return
		end)
		arg_5_0:PlayActorAnimationAction(9515, "speechless_start", 0.05, 0.5333334, function()
			return
		end)
		arg_5_0:DelayTimeAction(0.2, function()
			arg_5_0:ActorSeekerAction(9510, {
				"7"
			}, 0.5, function()
				return
			end)
		end)
		arg_5_0:SetCharToTagAction(9072, "1", function()
			return
		end)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_17_0)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11022001, "", 9073)
	arg_17_0:SetNeedSkip(true, {
		Invoke = function()
			arg_17_0:Skip("End")
		end
	})
	arg_17_0:SetNeedClick(true, {
		Invoke = function()
			arg_17_0:Next()
		end
	})
	arg_17_0:OnNext(function(arg_20_0)
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_21_0)
	arg_21_0:EnableCameraByTagAction("2", 1, 0)
	arg_21_0:ActorSeekerAction(9072, {
		"8"
	}, 0.5, function()
		arg_21_0:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
			return
		end)
		arg_21_0:PlayActorEmoteAction(9072, "complaint02", 0, 1.466667, function()
			return
		end, true, false)
	end)
	arg_21_0:CameraMoveAction("2", 4, 3, 5, 0.5)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11022002, "", 9072)
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
	arg_21_0:OnNext(function(arg_27_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_28_0)
	arg_28_0:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_28_0:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_28_0:ShowTalkView()
	arg_28_0:SetTalkContent(11022003, "", 9073)
	arg_28_0:SetNeedSkip(true, {
		Invoke = function()
			arg_28_0:Skip("End")
		end
	})
	arg_28_0:SetNeedClick(true, {
		Invoke = function()
			arg_28_0:Next()
		end
	})
	arg_28_0:OnNext(function(arg_33_0)
		arg_28_0:ClearOnNext()
		arg_28_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_34_0)
	arg_34_0:EnableCameraByTagAction("4", 1, 0)
	arg_34_0:CameraMoveAction("4", 4, 1, 5, 0.5)
	arg_34_0:ShowTalkView()
	arg_34_0:SetTalkContent(11022004, "", 9510)
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
		arg_34_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_38_0)
	arg_38_0:EnableCameraByTagAction("5", 1, 0)
	arg_38_0:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_38_0:CameraMoveAction("5", 4, 6, 5, 0.3)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11022005, "", 9072)
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
	arg_38_0:OnNext(function(arg_42_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_43_0)
	arg_43_0:EnableCameraByTagAction("6", 1, 0)
	arg_43_0:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_43_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_43_0:LookAtRoleAction(true, 9073, "9072")
	arg_43_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_43_0:LookAtRoleAction(true, 9510, "9072")
	arg_43_0:ShowTalkView()
	arg_43_0:SetTalkContent(11022006, "", 9073)
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
		arg_43_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_48_0)
	arg_48_0:PlayActorAnimationAction(9510, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_48_0:ShowTalkView()
	arg_48_0:SetTalkContent(11022007, "", 9510)
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
		arg_48_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_53_0)
	arg_53_0:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_53_0:ActorSeekerAction(9072, {
		"5"
	}, 0.7, function()
		arg_53_0:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
			return
		end)
	end)
	arg_53_0:DelayTimeAction(1, function()
		arg_53_0:EnableCameraByTagAction("8", 1, 0)
	end)
	arg_53_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_53_0:PlayActorEmoteAction(9510, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_53_0:SetCharToTagAction(9515, "9", function()
		return
	end)
	arg_53_0:DelayTimeAction(2.8, function()
		arg_53_0:SetNeedClick(true, {
			Invoke = function()
				arg_53_0:Next()
			end
		})
		arg_53_0:SetNeedSkip(false, nil)
	end)
	arg_53_0:ShowTalkView()
	arg_53_0:SetTalkContent(11022008, "", 9072)
	arg_53_0:SetNeedSkip(true, {
		Invoke = function()
			arg_53_0:Skip("End")
		end
	})
	arg_53_0:SetNeedClick(false, {
		Invoke = function()
			arg_53_0:Next()
		end
	})
	arg_53_0:OnNext(function(arg_65_0)
		arg_53_0:ClearOnNext()
		arg_53_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_66_0)
	arg_66_0:PlayActorEmoteAction(9073, "complaint02_start", 0, 0.4, function()
		return
	end, true, true)
	arg_66_0:ActorSeekerAction(9073, {
		"10"
	}, 2.5, function()
		arg_66_0:PlayActorAnimationAction(9073, "angry01", 0.05, 4.333333, function()
			return
		end)
	end)
	arg_66_0:ActorSeekerAction(9510, {
		"11"
	}, 2.5, function()
		return
	end)
	arg_66_0:ShowTalkView()
	arg_66_0:SetTalkContent(11022009, "", 9073)
	arg_66_0:SetNeedSkip(true, {
		Invoke = function()
			arg_66_0:Skip("End")
		end
	})
	arg_66_0:SetNeedClick(true, {
		Invoke = function()
			arg_66_0:Next()
		end
	})
	arg_66_0:OnNext(function(arg_73_0)
		arg_66_0:ClearOnNext()
		arg_66_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_74_0)
	arg_74_0:PlayActorAnimationAction(9515, "stand_female", 0, 4, function()
		return
	end)
	arg_74_0:PlayActorEmoteAction(9072, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	arg_74_0:CameraMoveAction("10", 4, 6, 5, 0.2)
	arg_74_0:EnableCameraByTagAction("10", 1, 0)
	arg_74_0:DelayTimeAction(2, function()
		arg_74_0:SetNeedClick(true, {
			Invoke = function()
				arg_74_0:Next()
			end
		})
		arg_74_0:SetNeedSkip(true, {
			Invoke = function()
				arg_74_0:Skip("End")
			end
		})
	end)
	arg_74_0:ShowTalkView()
	arg_74_0:SetTalkContent(11022010, "", 9072)
	arg_74_0:SetNeedSkip(true, {
		Invoke = function()
			arg_74_0:Skip("End")
		end
	})
	arg_74_0:SetNeedClick(false, {
		Invoke = function()
			arg_74_0:Next()
		end
	})
	arg_74_0:OnNext(function(arg_82_0)
		arg_74_0:ClearOnNext()
		arg_74_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_83_0)
	arg_83_0:EnableCameraByTagAction("11", 1, 0)
	arg_83_0:PlayActorAnimationAction(9515, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_83_0:ShowTalkView()
	arg_83_0:SetTalkContent(11022011, "", 9515)
	arg_83_0:SetNeedSkip(true, {
		Invoke = function()
			arg_83_0:Skip("End")
		end
	})
	arg_83_0:SetNeedClick(true, {
		Invoke = function()
			arg_83_0:Next()
		end
	})
	arg_83_0:OnNext(function(arg_87_0)
		arg_83_0:ClearOnNext()
		arg_83_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_88_0)
	arg_88_0:EnableCameraByTagAction("12", 1, 0)
	arg_88_0:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_88_0:CameraMoveAction("12", 4, 4, 5, 0.4)
	arg_88_0:PlayActorAnimationAction(9073, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_88_0:PlayActorEmoteAction(9073, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	arg_88_0:ShowTalkView()
	arg_88_0:SetTalkContent(11022012, "", 9072)
	arg_88_0:SetNeedSkip(true, {
		Invoke = function()
			arg_88_0:Skip("End")
		end
	})
	arg_88_0:SetNeedClick(true, {
		Invoke = function()
			arg_88_0:Next()
		end
	})
	arg_88_0:OnNext(function(arg_94_0)
		arg_88_0:ClearOnNext()
		arg_88_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_95_0)
	arg_95_0:EnableCameraByTagAction("13", 1, 0)
	arg_95_0:PlayActorAnimationAction(9515, "speechless_start", 0.05, 0.5333334, function()
		return
	end)
	arg_95_0:PlayActorEmoteAction(9515, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_95_0:ShowTalkView()
	arg_95_0:SetTalkContent(11022013, "", 9515)
	arg_95_0:SetNeedSkip(true, {
		Invoke = function()
			arg_95_0:Skip("End")
		end
	})
	arg_95_0:SetNeedClick(true, {
		Invoke = function()
			arg_95_0:Next()
		end
	})
	arg_95_0:OnNext(function(arg_100_0)
		arg_95_0:ClearOnNext()
		arg_95_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_101_0)
	arg_101_0:EnableCameraByTagAction("14", 1, 0)
	arg_101_0:PlayActorAnimationAction(9072, "action2_3", 0.05, 1.333333, function()
		return
	end)
	arg_101_0:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_101_0:ShowTalkView()
	arg_101_0:SetTalkContent(11022014, "", 9072)
	arg_101_0:SetNeedSkip(true, {
		Invoke = function()
			arg_101_0:Skip("End")
		end
	})
	arg_101_0:SetNeedClick(true, {
		Invoke = function()
			arg_101_0:Next()
		end
	})
	arg_101_0:OnNext(function(arg_106_0)
		arg_101_0:ClearOnNext()
		arg_101_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_107_0)
	arg_107_0:EnableCameraByTagAction("15", 1, 0)
	arg_107_0:PlayActorAnimationAction(9515, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_107_0:ShowTalkView()
	arg_107_0:SetTalkContent(11022015, "", 9515)
	arg_107_0:SetNeedSkip(true, {
		Invoke = function()
			arg_107_0:Skip("End")
		end
	})
	arg_107_0:SetNeedClick(true, {
		Invoke = function()
			arg_107_0:Next()
		end
	})
	arg_107_0:OnNext(function(arg_111_0)
		arg_107_0:ClearOnNext()
		arg_107_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_112_0)
	arg_112_0:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_112_0:ShowTalkView()
	arg_112_0:SetTalkContent(11022016, "", 9072)
	arg_112_0:SetNeedSkip(true, {
		Invoke = function()
			arg_112_0:Skip("End")
		end
	})
	arg_112_0:SetNeedClick(true, {
		Invoke = function()
			arg_112_0:Next()
		end
	})
	arg_112_0:OnNext(function(arg_116_0)
		arg_112_0:ClearOnNext()
		arg_112_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_117_0)
	arg_117_0:EnableCameraByTagAction("13", 1, 0)
	arg_117_0:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_117_0:PlayActorEmoteAction(9515, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	arg_117_0:ShowTalkView()
	arg_117_0:SetTalkContent(11022017, "", 9515)
	arg_117_0:SetNeedSkip(true, {
		Invoke = function()
			arg_117_0:Skip("End")
		end
	})
	arg_117_0:SetNeedClick(true, {
		Invoke = function()
			arg_117_0:Next()
		end
	})
	arg_117_0:OnNext(function(arg_122_0)
		arg_117_0:ClearOnNext()
		arg_117_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_123_0)
	arg_123_0:EnableCameraByTagAction("14", 1, 0)
	arg_123_0:PlayActorEmoteAction(9072, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	arg_123_0:DelayTimeAction(1.5, function()
		arg_123_0:PlayActorAnimationAction(9072, "take", 0.05, 1.833333, function()
			return
		end)
	end)
	arg_123_0:ShowTalkView()
	arg_123_0:SetTalkContent(11022018, "", 9072)
	arg_123_0:SetNeedSkip(true, {
		Invoke = function()
			arg_123_0:Skip("End")
		end
	})
	arg_123_0:SetNeedClick(true, {
		Invoke = function()
			arg_123_0:Next()
		end
	})
	arg_123_0:OnNext(function(arg_129_0)
		arg_123_0:ClearOnNext()
		arg_123_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_130_0)
	arg_130_0:EnableCameraByTagAction("15", 1, 0)
	arg_130_0:PlayActorEmoteAction(9515, "shocked01", 0, 1.4, function()
		arg_130_0:PlayActorAnimationAction(9515, "summer_doubt", 0.05, 2, function()
			return
		end)
	end, true, false)
	arg_130_0:ShowTalkView()
	arg_130_0:SetTalkContent(11022019, "", 9515)
	arg_130_0:SetNeedSkip(true, {
		Invoke = function()
			arg_130_0:Skip("End")
		end
	})
	arg_130_0:SetNeedClick(true, {
		Invoke = function()
			arg_130_0:Next()
		end
	})
	arg_130_0:OnNext(function(arg_135_0)
		arg_130_0:ClearOnNext()
		arg_130_0:DialogueNode_21()
	end)
end

function var_0_0.DialogueNode_21(arg_136_0)
	arg_136_0:EnableCameraByTagAction("14", 1, 0)
	arg_136_0:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_136_0:ShowTalkView()
	arg_136_0:SetTalkContent(11022020, "", 9072)
	arg_136_0:SetNeedSkip(true, {
		Invoke = function()
			arg_136_0:Skip("End")
		end
	})
	arg_136_0:SetNeedClick(true, {
		Invoke = function()
			arg_136_0:Next()
		end
	})
	arg_136_0:OnNext(function(arg_140_0)
		arg_136_0:ClearOnNext()
		arg_136_0:DialogueNode_22()
	end)
end

function var_0_0.DialogueNode_22(arg_141_0)
	arg_141_0:EnableCameraByTagAction("11", 1, 0)
	arg_141_0:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_141_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_04_mingshi", "", "")
	arg_141_0:ShowTalkView()
	arg_141_0:SetTalkContent(11022021, "", 9515)
	arg_141_0:SetNeedSkip(true, {
		Invoke = function()
			arg_141_0:Skip("End")
		end
	})
	arg_141_0:SetNeedClick(true, {
		Invoke = function()
			arg_141_0:Next()
		end
	})
	arg_141_0:OnNext(function(arg_145_0)
		arg_141_0:ClearOnNext()
		arg_141_0:DialogueNode_23()
	end)
end

function var_0_0.DialogueNode_23(arg_146_0)
	arg_146_0:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_146_0:ShowTalkView()
	arg_146_0:SetTalkContent(11022022, "", 9072)
	arg_146_0:SetNeedSkip(true, {
		Invoke = function()
			arg_146_0:Skip("End")
		end
	})
	arg_146_0:SetNeedClick(true, {
		Invoke = function()
			arg_146_0:Next()
		end
	})
	arg_146_0:OnNext(function(arg_150_0)
		arg_146_0:ClearOnNext()
		arg_146_0:DialogueNode_24()
	end)
end

function var_0_0.DialogueNode_24(arg_151_0)
	arg_151_0:EnableCameraByTagAction("13", 1, 0)
	arg_151_0:PlayActorAnimationAction(9515, "think_loop", 0.05, 2, function()
		return
	end)
	arg_151_0:PlayActorEmoteAction(9515, "disdain01_start", 0, 0.4, function()
		return
	end, true, true)
	arg_151_0:ShowTalkView()
	arg_151_0:SetTalkContent(11022023, "", 9515)
	arg_151_0:SetNeedSkip(true, {
		Invoke = function()
			arg_151_0:Skip("End")
		end
	})
	arg_151_0:SetNeedClick(true, {
		Invoke = function()
			arg_151_0:Next()
		end
	})
	arg_151_0:OnNext(function(arg_156_0)
		arg_151_0:ClearOnNext()
		arg_151_0:DialogueNode_25()
	end)
end

function var_0_0.DialogueNode_25(arg_157_0)
	arg_157_0:EnableCameraByTagAction("24_1", 1, 0)
	arg_157_0:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_157_0:ShowTalkView()
	arg_157_0:SetTalkContent(11022024, "", 9072)
	arg_157_0:SetNeedSkip(true, {
		Invoke = function()
			arg_157_0:Skip("End")
		end
	})
	arg_157_0:SetNeedClick(true, {
		Invoke = function()
			arg_157_0:Next()
		end
	})
	arg_157_0:OnNext(function(arg_161_0)
		arg_157_0:ClearOnNext()
		arg_157_0:DialogueNode_26()
	end)
end

function var_0_0.DialogueNode_26(arg_162_0)
	arg_162_0:EnableCameraByTagAction("15", 1, 0)
	arg_162_0:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_162_0:PlayActorEmoteAction(9515, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	arg_162_0:ShowTalkView()
	arg_162_0:SetTalkContent(11022025, "", 9515)
	arg_162_0:SetNeedSkip(true, {
		Invoke = function()
			arg_162_0:Skip("End")
		end
	})
	arg_162_0:SetNeedClick(true, {
		Invoke = function()
			arg_162_0:Next()
		end
	})
	arg_162_0:OnNext(function(arg_167_0)
		arg_162_0:ClearOnNext()
		arg_162_0:DialogueNode_27()
	end)
end

function var_0_0.DialogueNode_27(arg_168_0)
	arg_168_0:EnableCameraByTagAction("24", 1, 0)
	arg_168_0:PlayActorAnimationAction(9072, "take", 0.05, 1.833333, function()
		return
	end)
	arg_168_0:ShowTalkView()
	arg_168_0:SetTalkContent(11022026, "", 9072)
	arg_168_0:SetNeedSkip(true, {
		Invoke = function()
			arg_168_0:Skip("End")
		end
	})
	arg_168_0:SetNeedClick(true, {
		Invoke = function()
			arg_168_0:Next()
		end
	})
	arg_168_0:OnNext(function(arg_172_0)
		arg_168_0:ClearOnNext()
		arg_168_0:DialogueNode_28()
	end)
end

function var_0_0.DialogueNode_28(arg_173_0)
	arg_173_0:PlayActorEmoteAction(9073, "disdain01_start", 0, 0.4, function()
		return
	end, true, true)
	arg_173_0:ShowTalkView()
	arg_173_0:SetTalkContent(11022027, "", 9515)
	arg_173_0:SetNeedSkip(true, {
		Invoke = function()
			arg_173_0:Skip("End")
		end
	})
	arg_173_0:SetNeedClick(true, {
		Invoke = function()
			arg_173_0:Next()
		end
	})
	arg_173_0:OnNext(function(arg_177_0)
		arg_173_0:ClearOnNext()
		arg_173_0:DialogueNode_29()
	end)
end

function var_0_0.DialogueNode_29(arg_178_0)
	arg_178_0:ShowTalkView()
	arg_178_0:SetTalkContent(11022028, "", 9073)
	arg_178_0:SetNeedSkip(true, {
		Invoke = function()
			arg_178_0:Skip("End")
		end
	})
	arg_178_0:SetNeedClick(true, {
		Invoke = function()
			arg_178_0:Next()
		end
	})
	arg_178_0:OnNext(function(arg_181_0)
		arg_178_0:ClearOnNext()
		arg_178_0:DialogueNode_30()
	end)
end

function var_0_0.DialogueNode_30(arg_182_0)
	arg_182_0:EnableCameraByTagAction("13", 1, 0)
	arg_182_0:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_182_0:PlayActorEmoteAction(9515, "disdain01_end", 0, 0.4333334, function()
		return
	end, true, false)
	arg_182_0:ShowTalkView()
	arg_182_0:SetTalkContent(11022029, "", 9515)
	arg_182_0:SetNeedSkip(true, {
		Invoke = function()
			arg_182_0:Skip("End")
		end
	})
	arg_182_0:SetNeedClick(true, {
		Invoke = function()
			arg_182_0:Next()
		end
	})
	arg_182_0:OnNext(function(arg_187_0)
		arg_182_0:ClearOnNext()
		arg_182_0:DialogueNode_31()
	end)
end

function var_0_0.DialogueNode_31(arg_188_0)
	arg_188_0:EnableCameraByTagAction("14", 1, 0)
	arg_188_0:PlayActorEmoteAction(9072, "shocked01", 0, 1.4, function()
		arg_188_0:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
			return
		end)
	end, true, false)
	arg_188_0:ShowTalkView()
	arg_188_0:SetTalkContent(11022030, "", 9072)
	arg_188_0:SetNeedSkip(true, {
		Invoke = function()
			arg_188_0:Skip("End")
		end
	})
	arg_188_0:SetNeedClick(true, {
		Invoke = function()
			arg_188_0:Next()
		end
	})
	arg_188_0:OnNext(function(arg_193_0)
		arg_188_0:ClearOnNext()
		arg_188_0:DialogueNode_32()
	end)
end

function var_0_0.DialogueNode_32(arg_194_0)
	arg_194_0:EnableCameraByTagAction("15", 1, 0)
	arg_194_0:PlayActorAnimationAction(9515, "think_loop", 0, 2, function()
		return
	end)
	arg_194_0:PlayActorEmoteAction(9515, "disdain01", 0, 1.566667, function()
		return
	end, true, false)
	arg_194_0:ShowTalkView()
	arg_194_0:SetTalkContent(11022031, "", 9515)
	arg_194_0:SetNeedSkip(true, {
		Invoke = function()
			arg_194_0:Skip("End")
		end
	})
	arg_194_0:SetNeedClick(true, {
		Invoke = function()
			arg_194_0:Next()
		end
	})
	arg_194_0:OnNext(function(arg_199_0)
		arg_194_0:ClearOnNext()
		arg_194_0:DialogueNode_33()
	end)
end

function var_0_0.DialogueNode_33(arg_200_0)
	arg_200_0:ActorSeekerAction(9072, {
		"22"
	}, 0.5, function()
		arg_200_0:PlayActorAnimationAction(9072, "take", 0.05, 1.833333, function()
			return
		end)
	end)
	arg_200_0:DelayTimeAction(1, function()
		arg_200_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
		arg_200_0:LookAtRoleAction(true, 9510, "9072")
		arg_200_0:EnableCameraByTagAction("32", 1, 0)
		arg_200_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
		arg_200_0:LookAtRoleAction(true, 9073, "9072")
	end)
	arg_200_0:ShowTalkView()
	arg_200_0:SetTalkContent(11022032, "", 9072)

	local var_200_0 = {
		[0] = {
			id = 11022033,
			icon = "",
			Invoke = function()
				arg_200_0:Next(11022033)
			end
		},
		{
			id = 11022034,
			icon = "",
			Invoke = function()
				arg_200_0:Next(11022034)
			end
		},
		Length = 2
	}

	arg_200_0:SetChoice(var_200_0, false)
	arg_200_0:SetNeedSkip(false, nil)
	arg_200_0:SetNeedClick(false, nil)
	arg_200_0:OnNext(function(arg_206_0)
		arg_200_0:ClearOnNext()
		arg_200_0:CloseChoice()

		if arg_206_0 == 11022033 then
			arg_200_0:DialogueBranchNode_34()
		elseif arg_206_0 == 11022034 then
			arg_200_0:DialogueBranchNode_35()
		end
	end)
end

function var_0_0.DialogueBranchNode_34(arg_207_0)
	arg_207_0:OnNext(function()
		arg_207_0:ClearOnNext()
		arg_207_0:PureActorDialogueNode_36()
	end)
	arg_207_0:Next()
end

function var_0_0.PureActorDialogueNode_36(arg_209_0)
	arg_209_0:EnableCameraByTagAction("33", 1, 0)
	arg_209_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_209_0:CameraMoveAction("33", 4, 1, 1, 0.35)
	arg_209_0:DelayTimeAction(2, function()
		arg_209_0:EventAction(function()
			arg_209_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_209_0:HideTalkView()
	arg_209_0:OnNext(function()
		arg_209_0:ClearOnNext()
		arg_209_0:DialogueNode_37()
	end)
end

function var_0_0.DialogueNode_37(arg_214_0)
	arg_214_0:EnableCameraByTagAction("35", 1, 0)
	arg_214_0:PlayActorAnimationAction(9072, "summer_doubt", 0.05, 2, function()
		arg_214_0:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	arg_214_0:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_214_0:ShowTalkView()
	arg_214_0:SetTalkContent(11022035, "", 9072)
	arg_214_0:SetNeedSkip(true, {
		Invoke = function()
			arg_214_0:Skip("End")
		end
	})
	arg_214_0:SetNeedClick(true, {
		Invoke = function()
			arg_214_0:Next()
		end
	})
	arg_214_0:OnNext(function(arg_220_0)
		arg_214_0:ClearOnNext()
		arg_214_0:DialogueNode_38()
	end)
end

function var_0_0.DialogueNode_38(arg_221_0)
	arg_221_0:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, false, false)
	arg_221_0:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_221_0:ShowTalkView()
	arg_221_0:SetTalkContent(11022036, "", 9073)
	arg_221_0:SetNeedSkip(true, {
		Invoke = function()
			arg_221_0:Skip("End")
		end
	})
	arg_221_0:SetNeedClick(true, {
		Invoke = function()
			arg_221_0:Next()
		end
	})
	arg_221_0:OnNext(function(arg_226_0)
		arg_221_0:ClearOnNext()
		arg_221_0:DialogueNode_39()
	end)
end

function var_0_0.DialogueNode_39(arg_227_0)
	arg_227_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_227_0:ShowTalkView()
	arg_227_0:SetTalkContent(11022037, "", 9510)
	arg_227_0:SetNeedSkip(true, {
		Invoke = function()
			arg_227_0:Skip("End")
		end
	})
	arg_227_0:SetNeedClick(true, {
		Invoke = function()
			arg_227_0:Next()
		end
	})
	arg_227_0:OnNext(function(arg_231_0)
		arg_227_0:ClearOnNext()
		arg_227_0:BlackFadeDialogueNode_40()
	end)
end

function var_0_0.BlackFadeDialogueNode_40(arg_232_0)
	arg_232_0:HideTalkView()
	arg_232_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_232_0:HideAllDynamicAction(false, false, 4095, {})
		arg_232_0:EnableCameraByTagAction("", 1, 0)
		arg_232_0:DestroyCharAction(9072)
		arg_232_0:DestroyCharAction(9073)
		arg_232_0:DestroyCharAction(9515)
		arg_232_0:DestroyCharAction(9510)
		arg_232_0:ContinueBlackFade()
		arg_232_0:OnNext(function()
			arg_232_0:ClearOnNext()
			arg_232_0:CloseStoryEventNode_41()
		end)
	end, function()
		arg_232_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_41(arg_236_0)
	arg_236_0:EnableCameraCutAction(false)
	arg_236_0:EndStory()
end

function var_0_0.DialogueBranchNode_35(arg_237_0)
	arg_237_0:OnNext(function()
		arg_237_0:ClearOnNext()
		arg_237_0:PureActorDialogueNode_36()
	end)
	arg_237_0:Next()
end

function var_0_0.RegisterFuncMap(arg_239_0)
	arg_239_0:RegisterTalkFunction("End", arg_239_0.BlackFadeDialogueNode_40)
	arg_239_0:RegisterTalkFunction("End", arg_239_0.CloseStoryEventNode_41)
end

return var_0_0
