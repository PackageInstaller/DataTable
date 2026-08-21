BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11014", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11014"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11014"
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
		arg_5_0:SetCharToTagAction(9074, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("3", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
		arg_5_0:WalkingPeopleGlobleCull(true)
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
	arg_11_0:CameraMoveAction("3", 4, 2, 3, 0.4)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11014001, "", 9073)
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
	arg_11_0:OnNext(function(arg_14_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_15_0)
	arg_15_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_15_0:PlayActorAnimationAction(9074, "conversation_2", 0, 3.166667, function()
		return
	end)
	arg_15_0:SetLookAtParamsAction(9074, 0.8, 1, 0.8)
	arg_15_0:LookAtRoleAction(true, 9074, "9073")
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(11014002, "", 9074)
	arg_15_0:SetNeedSkip(true, {
		Invoke = function()
			arg_15_0:Skip("LastWord")
		end
	})
	arg_15_0:SetNeedClick(true, {
		Invoke = function()
			arg_15_0:Next()
		end
	})
	arg_15_0:OnNext(function(arg_19_0)
		arg_15_0:ClearOnNext()
		arg_15_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_20_0)
	arg_20_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_20_0:SetLookAtParamsAction(9073, 0.8, 1, 0.8)
	arg_20_0:LookAtRoleAction(true, 9073, "9074")
	arg_20_0:PlayActorEmoteAction(9073, "shocked01", 0, 1.4, function()
		arg_20_0:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
			return
		end, true, false)
	end, true, false)
	arg_20_0:DelayTimeAction(2, function()
		arg_20_0:PlayActorAnimationAction(9073, "summer_doubt", 0, 2, function()
			return
		end)
		arg_20_0:SetNeedClick(true, {
			Invoke = function()
				arg_20_0:Next()
			end
		})
		arg_20_0:SetNeedSkip(true, {
			Invoke = function()
				arg_20_0:Skip("LastWord")
			end
		})
	end)
	arg_20_0:ShowTalkView()
	arg_20_0:SetTalkContent(11014003, "", 9073)
	arg_20_0:SetNeedSkip(true, {
		Invoke = function()
			arg_20_0:Skip("LastWord")
		end
	})
	arg_20_0:SetNeedClick(false, {
		Invoke = function()
			arg_20_0:Next()
		end
	})
	arg_20_0:OnNext(function(arg_29_0)
		arg_20_0:ClearOnNext()
		arg_20_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_30_0)
	arg_30_0:PlayActorAnimationAction(9074, "conversation_1", 0, 3, function()
		return
	end)
	arg_30_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11014004, "", 9074)
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
	arg_30_0:OnNext(function(arg_34_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_35_0)
	arg_35_0:PlayActorAnimationAction(9073, "action3_1", 0, 2.266667, function()
		return
	end)
	arg_35_0:ShowTalkView()
	arg_35_0:SetTalkContent(11014005, "", 9073)
	arg_35_0:SetNeedSkip(true, {
		Invoke = function()
			arg_35_0:Skip("LastWord")
		end
	})
	arg_35_0:SetNeedClick(true, {
		Invoke = function()
			arg_35_0:Next()
		end
	})
	arg_35_0:OnNext(function(arg_39_0)
		arg_35_0:ClearOnNext()
		arg_35_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_40_0)
	arg_40_0:EnableCameraByTagAction("4", 1, 0)
	arg_40_0:CameraMoveAction("4", 4, 4, 8, 0.6)
	arg_40_0:PlayActorAnimationAction(9073, "summer_doubt", 0.2, 2, function()
		return
	end)
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11014006, "", 9073)
	arg_40_0:SetNeedSkip(true, {
		Invoke = function()
			arg_40_0:Skip("LastWord")
		end
	})
	arg_40_0:SetNeedClick(true, {
		Invoke = function()
			arg_40_0:Next()
		end
	})
	arg_40_0:OnNext(function(arg_44_0)
		arg_40_0:ClearOnNext()
		arg_40_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_45_0)
	arg_45_0:PlayActorAnimationAction(9074, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(11014007, "", 9074)
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
	arg_45_0:OnNext(function(arg_49_0)
		arg_45_0:ClearOnNext()
		arg_45_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_50_0)
	arg_50_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_50_0:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_50_0:ShowTalkView()
	arg_50_0:SetTalkContent(11014008, "", 9073)
	arg_50_0:SetNeedSkip(true, {
		Invoke = function()
			arg_50_0:Skip("LastWord")
		end
	})
	arg_50_0:SetNeedClick(true, {
		Invoke = function()
			arg_50_0:Next()
		end
	})
	arg_50_0:OnNext(function(arg_54_0)
		arg_50_0:ClearOnNext()
		arg_50_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_55_0)
	arg_55_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_55_0:PlayActorAnimationAction(9074, "think_start", 0.2, 1.333333, function()
		return
	end)
	arg_55_0:PlayActorEmoteAction(9074, "squint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_55_0:ShowTalkView()
	arg_55_0:SetTalkContent(11014009, "", 9074)
	arg_55_0:SetNeedSkip(true, {
		Invoke = function()
			arg_55_0:Skip("LastWord")
		end
	})
	arg_55_0:SetNeedClick(true, {
		Invoke = function()
			arg_55_0:Next()
		end
	})
	arg_55_0:OnNext(function(arg_60_0)
		arg_55_0:ClearOnNext()
		arg_55_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_61_0)
	arg_61_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_61_0:PlayActorAnimationAction(9073, "action2_1", 0.2, 1.666667, function()
		return
	end)
	arg_61_0:PlayActorEmoteAction(9073, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_61_0:ShowTalkView()
	arg_61_0:SetTalkContent(11014010, "", 9073)
	arg_61_0:SetNeedSkip(true, {
		Invoke = function()
			arg_61_0:Skip("LastWord")
		end
	})
	arg_61_0:SetNeedClick(true, {
		Invoke = function()
			arg_61_0:Next()
		end
	})
	arg_61_0:OnNext(function(arg_66_0)
		arg_61_0:ClearOnNext()
		arg_61_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_67_0)
	arg_67_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_67_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_67_0:LookAtRoleAction(true, 9074, "9073")
	arg_67_0:PlayActorEmoteAction(9074, "blink", 0.1, 0.3333333, function()
		return
	end, true, false)
	arg_67_0:PlayActorAnimationAction(9074, "think_end", 0.2, 1.666667, function()
		return
	end)
	arg_67_0:ShowTalkView()
	arg_67_0:SetTalkContent(11014011, "", 9074)
	arg_67_0:SetNeedSkip(false, {
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
		arg_67_0:BlackFadeDialogueNode_13()
	end)
end

function var_0_0.BlackFadeDialogueNode_13(arg_73_0)
	arg_73_0:HideTalkView()
	arg_73_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_73_0:DestroyCharAction(9073)
		arg_73_0:DestroyCharAction(9074)
		arg_73_0:HideAllDynamicAction(false, false, 4095, {})
		arg_73_0:Agent_PlayerPosControl("chuansong", function()
			arg_73_0:EnableCameraByTagAction("", 1, 0)
		end)
		arg_73_0:WalkingPeopleGlobleCull(false)
		arg_73_0:ContinueBlackFade()
		arg_73_0:OnNext(function()
			arg_73_0:ClearOnNext()
			arg_73_0:CloseStoryEventNode_14()
		end)
	end, function()
		arg_73_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_14(arg_78_0)
	arg_78_0:EnableCameraCutAction(false)
	arg_78_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_79_0)
	arg_79_0:RegisterTalkFunction("LastWord", arg_79_0.DialogueNode_12)
	arg_79_0:RegisterTalkFunction("End", arg_79_0.CloseStoryEventNode_14)
end

return var_0_0
