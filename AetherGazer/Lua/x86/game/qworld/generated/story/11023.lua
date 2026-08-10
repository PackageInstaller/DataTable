BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11023", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11023"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11023"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 11023001, 2.5, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9515, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9072, "3", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9510, "4", function()
			return
		end)
		arg_5_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
		arg_5_0:LookAtRoleAction(true, 9073, "9515")
		arg_5_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
		arg_5_0:LookAtRoleAction(true, 9510, "9515")
		arg_5_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
		arg_5_0:LookAtRoleAction(true, 9072, "9515")
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:PlayActorAnimationAction(9515, "think_loop", 0, 2, function()
			return
		end)
		arg_5_0:PlayActorEmoteAction(9515, "squint01_start", 0, 0.3333333, function()
			return
		end, true, true)
		arg_5_0:HideAllDynamicAction(true, true, 4091, {
			13
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

function var_0_0.DialogueNode_2(arg_15_0)
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(11023002, "", 9515)
	arg_15_0:SetNeedSkip(true, {
		Invoke = function()
			arg_15_0:Skip("LastWord")
		end
	})
	arg_15_0:SetNeedClick(true, {
		Invoke = function()
			arg_15_0:Next()
		end
	})
	arg_15_0:OnNext(function(arg_18_0)
		arg_15_0:ClearOnNext()
		arg_15_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_19_0)
	arg_19_0:EnableCameraByTagAction("2", 1, 0)
	arg_19_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_19_0:ShowTalkView()
	arg_19_0:SetTalkContent(11023003, "", 9510)
	arg_19_0:SetNeedSkip(true, {
		Invoke = function()
			arg_19_0:Skip("LastWord")
		end
	})
	arg_19_0:SetNeedClick(true, {
		Invoke = function()
			arg_19_0:Next()
		end
	})
	arg_19_0:OnNext(function(arg_23_0)
		arg_19_0:ClearOnNext()
		arg_19_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_24_0)
	arg_24_0:EnableCameraByTagAction("4", 1, 0)
	arg_24_0:PlayActorEmoteAction(9515, "squint01_end", 0, 0.4333335, function()
		return
	end, true, false)
	arg_24_0:SetLookAtParamsAction(9515, 0.6, 0.8, 1)
	arg_24_0:LookAtRoleAction(true, 9515, "9510")
	arg_24_0:ActorSeekerAction(9515, {
		"5"
	}, 0.3, function()
		arg_24_0:DelayTimeAction(0.5, function()
			arg_24_0:PlayActorAnimationAction(9515, "action2_1", 0.05, 1.666667, function()
				return
			end)
		end)
	end)
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(11023004, "", 9515)
	arg_24_0:SetNeedSkip(true, {
		Invoke = function()
			arg_24_0:Skip("LastWord")
		end
	})
	arg_24_0:SetNeedClick(true, {
		Invoke = function()
			arg_24_0:Next()
		end
	})
	arg_24_0:OnNext(function(arg_31_0)
		arg_24_0:ClearOnNext()
		arg_24_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_32_0)
	arg_32_0:EnableCameraByTagAction("5", 1, 0)
	arg_32_0:PlayActorAnimationAction(9515, "action2_3", 0.05, 1.333333, function()
		arg_32_0:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11023005, "", 9515)
	arg_32_0:SetNeedSkip(true, {
		Invoke = function()
			arg_32_0:Skip("LastWord")
		end
	})
	arg_32_0:SetNeedClick(true, {
		Invoke = function()
			arg_32_0:Next()
		end
	})
	arg_32_0:OnNext(function(arg_37_0)
		arg_32_0:ClearOnNext()
		arg_32_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_38_0)
	arg_38_0:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_38_0:EnableCameraByTagAction("6", 1, 0)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11023006, "", 9073)
	arg_38_0:SetNeedSkip(true, {
		Invoke = function()
			arg_38_0:Skip("LastWord")
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
	arg_43_0:SetLookAtParamsAction(9515, 0.8, 1, 1)
	arg_43_0:LookAtRoleAction(true, 9515, "9073")
	arg_43_0:EnableCameraByTagAction("7", 1, 0)
	arg_43_0:PlayActorAnimationAction(9515, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_43_0:CameraMoveAction("7", 4, 5, 5, 0.2)
	arg_43_0:ShowTalkView()
	arg_43_0:SetTalkContent(11023007, "", 9515)
	arg_43_0:SetNeedSkip(true, {
		Invoke = function()
			arg_43_0:Skip("LastWord")
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
	arg_48_0:EnableCameraByTagAction("8", 1, 0)
	arg_48_0:PlayActorEmoteAction(9072, "disdain01_start", 0, 0.4, function()
		return
	end, true, true)
	arg_48_0:CameraMoveAction("8", 4, 1, 0.8, 0.4)
	arg_48_0:ShowTalkView()
	arg_48_0:SetTalkContent(11023008, "", 9072)
	arg_48_0:SetNeedSkip(true, {
		Invoke = function()
			arg_48_0:Skip("LastWord")
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
	arg_53_0:EnableCameraByTagAction("9", 1, 0)
	arg_53_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_53_0:LookAtRoleAction(true, 9073, "9072")
	arg_53_0:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_53_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_53_0:ShowTalkView()
	arg_53_0:SetTalkContent(11023009, "", 9073)
	arg_53_0:SetNeedSkip(true, {
		Invoke = function()
			arg_53_0:Skip("LastWord")
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
	arg_59_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_59_0:LookAtRoleAction(true, 9072, "9073")
	arg_59_0:PlayActorAnimationAction(9072, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_59_0:PlayActorEmoteAction(9072, "shocked01_start", 0, 0.3666667, function()
		return
	end, false, false)
	arg_59_0:ShowTalkView()
	arg_59_0:SetTalkContent(11023010, "", 9072)
	arg_59_0:SetNeedSkip(true, {
		Invoke = function()
			arg_59_0:Skip("LastWord")
		end
	})
	arg_59_0:SetNeedClick(true, {
		Invoke = function()
			arg_59_0:Next()
		end
	})
	arg_59_0:OnNext(function(arg_64_0)
		arg_59_0:ClearOnNext()
		arg_59_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_65_0)
	arg_65_0:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_65_0:EnableCameraByTagAction("11", 1, 0)
	arg_65_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_65_0:LookAtRoleAction(true, 9510, "9072")
	arg_65_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, false, false)
	arg_65_0:ShowTalkView()
	arg_65_0:SetTalkContent(11023011, "", 9073)
	arg_65_0:SetNeedSkip(true, {
		Invoke = function()
			arg_65_0:Skip("LastWord")
		end
	})
	arg_65_0:SetNeedClick(true, {
		Invoke = function()
			arg_65_0:Next()
		end
	})
	arg_65_0:OnNext(function(arg_70_0)
		arg_65_0:ClearOnNext()
		arg_65_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_71_0)
	arg_71_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_71_0:ShowTalkView()
	arg_71_0:SetTalkContent(11023012, "", 9510)
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
		arg_71_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_76_0)
	arg_76_0:PlayActorAnimationAction(9073, "action3_3", 0.05, 2.566667, function()
		return
	end)
	arg_76_0:ShowTalkView()
	arg_76_0:SetTalkContent(11023013, "", 9073)
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
	arg_76_0:OnNext(function(arg_80_0)
		arg_76_0:ClearOnNext()
		arg_76_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_81_0)
	arg_81_0:EnableCameraByTagAction("14", 1, 0)
	arg_81_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_81_0:PlayActorEmoteAction(9510, "blink", 0, 0.3333333, function()
		return
	end, true, false)
	arg_81_0:SetLookAtParamsAction(9072, 0.6, 0.8, 1)
	arg_81_0:LookAtRoleAction(false, 9072, "9073")
	arg_81_0:ShowTalkView()
	arg_81_0:SetTalkContent(11023014, "", 9510)
	arg_81_0:SetNeedSkip(true, {
		Invoke = function()
			arg_81_0:Skip("LastWord")
		end
	})
	arg_81_0:SetNeedClick(true, {
		Invoke = function()
			arg_81_0:Next()
		end
	})
	arg_81_0:OnNext(function(arg_86_0)
		arg_81_0:ClearOnNext()
		arg_81_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_87_0)
	arg_87_0:EnableCameraByTagAction("15", 1, 0)
	arg_87_0:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_87_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_87_0:ShowTalkView()
	arg_87_0:SetTalkContent(11023015, "", 9073)
	arg_87_0:SetNeedSkip(true, {
		Invoke = function()
			arg_87_0:Skip("LastWord")
		end
	})
	arg_87_0:SetNeedClick(true, {
		Invoke = function()
			arg_87_0:Next()
		end
	})
	arg_87_0:OnNext(function(arg_92_0)
		arg_87_0:ClearOnNext()
		arg_87_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_93_0)
	arg_93_0:EnableCameraByTagAction("16", 1, 0)
	arg_93_0:CameraMoveAction("16", 4, 1, 0.8, 0.3)
	arg_93_0:PlayActorAnimationAction(9072, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_93_0:ShowTalkView()
	arg_93_0:SetTalkContent(11023016, "", 9072)
	arg_93_0:SetNeedSkip(true, {
		Invoke = function()
			arg_93_0:Skip("LastWord")
		end
	})
	arg_93_0:SetNeedClick(true, {
		Invoke = function()
			arg_93_0:Next()
		end
	})
	arg_93_0:OnNext(function(arg_97_0)
		arg_93_0:ClearOnNext()
		arg_93_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_98_0)
	arg_98_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_98_0:EnableCameraByTagAction("27", 1, 0)
		arg_98_0:CameraMoveAction("27", 4, 4, 10, 1.5)
	end)
	arg_98_0:ShowTalkView()
	arg_98_0:SetTalkContent(11023017, "", 9072)
	arg_98_0:SetNeedSkip(true, {
		Invoke = function()
			arg_98_0:Skip("LastWord")
		end
	})
	arg_98_0:SetNeedClick(true, {
		Invoke = function()
			arg_98_0:Next()
		end
	})
	arg_98_0:OnNext(function(arg_103_0)
		arg_98_0:ClearOnNext()
		arg_98_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_104_0)
	arg_104_0:ShowTalkView()
	arg_104_0:SetTalkContent(11023018, "", 9072)
	arg_104_0:SetNeedSkip(true, {
		Invoke = function()
			arg_104_0:Skip("LastWord")
		end
	})
	arg_104_0:SetNeedClick(true, {
		Invoke = function()
			arg_104_0:Next()
		end
	})
	arg_104_0:OnNext(function(arg_107_0)
		arg_104_0:ClearOnNext()
		arg_104_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_108_0)
	arg_108_0:ShowTalkView()
	arg_108_0:SetTalkContent(11023019, "", 9073)
	arg_108_0:SetNeedSkip(false, {
		Invoke = function()
			arg_108_0:Skip("End")
		end
	})
	arg_108_0:SetNeedClick(true, {
		Invoke = function()
			arg_108_0:Next()
		end
	})
	arg_108_0:OnNext(function(arg_111_0)
		arg_108_0:ClearOnNext()
		arg_108_0:PureActorDialogueNode_20()
	end)
end

function var_0_0.PureActorDialogueNode_20(arg_112_0)
	arg_112_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_112_0:EnableCameraByTagAction("xiuchuan_1", 1, 0)
		arg_112_0:PlayActorAnimationAction(9073, "jack_kick_1", 0, 1.166667, function()
			return
		end)
		arg_112_0:SetCharToTagAction(9073, "xiuchuan_1", function()
			return
		end)
		arg_112_0:DelayTimeAction(1.8, function()
			arg_112_0:CameraMoveAction("xiuchuan_2", 1, 4, 4, 0.4)
			arg_112_0:EnableCameraByTagAction("xiuchuan_2", 1, 0)
			arg_112_0:DelayTimeAction(2.2, function()
				arg_112_0:EnableCameraByTagAction("xiuchuan_4", 1, 0)
				arg_112_0:DelayTimeAction(2, function()
					arg_112_0:BlackFadeAction(0.2, 0.2, 0.2, function()
						arg_112_0:InstEffectAction({
							pointTag = "bujian",
							destroyMode = "DontDestroy",
							createMode = "Point",
							path = "QWWorld/Effect/EmotionBubble/fx_canlan_0401.prefab"
						})
					end, function()
						arg_112_0:HideAllDynamicAction(true, true, 4091, {
							12
						})
					end)
					arg_112_0:DelayTimeAction(2.6, function()
						arg_112_0:EventAction(function()
							arg_112_0:ImmediateNextFlag(-1)
						end)
					end)
				end)
				arg_112_0:DestroyCharAction(9073)
				arg_112_0:CameraMoveAction("xiuchuan_4", 1, 4, 5, 0.4)
			end)
			arg_112_0:SetCharToTagAction(9073, "xiuchuan_2", function()
				return
			end)
			arg_112_0:PlayActorAnimationAction(9073, "jack_kick_2", 0, 1.933334, function()
				return
			end)
		end)
		arg_112_0:CameraMoveAction("xiuchuan_1", 1, 2, 4, 0.4)
		arg_112_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_06_xiuchuan", "", "")
	end)
	arg_112_0:HideTalkView()
	arg_112_0:OnNext(function()
		arg_112_0:ClearOnNext()
		arg_112_0:BlackFadeDialogueNode_21()
	end)
end

function var_0_0.BlackFadeDialogueNode_21(arg_127_0)
	arg_127_0:HideTalkView()
	arg_127_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_127_0:HideAllDynamicAction(false, false, 4095, {})
		arg_127_0:DestroyCharAction(9072)
		arg_127_0:DestroyCharAction(9510)
		arg_127_0:DestroyCharAction(9515)
		arg_127_0:Agent_PlayerPosControl("chuansong", function()
			arg_127_0:EnableCameraByTagAction("", 1, 0)
		end)
		arg_127_0:ContinueBlackFade()
		arg_127_0:OnNext(function()
			arg_127_0:ClearOnNext()
			arg_127_0:CloseStoryEventNode_22()
		end)
	end, function()
		arg_127_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_22(arg_132_0)
	arg_132_0:EnableCameraCutAction(false)
	arg_132_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_133_0)
	arg_133_0:RegisterTalkFunction("LastWord", arg_133_0.DialogueNode_19)
	arg_133_0:RegisterTalkFunction("End", arg_133_0.CloseStoryEventNode_22)
end

return var_0_0
