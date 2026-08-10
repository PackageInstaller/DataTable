BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11354", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11354"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11354"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.5, 0.5, 1, function()
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:SetCharToTagAction(907301, "9073_1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:PlayActorAnimationAction(907301, "chair1_sit_stand", 0.05, 2, function()
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
	arg_11_0:SetTalkContent(11304001, "", 0)
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
	arg_15_0:SetCharToTagAction(9516, "9516", function()
		return
	end)
	arg_15_0:EnableCameraByTagAction("2", 1, 0)
	arg_15_0:PlayActorAnimationAction(9516, "excited_start", 0.05, 0.6666667, function()
		return
	end)
	arg_15_0:SetLookAtParamsAction(9516, 0.6, 0.8, 1)
	arg_15_0:LookAtRoleAction(true, 9516, "907301")
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(11304002, "", 9516)
	arg_15_0:SetNeedSkip(true, {
		Invoke = function()
			arg_15_0:Skip("End")
		end
	})
	arg_15_0:SetNeedClick(true, {
		Invoke = function()
			arg_15_0:Next()
		end
	})
	arg_15_0:OnNext(function(arg_20_0)
		arg_15_0:ClearOnNext()
		arg_15_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_21_0)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11304003, "", 9516)
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
		arg_21_0:BlackFadeDialogueNode_5()
	end)
end

function var_0_0.BlackFadeDialogueNode_5(arg_25_0)
	arg_25_0:HideTalkView()
	arg_25_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_25_0:SetCharToTagAction(907301, "9073_2", function()
			return
		end)
		arg_25_0:SetCharToTagAction(9516, "9516_2", function()
			return
		end)
		arg_25_0:SetLookAtParamsAction(907301, 0.6, 0.8, 1)
		arg_25_0:LookAtRoleAction(true, 907301, "9516")
		arg_25_0:SetLookAtParamsAction(9516, 0.6, 0.8, 1)
		arg_25_0:LookAtRoleAction(true, 9516, "907301")
		arg_25_0:PlayActorAnimationAction(907301, "stand_female", 0.05, 4, function()
			return
		end)
		arg_25_0:ContinueBlackFade()
		arg_25_0:OnNext(function()
			arg_25_0:ClearOnNext()
			arg_25_0:DialogueNode_6()
		end)
	end, function()
		arg_25_0:Next()
	end)
end

function var_0_0.DialogueNode_6(arg_32_0)
	arg_32_0:EnableCameraByTagAction("3", 1, 0)
	arg_32_0:PlayActorAnimationAction(9516, "troubled", 0.05, 3.666667, function()
		return
	end)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11304004, "", 9516)
	arg_32_0:SetNeedSkip(true, {
		Invoke = function()
			arg_32_0:Skip("End")
		end
	})
	arg_32_0:SetNeedClick(true, {
		Invoke = function()
			arg_32_0:Next()
		end
	})
	arg_32_0:OnNext(function(arg_36_0)
		arg_32_0:ClearOnNext()
		arg_32_0:BlackFadeDialogueNode_7()
	end)
end

function var_0_0.BlackFadeDialogueNode_7(arg_37_0)
	arg_37_0:HideTalkView()
	arg_37_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_37_0:HideAllDynamicAction(false, false, 4095, {})
		arg_37_0:DestroyCharAction(9516)
		arg_37_0:EnableCameraByTagAction("", 1, 0)
		arg_37_0:DestroyCharAction(907301)
		arg_37_0:ContinueBlackFade()
		arg_37_0:OnNext(function()
			arg_37_0:ClearOnNext()
			arg_37_0:CloseStoryEventNode_8()
		end)
	end, function()
		arg_37_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_8(arg_41_0)
	arg_41_0:EnableCameraCutAction(false)
	arg_41_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_42_0)
	arg_42_0:RegisterTalkFunction("End", arg_42_0.CloseStoryEventNode_8)
end

return var_0_0
