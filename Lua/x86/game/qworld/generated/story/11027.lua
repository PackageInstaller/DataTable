BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11027", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11027"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11027"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
		arg_5_0:SetCharToTagAction(9519, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9510, "3", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("right_sight", 1, 0)
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

function var_0_0.DialogueNode_2(arg_12_0)
	arg_12_0:EnableCameraByTagAction("right_sight", 1, 0)
	arg_12_0:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_12_0:PlayActorEmoteAction(9073, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_12_0:EnableCameraCutAction(true)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(11027001, "", 9073)
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
	arg_12_0:OnNext(function(arg_17_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_18_0)
	arg_18_0:EnableCameraByTagAction("Middle_camra", 1, 0)
	arg_18_0:PlayActorAnimationAction(9514, "proud", 0.05, 2.333333, function()
		return
	end)
	arg_18_0:PlayActorEmoteAction(9514, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	arg_18_0:ShowTalkView()
	arg_18_0:SetTalkContent(11027002, "", 9519)
	arg_18_0:SetNeedSkip(true, {
		Invoke = function()
			arg_18_0:Skip("End")
		end
	})
	arg_18_0:SetNeedClick(true, {
		Invoke = function()
			arg_18_0:Next()
		end
	})
	arg_18_0:OnNext(function(arg_23_0)
		arg_18_0:ClearOnNext()
		arg_18_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_24_0)
	arg_24_0:EnableCameraByTagAction("left_sight", 1, 0)
	arg_24_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_24_0:PlayActorEmoteAction(9510, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, false)
	arg_24_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_24_0:LookAtRoleAction(true, 9510, "9073")
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(11027003, "", 9510)
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
	arg_30_0:EnableCameraByTagAction("right_sight", 1, 0)
	arg_30_0:PlayActorAnimationAction(9073, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_30_0:PlayActorEmoteAction(9073, "disdain01_start", 0, 0.4, function()
		return
	end, true, false)
	arg_30_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_30_0:LookAtRoleAction(true, 9073, "9510")
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11027004, "", 9073)
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
	arg_36_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_36_0:PlayActorEmoteAction(9510, "squint01_start", 0, 0.3333333, function()
		return
	end, true, false)
	arg_36_0:SetLookAtParamsAction(9510, 0.8, 1, 1)
	arg_36_0:LookAtRoleAction(true, 9510, "9073")
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(11027005, "", 9510)
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
	arg_36_0:OnNext(function(arg_41_0)
		arg_36_0:ClearOnNext()
		arg_36_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_42_0)
	arg_42_0:EnableCameraByTagAction("Middle_camra", 1, 0)
	arg_42_0:PlayActorAnimationAction(9073, "troubled", 0.05, 3.666667, function()
		return
	end)
	arg_42_0:PlayActorEmoteAction(9073, "complaint02", 0, 1.466667, function()
		return
	end, true, false)
	arg_42_0:SetLookAtParamsAction(9073, 0.668, 0.788, 1)
	arg_42_0:LookAtRoleAction(true, 9073, "9510")
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11027006, "", 9073)
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
	arg_42_0:OnNext(function(arg_47_0)
		arg_42_0:ClearOnNext()
		arg_42_0:BlackFadeDialogueNode_8()
	end)
end

function var_0_0.BlackFadeDialogueNode_8(arg_48_0)
	arg_48_0:HideTalkView()
	arg_48_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_48_0:HideAllDynamicAction(false, false, 0, {})
		arg_48_0:DestroyCharAction(9073)
		arg_48_0:EnableCameraByTagAction("", 1, 0)
		arg_48_0:DestroyCharAction(9514)
		arg_48_0:DestroyCharAction(9510)
		arg_48_0:WalkingPeopleGlobleCull(false)
		arg_48_0:ContinueBlackFade()
		arg_48_0:OnNext(function()
			arg_48_0:ClearOnNext()
			arg_48_0:CloseStoryEventNode_9()
		end)
	end, function()
		arg_48_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_9(arg_52_0)
	arg_52_0:EnableCameraCutAction(false)
	arg_52_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_53_0)
	arg_53_0:RegisterTalkFunction("End", arg_53_0.CloseStoryEventNode_9)
end

return var_0_0
