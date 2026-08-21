BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11017", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11017"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11017"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		arg_5_0:EnableCameraByTagAction("ranbu_1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {
			30008
		})
		arg_5_0:InstEffectAction({
			pointTag = "ranbu_3",
			destroyMode = "DontDestroy",
			createMode = "Point",
			path = "QWWorld/Effect/fx_dye_cloth_3.prefab"
		})
		arg_5_0:DelayTimeAction(1.5, function()
			arg_5_0:InstEffectAction({
				pointTag = "ranbu_2",
				destroyMode = "DontDestroy",
				createMode = "Point",
				path = "QWWorld/Effect/fx_dye_cloth_2.prefab"
			})
		end)
		arg_5_0:DelayTimeAction(3, function()
			arg_5_0:InstEffectAction({
				pointTag = "ranbu_1",
				destroyMode = "DontDestroy",
				createMode = "Point",
				path = "QWWorld/Effect/fx_dye_cloth_1.prefab"
			})
		end)
		arg_5_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_03_ranbu", "", "")
	end)
	arg_5_0:DelayTimeAction(5, function()
		arg_5_0:EventAction(function()
			arg_5_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_5_0:HideTalkView()
	arg_5_0:OnNext(function()
		arg_5_0:ClearOnNext()
		arg_5_0:BlackFadeDialogueNode_2()
	end)
end

function var_0_0.BlackFadeDialogueNode_2(arg_13_0)
	arg_13_0:HideTalkView()
	arg_13_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_13_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_13_0:SetCharToTagAction(9513, "2", function()
			return
		end)
		arg_13_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
		arg_13_0:HideAllDynamicAction(true, true, 4083, {
			30007,
			30008
		})
		arg_13_0:WalkingPeopleGlobleCull(true)
		arg_13_0:ContinueBlackFade()
		arg_13_0:OnNext(function()
			arg_13_0:ClearOnNext()
			arg_13_0:DialogueNode_3()
		end)
	end, function()
		arg_13_0:Next()
	end)
end

function var_0_0.DialogueNode_3(arg_19_0)
	arg_19_0:PlayActorAnimationAction(9073, "happy04", 0, 2.2, function()
		return
	end)
	arg_19_0:ShowTalkView()
	arg_19_0:SetTalkContent(11017001, "", 9073)
	arg_19_0:SetNeedSkip(true, {
		Invoke = function()
			arg_19_0:Skip("End")
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
	arg_24_0:PlayActorAnimationAction(9513, "conversation_1", 0, 3, function()
		arg_24_0:PlayActorAnimationAction(9513, "summer_doubt", 0, 2, function()
			return
		end)
	end)
	arg_24_0:CameraMoveAction("1", 4, 4, 5, 0.35)
	arg_24_0:EnableCameraByTagAction("1", 1, 0)
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(11017002, "", 9513)
	arg_24_0:SetNeedSkip(true, {
		Invoke = function()
			arg_24_0:Skip("End")
		end
	})
	arg_24_0:SetNeedClick(true, {
		Invoke = function()
			arg_24_0:Next()
		end
	})
	arg_24_0:OnNext(function(arg_29_0)
		arg_24_0:ClearOnNext()
		arg_24_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_30_0)
	arg_30_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_30_0:PlayActorAnimationAction(9073, "embarrassed", 0, 2.6, function()
		arg_30_0:PlayActorAnimationAction(9073, "conversation_2", 0, 3.166667, function()
			return
		end)
	end)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11017003, "", 9073)
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
	arg_30_0:OnNext(function(arg_35_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_36_0)
	arg_36_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_36_0:PlayActorAnimationAction(9513, "action2_1", 0, 1.666667, function()
		return
	end)
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(11017004, "", 9513)
	arg_36_0:SetNeedSkip(true, {
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
	arg_41_0:PlayActorAnimationAction(9073, "summer_doubt_start", 0, 0.7666667, function()
		return
	end)
	arg_41_0:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, true)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(11017005, "", 9073)
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
	arg_41_0:OnNext(function(arg_46_0)
		arg_41_0:ClearOnNext()
		arg_41_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_47_0)
	arg_47_0:EnableCameraByTagAction("1", 1, 0)
	arg_47_0:CameraMoveAction("1", 4, 4, 7, 0.5)
	arg_47_0:PlayActorAnimationAction(9513, "action2_3", 0, 1.333333, function()
		return
	end)
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11017006, "", 9513)
	arg_47_0:SetNeedSkip(true, {
		Invoke = function()
			arg_47_0:Skip("End")
		end
	})
	arg_47_0:SetNeedClick(true, {
		Invoke = function()
			arg_47_0:Next()
		end
	})
	arg_47_0:OnNext(function(arg_51_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_52_0)
	arg_52_0:PlayActorAnimationAction(9513, "action2_3", 0.1, 1.333333, function()
		return
	end)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11017007, "", 9513)
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
		arg_52_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_57_0)
	arg_57_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_57_0:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	arg_57_0:ShowTalkView()
	arg_57_0:SetTalkContent(11017008, "", 9073)
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
	arg_57_0:OnNext(function(arg_61_0)
		arg_57_0:ClearOnNext()
		arg_57_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_62_0)
	arg_62_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_62_0:PlayActorAnimationAction(9513, "proud", 0, 2.333333, function()
		return
	end)
	arg_62_0:ShowTalkView()
	arg_62_0:SetTalkContent(11017009, "", 9513)
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
		arg_62_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_67_0)
	arg_67_0:EnableCameraByTagAction("10", 1, 0)
	arg_67_0:PlayActorAnimationAction(9073, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_67_0:CameraMoveAction("10", 7, 6, 6, 0.4)
	arg_67_0:ShowTalkView()
	arg_67_0:SetTalkContent(11017010, "", 9073)
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
	arg_67_0:OnNext(function(arg_71_0)
		arg_67_0:ClearOnNext()
		arg_67_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_72_0)
	arg_72_0:PlayActorAnimationAction(9513, "conversation_1", 0, 3, function()
		return
	end)
	arg_72_0:ShowTalkView()
	arg_72_0:SetTalkContent(11017011, "", 9513)
	arg_72_0:SetNeedSkip(true, {
		Invoke = function()
			arg_72_0:Skip("End")
		end
	})
	arg_72_0:SetNeedClick(true, {
		Invoke = function()
			arg_72_0:Next()
		end
	})
	arg_72_0:OnNext(function(arg_76_0)
		arg_72_0:ClearOnNext()
		arg_72_0:BlackFadeDialogueNode_14()
	end)
end

function var_0_0.BlackFadeDialogueNode_14(arg_77_0)
	arg_77_0:HideTalkView()
	arg_77_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_77_0:DestroyCharAction(9073)
		arg_77_0:DestroyCharAction(9513)
		arg_77_0:EnableCameraByTagAction("", 1, 0)
		arg_77_0:HideAllDynamicAction(false, false, 4095, {})
		arg_77_0:WalkingPeopleGlobleCull(false)
		arg_77_0:ContinueBlackFade()
		arg_77_0:OnNext(function()
			arg_77_0:ClearOnNext()
			arg_77_0:CloseStoryEventNode_15()
		end)
	end, function()
		arg_77_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_15(arg_81_0)
	arg_81_0:EnableCameraCutAction(false)
	arg_81_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_82_0)
	arg_82_0:RegisterTalkFunction("End", arg_82_0.BlackFadeDialogueNode_14)
	arg_82_0:RegisterTalkFunction("End", arg_82_0.CloseStoryEventNode_15)
end

return var_0_0
