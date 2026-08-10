BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11006", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11006"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11006"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:SetCharToTagAction(9512, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "0", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:ActorSeekerAction(9073, {
			"0_1"
		}, 0.4, function()
			return
		end)
		arg_5_0:CameraMoveAction("1", 4, 3, 6, 1)
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
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(11006001, "", 9073)
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
	arg_12_0:OnNext(function(arg_15_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_16_0)
	arg_16_0:SetCharToTagAction(9073, "0_1", function()
		return
	end)
	arg_16_0:EnableCameraByTagAction("2", 1, 0)
	arg_16_0:DelayTimeAction(2, function()
		arg_16_0:EnableCameraByTagAction("2_1", 1, 0)
	end)
	arg_16_0:DelayTimeAction(1, function()
		arg_16_0:ActorSeekerAction(9073, {
			"3"
		}, 2.5, function()
			return
		end)
	end)
	arg_16_0:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11006002, "", 9073)
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
	arg_16_0:OnNext(function(arg_24_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_25_0)
	arg_25_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_25_0:SetCharToTagAction(9073, "3", function()
		return
	end)
	arg_25_0:PlayActorEmoteAction(9512, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_25_0:PlayActorAnimationAction(9512, "summer_doubt", 0, 2, function()
		return
	end)
	arg_25_0:ShowTalkView()
	arg_25_0:SetTalkContent(11006003, "", 9512)

	local var_25_0 = {
		[0] = {
			id = 11006004,
			icon = "",
			Invoke = function()
				arg_25_0:Next(11006004)
			end
		},
		{
			id = 11006005,
			icon = "",
			Invoke = function()
				arg_25_0:Next(11006005)
			end
		},
		Length = 2
	}

	arg_25_0:SetChoice(var_25_0, false)
	arg_25_0:SetNeedSkip(false, nil)
	arg_25_0:SetNeedClick(false, nil)
	arg_25_0:OnNext(function(arg_31_0)
		arg_25_0:ClearOnNext()
		arg_25_0:CloseChoice()

		if arg_31_0 == 11006004 then
			arg_25_0:DialogueBranchNode_5()
		elseif arg_31_0 == 11006005 then
			arg_25_0:DialogueBranchNode_6()
		end
	end)
end

function var_0_0.DialogueBranchNode_5(arg_32_0)
	arg_32_0:OnNext(function()
		arg_32_0:ClearOnNext()
		arg_32_0:PureActorDialogueNode_7()
	end)
	arg_32_0:Next()
end

function var_0_0.PureActorDialogueNode_7(arg_34_0)
	arg_34_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_34_0:DelayTimeAction(2, function()
		arg_34_0:EventAction(function()
			arg_34_0:ImmediateNextFlag(-1)
		end)
		arg_34_0:PlayActorEmoteAction(9073, "shocked01_end", 0, 0.4000001, function()
			return
		end, true, false)
	end)
	arg_34_0:EnableCameraByTagAction("4_1", 1, 0)
	arg_34_0:CameraMoveAction("4_1", 4, 1, 1, 0.3)
	arg_34_0:HideTalkView()
	arg_34_0:OnNext(function()
		arg_34_0:ClearOnNext()
		arg_34_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_40_0)
	arg_40_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_40_0:PlayActorAnimationAction(9512, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11006006, "", 9512)
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
	arg_45_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_45_0:PlayActorAnimationAction(9073, "happy04", 0, 2.2, function()
		return
	end)
	arg_45_0:DelayTimeAction(1.5, function()
		arg_45_0:SetNeedClick(true, {
			Invoke = function()
				arg_45_0:Next()
			end
		})
		arg_45_0:SetNeedSkip(false, nil)
	end)
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(11006007, "", 9073)
	arg_45_0:SetNeedSkip(true, {
		Invoke = function()
			arg_45_0:Skip("End")
		end
	})
	arg_45_0:SetNeedClick(false, {
		Invoke = function()
			arg_45_0:Next()
		end
	})
	arg_45_0:OnNext(function(arg_51_0)
		arg_45_0:ClearOnNext()
		arg_45_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_52_0)
	arg_52_0:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11006008, "", 9073)
	arg_52_0:SetNeedSkip(true, {
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
	arg_57_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_57_0:PlayActorEmoteAction(9512, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	arg_57_0:PlayActorAnimationAction(9512, "action2_3", 0, 1.333333, function()
		return
	end)
	arg_57_0:ShowTalkView()
	arg_57_0:SetTalkContent(11006009, "", 9512)
	arg_57_0:SetNeedSkip(true, {
		Invoke = function()
			arg_57_0:Skip("End")
		end
	})
	arg_57_0:SetNeedClick(true, {
		Invoke = function()
			arg_57_0:Next()
		end
	})
	arg_57_0:OnNext(function(arg_62_0)
		arg_57_0:ClearOnNext()
		arg_57_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_63_0)
	arg_63_0:PlayActorEmoteAction(9512, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_63_0:ShowTalkView()
	arg_63_0:SetTalkContent(11006010, "", 9512)
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
	arg_63_0:OnNext(function(arg_67_0)
		arg_63_0:ClearOnNext()
		arg_63_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_68_0)
	arg_68_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_68_0:PlayActorAnimationAction(9073, "proud", 0, 2.333333, function()
		return
	end)
	arg_68_0:ShowTalkView()
	arg_68_0:SetTalkContent(11006011, "", 9073)
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
		arg_68_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_73_0)
	arg_73_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_73_0:PlayActorAnimationAction(9512, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_73_0:PlayActorEmoteAction(9512, "squint01_end", 0, 0.4333335, function()
		return
	end, true, false)
	arg_73_0:ShowTalkView()
	arg_73_0:SetTalkContent(11006012, "", 9512)
	arg_73_0:SetNeedSkip(true, {
		Invoke = function()
			arg_73_0:Skip("End")
		end
	})
	arg_73_0:SetNeedClick(true, {
		Invoke = function()
			arg_73_0:Next()
		end
	})
	arg_73_0:OnNext(function(arg_78_0)
		arg_73_0:ClearOnNext()
		arg_73_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_79_0)
	arg_79_0:PlayActorAnimationAction(9512, "action2_3", 0, 1.333333, function()
		return
	end)
	arg_79_0:ShowTalkView()
	arg_79_0:SetTalkContent(11006013, "", 9512)
	arg_79_0:SetNeedSkip(true, {
		Invoke = function()
			arg_79_0:Skip("End")
		end
	})
	arg_79_0:SetNeedClick(true, {
		Invoke = function()
			arg_79_0:Next()
		end
	})
	arg_79_0:OnNext(function(arg_83_0)
		arg_79_0:ClearOnNext()
		arg_79_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_84_0)
	arg_84_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_84_0:PlayActorAnimationAction(9073, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_84_0:ShowTalkView()
	arg_84_0:SetTalkContent(11006014, "", 9073)
	arg_84_0:SetNeedSkip(true, {
		Invoke = function()
			arg_84_0:Skip("End")
		end
	})
	arg_84_0:SetNeedClick(true, {
		Invoke = function()
			arg_84_0:Next()
		end
	})
	arg_84_0:OnNext(function(arg_88_0)
		arg_84_0:ClearOnNext()
		arg_84_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_89_0)
	arg_89_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		arg_89_0:EnableCameraByTagAction("15", 1, 0)
		arg_89_0:CameraMoveAction("15", 4, 4, 6, 0.5)
	end)
	arg_89_0:ShowTalkView()
	arg_89_0:SetTalkContent(11006015, "", 9512)
	arg_89_0:SetNeedSkip(true, {
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
		arg_89_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_95_0)
	arg_95_0:DelayTimeAction(2, function()
		arg_95_0:BlackFadeAction(0.2, 0.2, 0.2, function()
			return
		end, function()
			arg_95_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
			arg_95_0:PlayActorAnimationAction(9512, "conversation_2", 0.2, 3.166667, function()
				return
			end)
			arg_95_0:PlayActorEmoteAction(9512, "glory01", 0, 1.566667, function()
				return
			end, true, false)
		end)
		arg_95_0:DelayTimeAction(0.5, function()
			arg_95_0:SetNeedClick(true, {
				Invoke = function()
					arg_95_0:Next()
				end
			})
			arg_95_0:SetNeedSkip(false, nil)
		end)
	end)
	arg_95_0:ShowTalkView()
	arg_95_0:SetTalkContent(11006016, "", 9512)
	arg_95_0:SetNeedSkip(true, {
		Invoke = function()
			arg_95_0:Skip("End")
		end
	})
	arg_95_0:SetNeedClick(false, {
		Invoke = function()
			arg_95_0:Next()
		end
	})
	arg_95_0:OnNext(function(arg_105_0)
		arg_95_0:ClearOnNext()
		arg_95_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_106_0)
	arg_106_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_106_0:PlayActorAnimationAction(9073, "summer_doubt", 0.2, 2, function()
		arg_106_0:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
			return
		end)
	end)
	arg_106_0:ShowTalkView()
	arg_106_0:SetTalkContent(11006017, "", 9073)
	arg_106_0:SetNeedSkip(true, {
		Invoke = function()
			arg_106_0:Skip("End")
		end
	})
	arg_106_0:SetNeedClick(true, {
		Invoke = function()
			arg_106_0:Next()
		end
	})
	arg_106_0:OnNext(function(arg_111_0)
		arg_106_0:ClearOnNext()
		arg_106_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_112_0)
	arg_112_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_112_0:PlayActorEmoteAction(9512, "complaint01", 0, 1.5, function()
		arg_112_0:PlayActorAnimationAction(9512, "conversation_2", 0.2, 3.166667, function()
			return
		end)
	end, true, false)
	arg_112_0:ShowTalkView()
	arg_112_0:SetTalkContent(11006018, "", 9512)
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
	arg_112_0:OnNext(function(arg_117_0)
		arg_112_0:ClearOnNext()
		arg_112_0:DialogueNode_21()
	end)
end

function var_0_0.DialogueNode_21(arg_118_0)
	arg_118_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		arg_118_0:SetNeedClick(true, {
			Invoke = function()
				arg_118_0:Next()
			end
		})
		arg_118_0:SetNeedSkip(false, nil)
	end, function()
		arg_118_0:EnableCameraByTagAction("19", 1, 0)
	end)
	arg_118_0:ShowTalkView()
	arg_118_0:SetTalkContent(11006019, "", 9512)
	arg_118_0:SetNeedSkip(true, {
		Invoke = function()
			arg_118_0:Skip("End")
		end
	})
	arg_118_0:SetNeedClick(false, {
		Invoke = function()
			arg_118_0:Next()
		end
	})
	arg_118_0:OnNext(function(arg_124_0)
		arg_118_0:ClearOnNext()
		arg_118_0:DialogueNode_22()
	end)
end

function var_0_0.DialogueNode_22(arg_125_0)
	arg_125_0:ShowTalkView()
	arg_125_0:SetTalkContent(11006020, "", 9512)
	arg_125_0:SetNeedSkip(true, {
		Invoke = function()
			arg_125_0:Skip("End")
		end
	})
	arg_125_0:SetNeedClick(true, {
		Invoke = function()
			arg_125_0:Next()
		end
	})
	arg_125_0:OnNext(function(arg_128_0)
		arg_125_0:ClearOnNext()
		arg_125_0:DialogueNode_23()
	end)
end

function var_0_0.DialogueNode_23(arg_129_0)
	arg_129_0:PlayActorEmoteAction(9073, "squint01", 0, 1.733333, function()
		return
	end, true, false)
	arg_129_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		arg_129_0:SetNeedClick(true, {
			Invoke = function()
				arg_129_0:Next()
			end
		})
		arg_129_0:SetNeedSkip(false, nil)
	end, function()
		arg_129_0:EnableCameraByTagAction("21", 1, 0)
	end)
	arg_129_0:ShowTalkView()
	arg_129_0:SetTalkContent(11006021, "", 9073)
	arg_129_0:SetNeedSkip(true, {
		Invoke = function()
			arg_129_0:Skip("End")
		end
	})
	arg_129_0:SetNeedClick(false, {
		Invoke = function()
			arg_129_0:Next()
		end
	})
	arg_129_0:OnNext(function(arg_136_0)
		arg_129_0:ClearOnNext()
		arg_129_0:DialogueNode_24()
	end)
end

function var_0_0.DialogueNode_24(arg_137_0)
	arg_137_0:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
		return
	end)
	arg_137_0:PlayActorEmoteAction(9073, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_137_0:ShowTalkView()
	arg_137_0:SetTalkContent(11006022, "", 9073)
	arg_137_0:SetNeedSkip(true, {
		Invoke = function()
			arg_137_0:Skip("End")
		end
	})
	arg_137_0:SetNeedClick(true, {
		Invoke = function()
			arg_137_0:Next()
		end
	})
	arg_137_0:OnNext(function(arg_142_0)
		arg_137_0:ClearOnNext()
		arg_137_0:DialogueNode_25()
	end)
end

function var_0_0.DialogueNode_25(arg_143_0)
	arg_143_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_143_0:PlayActorAnimationAction(9512, "conversation_1", 0.2, 3, function()
		return
	end)
	arg_143_0:ShowTalkView()
	arg_143_0:SetTalkContent(11006023, "", 9512)
	arg_143_0:SetNeedSkip(true, {
		Invoke = function()
			arg_143_0:Skip("End")
		end
	})
	arg_143_0:SetNeedClick(true, {
		Invoke = function()
			arg_143_0:Next()
		end
	})
	arg_143_0:OnNext(function(arg_147_0)
		arg_143_0:ClearOnNext()
		arg_143_0:DialogueNode_26()
	end)
end

function var_0_0.DialogueNode_26(arg_148_0)
	arg_148_0:EnableCameraByTagAction("24", 1, 0)
	arg_148_0:PlayActorAnimationAction(9073, "summer_doubt_start", 0, 0.7666667, function()
		return
	end)
	arg_148_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_148_0:ShowTalkView()
	arg_148_0:SetTalkContent(11006024, "", 9073)
	arg_148_0:SetNeedSkip(true, {
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
		arg_148_0:DialogueNode_27()
	end)
end

function var_0_0.DialogueNode_27(arg_154_0)
	arg_154_0:SetCharToTagAction(9074, "4", function()
		return
	end)
	arg_154_0:ActorSeekerAction(9074, {
		"2"
	}, 0.6, function()
		return
	end)
	arg_154_0:EnableCameraByTagAction("25", 1, 0)
	arg_154_0:DelayTimeAction(2, function()
		arg_154_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
		arg_154_0:SetCharToTagAction(9073, "6", function()
			arg_154_0:SetLookAtParamsAction(9073, 0.8, 1, 0.7)
			arg_154_0:LookAtRoleAction(true, 9073, "9074")
		end)
		arg_154_0:SetCharToTagAction(9512, "5", function()
			return
		end)
		arg_154_0:DelayTimeAction(0.8, function()
			arg_154_0:SetNeedClick(true, {
				Invoke = function()
					arg_154_0:Next()
				end
			})
			arg_154_0:SetNeedSkip(false, nil)
		end)
	end)
	arg_154_0:ShowTalkView()
	arg_154_0:SetTalkContent(11006025, "", 9074)
	arg_154_0:SetNeedSkip(true, {
		Invoke = function()
			arg_154_0:Skip("End")
		end
	})
	arg_154_0:SetNeedClick(false, {
		Invoke = function()
			arg_154_0:Next()
		end
	})
	arg_154_0:OnNext(function(arg_164_0)
		arg_154_0:ClearOnNext()
		arg_154_0:DialogueNode_28()
	end)
end

function var_0_0.DialogueNode_28(arg_165_0)
	arg_165_0:PlayActorAnimationAction(9073, "summer_shock", 0.1, 1.166667, function()
		arg_165_0:PlayActorEmoteAction(9073, "shocked01_end", 0, 0.4000001, function()
			return
		end, true, false)
	end)
	arg_165_0:ShowTalkView()
	arg_165_0:SetTalkContent(11006026, "", 9073)
	arg_165_0:SetNeedSkip(true, {
		Invoke = function()
			arg_165_0:Skip("End")
		end
	})
	arg_165_0:SetNeedClick(true, {
		Invoke = function()
			arg_165_0:Next()
		end
	})
	arg_165_0:OnNext(function(arg_170_0)
		arg_165_0:ClearOnNext()
		arg_165_0:DialogueNode_29()
	end)
end

function var_0_0.DialogueNode_29(arg_171_0)
	arg_171_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_171_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_171_0:LookAtRoleAction(true, 9074, "9073")
	arg_171_0:ShowTalkView()
	arg_171_0:SetTalkContent(11006027, "", 9074)

	local var_171_0 = {
		[0] = {
			id = 11006028,
			icon = "",
			Invoke = function()
				arg_171_0:Next(11006028)
			end
		},
		{
			id = 11006029,
			icon = "",
			Invoke = function()
				arg_171_0:Next(11006029)
			end
		},
		Length = 2
	}

	arg_171_0:SetChoice(var_171_0, false)
	arg_171_0:SetNeedSkip(false, nil)
	arg_171_0:SetNeedClick(false, nil)
	arg_171_0:OnNext(function(arg_174_0)
		arg_171_0:ClearOnNext()
		arg_171_0:CloseChoice()

		if arg_174_0 == 11006028 then
			arg_171_0:DialogueBranchNode_30()
		elseif arg_174_0 == 11006029 then
			arg_171_0:DialogueBranchNode_31()
		end
	end)
end

function var_0_0.DialogueBranchNode_30(arg_175_0)
	arg_175_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_175_0:LookAtRoleAction(false, 9073, "9074")
	arg_175_0:OnNext(function()
		arg_175_0:ClearOnNext()
		arg_175_0:PureActorDialogueNode_32()
	end)
	arg_175_0:Next()
end

function var_0_0.PureActorDialogueNode_32(arg_177_0)
	arg_177_0:PlayActorAnimationAction(9073, "angry01", 0.2, 4.333333, function()
		return
	end)
	arg_177_0:PlayActorEmoteAction(9073, "shocked01_end", 0, 0.4000001, function()
		return
	end, false, false)
	arg_177_0:EnableCameraByTagAction("27", 1, 0)
	arg_177_0:DelayTimeAction(3.5, function()
		arg_177_0:EventAction(function()
			arg_177_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_177_0:HideTalkView()
	arg_177_0:OnNext(function()
		arg_177_0:ClearOnNext()
		arg_177_0:DialogueNode_33()
	end)
end

function var_0_0.DialogueNode_33(arg_183_0)
	arg_183_0:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_183_0:PlayActorEmoteAction(9073, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	arg_183_0:EnableCameraByTagAction("30", 1, 0)
	arg_183_0:SetLookAtParamsAction(9073, 0.8, 1, 1.2)
	arg_183_0:LookAtRoleAction(true, 9073, "9074")
	arg_183_0:ShowTalkView()
	arg_183_0:SetTalkContent(11006030, "", 9073)
	arg_183_0:SetNeedSkip(true, {
		Invoke = function()
			arg_183_0:Skip("End")
		end
	})
	arg_183_0:SetNeedClick(true, {
		Invoke = function()
			arg_183_0:Next()
		end
	})
	arg_183_0:OnNext(function(arg_188_0)
		arg_183_0:ClearOnNext()
		arg_183_0:DialogueNode_34()
	end)
end

function var_0_0.DialogueNode_34(arg_189_0)
	arg_189_0:EnableCameraByTagAction("31", 1, 0)
	arg_189_0:PlayActorAnimationAction(9074, "conversation_1", 0.2, 3, function()
		return
	end)
	arg_189_0:PlayActorEmoteAction(9073, "anger02_end", 0, 0.6, function()
		return
	end, true, false)
	arg_189_0:ShowTalkView()
	arg_189_0:SetTalkContent(11006031, "", 9074)
	arg_189_0:SetNeedSkip(true, {
		Invoke = function()
			arg_189_0:Skip("End")
		end
	})
	arg_189_0:SetNeedClick(true, {
		Invoke = function()
			arg_189_0:Next()
		end
	})
	arg_189_0:OnNext(function(arg_194_0)
		arg_189_0:ClearOnNext()
		arg_189_0:DialogueNode_35()
	end)
end

function var_0_0.DialogueNode_35(arg_195_0)
	arg_195_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_195_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_195_0:LookAtRoleAction(true, 9073, "9512")
	arg_195_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_195_0:LookAtRoleAction(true, 9074, "9512")
	arg_195_0:ShowTalkView()
	arg_195_0:SetTalkContent(11006032, "", 9073)
	arg_195_0:SetNeedSkip(true, {
		Invoke = function()
			arg_195_0:Skip("End")
		end
	})
	arg_195_0:SetNeedClick(true, {
		Invoke = function()
			arg_195_0:Next()
		end
	})
	arg_195_0:OnNext(function(arg_198_0)
		arg_195_0:ClearOnNext()
		arg_195_0:DialogueNode_36()
	end)
end

function var_0_0.DialogueNode_36(arg_199_0)
	arg_199_0:EnableCameraByTagAction("33", 1, 0)
	arg_199_0:PlayActorAnimationAction(9512, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_199_0:ShowTalkView()
	arg_199_0:SetTalkContent(11006033, "", 9512)
	arg_199_0:SetNeedSkip(true, {
		Invoke = function()
			arg_199_0:Skip("End")
		end
	})
	arg_199_0:SetNeedClick(true, {
		Invoke = function()
			arg_199_0:Next()
		end
	})
	arg_199_0:OnNext(function(arg_203_0)
		arg_199_0:ClearOnNext()
		arg_199_0:DialogueNode_37()
	end)
end

function var_0_0.DialogueNode_37(arg_204_0)
	arg_204_0:ShowTalkView()
	arg_204_0:SetTalkContent(11006034, "", 9512)
	arg_204_0:SetNeedSkip(true, {
		Invoke = function()
			arg_204_0:Skip("End")
		end
	})
	arg_204_0:SetNeedClick(true, {
		Invoke = function()
			arg_204_0:Next()
		end
	})
	arg_204_0:OnNext(function(arg_207_0)
		arg_204_0:ClearOnNext()
		arg_204_0:DialogueNode_38()
	end)
end

function var_0_0.DialogueNode_38(arg_208_0)
	arg_208_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_208_0:PlayActorAnimationAction(9074, "action2_1", 0.2, 1.666667, function()
		return
	end)
	arg_208_0:ShowTalkView()
	arg_208_0:SetTalkContent(11006035, "", 9074)
	arg_208_0:SetNeedSkip(true, {
		Invoke = function()
			arg_208_0:Skip("End")
		end
	})
	arg_208_0:SetNeedClick(true, {
		Invoke = function()
			arg_208_0:Next()
		end
	})
	arg_208_0:OnNext(function(arg_212_0)
		arg_208_0:ClearOnNext()
		arg_208_0:DialogueNode_39()
	end)
end

function var_0_0.DialogueNode_39(arg_213_0)
	arg_213_0:ShowTalkView()
	arg_213_0:SetTalkContent(11006036, "", 0)
	arg_213_0:SetNeedSkip(true, {
		Invoke = function()
			arg_213_0:Skip("End")
		end
	})
	arg_213_0:SetNeedClick(true, {
		Invoke = function()
			arg_213_0:Next()
		end
	})
	arg_213_0:OnNext(function(arg_216_0)
		arg_213_0:ClearOnNext()
		arg_213_0:DialogueNode_40()
	end)
end

function var_0_0.DialogueNode_40(arg_217_0)
	arg_217_0:PlayActorAnimationAction(9073, "stroke02", 0.2, 5.166667, function()
		return
	end)
	arg_217_0:ShowTalkView()
	arg_217_0:SetTalkContent(11006037, "", 0)
	arg_217_0:SetNeedSkip(true, {
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
		arg_217_0:BlackFadeDialogueNode_41()
	end)
end

function var_0_0.BlackFadeDialogueNode_41(arg_222_0)
	arg_222_0:HideTalkView()
	arg_222_0:OnBlackFade(false, 0, 0.5, 0.2, 0.2, function()
		arg_222_0:DestroyCharAction(9073)
		arg_222_0:DestroyCharAction(9074)
		arg_222_0:DestroyCharAction(9512)
		arg_222_0:EnableCameraByTagAction("", 1, 0)
		arg_222_0:HideAllDynamicAction(false, false, 4095, {})
		arg_222_0:ContinueBlackFade()
		arg_222_0:OnNext(function()
			arg_222_0:ClearOnNext()
			arg_222_0:CloseStoryEventNode_42()
		end)
	end, function()
		arg_222_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_42(arg_226_0)
	arg_226_0:EnableCameraCutAction(false)
	arg_226_0:EndStory()
end

function var_0_0.DialogueBranchNode_31(arg_227_0)
	arg_227_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_227_0:LookAtRoleAction(false, 9073, "9074")
	arg_227_0:OnNext(function()
		arg_227_0:ClearOnNext()
		arg_227_0:PureActorDialogueNode_32()
	end)
	arg_227_0:Next()
end

function var_0_0.DialogueBranchNode_6(arg_229_0)
	arg_229_0:OnNext(function()
		arg_229_0:ClearOnNext()
		arg_229_0:PureActorDialogueNode_7()
	end)
	arg_229_0:Next()
end

function var_0_0.RegisterFuncMap(arg_231_0)
	arg_231_0:RegisterTalkFunction("End", arg_231_0.BlackFadeDialogueNode_41)
	arg_231_0:RegisterTalkFunction("End", arg_231_0.CloseStoryEventNode_42)
end

return var_0_0
