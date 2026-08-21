BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11034", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11034"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11034"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4081, {})
		arg_5_0:SetCharToTagAction(907301, "9073_1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:CameraMoveAction("1", 4, 6, 2, 1)
		arg_5_0:PlayActorAnimationAction(9070, "summer_shock_start", 0.05, 0.3333333, function()
			return
		end)
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
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11034001, "", 9073)
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
	arg_11_0:OnNext(function(arg_14_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_15_0)
	arg_15_0:PlayActorAnimationAction(907301, "summer_doubt_end", 0.05, 0.4666667, function()
		return
	end)
	arg_15_0:ActorSeekerAction(907301, {
		"1"
	}, 0.5, function()
		return
	end)
	arg_15_0:SetCharToTagAction(9060, "9060_1", function()
		arg_15_0:ActorSeekerAction(9060, {
			"2"
		}, 0.6, function()
			arg_15_0:SetNeedClick(true, {
				Invoke = function()
					arg_15_0:Next()
				end
			})
			arg_15_0:SetNeedSkip(true, {
				Invoke = function()
					arg_15_0:Skip("End")
				end
			})
		end)
	end)
	arg_15_0:SetCharToTagAction(9510, "9510_1", function()
		arg_15_0:DelayTimeAction(0.2, function()
			arg_15_0:ActorSeekerAction(9510, {
				"3"
			}, 0.6, function()
				return
			end)
		end)
	end)
	arg_15_0:DelayTimeAction(3.5, function()
		return
	end)
	arg_15_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(11034002, "", 9073)
	arg_15_0:SetNeedSkip(true, {
		Invoke = function()
			arg_15_0:Skip("End")
		end
	})
	arg_15_0:SetNeedClick(false, {
		Invoke = function()
			arg_15_0:Next()
		end
	})
	arg_15_0:OnNext(function(arg_28_0)
		arg_15_0:ClearOnNext()
		arg_15_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_29_0)
	arg_29_0:PlayActorAnimationAction(9060, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(11034003, "", 9060)
	arg_29_0:SetNeedSkip(true, {
		Invoke = function()
			arg_29_0:Skip("End")
		end
	})
	arg_29_0:SetNeedClick(true, {
		Invoke = function()
			arg_29_0:Next()
		end
	})
	arg_29_0:OnNext(function(arg_33_0)
		arg_29_0:ClearOnNext()
		arg_29_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_34_0)
	arg_34_0:PlayActorEmoteAction(907301, "shocked01", 0, 1.4, function()
		arg_34_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
			arg_34_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
			arg_34_0:LookAtRoleAction(true, 907301, "9510")
			arg_34_0:SetNeedClick(true, {
				Invoke = function()
					arg_34_0:Next()
				end
			})
			arg_34_0:SetNeedSkip(true, {
				Invoke = function()
					arg_34_0:Skip("End")
				end
			})
		end)
	end, true, false)
	arg_34_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_34_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_34_0:LookAtRoleAction(true, 907301, "9060")
	arg_34_0:ShowTalkView()
	arg_34_0:SetTalkContent(11034004, "", 0)
	arg_34_0:SetNeedSkip(true, {
		Invoke = function()
			arg_34_0:Skip("End")
		end
	})
	arg_34_0:SetNeedClick(false, {
		Invoke = function()
			arg_34_0:Next()
		end
	})
	arg_34_0:OnNext(function(arg_41_0)
		arg_34_0:ClearOnNext()
		arg_34_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_42_0)
	arg_42_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_42_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11034005, "", 0)
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
		arg_42_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_47_0)
	arg_47_0:PlayActorAnimationAction(907301, "embarrassed", 0.05, 2.6, function()
		arg_47_0:PlayActorAnimationAction(907301, "excited_start", 0.05, 0.6666667, function()
			return
		end)
		arg_47_0:PlayActorEmoteAction(907301, "anger02_start", 0, 0.5, function()
			return
		end, true, true)
	end)
	arg_47_0:PlayActorEmoteAction(907301, "complaint02", 0, 1.466667, function()
		return
	end, true, false)
	arg_47_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11034006, "", 0)
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
	arg_47_0:OnNext(function(arg_54_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_55_0)
	arg_55_0:PlayActorAnimationAction(9510, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_55_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_55_0:DelayTimeAction(2, function()
		arg_55_0:PlayActorAnimationAction(9510, "think_end", 0.05, 1.666667, function()
			arg_55_0:PlayActorAnimationAction(9510, "conversation_2", 0.1, 3.166667, function()
				return
			end)
		end)
	end)
	arg_55_0:ShowTalkView()
	arg_55_0:SetTalkContent(11034007, "", 0)
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
	arg_55_0:OnNext(function(arg_62_0)
		arg_55_0:ClearOnNext()
		arg_55_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_63_0)
	arg_63_0:PlayActorEmoteAction(907301, "", 0, 0, function()
		return
	end, false, false)
	arg_63_0:PlayActorAnimationAction(907301, "excited_end", 0.05, 0.6666667, function()
		return
	end)
	arg_63_0:ShowTalkView()
	arg_63_0:SetTalkContent(11034008, "", 0)
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
	arg_63_0:OnNext(function(arg_68_0)
		arg_63_0:ClearOnNext()
		arg_63_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_69_0)
	arg_69_0:PlayActorAnimationAction(9060, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_69_0:PlayActorEmoteAction(9060, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_69_0:EnableCameraByTagAction("9", 1, 0)
	arg_69_0:ShowTalkView()
	arg_69_0:SetTalkContent(11034009, "", 0)
	arg_69_0:SetNeedSkip(true, {
		Invoke = function()
			arg_69_0:Skip("End")
		end
	})
	arg_69_0:SetNeedClick(true, {
		Invoke = function()
			arg_69_0:Next()
		end
	})
	arg_69_0:OnNext(function(arg_74_0)
		arg_69_0:ClearOnNext()
		arg_69_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_75_0)
	arg_75_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		arg_75_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
		arg_75_0:LookAtRoleAction(true, 907301, "9060")
	end)
	arg_75_0:EnableCameraByTagAction("4", 1, 0)
	arg_75_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_75_0:LookAtRoleAction(true, 907301, "9510")
	arg_75_0:CameraMoveAction("4", 4, 4, 6, 0.6)
	arg_75_0:ShowTalkView()
	arg_75_0:SetTalkContent(11034010, "", 0)
	arg_75_0:SetNeedSkip(true, {
		Invoke = function()
			arg_75_0:Skip("End")
		end
	})
	arg_75_0:SetNeedClick(true, {
		Invoke = function()
			arg_75_0:Next()
		end
	})
	arg_75_0:OnNext(function(arg_79_0)
		arg_75_0:ClearOnNext()
		arg_75_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_80_0)
	arg_80_0:ShowTalkView()
	arg_80_0:SetTalkContent(11034011, "", 0)
	arg_80_0:SetNeedSkip(true, {
		Invoke = function()
			arg_80_0:Skip("End")
		end
	})
	arg_80_0:SetNeedClick(true, {
		Invoke = function()
			arg_80_0:Next()
		end
	})
	arg_80_0:OnNext(function(arg_83_0)
		arg_80_0:ClearOnNext()
		arg_80_0:BlackFadeDialogueNode_13()
	end)
end

function var_0_0.BlackFadeDialogueNode_13(arg_84_0)
	arg_84_0:HideTalkView()
	arg_84_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_84_0:HideAllDynamicAction(false, false, 4095, {})
		arg_84_0:DestroyCharAction(907301)
		arg_84_0:EnableCameraByTagAction("", 1, 0)
		arg_84_0:DestroyCharAction(9060)
		arg_84_0:DestroyCharAction(9510)
		arg_84_0:ContinueBlackFade()
		arg_84_0:OnNext(function()
			arg_84_0:ClearOnNext()
			arg_84_0:CloseStoryEventNode_14()
		end)
	end, function()
		arg_84_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_14(arg_88_0)
	arg_88_0:EnableCameraCutAction(false)
	arg_88_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_89_0)
	arg_89_0:RegisterTalkFunction("End", arg_89_0.BlackFadeDialogueNode_13)
	arg_89_0:RegisterTalkFunction("End", arg_89_0.CloseStoryEventNode_14)
end

return var_0_0
