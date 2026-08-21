BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10007", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10007"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10007"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.3, function()
		arg_5_0:SetCharToTagAction(9071, "9071_1", function()
			arg_5_0:PlayActorEmoteAction(9071, "emote@9071_face", 0, 4, function()
				return
			end, true, true)
		end)
		arg_5_0:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:CameraMoveAction("1", 4, 4, 6, 0.3)
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
	arg_12_0:PlayActorAnimationAction(9071, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(10007001, "", 9071)
	arg_12_0:SetNeedSkip(false, {
		Invoke = function()
			arg_12_0:Skip("End")
		end
	})
	arg_12_0:SetNeedClick(true, {
		Invoke = function()
			arg_12_0:Next()
		end
	})
	arg_12_0:OnNext(function(arg_16_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:PlayActorEmoteAction(9070, "anger02", 0, 1.933333, function()
		return
	end, true, false)
	arg_17_0:CameraMoveAction("2_1", 4, 1, 0.8, 0.4)
	arg_17_0:EnableCameraByTagAction("2_1", 1, 0)
	arg_17_0:DelayTimeAction(2, function()
		arg_17_0:PlayActorAnimationAction(9070, "summer_doubt", 0, 2, function()
			return
		end)
		arg_17_0:PlayActorEmoteAction(9070, "shocked01", 0, 1.4, function()
			return
		end, true, false)
		arg_17_0:EnableCameraByTagAction("2_2", 1, 0)
		arg_17_0:CameraMoveAction("2_2", 4, 2, 6, 0.3)
		arg_17_0:SetNeedClick(true, {
			Invoke = function()
				arg_17_0:Next()
			end
		})
		arg_17_0:SetNeedSkip(false, nil)
	end)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(10007002, "", 9070)
	arg_17_0:SetNeedSkip(false, {
		Invoke = function()
			arg_17_0:Skip("End")
		end
	})
	arg_17_0:SetNeedClick(false, {
		Invoke = function()
			arg_17_0:Next()
		end
	})
	arg_17_0:OnNext(function(arg_25_0)
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_26_0)
	arg_26_0:EnableCameraByTagAction("3", 1, 0)
	arg_26_0:CameraMoveAction("3", 4, 6, 3, 0.1)
	arg_26_0:PlayActorAnimationAction(9071, "action2_3", 0, 1.333333, function()
		return
	end)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(10007003, "", 9071)
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
	arg_26_0:OnNext(function(arg_30_0)
		arg_26_0:ClearOnNext()
		arg_26_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_31_0)
	arg_31_0:EnableCameraByTagAction("4", 1, 0)
	arg_31_0:PlayActorEmoteAction(9070, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	arg_31_0:ShowTalkView()
	arg_31_0:SetTalkContent(10007004, "", 9070)
	arg_31_0:SetNeedSkip(false, {
		Invoke = function()
			arg_31_0:Skip("End")
		end
	})
	arg_31_0:SetNeedClick(true, {
		Invoke = function()
			arg_31_0:Next()
		end
	})
	arg_31_0:OnNext(function(arg_35_0)
		arg_31_0:ClearOnNext()
		arg_31_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_36_0)
	arg_36_0:EnableCameraByTagAction("5", 1, 0)
	arg_36_0:CameraMoveAction("5", 4, 4, 6, 0.2)
	arg_36_0:PlayActorAnimationAction(9070, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(10007005, "", 9070)
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
	arg_41_0:EnableCameraByTagAction("6", 1, 0)
	arg_41_0:PlayActorAnimationAction(9071, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(10007006, "", 9071)

	local var_41_0 = {
		Length = 1,
		[0] = {
			id = 10007007,
			icon = "",
			Invoke = function()
				arg_41_0:Next(10007007)
			end
		}
	}

	arg_41_0:SetChoice(var_41_0, false)
	arg_41_0:SetNeedSkip(false, nil)
	arg_41_0:SetNeedClick(false, nil)
	arg_41_0:OnNext(function(arg_44_0)
		arg_41_0:ClearOnNext()
		arg_41_0:CloseChoice()

		if arg_44_0 == 10007007 then
			arg_41_0:DialogueBranchNode_8()
		end
	end)
end

function var_0_0.DialogueBranchNode_8(arg_45_0)
	arg_45_0:OnNext(function()
		arg_45_0:ClearOnNext()
		arg_45_0:PureActorDialogueNode_9()
	end)
	arg_45_0:Next()
end

function var_0_0.PureActorDialogueNode_9(arg_47_0)
	arg_47_0:EnableCameraByTagAction("7", 1, 0)
	arg_47_0:CameraMoveAction("7", 4, 1, 1, 0.4)
	arg_47_0:PlayActorEmoteAction(9070, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	arg_47_0:DelayTimeAction(2, function()
		arg_47_0:EventAction(function()
			arg_47_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_47_0:HideTalkView()
	arg_47_0:OnNext(function()
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_52_0)
	arg_52_0:EnableCameraByTagAction("8", 1, 0)
	arg_52_0:CameraMoveAction("8", 4, 4, 6, 0.2)
	arg_52_0:PlayActorAnimationAction(9071, "action2_3", 0, 1.333333, function()
		return
	end)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(10007008, "", 9071)
	arg_52_0:SetNeedSkip(false, {
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
		arg_52_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_57_0)
	arg_57_0:PlayActorAnimationAction(9070, "action4_1", 0, 2.666667, function()
		return
	end)
	arg_57_0:EnableCameraByTagAction("9", 1, 0)
	arg_57_0:CameraMoveAction("9", 4, 1, 8, 0.4)
	arg_57_0:ShowTalkView()
	arg_57_0:SetTalkContent(10007009, "", 9070)
	arg_57_0:SetNeedSkip(false, {
		Invoke = function()
			arg_57_0:Skip("End")
		end
	})
	arg_57_0:SetNeedClick(true, {
		Invoke = function()
			arg_57_0:Next()
		end
	})
	arg_57_0:OnNext(function(arg_61_0)
		arg_57_0:ClearOnNext()
		arg_57_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_62_0)
	arg_62_0:PlayActorAnimationAction(9071, "dorm_male_idle01", 0, 8.166667, function()
		return
	end)
	arg_62_0:EnableCameraByTagAction("10", 1, 0)
	arg_62_0:CameraMoveAction("10", 4, 4, 6, 0.3)
	arg_62_0:ShowTalkView()
	arg_62_0:SetTalkContent(10007010, "", 9071)
	arg_62_0:SetNeedSkip(false, {
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
		arg_62_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_67_0)
	arg_67_0:EnableCameraByTagAction("11", 1, 0)
	arg_67_0:PlayActorAnimationAction(9070, "action4_3", 0, 4.3, function()
		return
	end)
	arg_67_0:DelayTimeAction(0.5, function()
		arg_67_0:PlayActorEmoteAction(9070, "shocked01_start", 0, 0.3666667, function()
			return
		end, true, true)
	end)
	arg_67_0:ShowTalkView()
	arg_67_0:SetTalkContent(10007011, "", 9070)
	arg_67_0:SetNeedSkip(false, {
		Invoke = function()
			arg_67_0:Skip("End")
		end
	})
	arg_67_0:SetNeedClick(true, {
		Invoke = function()
			arg_67_0:Next()
		end
	})
	arg_67_0:OnNext(function(arg_73_0)
		arg_67_0:ClearOnNext()
		arg_67_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_74_0)
	arg_74_0:EnableCameraByTagAction("12_1", 1, 0)
	arg_74_0:PlayActorAnimationAction(9071, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_74_0:CameraMoveAction("12_1", 4, 6, 6, 0.3)
	arg_74_0:DelayTimeAction(3, function()
		arg_74_0:EnableCameraByTagAction("12_2", 1, 0)
		arg_74_0:CameraMoveAction("12_2", 1, 6, 7, 0.2)
		arg_74_0:DelayTimeAction(1, function()
			arg_74_0:SetNeedClick(true, {
				Invoke = function()
					arg_74_0:Next()
				end
			})
			arg_74_0:SetNeedSkip(false, nil)
		end)
	end)
	arg_74_0:ShowTalkView()
	arg_74_0:SetTalkContent(10007012, "", 9071)
	arg_74_0:SetNeedSkip(false, {
		Invoke = function()
			arg_74_0:Skip("End")
		end
	})
	arg_74_0:SetNeedClick(false, {
		Invoke = function()
			arg_74_0:Next()
		end
	})
	arg_74_0:OnNext(function(arg_81_0)
		arg_74_0:ClearOnNext()
		arg_74_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_82_0)
	arg_82_0:EnableCameraByTagAction("13_1", 1, 0)
	arg_82_0:PlayActorAnimationAction(9071, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_82_0:CameraMoveAction("13_1", 4, 3, 6, 0.3)
	arg_82_0:DelayTimeAction(2, function()
		arg_82_0:BlackFadeAction(0.2, 0.3, 0.3, function()
			arg_82_0:SetNeedClick(true, {
				Invoke = function()
					arg_82_0:Next()
				end
			})
			arg_82_0:SetNeedSkip(false, nil)
		end, function()
			arg_82_0:EnableCameraByTagAction("13_2", 1, 0)
			arg_82_0:HideAllDynamicAction(false, true)
		end)
	end)
	arg_82_0:ShowTalkView()
	arg_82_0:SetTalkContent(10007013, "", 9071)
	arg_82_0:SetNeedSkip(false, {
		Invoke = function()
			arg_82_0:Skip("End")
		end
	})
	arg_82_0:SetNeedClick(false, {
		Invoke = function()
			arg_82_0:Next()
		end
	})
	arg_82_0:OnNext(function(arg_90_0)
		arg_82_0:ClearOnNext()
		arg_82_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_91_0)
	arg_91_0:BlackFadeAction(0.2, 0.3, 0.2, function()
		return
	end, function()
		arg_91_0:EnableCameraByTagAction("14", 1, 0)
		arg_91_0:PlayActorAnimationAction(9070, "happy01", 0, 2.333333, function()
			arg_91_0:PlayActorEmoteAction(9070, "happy01_start", 0, 0.1333333, function()
				return
			end, true, true)
		end)
		arg_91_0:HideAllDynamicAction(true, true)
	end)
	arg_91_0:ShowTalkView()
	arg_91_0:SetTalkContent(10007014, "", 9070)
	arg_91_0:SetNeedSkip(false, {
		Invoke = function()
			arg_91_0:Skip("End")
		end
	})
	arg_91_0:SetNeedClick(true, {
		Invoke = function()
			arg_91_0:Next()
		end
	})
	arg_91_0:OnNext(function(arg_98_0)
		arg_91_0:ClearOnNext()
		arg_91_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_99_0)
	arg_99_0:EnableCameraByTagAction("15", 1, 0)
	arg_99_0:CameraMoveAction("15", 4, 4, 6, 0.15)
	arg_99_0:ShowTalkView()
	arg_99_0:SetTalkContent(10007015, "", 9071)
	arg_99_0:SetNeedSkip(false, {
		Invoke = function()
			arg_99_0:Skip("End")
		end
	})
	arg_99_0:SetNeedClick(true, {
		Invoke = function()
			arg_99_0:Next()
		end
	})
	arg_99_0:OnNext(function(arg_102_0)
		arg_99_0:ClearOnNext()
		arg_99_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_103_0)
	arg_103_0:PlayActorEmoteAction(9070, "happy01_start", 0, 0.1333333, function()
		return
	end, false, false)
	arg_103_0:PlayActorAnimationAction(9070, "happy02", 0, 3, function()
		return
	end)
	arg_103_0:EnableCameraByTagAction("16", 1, 0)
	arg_103_0:ShowTalkView()
	arg_103_0:SetTalkContent(10007016, "", 9070)
	arg_103_0:SetNeedSkip(false, {
		Invoke = function()
			arg_103_0:Skip("End")
		end
	})
	arg_103_0:SetNeedClick(true, {
		Invoke = function()
			arg_103_0:Next()
		end
	})
	arg_103_0:OnNext(function(arg_108_0)
		arg_103_0:ClearOnNext()
		arg_103_0:BlackFadeDialogueNode_19()
	end)
end

function var_0_0.BlackFadeDialogueNode_19(arg_109_0)
	arg_109_0:HideTalkView()
	arg_109_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_109_0:EnableCameraCutAction(true)
		arg_109_0:EnableCameraByTagAction("", 1, 0.7)
		arg_109_0:HideAllDynamicAction(false, false)
		arg_109_0:DestroyCharAction(9070)
		arg_109_0:DestroyCharAction(9071)
		arg_109_0:ContinueBlackFade()
		arg_109_0:OnNext(function()
			arg_109_0:ClearOnNext()
			arg_109_0:CloseStoryEventNode_20()
		end)
	end, function()
		arg_109_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_20(arg_113_0)
	arg_113_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_114_0)
	arg_114_0:RegisterTalkFunction("End", arg_114_0.CloseStoryEventNode_20)
end

return var_0_0
