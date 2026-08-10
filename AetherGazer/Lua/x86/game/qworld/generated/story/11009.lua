BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11009", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11009"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11009"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		arg_5_0:SetCharToTagAction(9512, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "4", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4091, {})
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
	arg_12_0:SetTalkContent(11009001, "", 9512)

	local var_12_0 = {
		[0] = {
			id = 11009002,
			icon = "",
			Invoke = function()
				arg_12_0:Next(11009002)
			end
		},
		{
			id = 11009003,
			icon = "",
			Invoke = function()
				arg_12_0:Next(11009003)
			end
		},
		Length = 2
	}

	arg_12_0:SetChoice(var_12_0, false)
	arg_12_0:SetNeedSkip(false, nil)
	arg_12_0:SetNeedClick(false, nil)
	arg_12_0:OnNext(function(arg_15_0)
		arg_12_0:ClearOnNext()
		arg_12_0:CloseChoice()

		if arg_15_0 == 11009002 then
			arg_12_0:DialogueBranchNode_3()
		elseif arg_15_0 == 11009003 then
			arg_12_0:DialogueBranchNode_4()
		end
	end)
end

function var_0_0.DialogueBranchNode_3(arg_16_0)
	arg_16_0:OnNext(function()
		arg_16_0:ClearOnNext()
		arg_16_0:PureActorDialogueNode_5()
	end)
	arg_16_0:Next()
end

function var_0_0.PureActorDialogueNode_5(arg_18_0)
	arg_18_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_18_0:PlayActorAnimationAction(9073, "proud", 0, 2.333333, function()
		return
	end)
	arg_18_0:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	arg_18_0:DelayTimeAction(2, function()
		arg_18_0:EventAction(function()
			arg_18_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_18_0:HideTalkView()
	arg_18_0:OnNext(function()
		arg_18_0:ClearOnNext()
		arg_18_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_24_0)
	arg_24_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_24_0:PlayActorAnimationAction(9512, "conversation_1", 0, 3, function()
		return
	end)
	arg_24_0:PlayActorEmoteAction(9512, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(11009004, "", 9512)
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
	arg_24_0:OnNext(function(arg_29_0)
		arg_24_0:ClearOnNext()
		arg_24_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_30_0)
	arg_30_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_30_0:PlayActorAnimationAction(9073, "embarrassed", 0, 2.6, function()
		return
	end)
	arg_30_0:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11009005, "", 9073)
	arg_30_0:SetNeedSkip(true, {
		Invoke = function()
			arg_30_0:Skip("LastWord")
		end
	})
	arg_30_0:SetNeedClick(true, {
		Invoke = function()
			arg_30_0:Next()
		end
	})
	arg_30_0:OnNext(function(arg_35_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_36_0)
	arg_36_0:EnableCameraByTagAction("6_1", 1, 0)
	arg_36_0:CameraMoveAction("6_1", 4, 5, 4, 0.4)
	arg_36_0:DelayTimeAction(2.5, function()
		arg_36_0:BlackFadeAction(0.2, 0.2, 0.2, function()
			return
		end, function()
			arg_36_0:EnableCameraByTagAction("6_2", 1, 0)
			arg_36_0:CameraMoveAction("6_2", 4, 3, 6, 0.4)
		end)
	end)
	arg_36_0:PlayActorAnimationAction(9512, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(11009006, "", 9512)
	arg_36_0:SetNeedSkip(true, {
		Invoke = function()
			arg_36_0:Skip("LastWord")
		end
	})
	arg_36_0:SetNeedClick(true, {
		Invoke = function()
			arg_36_0:Next()
		end
	})
	arg_36_0:OnNext(function(arg_43_0)
		arg_36_0:ClearOnNext()
		arg_36_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_44_0)
	arg_44_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		arg_44_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	end)
	arg_44_0:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11009007, "", 9074)
	arg_44_0:SetNeedSkip(true, {
		Invoke = function()
			arg_44_0:Skip("LastWord")
		end
	})
	arg_44_0:SetNeedClick(true, {
		Invoke = function()
			arg_44_0:Next()
		end
	})
	arg_44_0:OnNext(function(arg_50_0)
		arg_44_0:ClearOnNext()
		arg_44_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_51_0)
	arg_51_0:EnableCameraByTagAction("8", 1, 0)
	arg_51_0:SetCharToTagAction(9523, "3", function()
		return
	end)
	arg_51_0:CameraMoveAction("8", 4, 5, 0.8, 0.35)
	arg_51_0:DelayTimeAction(1, function()
		arg_51_0:ActorSeekerAction(9523, {
			"7"
		}, 2.1, function()
			return
		end)
		arg_51_0:DelayTimeAction(1, function()
			arg_51_0:EnableCameraByTagAction("9", 1, 0)
			arg_51_0:DelayTimeAction(0.5, function()
				arg_51_0:SetNeedClick(true, {
					Invoke = function()
						arg_51_0:Next()
					end
				})
				arg_51_0:SetNeedSkip(true, {
					Invoke = function()
						arg_51_0:Skip("LastWord")
					end
				})
			end)
		end)
	end)
	arg_51_0:SetCharToTagAction(9073, "6", function()
		arg_51_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
		arg_51_0:LookAtRoleAction(true, 9073, "9523")
	end)
	arg_51_0:SetCharToTagAction(9074, "8", function()
		arg_51_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
		arg_51_0:LookAtRoleAction(true, 9074, "9523")
	end)
	arg_51_0:SetCharToTagAction(9512, "5", function()
		arg_51_0:SetLookAtParamsAction(9512, 0.8, 1, 1)
		arg_51_0:LookAtRoleAction(true, 9512, "9523")
	end)
	arg_51_0:ShowTalkView()
	arg_51_0:SetTalkContent(11009008, "", 9523)
	arg_51_0:SetNeedSkip(true, {
		Invoke = function()
			arg_51_0:Skip("LastWord")
		end
	})
	arg_51_0:SetNeedClick(false, {
		Invoke = function()
			arg_51_0:Next()
		end
	})
	arg_51_0:OnNext(function(arg_64_0)
		arg_51_0:ClearOnNext()
		arg_51_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_65_0)
	arg_65_0:EnableCameraByTagAction("10", 1, 0)
	arg_65_0:PlayActorAnimationAction(9074, "summer_doubt", 0, 2, function()
		return
	end)
	arg_65_0:ShowTalkView()
	arg_65_0:SetTalkContent(11009009, "", 9074)
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
	arg_65_0:OnNext(function(arg_69_0)
		arg_65_0:ClearOnNext()
		arg_65_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_70_0)
	arg_70_0:EnableCameraByTagAction("10_1", 1, 0)
	arg_70_0:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_70_0:ShowTalkView()
	arg_70_0:SetTalkContent(11009010, "", 9523)
	arg_70_0:SetNeedSkip(true, {
		Invoke = function()
			arg_70_0:Skip("LastWord")
		end
	})
	arg_70_0:SetNeedClick(true, {
		Invoke = function()
			arg_70_0:Next()
		end
	})
	arg_70_0:OnNext(function(arg_74_0)
		arg_70_0:ClearOnNext()
		arg_70_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_75_0)
	arg_75_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		arg_75_0:EnableCameraByTagAction("11", 1, 0)
		arg_75_0:SetCharToTagAction(9523, "11", function()
			return
		end)
	end)
	arg_75_0:SetLookAtParamsAction(9523, 0.8, 1, 1)
	arg_75_0:LookAtRoleAction(true, 9523, "9074")
	arg_75_0:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_75_0:ShowTalkView()
	arg_75_0:SetTalkContent(11009011, "", 9523)
	arg_75_0:SetNeedSkip(true, {
		Invoke = function()
			arg_75_0:Skip("LastWord")
		end
	})
	arg_75_0:SetNeedClick(true, {
		Invoke = function()
			arg_75_0:Next()
		end
	})
	arg_75_0:OnNext(function(arg_82_0)
		arg_75_0:ClearOnNext()
		arg_75_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_83_0)
	arg_83_0:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	arg_83_0:ShowTalkView()
	arg_83_0:SetTalkContent(11009012, "", 9074)
	arg_83_0:SetNeedSkip(true, {
		Invoke = function()
			arg_83_0:Skip("LastWord")
		end
	})
	arg_83_0:SetNeedClick(true, {
		Invoke = function()
			arg_83_0:Next()
		end
	})
	arg_83_0:OnNext(function(arg_87_0)
		arg_83_0:ClearOnNext()
		arg_83_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_88_0)
	arg_88_0:PlayActorAnimationAction(9523, "troubled", 0, 3.666667, function()
		return
	end)
	arg_88_0:ShowTalkView()
	arg_88_0:SetTalkContent(11009013, "", 9523)
	arg_88_0:SetNeedSkip(true, {
		Invoke = function()
			arg_88_0:Skip("LastWord")
		end
	})
	arg_88_0:SetNeedClick(true, {
		Invoke = function()
			arg_88_0:Next()
		end
	})
	arg_88_0:OnNext(function(arg_92_0)
		arg_88_0:ClearOnNext()
		arg_88_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_93_0)
	arg_93_0:EnableCameraByTagAction("14", 1, 0)
	arg_93_0:PlayActorAnimationAction(9523, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_93_0:ShowTalkView()
	arg_93_0:SetTalkContent(11009014, "", 9523)
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
	arg_98_0:EnableCameraByTagAction("10", 1, 0)
	arg_98_0:PlayActorEmoteAction(9074, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_98_0:ShowTalkView()
	arg_98_0:SetTalkContent(11009015, "", 9074)
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
	arg_98_0:OnNext(function(arg_102_0)
		arg_98_0:ClearOnNext()
		arg_98_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_103_0)
	arg_103_0:EnableCameraByTagAction("16", 2, 1)
	arg_103_0:PlayActorAnimationAction(9073, "conversation_1", 0, 3, function()
		return
	end)
	arg_103_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_103_0:LookAtRoleAction(true, 9073, "9074")
	arg_103_0:ShowTalkView()
	arg_103_0:SetTalkContent(11009016, "", 9073)
	arg_103_0:SetNeedSkip(true, {
		Invoke = function()
			arg_103_0:Skip("LastWord")
		end
	})
	arg_103_0:SetNeedClick(true, {
		Invoke = function()
			arg_103_0:Next()
		end
	})
	arg_103_0:OnNext(function(arg_107_0)
		arg_103_0:ClearOnNext()
		arg_103_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_108_0)
	arg_108_0:EnableCameraByTagAction("17", 1, 0)
	arg_108_0:SetCharToTagAction(9512, "1", function()
		arg_108_0:SetLookAtParamsAction(9512, 0.8, 1, 1)
		arg_108_0:LookAtRoleAction(true, 9512, "9073")
	end)
	arg_108_0:PlayActorAnimationAction(9512, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_108_0:ShowTalkView()
	arg_108_0:SetTalkContent(11009017, "", 9512)
	arg_108_0:SetNeedSkip(true, {
		Invoke = function()
			arg_108_0:Skip("LastWord")
		end
	})
	arg_108_0:SetNeedClick(true, {
		Invoke = function()
			arg_108_0:Next()
		end
	})
	arg_108_0:OnNext(function(arg_113_0)
		arg_108_0:ClearOnNext()
		arg_108_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_114_0)
	arg_114_0:ShowTalkView()
	arg_114_0:SetTalkContent(11009018, "", 9512)
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
	arg_114_0:OnNext(function(arg_117_0)
		arg_114_0:ClearOnNext()
		arg_114_0:DialogueNode_21()
	end)
end

function var_0_0.DialogueNode_21(arg_118_0)
	arg_118_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_118_0:SetCharToTagAction(9074, "4", function()
		arg_118_0:SetLookAtParamsAction(9074, 0.8, 1, 0.7)
		arg_118_0:LookAtRoleAction(true, 9074, "9512")
	end)
	arg_118_0:SetCharToTagAction(9073, "2", function()
		arg_118_0:SetLookAtParamsAction(9073, 0.8, 1, 0.7)
		arg_118_0:LookAtRoleAction(true, 9073, "9512")
	end)
	arg_118_0:PlayActorEmoteAction(9074, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_118_0:InstEffectAction({
		attachFollow = false,
		delayTime = 2,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 9074,
		path = "QWWorld/Effect/EmotionBubble/fx_jingxia_0501"
	})
	arg_118_0:ShowTalkView()
	arg_118_0:SetTalkContent(11009019, "", 9074)
	arg_118_0:SetNeedSkip(true, {
		Invoke = function()
			arg_118_0:Skip("LastWord")
		end
	})
	arg_118_0:SetNeedClick(true, {
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
	arg_125_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_125_0:LookAtRoleAction(true, 9073, "9074")
	arg_125_0:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
		arg_125_0:InstEffectAction({
			attachFollow = false,
			delayTime = 1,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9073,
			path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0801_QW"
		})
	end)
	arg_125_0:ShowTalkView()
	arg_125_0:SetTalkContent(11009020, "", 9073)
	arg_125_0:SetNeedSkip(true, {
		Invoke = function()
			arg_125_0:Skip("LastWord")
		end
	})
	arg_125_0:SetNeedClick(true, {
		Invoke = function()
			arg_125_0:Next()
		end
	})
	arg_125_0:OnNext(function(arg_129_0)
		arg_125_0:ClearOnNext()
		arg_125_0:DialogueNode_23()
	end)
end

function var_0_0.DialogueNode_23(arg_130_0)
	arg_130_0:EnableCameraByTagAction("21", 1, 0)
	arg_130_0:PlayActorEmoteAction(9074, "squint01", 0, 1.733333, function()
		arg_130_0:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
			return
		end)
	end, true, false)
	arg_130_0:ShowTalkView()
	arg_130_0:SetTalkContent(11009021, "", 9074)
	arg_130_0:SetNeedSkip(true, {
		Invoke = function()
			arg_130_0:Skip("LastWord")
		end
	})
	arg_130_0:SetNeedClick(true, {
		Invoke = function()
			arg_130_0:Next()
		end
	})
	arg_130_0:OnNext(function(arg_135_0)
		arg_130_0:ClearOnNext()
		arg_130_0:DialogueNode_24()
	end)
end

function var_0_0.DialogueNode_24(arg_136_0)
	arg_136_0:ShowTalkView()
	arg_136_0:SetTalkContent(11009022, "", 9512)
	arg_136_0:SetNeedSkip(true, {
		Invoke = function()
			arg_136_0:Skip("LastWord")
		end
	})
	arg_136_0:SetNeedClick(true, {
		Invoke = function()
			arg_136_0:Next()
		end
	})
	arg_136_0:OnNext(function(arg_139_0)
		arg_136_0:ClearOnNext()
		arg_136_0:DialogueNode_25()
	end)
end

function var_0_0.DialogueNode_25(arg_140_0)
	arg_140_0:EnableCameraByTagAction("3", 1, 0)
	arg_140_0:PlayActorAnimationAction(9073, "proud_end", 0.1, 0.7666668, function()
		arg_140_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
		arg_140_0:LookAtRoleAction(true, 9073, "9074")
		arg_140_0:PlayActorAnimationAction(9073, "action3_1", 0.1, 2.266667, function()
			return
		end)
	end)
	arg_140_0:ShowTalkView()
	arg_140_0:SetTalkContent(11009023, "", 9073)
	arg_140_0:SetNeedSkip(true, {
		Invoke = function()
			arg_140_0:Skip("LastWord")
		end
	})
	arg_140_0:SetNeedClick(true, {
		Invoke = function()
			arg_140_0:Next()
		end
	})
	arg_140_0:OnNext(function(arg_145_0)
		arg_140_0:ClearOnNext()
		arg_140_0:DialogueNode_26()
	end)
end

function var_0_0.DialogueNode_26(arg_146_0)
	arg_146_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_146_0:LookAtRoleAction(true, 9074, "9073")
	arg_146_0:PlayActorAnimationAction(9074, "conversation_2", 0.1, 3.166667, function()
		return
	end)
	arg_146_0:ShowTalkView()
	arg_146_0:SetTalkContent(11009024, "", 9074)
	arg_146_0:SetNeedSkip(true, {
		Invoke = function()
			arg_146_0:Skip("LastWord")
		end
	})
	arg_146_0:SetNeedClick(true, {
		Invoke = function()
			arg_146_0:Next()
		end
	})
	arg_146_0:OnNext(function(arg_150_0)
		arg_146_0:ClearOnNext()
		arg_146_0:PureActorDialogueNode_27()
	end)
end

function var_0_0.PureActorDialogueNode_27(arg_151_0)
	arg_151_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_151_0:EnableCameraByTagAction("25", 1, 0)
		arg_151_0:DelayTimeAction(1, function()
			arg_151_0:ActorSeekerAction(9073, {
				"25_1"
			}, 0.5, function()
				return
			end)
		end)
		arg_151_0:DelayTimeAction(3.5, function()
			arg_151_0:EventAction(function()
				arg_151_0:ImmediateNextFlag(-1)
			end)
		end)
		arg_151_0:SetCharToTagAction(9073, "25", function()
			return
		end)
		arg_151_0:SetCharToTagAction(9510, "26", function()
			return
		end)
	end)
	arg_151_0:HideTalkView()
	arg_151_0:OnNext(function()
		arg_151_0:ClearOnNext()
		arg_151_0:DialogueNode_28()
	end)
end

function var_0_0.DialogueNode_28(arg_161_0)
	arg_161_0:SetCharToTagAction(9073, "25_1", function()
		arg_161_0:PlayActorAnimationAction(9073, "happy01", 0, 2.333333, function()
			return
		end)
	end)
	arg_161_0:EnableCameraByTagAction("25_1", 1, 0)
	arg_161_0:ShowTalkView()
	arg_161_0:SetTalkContent(11009025, "", 9073)
	arg_161_0:SetNeedSkip(true, {
		Invoke = function()
			arg_161_0:Skip("LastWord")
		end
	})
	arg_161_0:SetNeedClick(true, {
		Invoke = function()
			arg_161_0:Next()
		end
	})
	arg_161_0:OnNext(function(arg_166_0)
		arg_161_0:ClearOnNext()
		arg_161_0:DialogueNode_29()
	end)
end

function var_0_0.DialogueNode_29(arg_167_0)
	arg_167_0:ActorSeekerAction(9510, {
		"26_1"
	}, 0.6, function()
		arg_167_0:PlayActorAnimationAction(9510, "conversation_2", 0, 3.166667, function()
			return
		end)
	end)
	arg_167_0:EnableCameraByTagAction("26", 1, 0)
	arg_167_0:ShowTalkView()
	arg_167_0:SetTalkContent(11009026, "", 9510)
	arg_167_0:SetNeedSkip(true, {
		Invoke = function()
			arg_167_0:Skip("LastWord")
		end
	})
	arg_167_0:SetNeedClick(true, {
		Invoke = function()
			arg_167_0:Next()
		end
	})
	arg_167_0:OnNext(function(arg_172_0)
		arg_167_0:ClearOnNext()
		arg_167_0:DialogueNode_30()
	end)
end

function var_0_0.DialogueNode_30(arg_173_0)
	arg_173_0:PlayActorAnimationAction(9510, "think_loop", 0.2, 2, function()
		return
	end)
	arg_173_0:ShowTalkView()
	arg_173_0:SetTalkContent(11009027, "", 9510)
	arg_173_0:SetNeedSkip(true, {
		Invoke = function()
			arg_173_0:Skip("LastWord")
		end
	})
	arg_173_0:SetNeedClick(true, {
		Invoke = function()
			arg_173_0:Next()
		end
	})
	arg_173_0:OnNext(function(arg_177_0)
		arg_173_0:ClearOnNext()
		arg_173_0:DialogueNode_31()
	end)
end

function var_0_0.DialogueNode_31(arg_178_0)
	arg_178_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		arg_178_0:EnableCameraByTagAction("27", 1, 0)
	end)
	arg_178_0:ShowTalkView()
	arg_178_0:SetTalkContent(11009028, "", 9073)
	arg_178_0:SetNeedSkip(true, {
		Invoke = function()
			arg_178_0:Skip("LastWord")
		end
	})
	arg_178_0:SetNeedClick(true, {
		Invoke = function()
			arg_178_0:Next()
		end
	})
	arg_178_0:OnNext(function(arg_183_0)
		arg_178_0:ClearOnNext()
		arg_178_0:DialogueNode_32()
	end)
end

function var_0_0.DialogueNode_32(arg_184_0)
	arg_184_0:ShowTalkView()
	arg_184_0:SetTalkContent(11009029, "", 9073)
	arg_184_0:SetNeedSkip(true, {
		Invoke = function()
			arg_184_0:Skip("LastWord")
		end
	})
	arg_184_0:SetNeedClick(true, {
		Invoke = function()
			arg_184_0:Next()
		end
	})
	arg_184_0:OnNext(function(arg_187_0)
		arg_184_0:ClearOnNext()
		arg_184_0:DialogueNode_33()
	end)
end

function var_0_0.DialogueNode_33(arg_188_0)
	arg_188_0:EnableCameraByTagAction("27", 1, 0)
	arg_188_0:ShowTalkView()
	arg_188_0:SetTalkContent(11009030, "", 9073)
	arg_188_0:SetNeedSkip(false, {
		Invoke = function()
			arg_188_0:Skip("End")
		end
	})
	arg_188_0:SetNeedClick(true, {
		Invoke = function()
			arg_188_0:Next()
		end
	})
	arg_188_0:OnNext(function(arg_191_0)
		arg_188_0:ClearOnNext()
		arg_188_0:PureActorDialogueNode_34()
	end)
end

function var_0_0.PureActorDialogueNode_34(arg_192_0)
	arg_192_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_192_0:EnableCameraByTagAction("xiuchuan3", 1, 0)
		arg_192_0:PlayActorAnimationAction(9073, "jack_kick_1", 0, 1.166667, function()
			return
		end)
		arg_192_0:SetCharToTagAction(9073, "xiuchuan_3", function()
			return
		end)
		arg_192_0:DelayTimeAction(1.9, function()
			arg_192_0:SetCharToTagAction(9073, "xiuchuan_4", function()
				return
			end)
			arg_192_0:EnableCameraByTagAction("xiuchuan_4", 1, 0)
			arg_192_0:CameraMoveAction("xiuchuan_4", 1, 4, 4, 0.4)
			arg_192_0:DelayTimeAction(2.2, function()
				arg_192_0:EnableCameraByTagAction("xiuchuan_6", 1, 0)
				arg_192_0:CameraMoveAction("xiuchuan_6", 1, 4, 5, 0.4)
				arg_192_0:DelayTimeAction(2, function()
					arg_192_0:BlackFadeAction(0.2, 0.2, 0.2, function()
						arg_192_0:InstEffectAction({
							pointTag = "bujian",
							destroyMode = "DontDestroy",
							createMode = "Point",
							path = "QWWorld/Effect/EmotionBubble/fx_canlan_0401.prefab"
						})
					end, function()
						arg_192_0:HideAllDynamicAction(true, true, 4091, {
							10
						})
					end)
					arg_192_0:DelayTimeAction(2.6, function()
						arg_192_0:EventAction(function()
							arg_192_0:ImmediateNextFlag(-1)
						end)
					end)
				end)
			end)
			arg_192_0:PlayActorAnimationAction(9073, "jack_kick_2", 0, 1.866667, function()
				return
			end)
		end)
		arg_192_0:CameraMoveAction("xiuchuan3", 1, 2, 4, 0.4)
		arg_192_0:HideAllDynamicAction(true, true, 4091, {
			11
		})
		arg_192_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_06_xiuchuan", "", "")
	end)
	arg_192_0:Agent_PlayerPosControl("chuansong", function()
		return
	end)
	arg_192_0:HideTalkView()
	arg_192_0:OnNext(function()
		arg_192_0:ClearOnNext()
		arg_192_0:BlackFadeDialogueNode_35()
	end)
end

function var_0_0.BlackFadeDialogueNode_35(arg_208_0)
	arg_208_0:HideTalkView()
	arg_208_0:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		arg_208_0:DestroyCharAction(9073)
		arg_208_0:DestroyCharAction(9074)
		arg_208_0:DestroyCharAction(9512)
		arg_208_0:EnableCameraByTagAction("", 1, 0)
		arg_208_0:HideAllDynamicAction(false, false, 4095, {})
		arg_208_0:ContinueBlackFade()
		arg_208_0:OnNext(function()
			arg_208_0:ClearOnNext()
			arg_208_0:CloseStoryEventNode_36()
		end)
	end, function()
		arg_208_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_36(arg_212_0)
	arg_212_0:EndStory()
end

function var_0_0.DialogueBranchNode_4(arg_213_0)
	arg_213_0:OnNext(function()
		arg_213_0:ClearOnNext()
		arg_213_0:PureActorDialogueNode_5()
	end)
	arg_213_0:Next()
end

function var_0_0.RegisterFuncMap(arg_215_0)
	arg_215_0:RegisterTalkFunction("LastWord", arg_215_0.DialogueNode_33)
	arg_215_0:RegisterTalkFunction("End", arg_215_0.CloseStoryEventNode_36)
end

return var_0_0
