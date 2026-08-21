BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11040", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11040"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11040"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:EnableCameraCutAction(true)
		arg_5_0:SetCharToTagAction(9060, "9060-1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "9074-1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 11, {
			15
		})
		arg_5_0:ActorSeekerAction(9060, {
			"9060-2"
		}, 0.5, function()
			return
		end)
		arg_5_0:SetCharToTagAction(9510, "9510-1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(907301, "9073-1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:BirdsGlobleCull(true)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_14_0)
	arg_14_0:CameraMoveAction("1", 3, 1, 4.5, 1)
	arg_14_0:DelayTimeAction(4, function()
		arg_14_0:SetNeedClick(true, {
			Invoke = function()
				arg_14_0:Next()
			end
		})
		arg_14_0:SetNeedSkip(true, {
			Invoke = function()
				arg_14_0:Skip("LastWord")
			end
		})
	end)
	arg_14_0:ShowTalkView()
	arg_14_0:SetTalkContent(11040001, "", 9060)
	arg_14_0:SetNeedSkip(true, {
		Invoke = function()
			arg_14_0:Skip("LastWord")
		end
	})
	arg_14_0:SetNeedClick(true, {
		Invoke = function()
			arg_14_0:Next()
		end
	})
	arg_14_0:OnNext(function(arg_20_0)
		arg_14_0:ClearOnNext()
		arg_14_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_21_0)
	arg_21_0:EnableCameraByTagAction("2", 1, 0)
	arg_21_0:PlayActorAnimationAction(9510, "summer_doubt", 0.1, 2, function()
		return
	end)
	arg_21_0:PlayActorEmoteAction(9510, "blink", 0.2, 0.3333333, function()
		return
	end, true, false)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11040002, "", 9510)
	arg_21_0:SetNeedSkip(true, {
		Invoke = function()
			arg_21_0:Skip("LastWord")
		end
	})
	arg_21_0:SetNeedClick(true, {
		Invoke = function()
			arg_21_0:Next()
		end
	})
	arg_21_0:OnNext(function(arg_26_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_27_0)
	arg_27_0:PlayActorAnimationAction(907301, "action2_1", 0.1, 1.666667, function()
		return
	end)
	arg_27_0:EnableCameraByTagAction("3", 2, 0.5)
	arg_27_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_27_0:LookAtRoleAction(true, 907301, "9510")
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11040003, "", 907301)
	arg_27_0:SetNeedSkip(true, {
		Invoke = function()
			arg_27_0:Skip("LastWord")
		end
	})
	arg_27_0:SetNeedClick(true, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_31_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_32_0)
	arg_32_0:EnableCameraByTagAction("4", 2, 0.5)
	arg_32_0:PlayActorEmoteAction(9510, "sad04_start", 0, 0.5, function()
		return
	end, true, true)
	arg_32_0:PlayActorAnimationAction(9510, "summer_shock", 0, 1.166667, function()
		return
	end)
	arg_32_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_32_0:LookAtRoleAction(true, 9510, "907301")
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11040004, "", 9510)
	arg_32_0:SetNeedSkip(true, {
		Invoke = function()
			arg_32_0:Skip("LastWord")
		end
	})
	arg_32_0:SetNeedClick(true, {
		Invoke = function()
			arg_32_0:Next()
		end
	})
	arg_32_0:OnNext(function(arg_37_0)
		arg_32_0:ClearOnNext()
		arg_32_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_38_0)
	arg_38_0:EnableCameraByTagAction("5", 1, 0.5)
	arg_38_0:CameraMoveAction("5", 4, 6, 3, 0.2)
	arg_38_0:PlayActorAnimationAction(907301, "proud", 0.05, 2.333333, function()
		return
	end)
	arg_38_0:ActorSeekerAction(907301, {
		"9073-2"
	}, 0.5, function()
		return
	end)
	arg_38_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11040005, "", 907301)
	arg_38_0:SetNeedSkip(true, {
		Invoke = function()
			arg_38_0:Skip("LastWord")
		end
	})
	arg_38_0:SetNeedClick(true, {
		Invoke = function()
			arg_38_0:Next()
		end
	})
	arg_38_0:OnNext(function(arg_44_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_45_0)
	arg_45_0:PlayActorEmoteAction(9510, "sad03_end", 0, 0.7333333, function()
		arg_45_0:DelayTimeAction(0.2, function()
			arg_45_0:PlayActorAnimationAction(9510, "embarrassed", 0.05, 2.6, function()
				return
			end)
		end)
	end, true, false)
	arg_45_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_45_0:LookAtRoleAction(true, 9510, "907301")
	arg_45_0:EnableCameraByTagAction("6", 1, 0.5)
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(11040006, "", 9510)
	arg_45_0:SetNeedSkip(true, {
		Invoke = function()
			arg_45_0:Skip("LastWord")
		end
	})
	arg_45_0:SetNeedClick(true, {
		Invoke = function()
			arg_45_0:Next()
		end
	})
	arg_45_0:OnNext(function(arg_51_0)
		arg_45_0:ClearOnNext()
		arg_45_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_52_0)
	arg_52_0:EnableCameraByTagAction("7", 1, 0.5)
	arg_52_0:PlayActorAnimationAction(9074, "dorm_female_idle01", 0.05, 4.166667, function()
		return
	end)
	arg_52_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_52_0:LookAtRoleAction(true, 9074, "907301")
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11040007, "", 9074)
	arg_52_0:SetNeedSkip(true, {
		Invoke = function()
			arg_52_0:Skip("LastWord")
		end
	})
	arg_52_0:SetNeedClick(true, {
		Invoke = function()
			arg_52_0:Next()
		end
	})
	arg_52_0:OnNext(function(arg_56_0)
		arg_52_0:ClearOnNext()
		arg_52_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_57_0)
	arg_57_0:EnableCameraByTagAction("8", 1, 0.5)
	arg_57_0:CameraMoveAction("8", 3, 4, 2, 0.2)
	arg_57_0:PlayActorAnimationAction(9510, "take", 0.05, 1.833333, function()
		return
	end)
	arg_57_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_57_0:LookAtRoleAction(false, 907301, "907301")
	arg_57_0:ShowTalkView()
	arg_57_0:SetTalkContent(11040008, "", 9510)
	arg_57_0:SetNeedSkip(true, {
		Invoke = function()
			arg_57_0:Skip("LastWord")
		end
	})
	arg_57_0:SetNeedClick(true, {
		Invoke = function()
			arg_57_0:Next()
		end
	})
	arg_57_0:OnNext(function(arg_61_0)
		arg_57_0:ClearOnNext()
		arg_57_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_62_0)
	arg_62_0:ActorSeekerAction(9510, {
		"9510-2",
		"9510-3",
		"9510-4",
		"9510-5"
	}, 2.5, function()
		return
	end)
	arg_62_0:DelayTimeAction(4, function()
		arg_62_0:SetNeedClick(true, {
			Invoke = function()
				arg_62_0:Next()
			end
		})
		arg_62_0:SetNeedSkip(true, {
			Invoke = function()
				arg_62_0:Skip("LastWord")
			end
		})
	end)
	arg_62_0:EnableCameraByTagAction("9_1", 1, 0.5)
	arg_62_0:ShowTalkView()
	arg_62_0:SetTalkContent(11040009, "", 9510)
	arg_62_0:SetNeedSkip(false, {
		Invoke = function()
			arg_62_0:Skip("End")
		end
	})
	arg_62_0:SetNeedClick(false, {
		Invoke = function()
			arg_62_0:Next()
		end
	})
	arg_62_0:OnNext(function(arg_69_0)
		arg_62_0:ClearOnNext()
		arg_62_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_70_0)
	arg_70_0:DestroyCharAction(9510)
	arg_70_0:EnableCameraByTagAction("10", 1, 0.5)
	arg_70_0:PlayActorAnimationAction(907301, "win", 0.05, 1.933333, function()
		return
	end)
	arg_70_0:SetCharToTagAction(907301, "9073-2", function()
		return
	end)
	arg_70_0:ShowTalkView()
	arg_70_0:SetTalkContent(11040010, "", 907301)
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
	arg_70_0:OnNext(function(arg_75_0)
		arg_70_0:ClearOnNext()
		arg_70_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_76_0)
	arg_76_0:EnableCameraByTagAction("11", 1, 0.5)
	arg_76_0:PlayActorAnimationAction(9074, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_76_0:SetLookAtParamsAction(9074, 0.6, 0.8, 1)
	arg_76_0:LookAtRoleAction(true, 9074, "907301")
	arg_76_0:ShowTalkView()
	arg_76_0:SetTalkContent(11040011, "", 9074)
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
	arg_76_0:OnNext(function(arg_80_0)
		arg_76_0:ClearOnNext()
		arg_76_0:PureActorDialogueNode_13()
	end)
end

function var_0_0.PureActorDialogueNode_13(arg_81_0)
	arg_81_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_81_0:EnableCameraByTagAction("xiuchuan_1", 1, 0)
		arg_81_0:PlayActorAnimationAction(907301, "jack_kick_1", 0, 1.166667, function()
			return
		end)
		arg_81_0:SetCharToTagAction(907301, "xiuchuan_1", function()
			return
		end)
		arg_81_0:DelayTimeAction(1.8, function()
			arg_81_0:CameraMoveAction("xiuchuan_2", 1, 4, 4, 0.4)
			arg_81_0:EnableCameraByTagAction("xiuchuan_2", 1, 0)
			arg_81_0:DelayTimeAction(2.2, function()
				arg_81_0:DelayTimeAction(2, function()
					arg_81_0:BlackFadeAction(0.2, 0.2, 0.2, function()
						arg_81_0:InstEffectAction({
							pointTag = "bujian",
							destroyMode = "DontDestroy",
							createMode = "Point",
							path = "QWWorld/Effect/EmotionBubble/fx_canlan_0401.prefab"
						})
					end, function()
						arg_81_0:HideAllDynamicAction(true, true, 4091, {
							14
						})
					end)
					arg_81_0:DelayTimeAction(2.6, function()
						arg_81_0:EventAction(function()
							arg_81_0:ImmediateNextFlag(-1)
						end)
					end)
				end)
				arg_81_0:EnableCameraByTagAction("xiuchuan_4", 1, 0)
				arg_81_0:DestroyCharAction(907301)
				arg_81_0:CameraMoveAction("xiuchuan_4", 1, 4, 5, 0.4)
			end)
			arg_81_0:SetCharToTagAction(907301, "xiuchuan_2", function()
				return
			end)
			arg_81_0:PlayActorAnimationAction(907301, "jack_kick_2", 0, 1.933334, function()
				return
			end)
		end)
		arg_81_0:CameraMoveAction("xiuchuan_1", 1, 2, 4, 0.4)
		arg_81_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_06_xiuchuan", "", "")
	end)
	arg_81_0:HideTalkView()
	arg_81_0:OnNext(function()
		arg_81_0:ClearOnNext()
		arg_81_0:BlackFadeDialogueNode_14()
	end)
end

function var_0_0.BlackFadeDialogueNode_14(arg_96_0)
	arg_96_0:HideTalkView()
	arg_96_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_96_0:DestroyCharAction(9060)
		arg_96_0:DestroyCharAction(9510)
		arg_96_0:DestroyCharAction(907301)
		arg_96_0:DestroyCharAction(9074)
		arg_96_0:HideAllDynamicAction(false, false, 4095, {})
		arg_96_0:Agent_PlayerPosControl("chuansong", function()
			arg_96_0:EnableCameraByTagAction("", 1, 0.5)
		end)
		arg_96_0:ContinueBlackFade()
		arg_96_0:OnNext(function()
			arg_96_0:ClearOnNext()
			arg_96_0:CloseStoryEventNode_15()
		end)
	end, function()
		arg_96_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_15(arg_101_0)
	arg_101_0:EnableCameraCutAction(false)
	arg_101_0:BirdsGlobleCull(false)
	arg_101_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_102_0)
	arg_102_0:RegisterTalkFunction("LastWord", arg_102_0.DialogueNode_12)
	arg_102_0:RegisterTalkFunction("End", arg_102_0.CloseStoryEventNode_15)
end

return var_0_0
