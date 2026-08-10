BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11042", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11042"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11042"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:SetCharToTagAction(907301, "1_0", function()
			arg_5_0:ActorSeekerAction(907301, {
				"1"
			}, 2.5, function()
				return
			end)
		end)
		arg_5_0:SetCharToTagAction(9074, "3", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9072, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_13_0)
	arg_13_0:ShowTalkView()
	arg_13_0:SetTalkContent(11042001, "", 907301)
	arg_13_0:SetNeedSkip(true, {
		Invoke = function()
			arg_13_0:Skip("End")
		end
	})
	arg_13_0:SetNeedClick(true, {
		Invoke = function()
			arg_13_0:Next()
		end
	})
	arg_13_0:OnNext(function(arg_16_0)
		arg_13_0:ClearOnNext()
		arg_13_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:PlayActorAnimationAction(9074, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11042002, "", 9074)
	arg_17_0:SetNeedSkip(true, {
		Invoke = function()
			arg_17_0:Skip("End")
		end
	})
	arg_17_0:SetNeedClick(true, {
		Invoke = function()
			arg_17_0:Next()
		end
	})
	arg_17_0:OnNext(function(arg_21_0)
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_22_0:EnableCameraByTagAction("3_1", 1, 0)
	arg_22_0:CameraMoveAction("3_1", 4, 6, 5, 1.5)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11042003, "", 9072)
	arg_22_0:SetNeedSkip(true, {
		Invoke = function()
			arg_22_0:Skip("End")
		end
	})
	arg_22_0:SetNeedClick(true, {
		Invoke = function()
			arg_22_0:Next()
		end
	})
	arg_22_0:OnNext(function(arg_26_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_27_0)
	arg_27_0:PlayActorAnimationAction(907301, "summer_doubt_start", 0.05, 0.7666667, function()
		return
	end)
	arg_27_0:EnableCameraByTagAction("4", 1, 0)
	arg_27_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_27_0:LookAtRoleAction(true, 907301, "9072")
	arg_27_0:CameraMoveAction("4", 4, 4, 5, 0.1)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11042004, "", 907301)
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
		arg_27_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_32_0)
	arg_32_0:PlayActorAnimationAction(9072, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_32_0:EnableCameraByTagAction("5", 1, 0)
	arg_32_0:InstEffectAction({
		pointTag = "yahaha",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	arg_32_0:CameraMoveAction("5", 2, 1, 2, 0.3)
	arg_32_0:DelayTimeAction(0.2, function()
		arg_32_0:LoadThingToTag(1, "Yahaha_shigandang", "yahaha", function()
			return
		end)
		arg_32_0:DelayTimeAction(1, function()
			arg_32_0:SetNeedClick(true, {
				Invoke = function()
					arg_32_0:Next()
				end
			})
			arg_32_0:SetNeedSkip(true, {
				Invoke = function()
					arg_32_0:Skip("End")
				end
			})
		end)
	end)
	arg_32_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_action_sgd_appear", "", "")
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11042005, "", 9072)
	arg_32_0:SetNeedSkip(true, {
		Invoke = function()
			arg_32_0:Skip("End")
		end
	})
	arg_32_0:SetNeedClick(false, {
		Invoke = function()
			arg_32_0:Next()
		end
	})
	arg_32_0:OnNext(function(arg_41_0)
		arg_32_0:ClearOnNext()
		arg_32_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_42_0)
	arg_42_0:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_42_0:EnableCameraByTagAction("6", 1, 0)
	arg_42_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_42_0:LookAtAction(true, 907301, "yahaha")
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11042006, "", 907301)
	arg_42_0:SetNeedSkip(true, {
		Invoke = function()
			arg_42_0:Skip("End")
		end
	})
	arg_42_0:SetNeedClick(true, {
		Invoke = function()
			arg_42_0:Next()
		end
	})
	arg_42_0:OnNext(function(arg_46_0)
		arg_42_0:ClearOnNext()
		arg_42_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_47_0)
	arg_47_0:PlayActorAnimationAction(9072, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_47_0:EnableCameraByTagAction("3", 1, 0)
	arg_47_0:CameraMoveAction("3", 4, 3, 5.5, 0.3)
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11042007, "", 9072)
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
	arg_52_0:PlayActorEmoteAction(9072, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_52_0:EnableCameraByTagAction("8", 1, 0)
	arg_52_0:SetLookAtParamsAction(9072, 0.6, 0.8, 1)
	arg_52_0:LookAtAction(true, 9072, "yahaha")
	arg_52_0:InstEffectAction({
		pointTag = "yahaha",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	arg_52_0:DelayTimeAction(0.2, function()
		arg_52_0:UnloadThing(1)
		arg_52_0:DelayTimeAction(1, function()
			arg_52_0:SetNeedClick(true, {
				Invoke = function()
					arg_52_0:Next()
				end
			})
			arg_52_0:SetNeedSkip(true, {
				Invoke = function()
					arg_52_0:Skip("End")
				end
			})
		end)
	end)
	arg_52_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_action_sgd_disappear", "", "")
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11042008, "", 9072)
	arg_52_0:SetNeedSkip(true, {
		Invoke = function()
			arg_52_0:Skip("End")
		end
	})
	arg_52_0:SetNeedClick(false, {
		Invoke = function()
			arg_52_0:Next()
		end
	})
	arg_52_0:OnNext(function(arg_60_0)
		arg_52_0:ClearOnNext()
		arg_52_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_61_0)
	arg_61_0:PlayActorAnimationAction(9074, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_61_0:EnableCameraByTagAction("9", 1, 0)
	arg_61_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_61_0:LookAtRoleAction(true, 9074, "9072")
	arg_61_0:PlayActorEmoteAction(9074, "anger02_start", 0, 0.5, function()
		return
	end, true, true)
	arg_61_0:ShowTalkView()
	arg_61_0:SetTalkContent(11042009, "", 9074)
	arg_61_0:SetNeedSkip(true, {
		Invoke = function()
			arg_61_0:Skip("End")
		end
	})
	arg_61_0:SetNeedClick(true, {
		Invoke = function()
			arg_61_0:Next()
		end
	})
	arg_61_0:OnNext(function(arg_66_0)
		arg_61_0:ClearOnNext()
		arg_61_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_67_0)
	arg_67_0:PlayActorAnimationAction(9072, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_67_0:SetLookAtParamsAction(9072, 0.8, 1, 1)
	arg_67_0:LookAtRoleAction(true, 9072, "907301")
	arg_67_0:PlayActorEmoteAction(9072, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_67_0:ShowTalkView()
	arg_67_0:SetTalkContent(11042010, "", 9072)
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
	arg_67_0:OnNext(function(arg_72_0)
		arg_67_0:ClearOnNext()
		arg_67_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_73_0)
	arg_73_0:PlayActorAnimationAction(907301, "summer_shock", 0, 1.166667, function()
		return
	end)
	arg_73_0:EnableCameraByTagAction("6", 1, 0)
	arg_73_0:DelayTimeAction(2, function()
		arg_73_0:PlayActorAnimationAction(907301, "summer_doubt", 0, 2, function()
			return
		end)
	end)
	arg_73_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_73_0:LookAtRoleAction(true, 907301, "9072")
	arg_73_0:PlayActorEmoteAction(9072, "fear01", 0, 3.166667, function()
		return
	end, true, true)
	arg_73_0:ShowTalkView()
	arg_73_0:SetTalkContent(11042011, "", 0)
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
	arg_73_0:OnNext(function(arg_80_0)
		arg_73_0:ClearOnNext()
		arg_73_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_81_0)
	arg_81_0:PlayActorAnimationAction(9072, "proud_end", 0.05, 0.7666668, function()
		return
	end)
	arg_81_0:ShowTalkView()
	arg_81_0:SetTalkContent(11042012, "", 0)
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
	arg_81_0:OnNext(function(arg_85_0)
		arg_81_0:ClearOnNext()
		arg_81_0:BlackFadeDialogueNode_14()
	end)
end

function var_0_0.BlackFadeDialogueNode_14(arg_86_0)
	arg_86_0:HideTalkView()
	arg_86_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_86_0:HideAllDynamicAction(false, false, 4095, {})
		arg_86_0:DestroyCharAction(9072)
		arg_86_0:EnableCameraByTagAction("", 1, 0)
		arg_86_0:DestroyCharAction(907301)
		arg_86_0:DestroyCharAction(9074)
		arg_86_0:ContinueBlackFade()
		arg_86_0:OnNext(function()
			arg_86_0:ClearOnNext()
			arg_86_0:CloseStoryEventNode_15()
		end)
	end, function()
		arg_86_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_15(arg_90_0)
	arg_90_0:EnableCameraCutAction(false)
	arg_90_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_91_0)
	arg_91_0:RegisterTalkFunction("End", arg_91_0.CloseStoryEventNode_15)
end

return var_0_0
