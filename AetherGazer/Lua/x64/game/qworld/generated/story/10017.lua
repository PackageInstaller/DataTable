BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10017", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10017"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10017"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9509, "9509_1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:DelayTimeAction(0.2, function()
			arg_5_0:EnableCameraByTagAction("1_1", 2, 0.8)
		end)
		arg_5_0:HideAllDynamicAction(true, true)
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
	arg_12_0:PlayActorEmoteAction(9509, "shocked01_start", 0.2, 0.3666667, function()
		return
	end, true, true)
	arg_12_0:DelayTimeAction(2, function()
		arg_12_0:PlayActorAnimationAction(9509, "happy02", 0.2, 3, function()
			return
		end)
		arg_12_0:SetNeedClick(true, {
			Invoke = function()
				arg_12_0:Next()
			end
		})
		arg_12_0:SetNeedSkip(false, nil)
		arg_12_0:PlayActorEmoteAction(9509, "shocked01_end", 0.2, 0.4000001, function()
			return
		end, true, false)
	end)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(10017001, "", 9509)
	arg_12_0:SetNeedSkip(false, {
		Invoke = function()
			arg_12_0:Skip("End")
		end
	})
	arg_12_0:SetNeedClick(false, {
		Invoke = function()
			arg_12_0:Next()
		end
	})
	arg_12_0:OnNext(function(arg_20_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_21_0)
	arg_21_0:EnableCameraByTagAction("2", 1, 0)
	arg_21_0:PlayActorEmoteAction(9070, "fear01", 0.2, 3.166667, function()
		return
	end, true, false)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(10017002, "", 9070)
	arg_21_0:SetNeedSkip(false, {
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
		arg_21_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_26_0)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(10017003, "", 9509)
	arg_26_0:SetNeedSkip(false, {
		Invoke = function()
			arg_26_0:Skip("End")
		end
	})
	arg_26_0:SetNeedClick(true, {
		Invoke = function()
			arg_26_0:Next()
		end
	})
	arg_26_0:OnNext(function(arg_29_0)
		arg_26_0:ClearOnNext()
		arg_26_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_30_0)
	arg_30_0:PlayActorAnimationAction(9070, "summer_doubt", 0.2, 2, function()
		return
	end)
	arg_30_0:EnableCameraByTagAction("4", 1, 0)
	arg_30_0:DelayTimeAction(0.1, function()
		arg_30_0:EnableCameraByTagAction("4_1", 2, 6)
	end)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(10017004, "", 9070)
	arg_30_0:SetNeedSkip(false, {
		Invoke = function()
			arg_30_0:Skip("End")
		end
	})
	arg_30_0:SetNeedClick(true, {
		Invoke = function()
			arg_30_0:Next()
		end
	})
	arg_30_0:OnNext(function(arg_35_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_36_0)
	arg_36_0:PlayActorAnimationAction(9509, "conversation_1", 0.2, 3, function()
		return
	end)
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(10017005, "", 9509)
	arg_36_0:SetNeedSkip(false, {
		Invoke = function()
			arg_36_0:Skip("End")
		end
	})
	arg_36_0:SetNeedClick(true, {
		Invoke = function()
			arg_36_0:Next()
		end
	})
	arg_36_0:OnNext(function(arg_40_0)
		arg_36_0:ClearOnNext()
		arg_36_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_41_0)
	arg_41_0:PlayActorAnimationAction(9070, "sad_01", 0.2, 6.166667, function()
		return
	end)
	arg_41_0:EnableCameraByTagAction("6", 1, 0)
	arg_41_0:CameraMoveAction("6", 4, 1, 6, 0.2)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(10017006, "", 9070)
	arg_41_0:SetNeedSkip(false, {
		Invoke = function()
			arg_41_0:Skip("End")
		end
	})
	arg_41_0:SetNeedClick(true, {
		Invoke = function()
			arg_41_0:Next()
		end
	})
	arg_41_0:OnNext(function(arg_45_0)
		arg_41_0:ClearOnNext()
		arg_41_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_46_0)
	arg_46_0:DelayTimeAction(2.5, function()
		arg_46_0:BlackFadeAction(0.2, 0.3, 0.3, function()
			arg_46_0:EnableCameraByTagAction("7-2", 2, 7)
			arg_46_0:SetNeedClick(true, {
				Invoke = function()
					arg_46_0:Next()
				end
			})
			arg_46_0:SetNeedSkip(false, nil)
		end, function()
			arg_46_0:EnableCameraByTagAction("7-1", 1, 0)
			arg_46_0:HideAllDynamicAction(true, true)
		end)
	end)
	arg_46_0:DelayTimeAction(4.1, function()
		return
	end)
	arg_46_0:EnableCameraByTagAction("7_0", 2, 3)
	arg_46_0:ShowTalkView()
	arg_46_0:SetTalkContent(10017007, "", 9070)
	arg_46_0:SetNeedSkip(false, {
		Invoke = function()
			arg_46_0:Skip("End")
		end
	})
	arg_46_0:SetNeedClick(false, {
		Invoke = function()
			arg_46_0:Next()
		end
	})
	arg_46_0:OnNext(function(arg_54_0)
		arg_46_0:ClearOnNext()
		arg_46_0:BlackFadeDialogueNode_9()
	end)
end

function var_0_0.BlackFadeDialogueNode_9(arg_55_0)
	arg_55_0:HideTalkView()
	arg_55_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_55_0:EnableCameraByTagAction("8", 1, 0)
		arg_55_0:HideAllDynamicAction(false, false)
		arg_55_0:CameraMoveAction("8", 4, 4, 4, 0.5)
		arg_55_0:ContinueBlackFade()
		arg_55_0:OnNext(function()
			arg_55_0:ClearOnNext()
			arg_55_0:DialogueNode_10()
		end)
	end, function()
		arg_55_0:Next()
	end)
end

function var_0_0.DialogueNode_10(arg_59_0)
	arg_59_0:DelayTimeAction(3, function()
		arg_59_0:BlackFadeAction(0.2, 0.3, 0.3, function()
			return
		end, function()
			arg_59_0:EnableCameraByTagAction("8_1", 1, 0)
			arg_59_0:CameraMoveAction("8_1", 4, 4, 4, 0.2)
		end)
	end)
	arg_59_0:DelayTimeAction(6, function()
		arg_59_0:BlackFadeAction(0.2, 0.3, 0.3, function()
			arg_59_0:SetNeedClick(true, {
				Invoke = function()
					arg_59_0:Next()
				end
			})
			arg_59_0:SetNeedSkip(false, nil)
			arg_59_0:PlayActorAnimationAction(9070, "sad_02", 0.2, 6.733334, function()
				return
			end)
		end, function()
			arg_59_0:EnableCameraByTagAction("8_3", 1, 0)
			arg_59_0:HideAllDynamicAction(true, true)
		end)
	end)
	arg_59_0:ShowTalkView()
	arg_59_0:SetTalkContent(10017008, "", 9070)
	arg_59_0:SetNeedSkip(false, {
		Invoke = function()
			arg_59_0:Skip("End")
		end
	})
	arg_59_0:SetNeedClick(false, {
		Invoke = function()
			arg_59_0:Next()
		end
	})
	arg_59_0:OnNext(function(arg_70_0)
		arg_59_0:ClearOnNext()
		arg_59_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_71_0)
	arg_71_0:EnableCameraByTagAction("9", 1, 0)
	arg_71_0:PlayActorAnimationAction(9509, "conversation_1", 0.2, 3, function()
		return
	end)
	arg_71_0:ShowTalkView()
	arg_71_0:SetTalkContent(10017009, "", 9509)
	arg_71_0:SetNeedSkip(false, {
		Invoke = function()
			arg_71_0:Skip("End")
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
	arg_76_0:PlayActorAnimationAction(9070, "action4_1", 0.2, 2.666667, function()
		return
	end)
	arg_76_0:EnableCameraByTagAction("10", 1, 0)
	arg_76_0:DelayTimeAction(0.1, function()
		arg_76_0:EnableCameraByTagAction("10_1", 2, 7)
	end)
	arg_76_0:ShowTalkView()
	arg_76_0:SetTalkContent(10017010, "", 9070)
	arg_76_0:SetNeedSkip(false, {
		Invoke = function()
			arg_76_0:Skip("End")
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
	arg_82_0:EnableCameraByTagAction("11", 1, 0)
	arg_82_0:PlayActorAnimationAction(9070, "action4_3", 0.2, 4.3, function()
		arg_82_0:PlayActorEmoteAction(9070, "complaint01", 0, 1.5, function()
			return
		end, true, false)
	end)
	arg_82_0:PlayActorAnimationAction(9509, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_82_0:DelayTimeAction(0.1, function()
		arg_82_0:EnableCameraByTagAction("11_1", 2, 10)
	end)
	arg_82_0:ShowTalkView()
	arg_82_0:SetTalkContent(10017011, "", 9509)
	arg_82_0:SetNeedSkip(false, {
		Invoke = function()
			arg_82_0:Skip("End")
		end
	})
	arg_82_0:SetNeedClick(true, {
		Invoke = function()
			arg_82_0:Next()
		end
	})
	arg_82_0:OnNext(function(arg_89_0)
		arg_82_0:ClearOnNext()
		arg_82_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_90_0)
	arg_90_0:PlayActorEmoteAction(9509, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	arg_90_0:ShowTalkView()
	arg_90_0:SetTalkContent(10017012, "", 9509)
	arg_90_0:SetNeedSkip(false, {
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
		arg_90_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_95_0)
	arg_95_0:PlayActorAnimationAction(9070, "summer_shock_start", 0, 0.3333333, function()
		return
	end)
	arg_95_0:EnableCameraByTagAction("13_1", 1, 0)
	arg_95_0:DelayTimeAction(0.1, function()
		arg_95_0:EnableCameraByTagAction("13", 2, 0.3)
	end)
	arg_95_0:PlayActorEmoteAction(9070, "sad04_start", 0, 0.5, function()
		return
	end, true, true)
	arg_95_0:ShowTalkView()
	arg_95_0:SetTalkContent(10017013, "", 9070)
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
	arg_95_0:OnNext(function(arg_101_0)
		arg_95_0:ClearOnNext()
		arg_95_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_102_0)
	arg_102_0:PlayActorAnimationAction(9509, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_102_0:EnableCameraByTagAction("14", 1, 0)
	arg_102_0:DelayTimeAction(0.1, function()
		arg_102_0:EnableCameraByTagAction("14_1", 7, 7)
	end)
	arg_102_0:ShowTalkView()
	arg_102_0:SetTalkContent(10017014, "", 9509)
	arg_102_0:SetNeedSkip(false, {
		Invoke = function()
			arg_102_0:Skip("End")
		end
	})
	arg_102_0:SetNeedClick(true, {
		Invoke = function()
			arg_102_0:Next()
		end
	})
	arg_102_0:OnNext(function(arg_107_0)
		arg_102_0:ClearOnNext()
		arg_102_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_108_0)
	arg_108_0:EnableCameraByTagAction("15", 1, 0)
	arg_108_0:PlayActorAnimationAction(9509, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_108_0:DelayTimeAction(0.1, function()
		arg_108_0:EnableCameraByTagAction("15_1", 7, 6)
	end)
	arg_108_0:ShowTalkView()
	arg_108_0:SetTalkContent(10017015, "", 9509)
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
	arg_108_0:OnNext(function(arg_113_0)
		arg_108_0:ClearOnNext()
		arg_108_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_114_0)
	arg_114_0:PlayActorAnimationAction(9509, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_114_0:EnableCameraByTagAction("16", 1, 0)
	arg_114_0:DelayTimeAction(0.1, function()
		arg_114_0:EnableCameraByTagAction("16_1", 7, 6)
	end)
	arg_114_0:ShowTalkView()
	arg_114_0:SetTalkContent(10017016, "", 9509)
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
		arg_114_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_120_0)
	arg_120_0:PlayActorAnimationAction(9509, "action2_1", 0.1, 1.666667, function()
		return
	end)
	arg_120_0:EnableCameraByTagAction("17", 1, 0)
	arg_120_0:PlayActorAnimationAction(9070, "action5_1", 0.15, 1.666667, function()
		return
	end)
	arg_120_0:ShowTalkView()
	arg_120_0:SetTalkContent(10017017, "", 9070)
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
	arg_120_0:OnNext(function(arg_125_0)
		arg_120_0:ClearOnNext()
		arg_120_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_126_0)
	arg_126_0:PlayActorAnimationAction(9509, "action2_3", 0.2, 1.333333, function()
		return
	end)
	arg_126_0:EnableCameraByTagAction("18", 1, 0)
	arg_126_0:DelayTimeAction(0.5, function()
		arg_126_0:PlayActorEmoteAction(9070, "glory01", 0, 1.566667, function()
			return
		end, false, false)
	end)
	arg_126_0:PlayActorEmoteAction(9509, "glory01", 0, 1.566667, function()
		return
	end, true, false)
	arg_126_0:ShowTalkView()
	arg_126_0:SetTalkContent(10017018, "", 9509)
	arg_126_0:SetNeedSkip(false, {
		Invoke = function()
			arg_126_0:Skip("End")
		end
	})
	arg_126_0:SetNeedClick(true, {
		Invoke = function()
			arg_126_0:Next()
		end
	})
	arg_126_0:OnNext(function(arg_133_0)
		arg_126_0:ClearOnNext()
		arg_126_0:DialogueNode_21()
	end)
end

function var_0_0.DialogueNode_21(arg_134_0)
	arg_134_0:EnableCameraByTagAction("19", 1, 0)
	arg_134_0:DelayTimeAction(0.05, function()
		arg_134_0:EnableCameraByTagAction("19_1", 7, 6.5)
	end)
	arg_134_0:DelayTimeAction(6.3, function()
		arg_134_0:EnableCameraByTagAction("19_2", 1, 0)
		arg_134_0:CameraMoveAction("19_2", 1, 4, 6, 3)
		arg_134_0:DelayTimeAction(1, function()
			arg_134_0:SetNeedClick(true, {
				Invoke = function()
					arg_134_0:Next()
				end
			})
			arg_134_0:SetNeedSkip(false, nil)
		end)
	end)
	arg_134_0:ActorSeekerAction(9509, {
		"9509_2",
		"9509_3"
	}, 0.8, function()
		return
	end)
	arg_134_0:ShowTalkView()
	arg_134_0:SetTalkContent(10017019, "", 9509)
	arg_134_0:SetNeedSkip(false, {
		Invoke = function()
			arg_134_0:Skip("End")
		end
	})
	arg_134_0:SetNeedClick(false, {
		Invoke = function()
			arg_134_0:Next()
		end
	})
	arg_134_0:OnNext(function(arg_142_0)
		arg_134_0:ClearOnNext()
		arg_134_0:DialogueNode_22()
	end)
end

function var_0_0.DialogueNode_22(arg_143_0)
	arg_143_0:ShowTalkView()
	arg_143_0:SetTalkContent(10017020, "", 9509)
	arg_143_0:SetNeedSkip(false, {
		Invoke = function()
			arg_143_0:Skip("End")
		end
	})
	arg_143_0:SetNeedClick(true, {
		Invoke = function()
			arg_143_0:Next()
		end
	})
	arg_143_0:OnNext(function(arg_146_0)
		arg_143_0:ClearOnNext()
		arg_143_0:BlackFadeDialogueNode_23()
	end)
end

function var_0_0.BlackFadeDialogueNode_23(arg_147_0)
	arg_147_0:HideTalkView()
	arg_147_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_147_0:EnableCameraCutAction(true)
		arg_147_0:EnableCameraByTagAction("", 1, 0)
		arg_147_0:HideAllDynamicAction(false, false)
		arg_147_0:DestroyCharAction(9070)
		arg_147_0:DestroyCharAction(9509)
		arg_147_0:ContinueBlackFade()
		arg_147_0:OnNext(function()
			arg_147_0:ClearOnNext()
			arg_147_0:CloseStoryEventNode_24()
		end)
	end, function()
		arg_147_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_24(arg_151_0)
	arg_151_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_152_0)
	arg_152_0:RegisterTalkFunction("End", arg_152_0.CloseStoryEventNode_24)
end

return var_0_0
