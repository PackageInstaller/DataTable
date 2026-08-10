BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11026", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11026"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11026"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4081, {
			50010,
			50015,
			50009,
			50014,
			50017
		})
		arg_5_0:SetCharToTagAction(9514, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9510, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9072, "4", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "3", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:CameraMoveAction("1", 4, 2, 4, 0.4)
		arg_5_0:PlayActorAnimationAction(9514, "summer_doubt_start", 0.05, 0.7666667, function()
			return
		end)
		arg_5_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
		arg_5_0:LookAtRoleAction(true, 9510, "9514")
		arg_5_0:WalkingPeopleGlobleCull(true)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_14_0)
	arg_14_0:ShowTalkView()
	arg_14_0:SetTalkContent(11026001, "", 0)
	arg_14_0:SetNeedSkip(true, {
		Invoke = function()
			arg_14_0:Skip("End")
		end
	})
	arg_14_0:SetNeedClick(true, {
		Invoke = function()
			arg_14_0:Next()
		end
	})
	arg_14_0:OnNext(function(arg_17_0)
		arg_14_0:ClearOnNext()
		arg_14_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_18_0)
	arg_18_0:ShowTalkView()
	arg_18_0:SetTalkContent(11026002, "", 0)
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
	arg_18_0:OnNext(function(arg_21_0)
		arg_18_0:ClearOnNext()
		arg_18_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11026003, "", 0)
	arg_22_0:SetNeedSkip(true, {
		Invoke = function()
			arg_22_0:Skip("End")
		end
	})
	arg_22_0:SetNeedClick(true, {
		Invoke = function()
			arg_22_0:Next()
		end
	})
	arg_22_0:OnNext(function(arg_25_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_26_0)
	arg_26_0:EnableCameraByTagAction("2", 1, 0)
	arg_26_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_26_0:LookAtRoleAction(true, 9073, "9510")
	arg_26_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_26_0:LookAtRoleAction(true, 9074, "9510")
	arg_26_0:ActorSeekerAction(9073, {
		"5"
	}, 0.6, function()
		return
	end)
	arg_26_0:ActorSeekerAction(9072, {
		"6"
	}, 0.6, function()
		return
	end)
	arg_26_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_26_0:LookAtRoleAction(true, 9510, "9073")
	arg_26_0:DelayTimeAction(2, function()
		arg_26_0:SetNeedClick(true, {
			Invoke = function()
				arg_26_0:Next()
			end
		})
		arg_26_0:SetNeedSkip(true, {
			Invoke = function()
				arg_26_0:Skip("End")
			end
		})
	end)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(11026004, "", 9073)
	arg_26_0:SetNeedSkip(true, {
		Invoke = function()
			arg_26_0:Skip("End")
		end
	})
	arg_26_0:SetNeedClick(false, {
		Invoke = function()
			arg_26_0:Next()
		end
	})
	arg_26_0:OnNext(function(arg_34_0)
		arg_26_0:ClearOnNext()
		arg_26_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_35_0)
	arg_35_0:EnableCameraByTagAction("3", 1, 0)
	arg_35_0:PlayActorAnimationAction(9514, "summer_doubt_start", 0.05, 0.7666667, function()
		return
	end)
	arg_35_0:PlayActorEmoteAction(9514, "sad03_start", 0, 0.4666667, function()
		return
	end, true, true)
	arg_35_0:CameraMoveAction("3", 4, 4, 2, 0.3)
	arg_35_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_35_0:LookAtRoleAction(true, 9510, "9514")
	arg_35_0:DelayTimeAction(1, function()
		arg_35_0:SetNeedClick(true, {
			Invoke = function()
				arg_35_0:Next()
			end
		})
		arg_35_0:SetNeedSkip(true, {
			Invoke = function()
				arg_35_0:Skip("End")
			end
		})
	end)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11026005, "", 9510)
	arg_35_0:SetNeedSkip(true, {
		Invoke = function()
			arg_35_0:Skip("End")
		end
	})
	arg_35_0:SetNeedClick(false, {
		Invoke = function()
			arg_35_0:Next()
		end
	})
	arg_35_0:OnNext(function(arg_43_0)
		arg_35_0:ClearOnNext()
		arg_35_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_44_0)
	arg_44_0:EnableCameraByTagAction("6", 1, 0)
	arg_44_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_44_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_44_0:LookAtRoleAction(true, 9073, "9072")
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11026006, "", 9073)
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
		arg_44_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_49_0)
	arg_49_0:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_49_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_49_0:LookAtRoleAction(true, 9072, "9073")
	arg_49_0:ShowTalkView()
	arg_49_0:SetTalkContent(11026007, "", 9072)
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
		arg_49_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_54_0)
	arg_54_0:EnableCameraByTagAction("8", 1, 0)
	arg_54_0:ActorSeekerAction(9072, {
		"8"
	}, 0.7, function()
		return
	end)
	arg_54_0:ActorSeekerAction(9510, {
		"9"
	}, 0.5, function()
		return
	end)
	arg_54_0:DelayTimeAction(1, function()
		arg_54_0:ActorSeekerAction(9514, {
			"10"
		}, 0, function()
			return
		end)
		arg_54_0:DelayTimeAction(1, function()
			arg_54_0:SetNeedClick(true, {
				Invoke = function()
					arg_54_0:Next()
				end
			})
			arg_54_0:SetNeedSkip(true, {
				Invoke = function()
					arg_54_0:Skip("End")
				end
			})
		end)
	end)
	arg_54_0:ActorSeekerAction(9073, {
		"7"
	}, 0.5, function()
		return
	end)
	arg_54_0:PlayActorAnimationAction(9514, "summer_doubt_end", 0.05, 0.4666667, function()
		return
	end)
	arg_54_0:PlayActorEmoteAction(9514, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	arg_54_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_54_0:LookAtRoleAction(true, 9073, "9514")
	arg_54_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_54_0:LookAtRoleAction(true, 9072, "9514")
	arg_54_0:ShowTalkView()
	arg_54_0:SetTalkContent(11026008, "", 9072)
	arg_54_0:SetNeedSkip(true, {
		Invoke = function()
			arg_54_0:Skip("End")
		end
	})
	arg_54_0:SetNeedClick(false, {
		Invoke = function()
			arg_54_0:Next()
		end
	})
	arg_54_0:OnNext(function(arg_67_0)
		arg_54_0:ClearOnNext()
		arg_54_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_68_0)
	arg_68_0:EnableCameraByTagAction("9", 1, 0)
	arg_68_0:PlayActorAnimationAction(9514, "troubled", 0.05, 3.666667, function()
		return
	end)
	arg_68_0:SetLookAtParamsAction(9514, 0.8, 1, 1)
	arg_68_0:LookAtRoleAction(true, 9514, "9072")
	arg_68_0:ShowTalkView()
	arg_68_0:SetTalkContent(11026009, "", 9514)
	arg_68_0:SetNeedSkip(true, {
		Invoke = function()
			arg_68_0:Skip("End")
		end
	})
	arg_68_0:SetNeedClick(true, {
		Invoke = function()
			arg_68_0:Next()
		end
	})
	arg_68_0:OnNext(function(arg_72_0)
		arg_68_0:ClearOnNext()
		arg_68_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_73_0)
	arg_73_0:EnableCameraByTagAction("10", 1, 0)
	arg_73_0:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_73_0:DelayTimeAction(2, function()
		arg_73_0:EnableCameraByTagAction("10_1", 2, 1)
		arg_73_0:DelayTimeAction(1, function()
			arg_73_0:SetNeedClick(true, {
				Invoke = function()
					arg_73_0:Next()
				end
			})
			arg_73_0:SetNeedSkip(true, {
				Invoke = function()
					arg_73_0:Skip("End")
				end
			})
			arg_73_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
				return
			end)
		end)
	end)
	arg_73_0:ShowTalkView()
	arg_73_0:SetTalkContent(11026010, "", 9072)
	arg_73_0:SetNeedSkip(true, {
		Invoke = function()
			arg_73_0:Skip("End")
		end
	})
	arg_73_0:SetNeedClick(false, {
		Invoke = function()
			arg_73_0:Next()
		end
	})
	arg_73_0:OnNext(function(arg_82_0)
		arg_73_0:ClearOnNext()
		arg_73_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_83_0)
	arg_83_0:PlayActorAnimationAction(9073, "proud", 0.05, 2.333333, function()
		arg_83_0:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
			return
		end)
	end)
	arg_83_0:EnableCameraByTagAction("11", 2, 1)
	arg_83_0:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_83_0:ShowTalkView()
	arg_83_0:SetTalkContent(11026011, "", 9073)
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
	arg_83_0:OnNext(function(arg_89_0)
		arg_83_0:ClearOnNext()
		arg_83_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_90_0)
	arg_90_0:EnableCameraByTagAction("12", 1, 0)
	arg_90_0:PlayActorAnimationAction(9514, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_90_0:CameraMoveAction("12", 4, 4, 5, 0.4)
	arg_90_0:ShowTalkView()
	arg_90_0:SetTalkContent(11026012, "", 9514)
	arg_90_0:SetNeedSkip(true, {
		Invoke = function()
			arg_90_0:Skip("End")
		end
	})
	arg_90_0:SetNeedClick(true, {
		Invoke = function()
			arg_90_0:Next()
		end
	})
	arg_90_0:OnNext(function(arg_94_0)
		arg_90_0:ClearOnNext()
		arg_90_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_95_0)
	arg_95_0:EnableCameraByTagAction("9", 1, 0)
	arg_95_0:PlayActorAnimationAction(9514, "dizzy", 0.05, 7, function()
		return
	end)
	arg_95_0:ShowTalkView()
	arg_95_0:SetTalkContent(11026013, "", 9514)
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
	arg_95_0:OnNext(function(arg_99_0)
		arg_95_0:ClearOnNext()
		arg_95_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_100_0)
	arg_100_0:EnableCameraByTagAction("11", 1, 0)
	arg_100_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_100_0:ShowTalkView()
	arg_100_0:SetTalkContent(11026014, "", 9073)
	arg_100_0:SetNeedSkip(true, {
		Invoke = function()
			arg_100_0:Skip("End")
		end
	})
	arg_100_0:SetNeedClick(true, {
		Invoke = function()
			arg_100_0:Next()
		end
	})
	arg_100_0:OnNext(function(arg_104_0)
		arg_100_0:ClearOnNext()
		arg_100_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_105_0)
	arg_105_0:EnableCameraByTagAction("15", 1, 0)
	arg_105_0:PlayActorAnimationAction(9514, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_105_0:SetLookAtParamsAction(9514, 0.8, 1, 1)
	arg_105_0:LookAtRoleAction(true, 9514, "9073")
	arg_105_0:PlayActorEmoteAction(9514, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	arg_105_0:ShowTalkView()
	arg_105_0:SetTalkContent(11026015, "", 9514)
	arg_105_0:SetNeedSkip(true, {
		Invoke = function()
			arg_105_0:Skip("End")
		end
	})
	arg_105_0:SetNeedClick(true, {
		Invoke = function()
			arg_105_0:Next()
		end
	})
	arg_105_0:OnNext(function(arg_110_0)
		arg_105_0:ClearOnNext()
		arg_105_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_111_0)
	arg_111_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_111_0:ShowTalkView()
	arg_111_0:SetTalkContent(11026016, "", 9073)
	arg_111_0:SetNeedSkip(true, {
		Invoke = function()
			arg_111_0:Skip("End")
		end
	})
	arg_111_0:SetNeedClick(true, {
		Invoke = function()
			arg_111_0:Next()
		end
	})
	arg_111_0:OnNext(function(arg_115_0)
		arg_111_0:ClearOnNext()
		arg_111_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_116_0)
	arg_116_0:PlayActorAnimationAction(9514, "take", 0.05, 1.833333, function()
		return
	end)
	arg_116_0:ShowTalkView()
	arg_116_0:SetTalkContent(11026017, "", 9514)
	arg_116_0:SetNeedSkip(true, {
		Invoke = function()
			arg_116_0:Skip("End")
		end
	})
	arg_116_0:SetNeedClick(true, {
		Invoke = function()
			arg_116_0:Next()
		end
	})
	arg_116_0:OnNext(function(arg_120_0)
		arg_116_0:ClearOnNext()
		arg_116_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_121_0)
	arg_121_0:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_121_0:EnableCameraByTagAction("11", 1, 0)
	arg_121_0:ShowTalkView()
	arg_121_0:SetTalkContent(11026018, "", 9073)
	arg_121_0:SetNeedSkip(true, {
		Invoke = function()
			arg_121_0:Skip("End")
		end
	})
	arg_121_0:SetNeedClick(true, {
		Invoke = function()
			arg_121_0:Next()
		end
	})
	arg_121_0:OnNext(function(arg_125_0)
		arg_121_0:ClearOnNext()
		arg_121_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_126_0)
	arg_126_0:EnableCameraByTagAction("9", 1, 0)
	arg_126_0:PlayActorAnimationAction(9514, "think_loop", 0, 2, function()
		return
	end)
	arg_126_0:PlayActorEmoteAction(9514, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_126_0:CameraMoveAction("9", 4, 1, 5, 0.3)
	arg_126_0:ShowTalkView()
	arg_126_0:SetTalkContent(11026019, "", 9514)
	arg_126_0:SetNeedSkip(true, {
		Invoke = function()
			arg_126_0:Skip("End")
		end
	})
	arg_126_0:SetNeedClick(true, {
		Invoke = function()
			arg_126_0:Next()
		end
	})
	arg_126_0:OnNext(function(arg_131_0)
		arg_126_0:ClearOnNext()
		arg_126_0:DialogueNode_21()
	end)
end

function var_0_0.DialogueNode_21(arg_132_0)
	arg_132_0:ShowTalkView()
	arg_132_0:SetTalkContent(11026020, "", 9514)
	arg_132_0:SetNeedSkip(true, {
		Invoke = function()
			arg_132_0:Skip("End")
		end
	})
	arg_132_0:SetNeedClick(true, {
		Invoke = function()
			arg_132_0:Next()
		end
	})
	arg_132_0:OnNext(function(arg_135_0)
		arg_132_0:ClearOnNext()
		arg_132_0:DialogueNode_22()
	end)
end

function var_0_0.DialogueNode_22(arg_136_0)
	arg_136_0:PlayActorAnimationAction(9514, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_136_0:PlayActorEmoteAction(9514, "squint01_end", 0, 0.4333335, function()
		return
	end, true, false)
	arg_136_0:ShowTalkView()
	arg_136_0:SetTalkContent(11026021, "", 9514)
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
	arg_136_0:OnNext(function(arg_141_0)
		arg_136_0:ClearOnNext()
		arg_136_0:DialogueNode_23()
	end)
end

function var_0_0.DialogueNode_23(arg_142_0)
	arg_142_0:EnableCameraByTagAction("21", 1, 0)
	arg_142_0:PlayActorAnimationAction(9073, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_142_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_142_0:LookAtRoleAction(true, 9073, "9510")
	arg_142_0:ShowTalkView()
	arg_142_0:SetTalkContent(11026022, "", 9073)
	arg_142_0:SetNeedSkip(true, {
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
		arg_142_0:DialogueNode_24()
	end)
end

function var_0_0.DialogueNode_24(arg_147_0)
	arg_147_0:PlayActorAnimationAction(9510, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_147_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_147_0:LookAtRoleAction(true, 9510, "9073")
	arg_147_0:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_147_0:ShowTalkView()
	arg_147_0:SetTalkContent(11026023, "", 9510)
	arg_147_0:SetNeedSkip(true, {
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
		arg_147_0:DialogueNode_25()
	end)
end

function var_0_0.DialogueNode_25(arg_153_0)
	arg_153_0:PlayActorAnimationAction(9073, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_153_0:EnableCameraByTagAction("24", 2, 1)
	arg_153_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_153_0:LookAtRoleAction(true, 9072, "9510")
	arg_153_0:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_153_0:ShowTalkView()
	arg_153_0:SetTalkContent(11026024, "", 9072)
	arg_153_0:SetNeedSkip(true, {
		Invoke = function()
			arg_153_0:Skip("End")
		end
	})
	arg_153_0:SetNeedClick(true, {
		Invoke = function()
			arg_153_0:Next()
		end
	})
	arg_153_0:OnNext(function(arg_158_0)
		arg_153_0:ClearOnNext()
		arg_153_0:DialogueNode_26()
	end)
end

function var_0_0.DialogueNode_26(arg_159_0)
	arg_159_0:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_159_0:ShowTalkView()
	arg_159_0:SetTalkContent(11026025, "", 9073)
	arg_159_0:SetNeedSkip(true, {
		Invoke = function()
			arg_159_0:Skip("End")
		end
	})
	arg_159_0:SetNeedClick(true, {
		Invoke = function()
			arg_159_0:Next()
		end
	})
	arg_159_0:OnNext(function(arg_163_0)
		arg_159_0:ClearOnNext()
		arg_159_0:DialogueNode_27()
	end)
end

function var_0_0.DialogueNode_27(arg_164_0)
	arg_164_0:PlayActorAnimationAction(9510, "summer_doubt_start", 0.05, 0.7666667, function()
		return
	end)
	arg_164_0:PlayActorEmoteAction(9510, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_164_0:ShowTalkView()
	arg_164_0:SetTalkContent(11026026, "", 9510)
	arg_164_0:SetNeedSkip(true, {
		Invoke = function()
			arg_164_0:Skip("End")
		end
	})
	arg_164_0:SetNeedClick(true, {
		Invoke = function()
			arg_164_0:Next()
		end
	})
	arg_164_0:OnNext(function(arg_169_0)
		arg_164_0:ClearOnNext()
		arg_164_0:DialogueNode_28()
	end)
end

function var_0_0.DialogueNode_28(arg_170_0)
	arg_170_0:EnableCameraByTagAction("27", 1, 0)
	arg_170_0:PlayActorAnimationAction(9073, "stand_female", 0.05, 4, function()
		return
	end)
	arg_170_0:CameraMoveAction("27", 4, 4, 6, 0.5)
	arg_170_0:DelayTimeAction(4, function()
		arg_170_0:EnableCameraByTagAction("27_1", 1, 0)
		arg_170_0:CameraMoveAction("27_1", 4, 6, 2, 0.2)
		arg_170_0:PlayActorEmoteAction(9073, "squint01", 0, 1.733333, function()
			return
		end, true, false)
	end)
	arg_170_0:ShowTalkView()
	arg_170_0:SetTalkContent(11026027, "", 9073)
	arg_170_0:SetNeedSkip(true, {
		Invoke = function()
			arg_170_0:Skip("End")
		end
	})
	arg_170_0:SetNeedClick(true, {
		Invoke = function()
			arg_170_0:Next()
		end
	})
	arg_170_0:OnNext(function(arg_176_0)
		arg_170_0:ClearOnNext()
		arg_170_0:DialogueNode_29()
	end)
end

function var_0_0.DialogueNode_29(arg_177_0)
	arg_177_0:EnableCameraByTagAction("28", 1, 0)
	arg_177_0:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_177_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_177_0:LookAtRoleAction(true, 9072, "9073")
	arg_177_0:HideAllDynamicAction(true, true, 4081, {
		50010,
		50015,
		50009,
		50014,
		50017
	})
	arg_177_0:ShowTalkView()
	arg_177_0:SetTalkContent(11026028, "", 9072)
	arg_177_0:SetNeedSkip(true, {
		Invoke = function()
			arg_177_0:Skip("End")
		end
	})
	arg_177_0:SetNeedClick(true, {
		Invoke = function()
			arg_177_0:Next()
		end
	})
	arg_177_0:OnNext(function(arg_181_0)
		arg_177_0:ClearOnNext()
		arg_177_0:DialogueNode_30()
	end)
end

function var_0_0.DialogueNode_30(arg_182_0)
	arg_182_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_182_0:LookAtRoleAction(true, 9073, "9510")
	arg_182_0:ShowTalkView()
	arg_182_0:SetTalkContent(11026029, "", 9073)
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
	arg_182_0:OnNext(function(arg_185_0)
		arg_182_0:ClearOnNext()
		arg_182_0:DialogueNode_31()
	end)
end

function var_0_0.DialogueNode_31(arg_186_0)
	arg_186_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_186_0:EnableCameraByTagAction("30", 1, 0)
	end)
	arg_186_0:ShowTalkView()
	arg_186_0:SetTalkContent(11026030, "", 9510)
	arg_186_0:SetNeedSkip(true, {
		Invoke = function()
			arg_186_0:Skip("End")
		end
	})
	arg_186_0:SetNeedClick(true, {
		Invoke = function()
			arg_186_0:Next()
		end
	})
	arg_186_0:OnNext(function(arg_191_0)
		arg_186_0:ClearOnNext()
		arg_186_0:DialogueNode_32()
	end)
end

function var_0_0.DialogueNode_32(arg_192_0)
	arg_192_0:ShowTalkView()
	arg_192_0:SetTalkContent(11026031, "", 9073)
	arg_192_0:SetNeedSkip(true, {
		Invoke = function()
			arg_192_0:Skip("End")
		end
	})
	arg_192_0:SetNeedClick(true, {
		Invoke = function()
			arg_192_0:Next()
		end
	})
	arg_192_0:OnNext(function(arg_195_0)
		arg_192_0:ClearOnNext()
		arg_192_0:BlackFadeDialogueNode_33()
	end)
end

function var_0_0.BlackFadeDialogueNode_33(arg_196_0)
	arg_196_0:HideTalkView()
	arg_196_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_196_0:HideAllDynamicAction(false, false, 4095, {})
		arg_196_0:DestroyCharAction(9073)
		arg_196_0:EnableCameraByTagAction("", 1, 0)
		arg_196_0:DestroyCharAction(9072)
		arg_196_0:DestroyCharAction(9510)
		arg_196_0:DestroyCharAction(9514)
		arg_196_0:WalkingPeopleGlobleCull(false)
		arg_196_0:ContinueBlackFade()
		arg_196_0:OnNext(function()
			arg_196_0:ClearOnNext()
			arg_196_0:CloseStoryEventNode_34()
		end)
	end, function()
		arg_196_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_34(arg_200_0)
	arg_200_0:EnableCameraCutAction(false)
	arg_200_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_201_0)
	arg_201_0:RegisterTalkFunction("End", arg_201_0.BlackFadeDialogueNode_33)
	arg_201_0:RegisterTalkFunction("End", arg_201_0.CloseStoryEventNode_34)
end

return var_0_0
