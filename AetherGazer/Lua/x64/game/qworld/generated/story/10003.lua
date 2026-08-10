BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10003", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10003"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10003"
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
		arg_5_0:SetCharToTagAction(9074, "9074_1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
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

function var_0_0.DialogueNode_2(arg_11_0)
	arg_11_0:PlayActorAnimationAction(9070, "happy01", 0.1, 2.333333, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(10003001, "", 9070)
	arg_11_0:SetNeedSkip(false, {
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
	arg_16_0:EnableCameraByTagAction("2", 1, 0)
	arg_16_0:PlayActorAnimationAction(9074, "conversation_1", 0.1, 3, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(10003002, "", 9074)
	arg_16_0:SetNeedSkip(false, {
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
	arg_21_0:EnableCameraByTagAction("3", 1, 0)
	arg_21_0:DelayTimeAction(1.5, function()
		arg_21_0:PlayActorAnimationAction(9070, "summer_doubt", 0.3, 2, function()
			return
		end)
	end)
	arg_21_0:PlayActorAnimationAction(9070, "conversation_1", 0.1, 3, function()
		return
	end)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(10003003, "", 9070)
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
	arg_21_0:OnNext(function(arg_27_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_28_0)
	arg_28_0:PlayActorAnimationAction(9070, "conversation_2", 0.1, 3.166667, function()
		return
	end)
	arg_28_0:EnableCameraByTagAction("4", 1, 0)
	arg_28_0:ShowTalkView()
	arg_28_0:SetTalkContent(10003004, "", 9070)
	arg_28_0:SetNeedSkip(false, {
		Invoke = function()
			arg_28_0:Skip("End")
		end
	})
	arg_28_0:SetNeedClick(true, {
		Invoke = function()
			arg_28_0:Next()
		end
	})
	arg_28_0:OnNext(function(arg_32_0)
		arg_28_0:ClearOnNext()
		arg_28_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_33_0)
	arg_33_0:BlackFadeAction(0.2, 0.3, 0.3, function()
		return
	end, function()
		arg_33_0:EnableCameraByTagAction("5", 1, 0)
		arg_33_0:DelayTimeAction(0.1, function()
			arg_33_0:HideAllDynamicAction(false, false)
		end)
	end)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(10003005, "", 9074)
	arg_33_0:SetNeedSkip(false, {
		Invoke = function()
			arg_33_0:Skip("End")
		end
	})
	arg_33_0:SetNeedClick(true, {
		Invoke = function()
			arg_33_0:Next()
		end
	})
	arg_33_0:OnNext(function(arg_39_0)
		arg_33_0:ClearOnNext()
		arg_33_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_40_0)
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(10003006, "", 9070)
	arg_40_0:SetNeedSkip(false, {
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
		arg_40_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_44_0)
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(10003007, "", 9074)
	arg_44_0:SetNeedSkip(false, {
		Invoke = function()
			arg_44_0:Skip("End")
		end
	})
	arg_44_0:SetNeedClick(true, {
		Invoke = function()
			arg_44_0:Next()
		end
	})
	arg_44_0:OnNext(function(arg_47_0)
		arg_44_0:ClearOnNext()
		arg_44_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_48_0)
	arg_48_0:ShowTalkView()
	arg_48_0:SetTalkContent(10003008, "", 9070)
	arg_48_0:SetNeedSkip(false, {
		Invoke = function()
			arg_48_0:Skip("End")
		end
	})
	arg_48_0:SetNeedClick(true, {
		Invoke = function()
			arg_48_0:Next()
		end
	})
	arg_48_0:OnNext(function(arg_51_0)
		arg_48_0:ClearOnNext()
		arg_48_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_52_0)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(10003009, "", 9070)
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
	arg_52_0:OnNext(function(arg_55_0)
		arg_52_0:ClearOnNext()
		arg_52_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_56_0)
	arg_56_0:BlackFadeAction(0.2, 0.3, 0.3, function()
		return
	end, function()
		arg_56_0:EnableCameraByTagAction("10", 1, 0)
		arg_56_0:CameraMoveAction("10", 4, 4, 5, 0.1)
		arg_56_0:PlayActorAnimationAction(9074, "conversation_1", 0.1, 3, function()
			return
		end)
		arg_56_0:HideAllDynamicAction(true, true)
	end)
	arg_56_0:ShowTalkView()
	arg_56_0:SetTalkContent(10003010, "", 9074)

	local var_56_0 = {
		[0] = {
			id = 10003011,
			icon = "",
			Invoke = function()
				arg_56_0:Next(10003011)
			end
		},
		{
			id = 10003014,
			icon = "",
			Invoke = function()
				arg_56_0:Next(10003014)
			end
		},
		{
			id = 10003020,
			icon = "",
			Invoke = function()
				arg_56_0:Next(10003020)
			end
		},
		Length = 3
	}

	arg_56_0:SetChoice(var_56_0, false)
	arg_56_0:SetNeedSkip(false, nil)
	arg_56_0:SetNeedClick(false, nil)
	arg_56_0:OnNext(function(arg_63_0)
		arg_56_0:ClearOnNext()
		arg_56_0:CloseChoice()

		if arg_63_0 == 10003011 then
			arg_56_0:DialogueBranchNode_12()
		elseif arg_63_0 == 10003014 then
			arg_56_0:DialogueBranchNode_13()
		elseif arg_63_0 == 10003020 then
			arg_56_0:DialogueBranchNode_14()
		end
	end)
end

function var_0_0.DialogueBranchNode_12(arg_64_0)
	arg_64_0:OnNext(function()
		arg_64_0:ClearOnNext()
		arg_64_0:DialogueNode_15()
	end)
	arg_64_0:Next()
end

function var_0_0.DialogueNode_15(arg_66_0)
	arg_66_0:EnableCameraByTagAction("11", 1, 0.7)
	arg_66_0:PlayActorAnimationAction(9070, "win", 0, 1.933333, function()
		return
	end)
	arg_66_0:DelayTimeAction(0.1, function()
		arg_66_0:EnableCameraByTagAction("12", 2, 0.7)
	end)
	arg_66_0:PlayActorEmoteAction(9070, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	arg_66_0:ShowTalkView()
	arg_66_0:SetTalkContent(10003012, "", 9070)
	arg_66_0:SetNeedSkip(false, {
		Invoke = function()
			arg_66_0:Skip("End")
		end
	})
	arg_66_0:SetNeedClick(true, {
		Invoke = function()
			arg_66_0:Next()
		end
	})
	arg_66_0:OnNext(function(arg_72_0)
		arg_66_0:ClearOnNext()
		arg_66_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_73_0)
	arg_73_0:ShowTalkView()
	arg_73_0:SetTalkContent(10003013, "", 9074)
	arg_73_0:SetNeedSkip(false, {
		Invoke = function()
			arg_73_0:Skip("End")
		end
	})
	arg_73_0:SetNeedClick(true, {
		Invoke = function()
			arg_73_0:Next()
		end
	})
	arg_73_0:OnNext(function(arg_76_0)
		arg_73_0:ClearOnNext()
		arg_73_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_77_0)
	arg_77_0:EnableCameraByTagAction("24", 1, 0.7)
	arg_77_0:PlayActorAnimationAction(9074, "action2_1", 0.1, 1.666667, function()
		return
	end)
	arg_77_0:PlayActorEmoteAction(9074, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_77_0:CameraMoveAction("24", 4, 4, 6, 0.5)
	arg_77_0:ShowTalkView()
	arg_77_0:SetTalkContent(10003024, "", 9074)
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
		arg_77_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_83_0)
	arg_83_0:EnableCameraByTagAction("25", 1, 0.7)
	arg_83_0:PlayActorAnimationAction(9070, "summer_shock_start", 0.15, 0.3333333, function()
		return
	end)
	arg_83_0:PlayActorEmoteAction(9070, "complaint02_start", 0, 0.4, function()
		return
	end, true, true)
	arg_83_0:ShowTalkView()
	arg_83_0:SetTalkContent(10003025, "", 9070)
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
		arg_83_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_89_0)
	arg_89_0:PlayActorAnimationAction(9074, "action2_3", 0.1, 1.333333, function()
		return
	end)
	arg_89_0:CameraMoveAction("26", 4, 4, 8, 0.6)
	arg_89_0:EnableCameraByTagAction("26", 1, 0.7)
	arg_89_0:ShowTalkView()
	arg_89_0:SetTalkContent(10003026, "", 9074)
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
	arg_89_0:OnNext(function(arg_93_0)
		arg_89_0:ClearOnNext()
		arg_89_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_94_0)
	arg_94_0:PlayActorAnimationAction(9070, "action5_1", 0.3, 1.666667, function()
		return
	end)
	arg_94_0:ShowTalkView()
	arg_94_0:SetTalkContent(10003027, "", 9070)
	arg_94_0:SetNeedSkip(false, {
		Invoke = function()
			arg_94_0:Skip("End")
		end
	})
	arg_94_0:SetNeedClick(true, {
		Invoke = function()
			arg_94_0:Next()
		end
	})
	arg_94_0:OnNext(function(arg_98_0)
		arg_94_0:ClearOnNext()
		arg_94_0:DialogueNode_21()
	end)
end

function var_0_0.DialogueNode_21(arg_99_0)
	arg_99_0:EnableCameraByTagAction("28", 1, 0.7)
	arg_99_0:CameraMoveAction("28", 4, 4, 10, 0.5)
	arg_99_0:PlayActorAnimationAction(9074, "action2_1", 0.1, 1.666667, function()
		return
	end)
	arg_99_0:PlayActorEmoteAction(9074, "complaint01", 0, 1.5, function()
		return
	end, false, false)
	arg_99_0:PlayActorEmoteAction(9070, "complaint02", 0, 1.466667, function()
		return
	end, false, false)
	arg_99_0:ShowTalkView()
	arg_99_0:SetTalkContent(10003028, "", 9074)
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
	arg_99_0:OnNext(function(arg_105_0)
		arg_99_0:ClearOnNext()
		arg_99_0:DialogueNode_22()
	end)
end

function var_0_0.DialogueNode_22(arg_106_0)
	arg_106_0:PlayActorAnimationAction(9070, "sad_01", 0.1, 6.166667, function()
		return
	end)
	arg_106_0:EnableCameraByTagAction("27", 1, 0)
	arg_106_0:ShowTalkView()
	arg_106_0:SetTalkContent(10003029, "", 9070)
	arg_106_0:SetNeedSkip(false, {
		Invoke = function()
			arg_106_0:Skip("End")
		end
	})
	arg_106_0:SetNeedClick(true, {
		Invoke = function()
			arg_106_0:Next()
		end
	})
	arg_106_0:OnNext(function(arg_110_0)
		arg_106_0:ClearOnNext()
		arg_106_0:DialogueNode_23()
	end)
end

function var_0_0.DialogueNode_23(arg_111_0)
	arg_111_0:PlayActorAnimationAction(9074, "action2_3", 0.1, 1.333333, function()
		return
	end)
	arg_111_0:PlayActorEmoteAction(9074, "complaint01_start", 0.1, 0.3333333, function()
		return
	end, true, true)
	arg_111_0:EnableCameraByTagAction("30", 1, 0.7)
	arg_111_0:ShowTalkView()
	arg_111_0:SetTalkContent(10003030, "", 9074)

	local var_111_0 = {
		[0] = {
			id = 10003031,
			icon = "",
			Invoke = function()
				arg_111_0:Next(10003031)
			end
		},
		{
			id = 10003033,
			icon = "",
			Invoke = function()
				arg_111_0:Next(10003033)
			end
		},
		Length = 2
	}

	arg_111_0:SetChoice(var_111_0, false)
	arg_111_0:SetNeedSkip(false, nil)
	arg_111_0:SetNeedClick(false, nil)
	arg_111_0:OnNext(function(arg_116_0)
		arg_111_0:ClearOnNext()
		arg_111_0:CloseChoice()

		if arg_116_0 == 10003031 then
			arg_111_0:DialogueBranchNode_24()
		elseif arg_116_0 == 10003033 then
			arg_111_0:DialogueBranchNode_25()
		end
	end)
end

function var_0_0.DialogueBranchNode_24(arg_117_0)
	arg_117_0:OnNext(function()
		arg_117_0:ClearOnNext()
		arg_117_0:DialogueNode_26()
	end)
	arg_117_0:Next()
end

function var_0_0.DialogueNode_26(arg_119_0)
	arg_119_0:EnableCameraByTagAction("31", 1, 0.7)
	arg_119_0:PlayActorAnimationAction(9070, "sad_01", 0.1, 6.166667, function()
		return
	end)
	arg_119_0:ShowTalkView()
	arg_119_0:SetTalkContent(10003032, "", 9074)
	arg_119_0:SetNeedSkip(false, {
		Invoke = function()
			arg_119_0:Skip("End")
		end
	})
	arg_119_0:SetNeedClick(true, {
		Invoke = function()
			arg_119_0:Next()
		end
	})
	arg_119_0:OnNext(function(arg_123_0)
		arg_119_0:ClearOnNext()
		arg_119_0:DialogueNode_27()
	end)
end

function var_0_0.DialogueNode_27(arg_124_0)
	arg_124_0:EnableCameraByTagAction("35_1", 1, 0.7)
	arg_124_0:PlayActorEmoteAction(9074, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	arg_124_0:DelayTimeAction(1.2, function()
		arg_124_0:ActorSeekerAction(9074, {
			"9074_35"
		}, 0.5, function()
			return
		end)
		arg_124_0:EnableCameraByTagAction("35_2", 1, 0.7)
		arg_124_0:DelayTimeAction(1.5, function()
			arg_124_0:EnableCameraByTagAction("35_3", 1, 0.7)
			arg_124_0:SetNeedClick(true, {
				Invoke = function()
					arg_124_0:Next()
				end
			})
			arg_124_0:SetNeedSkip(false, nil)
			arg_124_0:PlayActorAnimationAction(9074, "take", 0.1, 1.833333, function()
				return
			end)
		end)
	end)
	arg_124_0:ShowTalkView()
	arg_124_0:SetTalkContent(10003035, "", 9074)
	arg_124_0:SetNeedSkip(false, {
		Invoke = function()
			arg_124_0:Skip("End")
		end
	})
	arg_124_0:SetNeedClick(false, {
		Invoke = function()
			arg_124_0:Next()
		end
	})
	arg_124_0:OnNext(function(arg_133_0)
		arg_124_0:ClearOnNext()
		arg_124_0:DialogueNode_28()
	end)
end

function var_0_0.DialogueNode_28(arg_134_0)
	arg_134_0:EnableCameraByTagAction("36", 1, 0.7)
	arg_134_0:PlayActorEmoteAction(9070, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_134_0:CameraMoveAction("36", 4, 1, 6, 0.2)
	arg_134_0:ShowTalkView()
	arg_134_0:SetTalkContent(10003036, "", 9070)
	arg_134_0:SetNeedSkip(false, {
		Invoke = function()
			arg_134_0:Skip("End")
		end
	})
	arg_134_0:SetNeedClick(true, {
		Invoke = function()
			arg_134_0:Next()
		end
	})
	arg_134_0:OnNext(function(arg_138_0)
		arg_134_0:ClearOnNext()
		arg_134_0:DialogueNode_29()
	end)
end

function var_0_0.DialogueNode_29(arg_139_0)
	arg_139_0:EnableCameraByTagAction("37", 1, 0.7)
	arg_139_0:PlayActorAnimationAction(9074, "action2_1", 0.1, 1.666667, function()
		return
	end)
	arg_139_0:PlayActorEmoteAction(9074, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_139_0:ShowTalkView()
	arg_139_0:SetTalkContent(10003037, "", 9074)
	arg_139_0:SetNeedSkip(false, {
		Invoke = function()
			arg_139_0:Skip("End")
		end
	})
	arg_139_0:SetNeedClick(true, {
		Invoke = function()
			arg_139_0:Next()
		end
	})
	arg_139_0:OnNext(function(arg_144_0)
		arg_139_0:ClearOnNext()
		arg_139_0:DialogueNode_30()
	end)
end

function var_0_0.DialogueNode_30(arg_145_0)
	arg_145_0:EnableCameraByTagAction("38", 1, 0.7)
	arg_145_0:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
	arg_145_0:LookAtAction(true, 9074, "9074_17")
	arg_145_0:DelayTimeAction(1.5, function()
		arg_145_0:PlayActorAnimationAction(9074, "action2_3", 0.1, 1.333333, function()
			return
		end)
		arg_145_0:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
		arg_145_0:LookAtAction(false, 9074, "9074_17")
	end)
	arg_145_0:PlayActorAnimationAction(9070, "stand_female", 0.1, 4, function()
		return
	end)
	arg_145_0:ShowTalkView()
	arg_145_0:SetTalkContent(10003038, "", 9074)
	arg_145_0:SetNeedSkip(false, {
		Invoke = function()
			arg_145_0:Skip("End")
		end
	})
	arg_145_0:SetNeedClick(true, {
		Invoke = function()
			arg_145_0:Next()
		end
	})
	arg_145_0:OnNext(function(arg_151_0)
		arg_145_0:ClearOnNext()
		arg_145_0:DialogueNode_31()
	end)
end

function var_0_0.DialogueNode_31(arg_152_0)
	arg_152_0:EnableCameraByTagAction("39", 1, 0.7)
	arg_152_0:PlayActorAnimationAction(9070, "action3_1", 0.1, 2.266667, function()
		return
	end)
	arg_152_0:PlayActorEmoteAction(9070, "", 0, 0, function()
		return
	end, false, false)
	arg_152_0:ShowTalkView()
	arg_152_0:SetTalkContent(10003039, "", 9070)

	local var_152_0 = {
		Length = 1,
		[0] = {
			id = 10003040,
			icon = "",
			Invoke = function()
				arg_152_0:Next(10003040)
			end
		}
	}

	arg_152_0:SetChoice(var_152_0, false)
	arg_152_0:SetNeedSkip(false, nil)
	arg_152_0:SetNeedClick(false, nil)
	arg_152_0:OnNext(function(arg_156_0)
		arg_152_0:ClearOnNext()
		arg_152_0:CloseChoice()

		if arg_156_0 == 10003040 then
			arg_152_0:DialogueBranchNode_32()
		end
	end)
end

function var_0_0.DialogueBranchNode_32(arg_157_0)
	arg_157_0:OnNext(function()
		arg_157_0:ClearOnNext()
		arg_157_0:BlackFadeDialogueNode_33()
	end)
	arg_157_0:Next()
end

function var_0_0.BlackFadeDialogueNode_33(arg_159_0)
	arg_159_0:HideTalkView()
	arg_159_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_159_0:EnableCameraCutAction(true)
		arg_159_0:EnableCameraByTagAction("", 1, 0.7)
		arg_159_0:HideAllDynamicAction(false, false)
		arg_159_0:DestroyCharAction(9070)
		arg_159_0:DestroyCharAction(9074)
		arg_159_0:ContinueBlackFade()
		arg_159_0:OnNext(function()
			arg_159_0:ClearOnNext()
			arg_159_0:CloseStoryEventNode_34()
		end)
	end, function()
		arg_159_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_34(arg_163_0)
	arg_163_0:EndStory()
end

function var_0_0.DialogueBranchNode_25(arg_164_0)
	arg_164_0:OnNext(function()
		arg_164_0:ClearOnNext()
		arg_164_0:DialogueNode_35()
	end)
	arg_164_0:Next()
end

function var_0_0.DialogueNode_35(arg_166_0)
	arg_166_0:EnableCameraByTagAction("31", 1, 0.7)
	arg_166_0:PlayActorAnimationAction(9070, "win", 0.1, 1.933333, function()
		return
	end)
	arg_166_0:PlayActorEmoteAction(9070, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_166_0:ShowTalkView()
	arg_166_0:SetTalkContent(10003034, "", 9074)
	arg_166_0:SetNeedSkip(false, {
		Invoke = function()
			arg_166_0:Skip("End")
		end
	})
	arg_166_0:SetNeedClick(true, {
		Invoke = function()
			arg_166_0:Next()
		end
	})
	arg_166_0:OnNext(function(arg_171_0)
		arg_166_0:ClearOnNext()
		arg_166_0:DialogueNode_27()
	end)
end

function var_0_0.DialogueBranchNode_13(arg_172_0)
	arg_172_0:OnNext(function()
		arg_172_0:ClearOnNext()
		arg_172_0:DialogueNode_36()
	end)
	arg_172_0:Next()
end

function var_0_0.DialogueNode_36(arg_174_0)
	arg_174_0:EnableCameraByTagAction("14_1", 1, 0)
	arg_174_0:PlayActorEmoteAction(9074, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_174_0:ShowTalkView()
	arg_174_0:SetTalkContent(10003015, "", 9074)
	arg_174_0:SetNeedSkip(false, {
		Invoke = function()
			arg_174_0:Skip("End")
		end
	})
	arg_174_0:SetNeedClick(true, {
		Invoke = function()
			arg_174_0:Next()
		end
	})
	arg_174_0:OnNext(function(arg_178_0)
		arg_174_0:ClearOnNext()
		arg_174_0:DialogueNode_37()
	end)
end

function var_0_0.DialogueNode_37(arg_179_0)
	arg_179_0:EnableCameraByTagAction("16", 1, 0)
	arg_179_0:CameraMoveAction("16", 4, 1, 10, 0.5)
	arg_179_0:PlayActorAnimationAction(9070, "conversation_2", 0.1, 3.166667, function()
		return
	end)
	arg_179_0:ShowTalkView()
	arg_179_0:SetTalkContent(10003016, "", 9070)
	arg_179_0:SetNeedSkip(false, {
		Invoke = function()
			arg_179_0:Skip("End")
		end
	})
	arg_179_0:SetNeedClick(true, {
		Invoke = function()
			arg_179_0:Next()
		end
	})
	arg_179_0:OnNext(function(arg_183_0)
		arg_179_0:ClearOnNext()
		arg_179_0:DialogueNode_38()
	end)
end

function var_0_0.DialogueNode_38(arg_184_0)
	arg_184_0:PlayActorAnimationAction(9074, "action2_1", 0.1, 1.666667, function()
		return
	end)
	arg_184_0:DelayTimeAction(3, function()
		arg_184_0:BlackFadeAction(0.2, 0.3, 0.3, function()
			return
		end, function()
			arg_184_0:CameraMoveAction("17", 4, 4, 6, 1)
			arg_184_0:EnableCameraByTagAction("17", 1, 0)
		end)
	end)
	arg_184_0:DelayTimeAction(2, function()
		arg_184_0:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
		arg_184_0:LookAtAction(true, 9074, "9074_17")
	end)
	arg_184_0:ShowTalkView()
	arg_184_0:SetTalkContent(10003017, "", 9074)
	arg_184_0:SetNeedSkip(false, {
		Invoke = function()
			arg_184_0:Skip("End")
		end
	})
	arg_184_0:SetNeedClick(true, {
		Invoke = function()
			arg_184_0:Next()
		end
	})
	arg_184_0:OnNext(function(arg_192_0)
		arg_184_0:ClearOnNext()
		arg_184_0:DialogueNode_39()
	end)
end

function var_0_0.DialogueNode_39(arg_193_0)
	arg_193_0:EnableCameraByTagAction("18", 1, 0)
	arg_193_0:PlayActorAnimationAction(9070, "summer_doubt", 0.1, 2, function()
		return
	end)
	arg_193_0:PlayActorEmoteAction(9070, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	arg_193_0:ShowTalkView()
	arg_193_0:SetTalkContent(10003018, "", 9070)
	arg_193_0:SetNeedSkip(false, {
		Invoke = function()
			arg_193_0:Skip("End")
		end
	})
	arg_193_0:SetNeedClick(true, {
		Invoke = function()
			arg_193_0:Next()
		end
	})
	arg_193_0:OnNext(function(arg_198_0)
		arg_193_0:ClearOnNext()
		arg_193_0:DialogueNode_40()
	end)
end

function var_0_0.DialogueNode_40(arg_199_0)
	arg_199_0:EnableCameraByTagAction("19", 1, 0)
	arg_199_0:PlayActorAnimationAction(9074, "action2_3", 0.1, 1.333333, function()
		return
	end)
	arg_199_0:PlayActorEmoteAction(9074, "glory01", 0, 1.566667, function()
		return
	end, true, false)
	arg_199_0:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
	arg_199_0:LookAtAction(false, 9074, "9074_17")
	arg_199_0:ShowTalkView()
	arg_199_0:SetTalkContent(10003019, "", 9074)
	arg_199_0:SetNeedSkip(false, {
		Invoke = function()
			arg_199_0:Skip("End")
		end
	})
	arg_199_0:SetNeedClick(true, {
		Invoke = function()
			arg_199_0:Next()
		end
	})
	arg_199_0:OnNext(function(arg_204_0)
		arg_199_0:ClearOnNext()
		arg_199_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueBranchNode_14(arg_205_0)
	arg_205_0:OnNext(function()
		arg_205_0:ClearOnNext()
		arg_205_0:DialogueNode_41()
	end)
	arg_205_0:Next()
end

function var_0_0.DialogueNode_41(arg_207_0)
	arg_207_0:EnableCameraByTagAction("21", 1, 0)
	arg_207_0:CameraMoveAction("21", 4, 1, 0.5, 0.3)
	arg_207_0:PlayActorEmoteAction(9074, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_207_0:ShowTalkView()
	arg_207_0:SetTalkContent(10003021, "", 9074)
	arg_207_0:SetNeedSkip(false, {
		Invoke = function()
			arg_207_0:Skip("End")
		end
	})
	arg_207_0:SetNeedClick(true, {
		Invoke = function()
			arg_207_0:Next()
		end
	})
	arg_207_0:OnNext(function(arg_211_0)
		arg_207_0:ClearOnNext()
		arg_207_0:DialogueNode_42()
	end)
end

function var_0_0.DialogueNode_42(arg_212_0)
	arg_212_0:EnableCameraByTagAction("22", 1, 0)
	arg_212_0:CameraMoveAction("22", 2, 1, 7, 0.6)
	arg_212_0:PlayActorAnimationAction(9070, "action3_1", 0, 2.266667, function()
		return
	end)
	arg_212_0:ShowTalkView()
	arg_212_0:SetTalkContent(10003022, "", 9070)
	arg_212_0:SetNeedSkip(false, {
		Invoke = function()
			arg_212_0:Skip("End")
		end
	})
	arg_212_0:SetNeedClick(true, {
		Invoke = function()
			arg_212_0:Next()
		end
	})
	arg_212_0:OnNext(function(arg_216_0)
		arg_212_0:ClearOnNext()
		arg_212_0:DialogueNode_43()
	end)
end

function var_0_0.DialogueNode_43(arg_217_0)
	arg_217_0:EnableCameraByTagAction("23", 1, 0)
	arg_217_0:CameraMoveAction("23", 2, 4, 6, 0.2)
	arg_217_0:PlayActorEmoteAction(9074, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	arg_217_0:ShowTalkView()
	arg_217_0:SetTalkContent(10003023, "", 9074)
	arg_217_0:SetNeedSkip(false, {
		Invoke = function()
			arg_217_0:Skip("End")
		end
	})
	arg_217_0:SetNeedClick(true, {
		Invoke = function()
			arg_217_0:Next()
		end
	})
	arg_217_0:OnNext(function(arg_221_0)
		arg_217_0:ClearOnNext()
		arg_217_0:DialogueNode_17()
	end)
end

function var_0_0.RegisterFuncMap(arg_222_0)
	arg_222_0:RegisterTalkFunction("End", arg_222_0.CloseStoryEventNode_34)
end

return var_0_0
