BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11352", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11352"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11352"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(true, 11302001, 2.5, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(907301, "1", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(false, true, 4095, {})
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

function var_0_0.DialogueNode_2(arg_10_0)
	arg_10_0:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 907301,
		path = "QWWorld/Effect/EmotionBubble/fx_xixi_1201_QW"
	})
	arg_10_0:PlayActorAnimationAction(907301, "9073_idle01", 0.05, 3.333333, function()
		return
	end)
	arg_10_0:ShowTalkView()
	arg_10_0:SetTalkContent(11302002, "", 0)
	arg_10_0:SetNeedSkip(true, {
		Invoke = function()
			arg_10_0:Skip("End")
		end
	})
	arg_10_0:SetNeedClick(true, {
		Invoke = function()
			arg_10_0:Next()
		end
	})
	arg_10_0:OnNext(function(arg_14_0)
		arg_10_0:ClearOnNext()
		arg_10_0:BlackFadeDialogueNode_3()
	end)
end

function var_0_0.BlackFadeDialogueNode_3(arg_15_0)
	arg_15_0:HideTalkView()
	arg_15_0:OnBlackFade(true, 11302003, 6, 0.5, 0.5, function()
		arg_15_0:SetCharToTagAction(9535, "3", function()
			return
		end)
		arg_15_0:SetCharToTagAction(907301, "2", function()
			return
		end)
		arg_15_0:PlayActorAnimationAction(907301, "eniliyi_stand", 0, 2.333333, function()
			return
		end)
		arg_15_0:EnableCameraByTagAction("2", 1, 0)
		arg_15_0:ContinueBlackFade()
		arg_15_0:OnNext(function()
			arg_15_0:ClearOnNext()
			arg_15_0:DialogueNode_4()
		end)
	end, function()
		arg_15_0:Next()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:PlayActorAnimationAction(9535, "troubled", 0.05, 3.666667, function()
		return
	end)
	arg_22_0:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 9535,
		path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0801_QW"
	})
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11302004, "", 0)
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
		arg_22_0:BlackFadeDialogueNode_5()
	end)
end

function var_0_0.BlackFadeDialogueNode_5(arg_27_0)
	arg_27_0:HideTalkView()
	arg_27_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_27_0:DestroyCharAction(907301)
		arg_27_0:EnableCameraByTagAction("", 1, 0)
		arg_27_0:HideAllDynamicAction(false, false, 4095, {})
		arg_27_0:WalkingPeopleGlobleCull(false)
		arg_27_0:DestroyCharAction(9535)
		arg_27_0:ContinueBlackFade()
		arg_27_0:OnNext(function()
			arg_27_0:ClearOnNext()
			arg_27_0:CloseStoryEventNode_6()
		end)
	end, function()
		arg_27_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_6(arg_31_0)
	arg_31_0:EnableCameraCutAction(false)
	arg_31_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_32_0)
	arg_32_0:RegisterTalkFunction("End", arg_32_0.CloseStoryEventNode_6)
end

return var_0_0
