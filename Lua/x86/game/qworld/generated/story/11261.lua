BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11261", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11261"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11261"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(907301, "9073", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9520, "9520", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {
			410001
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

function var_0_0.DialogueNode_2(arg_11_0)
	arg_11_0:PlayActorAnimationAction(907301, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11261001, "", 907301)
	arg_11_0:SetNeedSkip(true, {
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
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11261002, "", 9520)

	local var_16_0 = {
		[0] = {
			id = 11261003,
			icon = "",
			Invoke = function()
				arg_16_0:Next(11261003)
			end
		},
		{
			id = 11261004,
			icon = "",
			Invoke = function()
				arg_16_0:Next(11261004)
			end
		},
		Length = 2
	}

	arg_16_0:SetChoice(var_16_0, false)
	arg_16_0:SetNeedSkip(false, nil)
	arg_16_0:SetNeedClick(false, nil)
	arg_16_0:OnNext(function(arg_19_0)
		arg_16_0:ClearOnNext()
		arg_16_0:CloseChoice()

		if arg_19_0 == 11261003 then
			arg_16_0:DialogueBranchNode_4()
		elseif arg_19_0 == 11261004 then
			arg_16_0:DialogueBranchNode_5()
		end
	end)
end

function var_0_0.DialogueBranchNode_4(arg_20_0)
	arg_20_0:OnNext(function()
		arg_20_0:ClearOnNext()
		arg_20_0:PureActorDialogueNode_6()
	end)
	arg_20_0:Next()
end

function var_0_0.PureActorDialogueNode_6(arg_22_0)
	arg_22_0:PlayActorAnimationAction(907301, "win", 0, 1.933333, function()
		return
	end)
	arg_22_0:EnableCameraByTagAction("2", 1, 0)
	arg_22_0:CameraMoveAction("2", 4, 1, 1, 0.3)
	arg_22_0:DelayTimeAction(2, function()
		arg_22_0:EventAction(function()
			arg_22_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_22_0:HideTalkView()
	arg_22_0:OnNext(function()
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_27_0)
	arg_27_0:EnableCameraByTagAction("1", 1, 0)
	arg_27_0:PlayActorAnimationAction(907301, "embarrassed", 0, 2.6, function()
		return
	end)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11261005, "", 0)
	arg_27_0:SetNeedSkip(true, {
		Invoke = function()
			arg_27_0:Skip("End")
		end
	})
	arg_27_0:SetNeedClick(true, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_31_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_32_0)
	arg_32_0:PlayActorAnimationAction(9520, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11261006, "", 0)
	arg_32_0:SetNeedSkip(true, {
		Invoke = function()
			arg_32_0:Skip("End")
		end
	})
	arg_32_0:SetNeedClick(true, {
		Invoke = function()
			arg_32_0:Next()
		end
	})
	arg_32_0:OnNext(function(arg_36_0)
		arg_32_0:ClearOnNext()
		arg_32_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_37_0)
	arg_37_0:ShowTalkView()
	arg_37_0:SetTalkContent(11261007, "", 0)
	arg_37_0:SetNeedSkip(true, {
		Invoke = function()
			arg_37_0:Skip("End")
		end
	})
	arg_37_0:SetNeedClick(true, {
		Invoke = function()
			arg_37_0:Next()
		end
	})
	arg_37_0:OnNext(function(arg_40_0)
		arg_37_0:ClearOnNext()
		arg_37_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_41_0)
	arg_41_0:PlayActorAnimationAction(9520, "troubled", 0, 3.666667, function()
		return
	end)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(11261008, "", 0)
	arg_41_0:SetNeedSkip(true, {
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
		arg_41_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_46_0)
	arg_46_0:PlayActorAnimationAction(907301, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_46_0:ShowTalkView()
	arg_46_0:SetTalkContent(11261009, "", 0)
	arg_46_0:SetNeedSkip(true, {
		Invoke = function()
			arg_46_0:Skip("End")
		end
	})
	arg_46_0:SetNeedClick(true, {
		Invoke = function()
			arg_46_0:Next()
		end
	})
	arg_46_0:OnNext(function(arg_50_0)
		arg_46_0:ClearOnNext()
		arg_46_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_51_0)
	arg_51_0:ShowTalkView()
	arg_51_0:SetTalkContent(11261010, "", 0)
	arg_51_0:SetNeedSkip(true, {
		Invoke = function()
			arg_51_0:Skip("End")
		end
	})
	arg_51_0:SetNeedClick(true, {
		Invoke = function()
			arg_51_0:Next()
		end
	})
	arg_51_0:OnNext(function(arg_54_0)
		arg_51_0:ClearOnNext()
		arg_51_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_55_0)
	arg_55_0:ShowTalkView()
	arg_55_0:SetTalkContent(11261011, "", 0)
	arg_55_0:SetNeedSkip(true, {
		Invoke = function()
			arg_55_0:Skip("End")
		end
	})
	arg_55_0:SetNeedClick(true, {
		Invoke = function()
			arg_55_0:Next()
		end
	})
	arg_55_0:OnNext(function(arg_58_0)
		arg_55_0:ClearOnNext()
		arg_55_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_59_0)
	arg_59_0:PlayActorAnimationAction(907301, "think_start", 0, 1.333333, function()
		return
	end)
	arg_59_0:ShowTalkView()
	arg_59_0:SetTalkContent(11261012, "", 0)
	arg_59_0:SetNeedSkip(true, {
		Invoke = function()
			arg_59_0:Skip("End")
		end
	})
	arg_59_0:SetNeedClick(true, {
		Invoke = function()
			arg_59_0:Next()
		end
	})
	arg_59_0:OnNext(function(arg_63_0)
		arg_59_0:ClearOnNext()
		arg_59_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_64_0)
	arg_64_0:ShowTalkView()
	arg_64_0:SetTalkContent(11261013, "", 0)
	arg_64_0:SetNeedSkip(true, {
		Invoke = function()
			arg_64_0:Skip("End")
		end
	})
	arg_64_0:SetNeedClick(true, {
		Invoke = function()
			arg_64_0:Next()
		end
	})
	arg_64_0:OnNext(function(arg_67_0)
		arg_64_0:ClearOnNext()
		arg_64_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_68_0)
	arg_68_0:PlayActorAnimationAction(907301, "think_end", 0, 1.666667, function()
		return
	end)
	arg_68_0:ShowTalkView()
	arg_68_0:SetTalkContent(11261014, "", 0)
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
		arg_68_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_73_0)
	arg_73_0:ShowTalkView()
	arg_73_0:SetTalkContent(11261015, "", 0)
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
	arg_73_0:OnNext(function(arg_76_0)
		arg_73_0:ClearOnNext()
		arg_73_0:BlackFadeDialogueNode_18()
	end)
end

function var_0_0.BlackFadeDialogueNode_18(arg_77_0)
	arg_77_0:HideTalkView()
	arg_77_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_77_0:EnableCameraByTagAction("", 1, 0)
		arg_77_0:DestroyCharAction(907301)
		arg_77_0:DestroyCharAction(9520)
		arg_77_0:HideAllDynamicAction(false, false, 4081, {
			410016
		})
		arg_77_0:ContinueBlackFade()
		arg_77_0:OnNext(function()
			arg_77_0:ClearOnNext()
			arg_77_0:CloseStoryEventNode_19()
		end)
	end, function()
		arg_77_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_19(arg_81_0)
	arg_81_0:EnableCameraCutAction(false)
	arg_81_0:EndStory()
end

function var_0_0.DialogueBranchNode_5(arg_82_0)
	arg_82_0:OnNext(function()
		arg_82_0:ClearOnNext()
		arg_82_0:PureActorDialogueNode_6()
	end)
	arg_82_0:Next()
end

function var_0_0.RegisterFuncMap(arg_84_0)
	arg_84_0:RegisterTalkFunction("End", arg_84_0.CloseStoryEventNode_19)
end

return var_0_0
