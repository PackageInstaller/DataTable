BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11181", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11181"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11181"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9525, "9525", function()
			return
		end)
		arg_5_0:SetCharToTagAction(907301, "907301", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {
			430001
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
	arg_11_0:PlayActorAnimationAction(9525, "sad_02", 0.05, 6.733334, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11181001, "", 9525)
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
	arg_16_0:PlayActorAnimationAction(907301, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11181002, "", 907301)
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
	arg_16_0:OnNext(function(arg_20_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_21_0)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11181003, "", 9525)
	arg_21_0:SetNeedSkip(true, {
		Invoke = function()
			arg_21_0:Skip("End")
		end
	})
	arg_21_0:SetNeedClick(true, {
		Invoke = function()
			arg_21_0:Next()
		end
	})
	arg_21_0:OnNext(function(arg_24_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_25_0)
	arg_25_0:PlayActorAnimationAction(907301, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_25_0:ShowTalkView()
	arg_25_0:SetTalkContent(11181004, "", 907301)
	arg_25_0:SetNeedSkip(true, {
		Invoke = function()
			arg_25_0:Skip("End")
		end
	})
	arg_25_0:SetNeedClick(true, {
		Invoke = function()
			arg_25_0:Next()
		end
	})
	arg_25_0:OnNext(function(arg_29_0)
		arg_25_0:ClearOnNext()
		arg_25_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_30_0)
	arg_30_0:PlayActorAnimationAction(9525, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11181005, "", 9525)
	arg_30_0:SetNeedSkip(true, {
		Invoke = function()
			arg_30_0:Skip("End")
		end
	})
	arg_30_0:SetNeedClick(true, {
		Invoke = function()
			arg_30_0:Next()
		end
	})
	arg_30_0:OnNext(function(arg_34_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_35_0)
	arg_35_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11181006, "", 907301)
	arg_35_0:SetNeedSkip(true, {
		Invoke = function()
			arg_35_0:Skip("End")
		end
	})
	arg_35_0:SetNeedClick(true, {
		Invoke = function()
			arg_35_0:Next()
		end
	})
	arg_35_0:OnNext(function(arg_39_0)
		arg_35_0:ClearOnNext()
		arg_35_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_40_0)
	arg_40_0:SetLookAtParamsAction(9525, 0.8, 1, 1)
	arg_40_0:LookAtAction(true, 9525, "che")
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11181007, "", 9525)
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
	arg_40_0:OnNext(function(arg_43_0)
		arg_40_0:ClearOnNext()
		arg_40_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_44_0)
	arg_44_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_44_0:LookAtAction(true, 907301, "che")
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11181008, "", 907301)
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
	arg_44_0:OnNext(function(arg_47_0)
		arg_44_0:ClearOnNext()
		arg_44_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_48_0)
	arg_48_0:ShowTalkView()
	arg_48_0:SetTalkContent(11181009, "", 9525)
	arg_48_0:SetNeedSkip(true, {
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
		arg_48_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_52_0)
	arg_52_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_52_0:LookAtRoleAction(true, 907301, "9525")
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11181010, "", 907301)
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
	arg_52_0:OnNext(function(arg_55_0)
		arg_52_0:ClearOnNext()
		arg_52_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_56_0)
	arg_56_0:ShowTalkView()
	arg_56_0:SetTalkContent(11181011, "", 9525)

	local var_56_0 = {
		[0] = {
			id = 11181012,
			icon = "",
			Invoke = function()
				arg_56_0:Next(11181012)
			end
		},
		{
			id = 11181015,
			icon = "",
			Invoke = function()
				arg_56_0:Next(11181015)
			end
		},
		Length = 2
	}

	arg_56_0:SetChoice(var_56_0, false)
	arg_56_0:SetNeedSkip(false, nil)
	arg_56_0:SetNeedClick(false, nil)
	arg_56_0:OnNext(function(arg_59_0)
		arg_56_0:ClearOnNext()
		arg_56_0:CloseChoice()

		if arg_59_0 == 11181012 then
			arg_56_0:DialogueBranchNode_13()
		elseif arg_59_0 == 11181015 then
			arg_56_0:DialogueBranchNode_14()
		end
	end)
end

function var_0_0.DialogueBranchNode_13(arg_60_0)
	arg_60_0:OnNext(function()
		arg_60_0:ClearOnNext()
		arg_60_0:DialogueNode_15()
	end)
	arg_60_0:Next()
end

function var_0_0.DialogueNode_15(arg_62_0)
	arg_62_0:SetLookAtParamsAction(9525, 0.8, 1, 1)
	arg_62_0:LookAtRoleAction(true, 9525, "907301")
	arg_62_0:PlayActorAnimationAction(9525, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_62_0:ShowTalkView()
	arg_62_0:SetTalkContent(11181013, "", 9525)
	arg_62_0:SetNeedSkip(true, {
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
		arg_62_0:DialogueNode_16()
	end)
end

function var_0_0.DialogueNode_16(arg_67_0)
	arg_67_0:ShowTalkView()
	arg_67_0:SetTalkContent(11181014, "", 9525)
	arg_67_0:SetNeedSkip(true, {
		Invoke = function()
			arg_67_0:Skip("End")
		end
	})
	arg_67_0:SetNeedClick(true, {
		Invoke = function()
			arg_67_0:Next()
		end
	})
	arg_67_0:OnNext(function(arg_70_0)
		arg_67_0:ClearOnNext()
		arg_67_0:DialogueNode_17()
	end)
end

function var_0_0.DialogueNode_17(arg_71_0)
	arg_71_0:PlayActorAnimationAction(907301, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_71_0:ShowTalkView()
	arg_71_0:SetTalkContent(11181018, "", 907301)
	arg_71_0:SetNeedSkip(true, {
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
		arg_71_0:DialogueNode_18()
	end)
end

function var_0_0.DialogueNode_18(arg_76_0)
	arg_76_0:PlayActorAnimationAction(9525, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_76_0:ShowTalkView()
	arg_76_0:SetTalkContent(11181019, "", 9525)
	arg_76_0:SetNeedSkip(true, {
		Invoke = function()
			arg_76_0:Skip("End")
		end
	})
	arg_76_0:SetNeedClick(true, {
		Invoke = function()
			arg_76_0:Next()
		end
	})
	arg_76_0:OnNext(function(arg_80_0)
		arg_76_0:ClearOnNext()
		arg_76_0:DialogueNode_19()
	end)
end

function var_0_0.DialogueNode_19(arg_81_0)
	arg_81_0:SetLookAtParamsAction(9525, 0.8, 1, 1)
	arg_81_0:LookAtAction(true, 9525, "che")
	arg_81_0:ShowTalkView()
	arg_81_0:SetTalkContent(11181020, "", 9525)
	arg_81_0:SetNeedSkip(true, {
		Invoke = function()
			arg_81_0:Skip("End")
		end
	})
	arg_81_0:SetNeedClick(true, {
		Invoke = function()
			arg_81_0:Next()
		end
	})
	arg_81_0:OnNext(function(arg_84_0)
		arg_81_0:ClearOnNext()
		arg_81_0:DialogueNode_20()
	end)
end

function var_0_0.DialogueNode_20(arg_85_0)
	arg_85_0:ShowTalkView()
	arg_85_0:SetTalkContent(11181021, "", 907301)
	arg_85_0:SetNeedSkip(true, {
		Invoke = function()
			arg_85_0:Skip("End")
		end
	})
	arg_85_0:SetNeedClick(true, {
		Invoke = function()
			arg_85_0:Next()
		end
	})
	arg_85_0:OnNext(function(arg_88_0)
		arg_85_0:ClearOnNext()
		arg_85_0:BlackFadeDialogueNode_21()
	end)
end

function var_0_0.BlackFadeDialogueNode_21(arg_89_0)
	arg_89_0:HideTalkView()
	arg_89_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_89_0:EnableCameraByTagAction("", 1, 0)
		arg_89_0:HideAllDynamicAction(false, false, 4081, {
			430001
		})
		arg_89_0:DestroyCharAction(907301)
		arg_89_0:DestroyCharAction(9525)
		arg_89_0:ContinueBlackFade()
		arg_89_0:OnNext(function()
			arg_89_0:ClearOnNext()
			arg_89_0:CloseStoryEventNode_22()
		end)
	end, function()
		arg_89_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_22(arg_93_0)
	arg_93_0:EnableCameraCutAction(false)
	arg_93_0:EndStory()
end

function var_0_0.DialogueBranchNode_14(arg_94_0)
	arg_94_0:OnNext(function()
		arg_94_0:ClearOnNext()
		arg_94_0:DialogueNode_23()
	end)
	arg_94_0:Next()
end

function var_0_0.DialogueNode_23(arg_96_0)
	arg_96_0:SetLookAtParamsAction(9525, 0.8, 1, 1)
	arg_96_0:LookAtRoleAction(true, 9525, "907301")
	arg_96_0:PlayActorAnimationAction(9525, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_96_0:ShowTalkView()
	arg_96_0:SetTalkContent(11181016, "", 9525)
	arg_96_0:SetNeedSkip(true, {
		Invoke = function()
			arg_96_0:Skip("End")
		end
	})
	arg_96_0:SetNeedClick(true, {
		Invoke = function()
			arg_96_0:Next()
		end
	})
	arg_96_0:OnNext(function(arg_100_0)
		arg_96_0:ClearOnNext()
		arg_96_0:DialogueNode_24()
	end)
end

function var_0_0.DialogueNode_24(arg_101_0)
	arg_101_0:ShowTalkView()
	arg_101_0:SetTalkContent(11181017, "", 9525)
	arg_101_0:SetNeedSkip(true, {
		Invoke = function()
			arg_101_0:Skip("End")
		end
	})
	arg_101_0:SetNeedClick(true, {
		Invoke = function()
			arg_101_0:Next()
		end
	})
	arg_101_0:OnNext(function(arg_104_0)
		arg_101_0:ClearOnNext()
		arg_101_0:DialogueNode_17()
	end)
end

function var_0_0.RegisterFuncMap(arg_105_0)
	arg_105_0:RegisterTalkFunction("End", arg_105_0.CloseStoryEventNode_22)
end

return var_0_0
