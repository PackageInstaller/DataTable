BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11041", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11041"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11041"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:EnableCameraCutAction(true)
		arg_5_0:SetCharToTagAction(9060, "9060-1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:SetCharToTagAction(9510, "9510-1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(907301, "9073-1", function()
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

function var_0_0.DialogueNode_2(arg_12_0)
	arg_12_0:PlayActorAnimationAction(9060, "summer_doubt", 0.1, 2, function()
		return
	end)
	arg_12_0:CameraMoveAction("1", 3, 6, 3, 0.2)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(11041001, "", 9060)
	arg_12_0:SetNeedSkip(true, {
		Invoke = function()
			arg_12_0:Skip("LastWord")
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
	arg_17_0:PlayActorAnimationAction(907301, "happy02", 0.1, 3, function()
		return
	end)
	arg_17_0:EnableCameraByTagAction("2", 1, 0)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11041002, "", 907301)
	arg_17_0:SetNeedSkip(true, {
		Invoke = function()
			arg_17_0:Skip("LastWord")
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
	arg_22_0:PlayActorAnimationAction(9510, "conversation_2", 0.1, 3.166667, function()
		return
	end)
	arg_22_0:EnableCameraByTagAction("3", 1, 0)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11041003, "", 9510)
	arg_22_0:SetNeedSkip(true, {
		Invoke = function()
			arg_22_0:Skip("LastWord")
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
	arg_27_0:EnableCameraByTagAction("4", 1, 0)
	arg_27_0:SetLookAtParamsAction(907301, 0.8, 1, 0.8)
	arg_27_0:LookAtRoleAction(true, 907301, "9510")
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11041004, "", 907301)
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
	arg_27_0:OnNext(function(arg_30_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_31_0)
	arg_31_0:PlayActorAnimationAction(9510, "think_start", 0.1, 1.333333, function()
		return
	end)
	arg_31_0:DelayTimeAction(3, function()
		arg_31_0:EnableCameraByTagAction("6", 1, 0)
		arg_31_0:CameraMoveAction("6", 3, 1, 4, 2)
	end)
	arg_31_0:DelayTimeAction(5, function()
		arg_31_0:SetNeedClick(true, {
			Invoke = function()
				arg_31_0:Next()
			end
		})
		arg_31_0:SetNeedSkip(false, nil)
	end)
	arg_31_0:EnableCameraByTagAction("5", 1, 0)
	arg_31_0:ShowTalkView()
	arg_31_0:SetTalkContent(11041005, "", 9510)
	arg_31_0:SetNeedSkip(true, {
		Invoke = function()
			arg_31_0:Skip("LastWord")
		end
	})
	arg_31_0:SetNeedClick(false, {
		Invoke = function()
			arg_31_0:Next()
		end
	})
	arg_31_0:OnNext(function(arg_38_0)
		arg_31_0:ClearOnNext()
		arg_31_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_39_0)
	arg_39_0:PlayActorAnimationAction(9510, "think_end", 0.1, 1.666667, function()
		return
	end)
	arg_39_0:EnableCameraByTagAction("5", 1, 0)
	arg_39_0:ShowTalkView()
	arg_39_0:SetTalkContent(11041006, "", 9510)
	arg_39_0:SetNeedSkip(true, {
		Invoke = function()
			arg_39_0:Skip("LastWord")
		end
	})
	arg_39_0:SetNeedClick(true, {
		Invoke = function()
			arg_39_0:Next()
		end
	})
	arg_39_0:OnNext(function(arg_43_0)
		arg_39_0:ClearOnNext()
		arg_39_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_44_0)
	arg_44_0:PlayActorAnimationAction(907301, "proud", 0.1, 2.333333, function()
		return
	end)
	arg_44_0:EnableCameraByTagAction("7", 1, 0)
	arg_44_0:PlayActorEmoteAction(907301, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11041007, "", 907301)
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
	arg_44_0:OnNext(function(arg_49_0)
		arg_44_0:ClearOnNext()
		arg_44_0:BlackFadeDialogueNode_9()
	end)
end

function var_0_0.BlackFadeDialogueNode_9(arg_50_0)
	arg_50_0:HideTalkView()
	arg_50_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_50_0:DestroyCharAction(9060)
		arg_50_0:DestroyCharAction(9510)
		arg_50_0:DestroyCharAction(907301)
		arg_50_0:HideAllDynamicAction(false, false, 4095, {})
		arg_50_0:Agent_PlayerPosControl("chuansong", function()
			arg_50_0:EnableCameraByTagAction("", 1, 0)
		end)
		arg_50_0:ContinueBlackFade()
		arg_50_0:OnNext(function()
			arg_50_0:ClearOnNext()
			arg_50_0:CloseStoryEventNode_10()
		end)
	end, function()
		arg_50_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_10(arg_55_0)
	arg_55_0:EnableCameraCutAction(false)
	arg_55_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_56_0)
	arg_56_0:RegisterTalkFunction("LastWord", arg_56_0.BlackFadeDialogueNode_9)
	arg_56_0:RegisterTalkFunction("End", arg_56_0.CloseStoryEventNode_10)
end

return var_0_0
