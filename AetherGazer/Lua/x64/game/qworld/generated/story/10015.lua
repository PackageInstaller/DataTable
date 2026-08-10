BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10015", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10015"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10015"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		arg_5_0:SetCharToTagAction(9509, "9509_1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true)
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
	arg_11_0:DelayTimeAction(3, function()
		arg_11_0:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
			return
		end)
		arg_11_0:SetNeedClick(true, {
			Invoke = function()
				arg_11_0:Next()
			end
		})
		arg_11_0:SetNeedSkip(false, nil)
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(10015001, "", 9070)
	arg_11_0:SetNeedSkip(false, {
		Invoke = function()
			arg_11_0:Skip("End")
		end
	})
	arg_11_0:SetNeedClick(false, {
		Invoke = function()
			arg_11_0:Next()
		end
	})
	arg_11_0:OnNext(function(arg_17_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_18_0)
	arg_18_0:EnableCameraByTagAction("2", 1, 0)
	arg_18_0:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
		return
	end)
	arg_18_0:PlayActorEmoteAction(9070, "sad03", 0, 1.933333, function()
		return
	end, true, true)
	arg_18_0:ShowTalkView()
	arg_18_0:SetTalkContent(10015002, "", 9070)
	arg_18_0:SetNeedSkip(false, {
		Invoke = function()
			arg_18_0:Skip("End")
		end
	})
	arg_18_0:SetNeedClick(true, {
		Invoke = function()
			arg_18_0:Next()
		end
	})
	arg_18_0:OnNext(function(arg_23_0)
		arg_18_0:ClearOnNext()
		arg_18_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_24_0)
	arg_24_0:ActorSeekerAction(9509, {
		"9509_2"
	}, 0.5, function()
		return
	end)
	arg_24_0:EnableCameraByTagAction("3", 1, 0)
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(10015003, "", 9509)
	arg_24_0:SetNeedSkip(false, {
		Invoke = function()
			arg_24_0:Skip("End")
		end
	})
	arg_24_0:SetNeedClick(true, {
		Invoke = function()
			arg_24_0:Next()
		end
	})
	arg_24_0:OnNext(function(arg_28_0)
		arg_24_0:ClearOnNext()
		arg_24_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_29_0)
	arg_29_0:EnableCameraByTagAction("4", 1, 0)
	arg_29_0:CameraMoveAction("4", 4, 1, 0.2, 0.6)
	arg_29_0:PlayActorEmoteAction(9070, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_29_0:DelayTimeAction(1.4, function()
		arg_29_0:ActorSeekerAction(9070, {
			"9070_2"
		}, 2.1, function()
			return
		end)
		arg_29_0:EnableCameraByTagAction("4_1", 1, 0)
		arg_29_0:CameraMoveAction("4_1", 4, 5, 4, 0.6)
		arg_29_0:DelayTimeAction(3, function()
			arg_29_0:SetNeedClick(true, {
				Invoke = function()
					arg_29_0:Next()
				end
			})
			arg_29_0:SetNeedSkip(false, nil)
		end)
	end)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(10015004, "", 9070)
	arg_29_0:SetNeedSkip(false, {
		Invoke = function()
			arg_29_0:Skip("End")
		end
	})
	arg_29_0:SetNeedClick(false, {
		Invoke = function()
			arg_29_0:Next()
		end
	})
	arg_29_0:OnNext(function(arg_37_0)
		arg_29_0:ClearOnNext()
		arg_29_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_38_0)
	arg_38_0:EnableCameraByTagAction("5", 1, 0)
	arg_38_0:PlayActorAnimationAction(9509, "happy02", 0, 3, function()
		return
	end)
	arg_38_0:DelayTimeAction(1, function()
		arg_38_0:SetNeedClick(true, {
			Invoke = function()
				arg_38_0:Next()
			end
		})
		arg_38_0:SetNeedSkip(false, nil)
	end)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(10015005, "", 9509)
	arg_38_0:SetNeedSkip(false, {
		Invoke = function()
			arg_38_0:Skip("End")
		end
	})
	arg_38_0:SetNeedClick(false, {
		Invoke = function()
			arg_38_0:Next()
		end
	})
	arg_38_0:OnNext(function(arg_44_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_45_0)
	arg_45_0:EnableCameraByTagAction("6", 1, 0)
	arg_45_0:PlayActorAnimationAction(9070, "stroke01", 0, 9.066668, function()
		return
	end)
	arg_45_0:CameraMoveAction("6", 4, 1, 8, 0.4)
	arg_45_0:PlayActorEmoteAction(9070, "shocked01_start", 0, 0.3666667, function()
		return
	end, false, false)
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(10015006, "", 9070)
	arg_45_0:SetNeedSkip(false, {
		Invoke = function()
			arg_45_0:Skip("End")
		end
	})
	arg_45_0:SetNeedClick(true, {
		Invoke = function()
			arg_45_0:Next()
		end
	})
	arg_45_0:OnNext(function(arg_50_0)
		arg_45_0:ClearOnNext()
		arg_45_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_51_0)
	arg_51_0:PlayActorAnimationAction(9509, "dorm_male_idle01", 0, 8.166667, function()
		return
	end)
	arg_51_0:EnableCameraByTagAction("7", 1, 0)
	arg_51_0:CameraMoveAction("7", 4, 4, 6, 0.4)
	arg_51_0:DelayTimeAction(2, function()
		arg_51_0:SetNeedClick(true, {
			Invoke = function()
				arg_51_0:Next()
			end
		})
		arg_51_0:SetNeedSkip(false, nil)
	end)
	arg_51_0:ShowTalkView()
	arg_51_0:SetTalkContent(10015007, "", 9509)
	arg_51_0:SetNeedSkip(false, {
		Invoke = function()
			arg_51_0:Skip("End")
		end
	})
	arg_51_0:SetNeedClick(false, {
		Invoke = function()
			arg_51_0:Next()
		end
	})
	arg_51_0:OnNext(function(arg_57_0)
		arg_51_0:ClearOnNext()
		arg_51_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_58_0)
	arg_58_0:EnableCameraByTagAction("8", 1, 0)
	arg_58_0:CameraMoveAction("8", 4, 4, 6, 0.3)
	arg_58_0:ActorSeekerAction(9509, {
		"9509_3"
	}, 0.5, function()
		return
	end)
	arg_58_0:DelayTimeAction(1.8, function()
		arg_58_0:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
			return
		end)
	end)
	arg_58_0:ShowTalkView()
	arg_58_0:SetTalkContent(10015008, "", 9509)

	local var_58_0 = {
		[0] = {
			id = 10015009,
			icon = "",
			Invoke = function()
				arg_58_0:Next(10015009)
			end
		},
		{
			id = 10015014,
			icon = "",
			Invoke = function()
				arg_58_0:Next(10015014)
			end
		},
		{
			id = 10015020,
			icon = "",
			Invoke = function()
				arg_58_0:Next(10015020)
			end
		},
		Length = 3
	}

	arg_58_0:SetChoice(var_58_0, false)
	arg_58_0:SetNeedSkip(false, nil)
	arg_58_0:SetNeedClick(false, nil)
	arg_58_0:OnNext(function(arg_65_0)
		arg_58_0:ClearOnNext()
		arg_58_0:CloseChoice()

		if arg_65_0 == 10015009 then
			arg_58_0:DialogueBranchNode_10()
		elseif arg_65_0 == 10015014 then
			arg_58_0:DialogueBranchNode_11()
		elseif arg_65_0 == 10015020 then
			arg_58_0:DialogueBranchNode_12()
		end
	end)
end

function var_0_0.DialogueBranchNode_10(arg_66_0)
	arg_66_0:OnNext(function()
		arg_66_0:ClearOnNext()
		arg_66_0:DialogueNode_13()
	end)
	arg_66_0:Next()
end

function var_0_0.DialogueNode_13(arg_68_0)
	arg_68_0:EnableCameraByTagAction("9", 1, 0)
	arg_68_0:PlayActorAnimationAction(9070, "action4_1", 0, 2.666667, function()
		return
	end)
	arg_68_0:DelayTimeAction(2.5, function()
		arg_68_0:SetNeedClick(true, {
			Invoke = function()
				arg_68_0:Next()
			end
		})
		arg_68_0:SetNeedSkip(false, nil)
	end)
	arg_68_0:PlayActorAnimationAction(9509, "action2_3", 0, 1.333333, function()
		return
	end)
	arg_68_0:PlayActorEmoteAction(9070, "laugh01", 0, 0.9333334, function()
		return
	end, false, false)
	arg_68_0:ShowTalkView()
	arg_68_0:SetTalkContent(10015010, "", 9509)
	arg_68_0:SetNeedSkip(false, {
		Invoke = function()
			arg_68_0:Skip("End")
		end
	})
	arg_68_0:SetNeedClick(false, {
		Invoke = function()
			arg_68_0:Next()
		end
	})
	arg_68_0:OnNext(function(arg_76_0)
		arg_68_0:ClearOnNext()
		arg_68_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_77_0)
	arg_77_0:PlayActorAnimationAction(9070, "summer_doubt", 0.2, 2, function()
		return
	end)
	arg_77_0:PlayActorEmoteAction(9070, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_77_0:EnableCameraByTagAction("11", 1, 0)
	arg_77_0:CameraMoveAction("11", 4, 6, 8, 0.4)
	arg_77_0:ShowTalkView()
	arg_77_0:SetTalkContent(10015011, "", 9070)
	arg_77_0:SetNeedSkip(false, {
		Invoke = function()
			arg_77_0:Skip("End")
		end
	})
	arg_77_0:SetNeedClick(true, {
		Invoke = function()
			arg_77_0:Next()
		end
	})
	arg_77_0:OnNext(function(arg_82_0)
		arg_77_0:ClearOnNext()
		arg_77_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_83_0)
	arg_83_0:EnableCameraByTagAction("12", 1, 0)
	arg_83_0:CameraMoveAction("12", 4, 6, 6, 0.2)
	arg_83_0:PlayActorEmoteAction(9509, "disdain01_start", 0, 0.4, function()
		return
	end, true, true)
	arg_83_0:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_83_0:ShowTalkView()
	arg_83_0:SetTalkContent(10015012, "", 9509)
	arg_83_0:SetNeedSkip(false, {
		Invoke = function()
			arg_83_0:Skip("End")
		end
	})
	arg_83_0:SetNeedClick(true, {
		Invoke = function()
			arg_83_0:Next()
		end
	})
	arg_83_0:OnNext(function(arg_88_0)
		arg_83_0:ClearOnNext()
		arg_83_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_89_0)
	arg_89_0:EnableCameraByTagAction("13", 1, 0)
	arg_89_0:PlayActorAnimationAction(9070, "stroke01", 0, 9.066668, function()
		return
	end)
	arg_89_0:PlayActorEmoteAction(9070, "disdain01_start", 0, 0.4, function()
		return
	end, false, false)
	arg_89_0:ShowTalkView()
	arg_89_0:SetTalkContent(10015013, "", 9070)
	arg_89_0:SetNeedSkip(false, {
		Invoke = function()
			arg_89_0:Skip("End")
		end
	})
	arg_89_0:SetNeedClick(true, {
		Invoke = function()
			arg_89_0:Next()
		end
	})
	arg_89_0:OnNext(function(arg_94_0)
		arg_89_0:ClearOnNext()
		arg_89_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_95_0)
	arg_95_0:EnableCameraByTagAction("25", 1, 0)
	arg_95_0:CameraMoveAction("25", 4, 4, 8, 0.6)
	arg_95_0:PlayActorAnimationAction(9509, "action2_3", 0, 1.333333, function()
		return
	end)
	arg_95_0:PlayActorEmoteAction(9509, "", 0, 0, function()
		return
	end, false, false)
	arg_95_0:ShowTalkView()
	arg_95_0:SetTalkContent(10015025, "", 9509)
	arg_95_0:SetNeedSkip(false, {
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
		arg_95_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_101_0)
	arg_101_0:EnableCameraByTagAction("25", 1, 0)
	arg_101_0:PlayActorAnimationAction(9070, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_101_0:ShowTalkView()
	arg_101_0:SetTalkContent(10015026, "", 9070)
	arg_101_0:SetNeedSkip(false, {
		Invoke = function()
			arg_101_0:Skip("End")
		end
	})
	arg_101_0:SetNeedClick(true, {
		Invoke = function()
			arg_101_0:Next()
		end
	})
	arg_101_0:OnNext(function(arg_105_0)
		arg_101_0:ClearOnNext()
		arg_101_0:BlackFadeDialogueNode_19()
	end)
end

function var_0_0.BlackFadeDialogueNode_19(arg_106_0)
	arg_106_0:HideTalkView()
	arg_106_0:OnBlackFade(false, 0, 0.5, 0.2, 0.2, function()
		arg_106_0:HideAllDynamicAction(false, false)
		arg_106_0:EnableCameraByTagAction("", 1, 0)
		arg_106_0:DestroyCharAction(9070)
		arg_106_0:DestroyCharAction(9509)
		arg_106_0:Agent_PlayerPosControl("9070_2", function()
			return
		end)
		arg_106_0:ContinueBlackFade()
		arg_106_0:OnNext(function()
			arg_106_0:ClearOnNext()
			arg_106_0:CloseStoryEventNode_20()
		end)
	end, function()
		arg_106_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_20(arg_111_0)
	arg_111_0:EndStory()
end

function var_0_0.DialogueBranchNode_11(arg_112_0)
	arg_112_0:OnNext(function()
		arg_112_0:ClearOnNext()
		arg_112_0:DialogueNode_21()
	end)
	arg_112_0:Next()
end

function var_0_0.DialogueNode_21(arg_114_0)
	arg_114_0:EnableCameraByTagAction("9", 1, 0)
	arg_114_0:PlayActorAnimationAction(9070, "stroke02", 0, 5.166667, function()
		return
	end)
	arg_114_0:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_114_0:ShowTalkView()
	arg_114_0:SetTalkContent(10015015, "", 9509)
	arg_114_0:SetNeedSkip(false, {
		Invoke = function()
			arg_114_0:Skip("End")
		end
	})
	arg_114_0:SetNeedClick(true, {
		Invoke = function()
			arg_114_0:Next()
		end
	})
	arg_114_0:OnNext(function(arg_119_0)
		arg_114_0:ClearOnNext()
		arg_114_0:DialogueNode_22()
	end)
end

function var_0_0.DialogueNode_22(arg_120_0)
	arg_120_0:EnableCameraByTagAction("16", 1, 0)
	arg_120_0:CameraMoveAction("16", 4, 4, 8, 0.6)
	arg_120_0:PlayActorAnimationAction(9070, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_120_0:ShowTalkView()
	arg_120_0:SetTalkContent(10015016, "", 9070)
	arg_120_0:SetNeedSkip(false, {
		Invoke = function()
			arg_120_0:Skip("End")
		end
	})
	arg_120_0:SetNeedClick(true, {
		Invoke = function()
			arg_120_0:Next()
		end
	})
	arg_120_0:OnNext(function(arg_124_0)
		arg_120_0:ClearOnNext()
		arg_120_0:DialogueNode_23()
	end)
end

function var_0_0.DialogueNode_23(arg_125_0)
	arg_125_0:EnableCameraByTagAction("17", 1, 0)
	arg_125_0:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
		return
	end)
	arg_125_0:ShowTalkView()
	arg_125_0:SetTalkContent(10015017, "", 9070)
	arg_125_0:SetNeedSkip(false, {
		Invoke = function()
			arg_125_0:Skip("End")
		end
	})
	arg_125_0:SetNeedClick(true, {
		Invoke = function()
			arg_125_0:Next()
		end
	})
	arg_125_0:OnNext(function(arg_129_0)
		arg_125_0:ClearOnNext()
		arg_125_0:DialogueNode_24()
	end)
end

function var_0_0.DialogueNode_24(arg_130_0)
	arg_130_0:EnableCameraByTagAction("18", 1, 0)
	arg_130_0:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_130_0:CameraMoveAction("18", 4, 1, 6, 0.4)
	arg_130_0:ShowTalkView()
	arg_130_0:SetTalkContent(10015018, "", 9509)
	arg_130_0:SetNeedSkip(false, {
		Invoke = function()
			arg_130_0:Skip("End")
		end
	})
	arg_130_0:SetNeedClick(true, {
		Invoke = function()
			arg_130_0:Next()
		end
	})
	arg_130_0:OnNext(function(arg_134_0)
		arg_130_0:ClearOnNext()
		arg_130_0:DialogueNode_25()
	end)
end

function var_0_0.DialogueNode_25(arg_135_0)
	arg_135_0:PlayActorAnimationAction(9070, "stroke01", 0, 9.066668, function()
		return
	end)
	arg_135_0:EnableCameraByTagAction("19", 1, 0)
	arg_135_0:ShowTalkView()
	arg_135_0:SetTalkContent(10015019, "", 9070)
	arg_135_0:SetNeedSkip(false, {
		Invoke = function()
			arg_135_0:Skip("End")
		end
	})
	arg_135_0:SetNeedClick(true, {
		Invoke = function()
			arg_135_0:Next()
		end
	})
	arg_135_0:OnNext(function(arg_139_0)
		arg_135_0:ClearOnNext()
		arg_135_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueBranchNode_12(arg_140_0)
	arg_140_0:OnNext(function()
		arg_140_0:ClearOnNext()
		arg_140_0:DialogueNode_26()
	end)
	arg_140_0:Next()
end

function var_0_0.DialogueNode_26(arg_142_0)
	arg_142_0:EnableCameraByTagAction("9", 1, 0)
	arg_142_0:PlayActorAnimationAction(9070, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_142_0:CameraMoveAction("9", 4, 2, 10, 0.7)
	arg_142_0:ShowTalkView()
	arg_142_0:SetTalkContent(10015021, "", 0)
	arg_142_0:SetNeedSkip(false, {
		Invoke = function()
			arg_142_0:Skip("End")
		end
	})
	arg_142_0:SetNeedClick(true, {
		Invoke = function()
			arg_142_0:Next()
		end
	})
	arg_142_0:OnNext(function(arg_146_0)
		arg_142_0:ClearOnNext()
		arg_142_0:DialogueNode_27()
	end)
end

function var_0_0.DialogueNode_27(arg_147_0)
	arg_147_0:EnableCameraByTagAction("22", 1, 0)
	arg_147_0:CameraMoveAction("22", 4, 1, 1, 0.5)
	arg_147_0:PlayActorAnimationAction(9509, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_147_0:PlayActorEmoteAction(9509, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_147_0:ShowTalkView()
	arg_147_0:SetTalkContent(10015022, "", 0)
	arg_147_0:SetNeedSkip(false, {
		Invoke = function()
			arg_147_0:Skip("End")
		end
	})
	arg_147_0:SetNeedClick(true, {
		Invoke = function()
			arg_147_0:Next()
		end
	})
	arg_147_0:OnNext(function(arg_152_0)
		arg_147_0:ClearOnNext()
		arg_147_0:DialogueNode_28()
	end)
end

function var_0_0.DialogueNode_28(arg_153_0)
	arg_153_0:EnableCameraByTagAction("23", 1, 0)
	arg_153_0:PlayActorAnimationAction(9070, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_153_0:ShowTalkView()
	arg_153_0:SetTalkContent(10015023, "", 0)
	arg_153_0:SetNeedSkip(false, {
		Invoke = function()
			arg_153_0:Skip("End")
		end
	})
	arg_153_0:SetNeedClick(true, {
		Invoke = function()
			arg_153_0:Next()
		end
	})
	arg_153_0:OnNext(function(arg_157_0)
		arg_153_0:ClearOnNext()
		arg_153_0:DialogueNode_29()
	end)
end

function var_0_0.DialogueNode_29(arg_158_0)
	arg_158_0:PlayActorAnimationAction(9070, "stroke01", 0.2, 9.066668, function()
		return
	end)
	arg_158_0:ShowTalkView()
	arg_158_0:SetTalkContent(10015024, "", 0)
	arg_158_0:SetNeedSkip(false, {
		Invoke = function()
			arg_158_0:Skip("End")
		end
	})
	arg_158_0:SetNeedClick(true, {
		Invoke = function()
			arg_158_0:Next()
		end
	})
	arg_158_0:OnNext(function(arg_162_0)
		arg_158_0:ClearOnNext()
		arg_158_0:DialogueNode_17()
	end)
end

function var_0_0.RegisterFuncMap(arg_163_0)
	arg_163_0:RegisterTalkFunction("End", arg_163_0.CloseStoryEventNode_20)
end

return var_0_0
