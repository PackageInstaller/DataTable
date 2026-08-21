BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11018", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11018"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11018"
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
		arg_5_0:SetCharToTagAction(9510, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
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
	arg_11_0:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11018001, "", 9073)
	arg_11_0:SetNeedSkip(true, {
		Invoke = function()
			arg_11_0:Skip("LastWord")
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
	arg_16_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_16_0:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		arg_16_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end, true, false)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11018002, "", 9510)
	arg_16_0:SetNeedSkip(true, {
		Invoke = function()
			arg_16_0:Skip("LastWord")
		end
	})
	arg_16_0:SetNeedClick(true, {
		Invoke = function()
			arg_16_0:Next()
		end
	})
	arg_16_0:OnNext(function(arg_21_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_22_0:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11018003, "", 9073)
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
	arg_27_0:EnableCameraByTagAction("1", 1, 0)
	arg_27_0:PlayActorAnimationAction(9510, "dorm_male_idle01", 0.05, 8.166667, function()
		return
	end)
	arg_27_0:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_27_0:CameraMoveAction("1", 4, 4, 5, 0.4)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11018004, "", 9510)
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
	arg_27_0:OnNext(function(arg_32_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_33_0)
	arg_33_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_33_0:PlayActorAnimationAction(9073, "firm", 0.05, 2.333333, function()
		return
	end)
	arg_33_0:CameraMoveAction("1", 4, 1, 1, 0.2)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(11018005, "", 9073)
	arg_33_0:SetNeedSkip(true, {
		Invoke = function()
			arg_33_0:Skip("LastWord")
		end
	})
	arg_33_0:SetNeedClick(true, {
		Invoke = function()
			arg_33_0:Next()
		end
	})
	arg_33_0:OnNext(function(arg_37_0)
		arg_33_0:ClearOnNext()
		arg_33_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_38_0)
	arg_38_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_38_0:PlayActorEmoteAction(9510, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_38_0:PlayActorAnimationAction(9510, "speechless", 0, 3.333333, function()
		return
	end)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11018006, "", 9510)
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
	arg_38_0:OnNext(function(arg_43_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_44_0)
	arg_44_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_44_0:PlayActorAnimationAction(9073, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11018007, "", 9073)
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
	arg_44_0:OnNext(function(arg_48_0)
		arg_44_0:ClearOnNext()
		arg_44_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_49_0)
	arg_49_0:EnableCameraByTagAction("8", 1, 0)
	arg_49_0:PlayActorEmoteAction(9510, "complaint01_end", 0, 0.5666668, function()
		arg_49_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
			return
		end)
	end, true, false)
	arg_49_0:ShowTalkView()
	arg_49_0:SetTalkContent(11018008, "", 9510)
	arg_49_0:SetNeedSkip(true, {
		Invoke = function()
			arg_49_0:Skip("LastWord")
		end
	})
	arg_49_0:SetNeedClick(true, {
		Invoke = function()
			arg_49_0:Next()
		end
	})
	arg_49_0:OnNext(function(arg_54_0)
		arg_49_0:ClearOnNext()
		arg_49_0:BlackFadeDialogueNode_10()
	end)
end

function var_0_0.BlackFadeDialogueNode_10(arg_55_0)
	arg_55_0:HideTalkView()
	arg_55_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_55_0:DestroyCharAction(9073)
		arg_55_0:DestroyCharAction(9510)
		arg_55_0:HideAllDynamicAction(false, false, 4095, {})
		arg_55_0:Agent_PlayerPosControl("chuansong", function()
			arg_55_0:EnableCameraByTagAction("", 1, 0)
		end)
		arg_55_0:ContinueBlackFade()
		arg_55_0:OnNext(function()
			arg_55_0:ClearOnNext()
			arg_55_0:CloseStoryEventNode_11()
		end)
	end, function()
		arg_55_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_11(arg_60_0)
	arg_60_0:EnableCameraCutAction(false)
	arg_60_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_61_0)
	arg_61_0:RegisterTalkFunction("8", arg_61_0.DialogueNode_7)
	arg_61_0:RegisterTalkFunction("LastWord", arg_61_0.BlackFadeDialogueNode_10)
	arg_61_0:RegisterTalkFunction("End", arg_61_0.CloseStoryEventNode_11)
end

return var_0_0
