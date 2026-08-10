BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11011", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11011"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11011"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9510, "3", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
		arg_5_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
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
	arg_12_0:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(11011001, "", 9073)
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
	arg_12_0:OnNext(function(arg_16_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_17_0:DelayTimeAction(2.5, function()
		arg_17_0:BlackFadeAction(0.2, 0.2, 0.2, function()
			arg_17_0:SetNeedClick(true, {
				Invoke = function()
					arg_17_0:Next()
				end
			})
			arg_17_0:SetNeedSkip(false, nil)
		end, function()
			arg_17_0:EnableCameraByTagAction("2", 1, 0)
			arg_17_0:CameraMoveAction("2", 4, 4, 4, 0.4)
		end)
	end)
	arg_17_0:PlayActorAnimationAction(9074, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_17_0:SetLookAtParamsAction(9074, 0.8, 1, 0.7)
	arg_17_0:LookAtRoleAction(true, 9074, "9073")
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11011002, "", 9074)
	arg_17_0:SetNeedSkip(true, {
		Invoke = function()
			arg_17_0:Skip("End")
		end
	})
	arg_17_0:SetNeedClick(false, {
		Invoke = function()
			arg_17_0:Next()
		end
	})
	arg_17_0:OnNext(function(arg_25_0)
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_26_0)
	arg_26_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_26_0:SetLookAtParamsAction(9073, 0.8, 1, 0.7)
	arg_26_0:LookAtRoleAction(true, 9073, "9510")
	arg_26_0:PlayActorAnimationAction(9073, "think_loop", 0.1, 2, function()
		return
	end)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(11011003, "", 9073)
	arg_26_0:SetNeedSkip(true, {
		Invoke = function()
			arg_26_0:Skip("End")
		end
	})
	arg_26_0:SetNeedClick(true, {
		Invoke = function()
			arg_26_0:Next()
		end
	})
	arg_26_0:OnNext(function(arg_30_0)
		arg_26_0:ClearOnNext()
		arg_26_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_31_0)
	arg_31_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_31_0:SetLookAtParamsAction(9510, 0.8, 1, 0.7)
	arg_31_0:LookAtRoleAction(true, 9510, "9073")
	arg_31_0:PlayActorAnimationAction(9510, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_31_0:ShowTalkView()
	arg_31_0:SetTalkContent(11011004, "", 9510)
	arg_31_0:SetNeedSkip(true, {
		Invoke = function()
			arg_31_0:Skip("End")
		end
	})
	arg_31_0:SetNeedClick(true, {
		Invoke = function()
			arg_31_0:Next()
		end
	})
	arg_31_0:OnNext(function(arg_35_0)
		arg_31_0:ClearOnNext()
		arg_31_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_36_0)
	arg_36_0:EnableCameraByTagAction("3", 1, 0)
	arg_36_0:PlayActorAnimationAction(9073, "summer_doubt_start", 0, 0.7666667, function()
		return
	end)
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(11011005, "", 9073)
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
	arg_41_0:PlayActorAnimationAction(9510, "conversation_1", 0.2, 3, function()
		return
	end)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(11011006, "", 9510)
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
		arg_41_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_46_0)
	arg_46_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_46_0:SetLookAtParamsAction(9074, 0.8, 1, 0.7)
	arg_46_0:LookAtRoleAction(true, 9074, "9510")
	arg_46_0:PlayActorEmoteAction(9074, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_46_0:ShowTalkView()
	arg_46_0:SetTalkContent(11011007, "", 0)
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
		arg_46_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_51_0)
	arg_51_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_51_0:SetLookAtParamsAction(9510, 0.8, 1, 0.7)
	arg_51_0:LookAtRoleAction(true, 9510, "9074")
	arg_51_0:PlayActorAnimationAction(9510, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_51_0:SetLookAtParamsAction(9073, 0.8, 1, 0.7)
	arg_51_0:LookAtRoleAction(true, 9073, "9074")
	arg_51_0:ShowTalkView()
	arg_51_0:SetTalkContent(11011008, "", 0)
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
	arg_51_0:OnNext(function(arg_55_0)
		arg_51_0:ClearOnNext()
		arg_51_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_56_0)
	arg_56_0:PlayActorAnimationAction(9073, "summer_doubt_end", 0.2, 0.4666667, function()
		return
	end)
	arg_56_0:ShowTalkView()
	arg_56_0:SetTalkContent(11011009, "", 0)
	arg_56_0:SetNeedSkip(true, {
		Invoke = function()
			arg_56_0:Skip("End")
		end
	})
	arg_56_0:SetNeedClick(true, {
		Invoke = function()
			arg_56_0:Next()
		end
	})
	arg_56_0:OnNext(function(arg_60_0)
		arg_56_0:ClearOnNext()
		arg_56_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_61_0)
	arg_61_0:PlayActorAnimationAction(9510, "conversation_1", 0.2, 3, function()
		return
	end)
	arg_61_0:SetLookAtParamsAction(9510, 0.8, 1, 0.7)
	arg_61_0:LookAtRoleAction(true, 9510, "9073")
	arg_61_0:ShowTalkView()
	arg_61_0:SetTalkContent(11011010, "", 0)
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
	arg_61_0:OnNext(function(arg_65_0)
		arg_61_0:ClearOnNext()
		arg_61_0:BlackFadeDialogueNode_12()
	end)
end

function var_0_0.BlackFadeDialogueNode_12(arg_66_0)
	arg_66_0:HideTalkView()
	arg_66_0:OnBlackFade(false, 0, 0.2, 0.2, 0.2, function()
		arg_66_0:DestroyCharAction(9073)
		arg_66_0:DestroyCharAction(9074)
		arg_66_0:DestroyCharAction(9510)
		arg_66_0:HideAllDynamicAction(false, false, 4095, {})
		arg_66_0:EnableCameraByTagAction("", 1, 0)
		arg_66_0:ContinueBlackFade()
		arg_66_0:OnNext(function()
			arg_66_0:ClearOnNext()
			arg_66_0:CloseStoryEventNode_13()
		end)
	end, function()
		arg_66_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_13(arg_70_0)
	arg_70_0:EnableCameraCutAction(false)
	arg_70_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_71_0)
	arg_71_0:RegisterTalkFunction("End", arg_71_0.BlackFadeDialogueNode_12)
	arg_71_0:RegisterTalkFunction("End", arg_71_0.CloseStoryEventNode_13)
end

return var_0_0
