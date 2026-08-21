BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11028", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11028"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11028"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {})
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
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

function var_0_0.DialogueNode_2(arg_10_0)
	arg_10_0:ShowTalkView()
	arg_10_0:SetTalkContent(11028001, "", 9073)

	local var_10_0 = {
		[0] = {
			id = 11028002,
			icon = "",
			Invoke = function()
				arg_10_0:Next(11028002)
			end
		},
		{
			id = 11028003,
			icon = "",
			Invoke = function()
				arg_10_0:Next(11028003)
			end
		},
		{
			id = 11028004,
			icon = "",
			Invoke = function()
				arg_10_0:Next(11028004)
			end
		},
		Length = 3
	}

	arg_10_0:SetChoice(var_10_0, false)
	arg_10_0:SetNeedSkip(false, nil)
	arg_10_0:SetNeedClick(false, nil)
	arg_10_0:OnNext(function(arg_14_0)
		arg_10_0:ClearOnNext()
		arg_10_0:CloseChoice()

		if arg_14_0 == 11028002 then
			arg_10_0:DialogueBranchNode_3()
		elseif arg_14_0 == 11028003 then
			arg_10_0:DialogueBranchNode_4()
		elseif arg_14_0 == 11028004 then
			arg_10_0:DialogueBranchNode_5()
		end
	end)
end

function var_0_0.DialogueBranchNode_3(arg_15_0)
	arg_15_0:OnNext(function()
		arg_15_0:ClearOnNext()
		arg_15_0:PureActorDialogueNode_6()
	end)
	arg_15_0:Next()
end

function var_0_0.PureActorDialogueNode_6(arg_17_0)
	arg_17_0:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	arg_17_0:EventAction(function()
		arg_17_0:ImmediateNextFlag(-1)
	end)
	arg_17_0:HideTalkView()
	arg_17_0:OnNext(function()
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_21_0)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11028005, "", 9073)

	local var_21_0 = {
		[0] = {
			id = 11028006,
			icon = "",
			Invoke = function()
				arg_21_0:Next(11028006)
			end
		},
		{
			id = 11028007,
			icon = "",
			Invoke = function()
				arg_21_0:Next(11028007)
			end
		},
		Length = 2
	}

	arg_21_0:SetChoice(var_21_0, false)
	arg_21_0:SetNeedSkip(false, nil)
	arg_21_0:SetNeedClick(false, nil)
	arg_21_0:OnNext(function(arg_24_0)
		arg_21_0:ClearOnNext()
		arg_21_0:CloseChoice()

		if arg_24_0 == 11028006 then
			arg_21_0:DialogueBranchNode_8()
		elseif arg_24_0 == 11028007 then
			arg_21_0:DialogueBranchNode_9()
		end
	end)
end

function var_0_0.DialogueBranchNode_8(arg_25_0)
	arg_25_0:OnNext(function()
		arg_25_0:ClearOnNext()
		arg_25_0:DialogueNode_10()
	end)
	arg_25_0:Next()
end

function var_0_0.DialogueNode_10(arg_27_0)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11028008, "", 9073)
	arg_27_0:SetNeedSkip(false, {
		Invoke = function()
			arg_27_0:Skip("End")
		end
	})
	arg_27_0:SetNeedClick(true, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_30_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_2()
	end)
end

function var_0_0.DialogueBranchNode_9(arg_31_0)
	arg_31_0:OnNext(function()
		arg_31_0:ClearOnNext()
		arg_31_0:DialogueNode_2()
	end)
	arg_31_0:Next()
end

function var_0_0.DialogueBranchNode_4(arg_33_0)
	arg_33_0:OnNext(function()
		arg_33_0:ClearOnNext()
		arg_33_0:PureActorDialogueNode_11()
	end)
	arg_33_0:Next()
end

function var_0_0.PureActorDialogueNode_11(arg_35_0)
	arg_35_0:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	arg_35_0:EventAction(function()
		arg_35_0:ImmediateNextFlag(-1)
	end)
	arg_35_0:HideTalkView()
	arg_35_0:OnNext(function()
		arg_35_0:ClearOnNext()
		arg_35_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_39_0)
	arg_39_0:ShowTalkView()
	arg_39_0:SetTalkContent(11028009, "", 9073)

	local var_39_0 = {
		[0] = {
			id = 11028010,
			icon = "",
			Invoke = function()
				arg_39_0:Next(11028010)
			end
		},
		{
			id = 11028011,
			icon = "",
			Invoke = function()
				arg_39_0:Next(11028011)
			end
		},
		Length = 2
	}

	arg_39_0:SetChoice(var_39_0, false)
	arg_39_0:SetNeedSkip(false, nil)
	arg_39_0:SetNeedClick(false, nil)
	arg_39_0:OnNext(function(arg_42_0)
		arg_39_0:ClearOnNext()
		arg_39_0:CloseChoice()

		if arg_42_0 == 11028010 then
			arg_39_0:DialogueBranchNode_13()
		elseif arg_42_0 == 11028011 then
			arg_39_0:DialogueBranchNode_14()
		end
	end)
end

function var_0_0.DialogueBranchNode_13(arg_43_0)
	arg_43_0:OnNext(function()
		arg_43_0:ClearOnNext()
		arg_43_0:DialogueNode_15()
	end)
	arg_43_0:Next()
end

function var_0_0.DialogueNode_15(arg_45_0)
	arg_45_0:PlaySoundsAction(2, "minigame_activity_3_5", "minigame_activity_3_5_catch_crown", "", "")
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(11028012, "", 9073)
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
	arg_45_0:OnNext(function(arg_48_0)
		arg_45_0:ClearOnNext()
		arg_45_0:PureActorDialogueNode_16()
	end)
end

function var_0_0.PureActorDialogueNode_16(arg_49_0)
	arg_49_0:HideAllDynamicAction(true, true, 1, {
		50012
	})
	arg_49_0:EventAction(function()
		arg_49_0:ImmediateNextFlag(-1)
	end)
	arg_49_0:HideTalkView()
	arg_49_0:OnNext(function()
		arg_49_0:ClearOnNext()
		arg_49_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_52_0)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11028017, "", 9073)

	local var_52_0 = {
		[0] = {
			id = 11028018,
			icon = "",
			Invoke = function()
				arg_52_0:Next(11028018)
			end
		},
		{
			id = 11028019,
			icon = "",
			Invoke = function()
				arg_52_0:Next(11028019)
			end
		},
		Length = 2
	}

	arg_52_0:SetChoice(var_52_0, false)
	arg_52_0:SetNeedSkip(false, nil)
	arg_52_0:SetNeedClick(false, nil)
	arg_52_0:OnNext(function(arg_55_0)
		arg_52_0:ClearOnNext()
		arg_52_0:CloseChoice()

		if arg_55_0 == 11028018 then
			arg_52_0:DialogueBranchNode_18()
		elseif arg_55_0 == 11028019 then
			arg_52_0:DialogueBranchNode_19()
		end
	end)
end

function var_0_0.DialogueBranchNode_18(arg_56_0)
	arg_56_0:OnNext(function()
		arg_56_0:ClearOnNext()
		arg_56_0:PureActorDialogueNode_20()
	end)
	arg_56_0:Next()
end

function var_0_0.PureActorDialogueNode_20(arg_58_0)
	arg_58_0:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	arg_58_0:EventAction(function()
		arg_58_0:ImmediateNextFlag(-1)
	end)
	arg_58_0:HideTalkView()
	arg_58_0:OnNext(function()
		arg_58_0:ClearOnNext()
		arg_58_0:DialogueNode_21()
	end)
end

function var_0_0.DialogueNode_21(arg_62_0)
	arg_62_0:ShowTalkView()
	arg_62_0:SetTalkContent(11028020, "", 9073)

	local var_62_0 = {
		[0] = {
			id = 11028021,
			icon = "",
			Invoke = function()
				arg_62_0:Next(11028021)
			end
		},
		{
			id = 11028022,
			icon = "",
			Invoke = function()
				arg_62_0:Next(11028022)
			end
		},
		Length = 2
	}

	arg_62_0:SetChoice(var_62_0, false)
	arg_62_0:SetNeedSkip(false, nil)
	arg_62_0:SetNeedClick(false, nil)
	arg_62_0:OnNext(function(arg_65_0)
		arg_62_0:ClearOnNext()
		arg_62_0:CloseChoice()

		if arg_65_0 == 11028021 then
			arg_62_0:DialogueBranchNode_22()
		elseif arg_65_0 == 11028022 then
			arg_62_0:DialogueBranchNode_23()
		end
	end)
end

function var_0_0.DialogueBranchNode_22(arg_66_0)
	arg_66_0:OnNext(function()
		arg_66_0:ClearOnNext()
		arg_66_0:DialogueNode_24()
	end)
	arg_66_0:Next()
end

function var_0_0.DialogueNode_24(arg_68_0)
	arg_68_0:PlaySoundsAction(2, "minigame_activity_3_5", "minigame_activity_3_5_catch_crown", "", "")
	arg_68_0:ShowTalkView()
	arg_68_0:SetTalkContent(11028023, "", 9073)
	arg_68_0:SetNeedSkip(false, {
		Invoke = function()
			arg_68_0:Skip("End")
		end
	})
	arg_68_0:SetNeedClick(true, {
		Invoke = function()
			arg_68_0:Next()
		end
	})
	arg_68_0:OnNext(function(arg_71_0)
		arg_68_0:ClearOnNext()
		arg_68_0:PureActorDialogueNode_25()
	end)
end

function var_0_0.PureActorDialogueNode_25(arg_72_0)
	arg_72_0:HideAllDynamicAction(true, true, 1, {
		50011,
		50012
	})
	arg_72_0:EventAction(function()
		arg_72_0:ImmediateNextFlag(-1)
	end)
	arg_72_0:HideTalkView()
	arg_72_0:OnNext(function()
		arg_72_0:ClearOnNext()
		arg_72_0:DialogueNode_26()
	end)
end

function var_0_0.DialogueNode_26(arg_75_0)
	arg_75_0:ShowTalkView()
	arg_75_0:SetTalkContent(11028028, "", 9073)

	local var_75_0 = {
		Length = 1,
		[0] = {
			id = 11028029,
			icon = "",
			Invoke = function()
				arg_75_0:Next(11028029)
			end
		}
	}

	arg_75_0:SetChoice(var_75_0, false)
	arg_75_0:SetNeedSkip(false, nil)
	arg_75_0:SetNeedClick(false, nil)
	arg_75_0:OnNext(function(arg_77_0)
		arg_75_0:ClearOnNext()
		arg_75_0:CloseChoice()

		if arg_77_0 == 11028029 then
			arg_75_0:DialogueBranchNode_27()
		end
	end)
end

function var_0_0.DialogueBranchNode_27(arg_78_0)
	arg_78_0:OnNext(function()
		arg_78_0:ClearOnNext()
		arg_78_0:PureActorDialogueNode_28()
	end)
	arg_78_0:Next()
end

function var_0_0.PureActorDialogueNode_28(arg_80_0)
	arg_80_0:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	arg_80_0:EventAction(function()
		arg_80_0:ImmediateNextFlag(-1)
	end)
	arg_80_0:HideTalkView()
	arg_80_0:OnNext(function()
		arg_80_0:ClearOnNext()
		arg_80_0:DialogueNode_29()
	end)
end

function var_0_0.DialogueNode_29(arg_84_0)
	arg_84_0:PlaySoundsAction(2, "minigame_activity_3_5", "minigame_activity_3_5_catch_crown", "", "")
	arg_84_0:ShowTalkView()
	arg_84_0:SetTalkContent(11028030, "", 9073)

	local var_84_0 = {
		Length = 1,
		[0] = {
			id = 11028031,
			icon = "",
			Invoke = function()
				arg_84_0:Next(11028031)
			end
		}
	}

	arg_84_0:SetChoice(var_84_0, false)
	arg_84_0:SetNeedSkip(false, nil)
	arg_84_0:SetNeedClick(false, nil)
	arg_84_0:OnNext(function(arg_86_0)
		arg_84_0:ClearOnNext()
		arg_84_0:CloseChoice()

		if arg_86_0 == 11028031 then
			arg_84_0:DialogueBranchNode_30()
		end
	end)
end

function var_0_0.DialogueBranchNode_30(arg_87_0)
	arg_87_0:OnNext(function()
		arg_87_0:ClearOnNext()
		arg_87_0:DialogueNode_31()
	end)
	arg_87_0:Next()
end

function var_0_0.DialogueNode_31(arg_89_0)
	arg_89_0:ShowTalkView()
	arg_89_0:SetTalkContent(11028032, "", 9073)
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
	arg_89_0:OnNext(function(arg_92_0)
		arg_89_0:ClearOnNext()
		arg_89_0:BlackFadeDialogueNode_32()
	end)
end

function var_0_0.BlackFadeDialogueNode_32(arg_93_0)
	arg_93_0:HideTalkView()
	arg_93_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_93_0:HideAllDynamicAction(false, false, 1, {
			50013,
			50011,
			50012
		})
		arg_93_0:EnableCameraByTagAction("", 1, 0)
		arg_93_0:DestroyCharAction(9073)
		arg_93_0:EventAction(function()
			arg_93_0:ImmediateNextFlag(-1)
		end)
		arg_93_0:WalkingPeopleGlobleCull(false)
		arg_93_0:ContinueBlackFade()
		arg_93_0:OnNext(function()
			arg_93_0:ClearOnNext()
			arg_93_0:CloseStoryEventNode_33()
		end)
	end, function()
		arg_93_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_33(arg_98_0)
	arg_98_0:EnableCameraCutAction(false)
	arg_98_0:EndStory()
end

function var_0_0.DialogueBranchNode_23(arg_99_0)
	arg_99_0:OnNext(function()
		arg_99_0:ClearOnNext()
		arg_99_0:DialogueNode_17()
	end)
	arg_99_0:Next()
end

function var_0_0.DialogueBranchNode_19(arg_101_0)
	arg_101_0:OnNext(function()
		arg_101_0:ClearOnNext()
		arg_101_0:PureActorDialogueNode_34()
	end)
	arg_101_0:Next()
end

function var_0_0.PureActorDialogueNode_34(arg_103_0)
	arg_103_0:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	arg_103_0:EventAction(function()
		arg_103_0:ImmediateNextFlag(-1)
	end)
	arg_103_0:HideTalkView()
	arg_103_0:OnNext(function()
		arg_103_0:ClearOnNext()
		arg_103_0:DialogueNode_35()
	end)
end

function var_0_0.DialogueNode_35(arg_107_0)
	arg_107_0:ShowTalkView()
	arg_107_0:SetTalkContent(11028024, "", 9073)

	local var_107_0 = {
		[0] = {
			id = 11028025,
			icon = "",
			Invoke = function()
				arg_107_0:Next(11028025)
			end
		},
		{
			id = 11028026,
			icon = "",
			Invoke = function()
				arg_107_0:Next(11028026)
			end
		},
		Length = 2
	}

	arg_107_0:SetChoice(var_107_0, false)
	arg_107_0:SetNeedSkip(false, nil)
	arg_107_0:SetNeedClick(false, nil)
	arg_107_0:OnNext(function(arg_110_0)
		arg_107_0:ClearOnNext()
		arg_107_0:CloseChoice()

		if arg_110_0 == 11028025 then
			arg_107_0:DialogueBranchNode_36()
		elseif arg_110_0 == 11028026 then
			arg_107_0:DialogueBranchNode_37()
		end
	end)
end

function var_0_0.DialogueBranchNode_36(arg_111_0)
	arg_111_0:OnNext(function()
		arg_111_0:ClearOnNext()
		arg_111_0:DialogueNode_38()
	end)
	arg_111_0:Next()
end

function var_0_0.DialogueNode_38(arg_113_0)
	arg_113_0:ShowTalkView()
	arg_113_0:SetTalkContent(11028027, "", 9073)
	arg_113_0:SetNeedSkip(false, {
		Invoke = function()
			arg_113_0:Skip("End")
		end
	})
	arg_113_0:SetNeedClick(true, {
		Invoke = function()
			arg_113_0:Next()
		end
	})
	arg_113_0:OnNext(function(arg_116_0)
		arg_113_0:ClearOnNext()
		arg_113_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueBranchNode_37(arg_117_0)
	arg_117_0:OnNext(function()
		arg_117_0:ClearOnNext()
		arg_117_0:DialogueNode_17()
	end)
	arg_117_0:Next()
end

function var_0_0.DialogueBranchNode_14(arg_119_0)
	arg_119_0:OnNext(function()
		arg_119_0:ClearOnNext()
		arg_119_0:DialogueNode_2()
	end)
	arg_119_0:Next()
end

function var_0_0.DialogueBranchNode_5(arg_121_0)
	arg_121_0:OnNext(function()
		arg_121_0:ClearOnNext()
		arg_121_0:PureActorDialogueNode_39()
	end)
	arg_121_0:Next()
end

function var_0_0.PureActorDialogueNode_39(arg_123_0)
	arg_123_0:PlayActorAnimationAction(9073, "take", 0.05, 1.833333, function()
		return
	end)
	arg_123_0:EventAction(function()
		arg_123_0:ImmediateNextFlag(-1)
	end)
	arg_123_0:HideTalkView()
	arg_123_0:OnNext(function()
		arg_123_0:ClearOnNext()
		arg_123_0:DialogueNode_40()
	end)
end

function var_0_0.DialogueNode_40(arg_127_0)
	arg_127_0:ShowTalkView()
	arg_127_0:SetTalkContent(11028013, "", 9073)

	local var_127_0 = {
		[0] = {
			id = 11028014,
			icon = "",
			Invoke = function()
				arg_127_0:Next(11028014)
			end
		},
		{
			id = 11028015,
			icon = "",
			Invoke = function()
				arg_127_0:Next(11028015)
			end
		},
		Length = 2
	}

	arg_127_0:SetChoice(var_127_0, false)
	arg_127_0:SetNeedSkip(false, nil)
	arg_127_0:SetNeedClick(false, nil)
	arg_127_0:OnNext(function(arg_130_0)
		arg_127_0:ClearOnNext()
		arg_127_0:CloseChoice()

		if arg_130_0 == 11028014 then
			arg_127_0:DialogueBranchNode_41()
		elseif arg_130_0 == 11028015 then
			arg_127_0:DialogueBranchNode_42()
		end
	end)
end

function var_0_0.DialogueBranchNode_41(arg_131_0)
	arg_131_0:OnNext(function()
		arg_131_0:ClearOnNext()
		arg_131_0:DialogueNode_43()
	end)
	arg_131_0:Next()
end

function var_0_0.DialogueNode_43(arg_133_0)
	arg_133_0:ShowTalkView()
	arg_133_0:SetTalkContent(11028016, "", 9073)
	arg_133_0:SetNeedSkip(false, {
		Invoke = function()
			arg_133_0:Skip("End")
		end
	})
	arg_133_0:SetNeedClick(true, {
		Invoke = function()
			arg_133_0:Next()
		end
	})
	arg_133_0:OnNext(function(arg_136_0)
		arg_133_0:ClearOnNext()
		arg_133_0:DialogueNode_2()
	end)
end

function var_0_0.DialogueBranchNode_42(arg_137_0)
	arg_137_0:OnNext(function()
		arg_137_0:ClearOnNext()
		arg_137_0:DialogueNode_2()
	end)
	arg_137_0:Next()
end

function var_0_0.RegisterFuncMap(arg_139_0)
	arg_139_0:RegisterTalkFunction("End", arg_139_0.CloseStoryEventNode_33)
end

return var_0_0
