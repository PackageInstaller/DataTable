BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11030", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11030"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11030"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(true, 11030001, 3, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:SetCharToTagAction(9514, "1", function()
			arg_5_0:InstEffectAction({
				attachFollow = false,
				delayTime = 4,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9514,
				path = "QWWorld/Effect/EmotionBubble/fx_xixi_1201_QW"
			})
		end)
		arg_5_0:SetCharToTagAction(9521, "2", function()
			arg_5_0:InstEffectAction({
				attachFollow = false,
				delayTime = 4,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9521,
				path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0802_QW"
			})
		end)
		arg_5_0:SetCharToTagAction(9518, "3", function()
			arg_5_0:InstEffectAction({
				attachFollow = false,
				delayTime = 4,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9518,
				path = "QWWorld/Effect/EmotionBubble/fx_piaosan_1401"
			})
		end)
		arg_5_0:SetCharToTagAction(9520, "4", function()
			arg_5_0:InstEffectAction({
				attachFollow = false,
				delayTime = 4,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9520,
				path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0801_QW_behind"
			})
		end)
		arg_5_0:PlayActorAnimationAction(9514, "cute", 0.05, 2.333333, function()
			return
		end)
		arg_5_0:PlayActorAnimationAction(9521, "action2_1", 0.05, 1.666667, function()
			return
		end)
		arg_5_0:PlayActorAnimationAction(9518, "firm", 0.05, 2.333333, function()
			return
		end)
		arg_5_0:PlayActorAnimationAction(9520, "conversation_2", 0.05, 3.166667, function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:WalkingPeopleGlobleCull(true)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:PureActorDialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_2(arg_17_0)
	arg_17_0:DelayTimeAction(3.5, function()
		arg_17_0:EventAction(function()
			arg_17_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_17_0:HideTalkView()
	arg_17_0:OnNext(function()
		arg_17_0:ClearOnNext()
		arg_17_0:BlackFadeDialogueNode_3()
	end)
end

function var_0_0.BlackFadeDialogueNode_3(arg_21_0)
	arg_21_0:HideTalkView()
	arg_21_0:OnBlackFade(true, 11030002, 3, 0.5, 1, function()
		arg_21_0:EnableCameraByTagAction("2", 1, 0)
		arg_21_0:SetCharToTagAction(9514, "8", function()
			return
		end)
		arg_21_0:PlayActorAnimationAction(9514, "conversation_2", 0, 3.166667, function()
			return
		end)
		arg_21_0:PlayActorEmoteAction(9514, "happy01_start", 0, 0.1333333, function()
			return
		end, true, true)
		arg_21_0:SetCharToTagAction(9073, "9073", function()
			return
		end)
		arg_21_0:SetCharToTagAction(9072, "9072", function()
			return
		end)
		arg_21_0:SetCharToTagAction(9510, "9510", function()
			return
		end)
		arg_21_0:DestroyCharAction(9512)
		arg_21_0:DestroyCharAction(9513)
		arg_21_0:DestroyCharAction(9523)
		arg_21_0:ContinueBlackFade()
		arg_21_0:OnNext(function()
			arg_21_0:ClearOnNext()
			arg_21_0:DialogueNode_4()
		end)
	end, function()
		arg_21_0:Next()
	end)
end

function var_0_0.DialogueNode_4(arg_31_0)
	arg_31_0:ShowTalkView()
	arg_31_0:SetTalkContent(11030003, "", 9514)
	arg_31_0:SetNeedSkip(true, {
		Invoke = function()
			arg_31_0:Skip("LastWord")
		end
	})
	arg_31_0:SetNeedClick(true, {
		Invoke = function()
			arg_31_0:Next()
		end
	})
	arg_31_0:OnNext(function(arg_34_0)
		arg_31_0:ClearOnNext()
		arg_31_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_35_0)
	arg_35_0:EnableCameraByTagAction("4", 1, 0)
	arg_35_0:PlayActorAnimationAction(9073, "proud", 0.05, 2.333333, function()
		arg_35_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	arg_35_0:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11030004, "", 9073)
	arg_35_0:SetNeedSkip(true, {
		Invoke = function()
			arg_35_0:Skip("LastWord")
		end
	})
	arg_35_0:SetNeedClick(true, {
		Invoke = function()
			arg_35_0:Next()
		end
	})
	arg_35_0:OnNext(function(arg_41_0)
		arg_35_0:ClearOnNext()
		arg_35_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_42_0)
	arg_42_0:EnableCameraByTagAction("5", 2, 1)
	arg_42_0:PlayActorAnimationAction(9510, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11030005, "", 9510)
	arg_42_0:SetNeedSkip(true, {
		Invoke = function()
			arg_42_0:Skip("LastWord")
		end
	})
	arg_42_0:SetNeedClick(true, {
		Invoke = function()
			arg_42_0:Next()
		end
	})
	arg_42_0:OnNext(function(arg_46_0)
		arg_42_0:ClearOnNext()
		arg_42_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_47_0)
	arg_47_0:EnableCameraByTagAction("6", 1, 0)
	arg_47_0:PlayActorAnimationAction(9514, "action3_1", 0.05, 2.266667, function()
		arg_47_0:PlayActorAnimationAction(9514, "embarrassed", 0.05, 2.6, function()
			return
		end)
		arg_47_0:PlayActorEmoteAction(9514, "blink", 0.1, 0.3333333, function()
			return
		end, true, false)
	end)
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11030006, "", 9514)
	arg_47_0:SetNeedSkip(true, {
		Invoke = function()
			arg_47_0:Skip("LastWord")
		end
	})
	arg_47_0:SetNeedClick(true, {
		Invoke = function()
			arg_47_0:Next()
		end
	})
	arg_47_0:OnNext(function(arg_53_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_54_0)
	arg_54_0:PlayActorAnimationAction(9514, "sad_02", 0.05, 6.733334, function()
		return
	end)
	arg_54_0:PlayActorEmoteAction(9514, "blink", 0.1, 0.3333333, function()
		return
	end, true, false)
	arg_54_0:ShowTalkView()
	arg_54_0:SetTalkContent(11030007, "", 9514)
	arg_54_0:SetNeedSkip(true, {
		Invoke = function()
			arg_54_0:Skip("LastWord")
		end
	})
	arg_54_0:SetNeedClick(true, {
		Invoke = function()
			arg_54_0:Next()
		end
	})
	arg_54_0:OnNext(function(arg_59_0)
		arg_54_0:ClearOnNext()
		arg_54_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_60_0)
	arg_60_0:EnableCameraByTagAction("4", 1, 0)
	arg_60_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_60_0:PlayActorEmoteAction(9073, "blink", 0.1, 0.3333333, function()
		return
	end, false, false)
	arg_60_0:ShowTalkView()
	arg_60_0:SetTalkContent(11030008, "", 9073)
	arg_60_0:SetNeedSkip(true, {
		Invoke = function()
			arg_60_0:Skip("LastWord")
		end
	})
	arg_60_0:SetNeedClick(true, {
		Invoke = function()
			arg_60_0:Next()
		end
	})
	arg_60_0:OnNext(function(arg_65_0)
		arg_60_0:ClearOnNext()
		arg_60_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_66_0)
	arg_66_0:EnableCameraByTagAction("9", 2, 1)
	arg_66_0:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_66_0:ShowTalkView()
	arg_66_0:SetTalkContent(11030009, "", 9072)
	arg_66_0:SetNeedSkip(true, {
		Invoke = function()
			arg_66_0:Skip("LastWord")
		end
	})
	arg_66_0:SetNeedClick(true, {
		Invoke = function()
			arg_66_0:Next()
		end
	})
	arg_66_0:OnNext(function(arg_70_0)
		arg_66_0:ClearOnNext()
		arg_66_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_71_0)
	arg_71_0:EnableCameraByTagAction("10", 1, 0)
	arg_71_0:PlayActorAnimationAction(9510, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	arg_71_0:ShowTalkView()
	arg_71_0:SetTalkContent(11030010, "", 9510)
	arg_71_0:SetNeedSkip(true, {
		Invoke = function()
			arg_71_0:Skip("LastWord")
		end
	})
	arg_71_0:SetNeedClick(true, {
		Invoke = function()
			arg_71_0:Next()
		end
	})
	arg_71_0:OnNext(function(arg_75_0)
		arg_71_0:ClearOnNext()
		arg_71_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_76_0)
	arg_76_0:EnableCameraByTagAction("6", 1, 0)
	arg_76_0:PlayActorAnimationAction(9514, "summer_doubt", 0.05, 2, function()
		arg_76_0:PlayActorEmoteAction(9514, "glory01", 0.05, 1.566667, function()
			return
		end, true, false)
	end)
	arg_76_0:ShowTalkView()
	arg_76_0:SetTalkContent(11030011, "", 9514)
	arg_76_0:SetNeedSkip(true, {
		Invoke = function()
			arg_76_0:Skip("LastWord")
		end
	})
	arg_76_0:SetNeedClick(true, {
		Invoke = function()
			arg_76_0:Next()
		end
	})
	arg_76_0:OnNext(function(arg_81_0)
		arg_76_0:ClearOnNext()
		arg_76_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_82_0)
	arg_82_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_82_0:LookAtRoleAction(true, 9073, "9510")
	arg_82_0:EnableCameraByTagAction("10", 1, 0)
	arg_82_0:DelayTimeAction(2, function()
		arg_82_0:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
			return
		end)
	end)
	arg_82_0:ShowTalkView()
	arg_82_0:SetTalkContent(11030012, "", 9073)
	arg_82_0:SetNeedSkip(true, {
		Invoke = function()
			arg_82_0:Skip("LastWord")
		end
	})
	arg_82_0:SetNeedClick(true, {
		Invoke = function()
			arg_82_0:Next()
		end
	})
	arg_82_0:OnNext(function(arg_87_0)
		arg_82_0:ClearOnNext()
		arg_82_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_88_0)
	arg_88_0:EnableCameraByTagAction("5", 1, 0)
	arg_88_0:PlayActorAnimationAction(9510, "action3_1", 0, 2.266667, function()
		arg_88_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
		arg_88_0:LookAtRoleAction(true, 9510, "9514")
		arg_88_0:DelayTimeAction(1, function()
			arg_88_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
				return
			end)
			arg_88_0:SetNeedClick(true, {
				Invoke = function()
					arg_88_0:Next()
				end
			})
			arg_88_0:SetNeedSkip(true, {
				Invoke = function()
					arg_88_0:Skip("End")
				end
			})
			arg_88_0:EnableCameraByTagAction("2", 1, 0)
		end)
	end)
	arg_88_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_88_0:LookAtRoleAction(true, 9072, "9073")
	arg_88_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_88_0:LookAtRoleAction(true, 9510, "9073")
	arg_88_0:ShowTalkView()
	arg_88_0:SetTalkContent(11030013, "", 9510)
	arg_88_0:SetNeedSkip(true, {
		Invoke = function()
			arg_88_0:Skip("LastWord")
		end
	})
	arg_88_0:SetNeedClick(false, {
		Invoke = function()
			arg_88_0:Next()
		end
	})
	arg_88_0:OnNext(function(arg_96_0)
		arg_88_0:ClearOnNext()
		arg_88_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_97_0)
	arg_97_0:PlayActorAnimationAction(9514, "conversation_2", 0.05, 3.166667, function()
		arg_97_0:PlayActorAnimationAction(9514, "summer_doubt", 0.05, 2, function()
			return
		end)
	end)
	arg_97_0:SetLookAtParamsAction(9514, 0.8, 1, 1)
	arg_97_0:LookAtRoleAction(true, 9514, "9510")
	arg_97_0:ShowTalkView()
	arg_97_0:SetTalkContent(11030014, "", 9514)
	arg_97_0:SetNeedSkip(true, {
		Invoke = function()
			arg_97_0:Skip("LastWord")
		end
	})
	arg_97_0:SetNeedClick(true, {
		Invoke = function()
			arg_97_0:Next()
		end
	})
	arg_97_0:OnNext(function(arg_102_0)
		arg_97_0:ClearOnNext()
		arg_97_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_103_0)
	arg_103_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_103_0:DelayTimeAction(1, function()
		arg_103_0:BlackFadeAction(0.2, 0.5, 0.5, function()
			arg_103_0:DelayTimeAction(0.5, function()
				arg_103_0:SetNeedClick(true, {
					Invoke = function()
						arg_103_0:Next()
					end
				})
				arg_103_0:SetNeedSkip(true, {
					Invoke = function()
						arg_103_0:Skip("End")
					end
				})
			end)
		end, function()
			arg_103_0:EnableCameraByTagAction("15", 1, 0)
			arg_103_0:CameraMoveAction("15", 4, 3, 5, 0.4)
		end)
	end)
	arg_103_0:ShowTalkView()
	arg_103_0:SetTalkContent(11030015, "", 9510)
	arg_103_0:SetNeedSkip(true, {
		Invoke = function()
			arg_103_0:Skip("LastWord")
		end
	})
	arg_103_0:SetNeedClick(false, {
		Invoke = function()
			arg_103_0:Next()
		end
	})
	arg_103_0:OnNext(function(arg_113_0)
		arg_103_0:ClearOnNext()
		arg_103_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_114_0)
	arg_114_0:PlayActorAnimationAction(9073, "win", 0.1, 1.933333, function()
		return
	end)
	arg_114_0:SetLookAtParamsAction(9073, 0.6, 0.8, 1)
	arg_114_0:LookAtRoleAction(true, 9073, "9510")
	arg_114_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_114_0:EnableCameraByTagAction("4", 1, 0)
		arg_114_0:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
			return
		end, true, false)
		arg_114_0:CameraMoveAction("4", 4, 1, 0.6, 0.2)
	end)
	arg_114_0:ShowTalkView()
	arg_114_0:SetTalkContent(11030016, "", 9073)
	arg_114_0:SetNeedSkip(true, {
		Invoke = function()
			arg_114_0:Skip("LastWord")
		end
	})
	arg_114_0:SetNeedClick(true, {
		Invoke = function()
			arg_114_0:Next()
		end
	})
	arg_114_0:OnNext(function(arg_121_0)
		arg_114_0:ClearOnNext()
		arg_114_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_122_0)
	arg_122_0:EnableCameraByTagAction("10", 1, 0)
	arg_122_0:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_122_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_122_0:LookAtRoleAction(true, 9072, "9073")
	arg_122_0:ShowTalkView()
	arg_122_0:SetTalkContent(11030017, "", 9072)
	arg_122_0:SetNeedSkip(true, {
		Invoke = function()
			arg_122_0:Skip("LastWord")
		end
	})
	arg_122_0:SetNeedClick(true, {
		Invoke = function()
			arg_122_0:Next()
		end
	})
	arg_122_0:OnNext(function(arg_126_0)
		arg_122_0:ClearOnNext()
		arg_122_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_127_0)
	arg_127_0:PlayActorAnimationAction(9073, "cute", 0.1, 2.333333, function()
		return
	end)
	arg_127_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_127_0:LookAtRoleAction(true, 9073, "9072")
	arg_127_0:ShowTalkView()
	arg_127_0:SetTalkContent(11030018, "", 9073)
	arg_127_0:SetNeedSkip(true, {
		Invoke = function()
			arg_127_0:Skip("LastWord")
		end
	})
	arg_127_0:SetNeedClick(true, {
		Invoke = function()
			arg_127_0:Next()
		end
	})
	arg_127_0:OnNext(function(arg_131_0)
		arg_127_0:ClearOnNext()
		arg_127_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_132_0)
	arg_132_0:EnableCameraByTagAction("19", 1, 0)
	arg_132_0:PlayActorAnimationAction(9073, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_132_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_132_0:LookAtRoleAction(true, 9073, "9510")
	arg_132_0:ShowTalkView()
	arg_132_0:SetTalkContent(11030019, "", 9073)
	arg_132_0:SetNeedSkip(true, {
		Invoke = function()
			arg_132_0:Skip("LastWord")
		end
	})
	arg_132_0:SetNeedClick(true, {
		Invoke = function()
			arg_132_0:Next()
		end
	})
	arg_132_0:OnNext(function(arg_136_0)
		arg_132_0:ClearOnNext()
		arg_132_0:DialogueNode_21()
	end)
end

function var_0_0.DialogueNode_21(arg_137_0)
	arg_137_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_137_0:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_137_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_137_0:LookAtRoleAction(true, 9510, "9073")
	arg_137_0:ShowTalkView()
	arg_137_0:SetTalkContent(11030020, "", 9510)
	arg_137_0:SetNeedSkip(true, {
		Invoke = function()
			arg_137_0:Skip("LastWord")
		end
	})
	arg_137_0:SetNeedClick(true, {
		Invoke = function()
			arg_137_0:Next()
		end
	})
	arg_137_0:OnNext(function(arg_142_0)
		arg_137_0:ClearOnNext()
		arg_137_0:DialogueNode_22()
	end)
end

function var_0_0.DialogueNode_22(arg_143_0)
	arg_143_0:EnableCameraByTagAction("19", 2, 1)
	arg_143_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_143_0:ShowTalkView()
	arg_143_0:SetTalkContent(11030024, "", 9510)
	arg_143_0:SetNeedSkip(true, {
		Invoke = function()
			arg_143_0:Skip("LastWord")
		end
	})
	arg_143_0:SetNeedClick(true, {
		Invoke = function()
			arg_143_0:Next()
		end
	})
	arg_143_0:OnNext(function(arg_147_0)
		arg_143_0:ClearOnNext()
		arg_143_0:DialogueNode_23()
	end)
end

function var_0_0.DialogueNode_23(arg_148_0)
	arg_148_0:PlayActorAnimationAction(9073, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	arg_148_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_148_0:LookAtRoleAction(true, 9073, "9510")
	arg_148_0:PlayActorEmoteAction(9073, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	arg_148_0:EnableCameraByTagAction("19", 1, 1)
	arg_148_0:ShowTalkView()
	arg_148_0:SetTalkContent(11030025, "", 9073)
	arg_148_0:SetNeedSkip(false, {
		Invoke = function()
			arg_148_0:Skip("End")
		end
	})
	arg_148_0:SetNeedClick(true, {
		Invoke = function()
			arg_148_0:Next()
		end
	})
	arg_148_0:OnNext(function(arg_153_0)
		arg_148_0:ClearOnNext()
		arg_148_0:BlackFadeDialogueNode_24()
	end)
end

function var_0_0.BlackFadeDialogueNode_24(arg_154_0)
	arg_154_0:HideTalkView()
	arg_154_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_154_0:HideAllDynamicAction(false, false, 4095, {})
		arg_154_0:DestroyCharAction(9072)
		arg_154_0:DestroyCharAction(9073)
		arg_154_0:DestroyCharAction(9510)
		arg_154_0:DestroyCharAction(9514)
		arg_154_0:Agent_PlayerPosControl("chuansong", function()
			arg_154_0:EnableCameraByTagAction("", 1, 0)
		end)
		arg_154_0:WalkingPeopleGlobleCull(false)
		arg_154_0:ContinueBlackFade()
		arg_154_0:OnNext(function()
			arg_154_0:ClearOnNext()
			arg_154_0:CloseStoryEventNode_25()
		end)
	end, function()
		arg_154_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_25(arg_159_0)
	arg_159_0:EnableCameraCutAction(false)
	arg_159_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_160_0)
	arg_160_0:RegisterTalkFunction("LastWord", arg_160_0.DialogueNode_23)
	arg_160_0:RegisterTalkFunction("End", arg_160_0.CloseStoryEventNode_25)
end

return var_0_0
