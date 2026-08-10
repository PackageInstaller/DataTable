BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11019", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11019"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11019"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(true, 11019002, 2.5, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9510, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:PlayActorAnimationAction(9073, "happy01", 0.05, 2.333333, function()
			return
		end)
		arg_5_0:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
			return
		end, true, true)
		arg_5_0:InstEffectAction({
			attachFollow = false,
			delayTime = 5,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9073,
			path = "QWWorld/Effect/EmotionBubble/fx_xixi_1201_QW"
		})
		arg_5_0:HideAllDynamicAction(false, true, 4095, {})
		arg_5_0:WalkingPeopleGlobleCull(true)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:PureActorDialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_2(arg_13_0)
	arg_13_0:DelayTimeAction(3.5, function()
		arg_13_0:EventAction(function()
			arg_13_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_13_0:DelayTimeAction(0.5, function()
		arg_13_0:InstEffectAction({
			attachFollow = false,
			delayTime = 5,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9510,
			path = "QWWorld/Effect/EmotionBubble/fx_liuhan_1801_QW"
		})
	end)
	arg_13_0:PlayActorAnimationAction(9510, "summer_doubt_start", 0.05, 0.7666667, function()
		return
	end)
	arg_13_0:HideTalkView()
	arg_13_0:OnNext(function()
		arg_13_0:ClearOnNext()
		arg_13_0:BlackFadeDialogueNode_3()
	end)
end

function var_0_0.BlackFadeDialogueNode_3(arg_19_0)
	arg_19_0:HideTalkView()
	arg_19_0:OnBlackFade(true, 11019003, 3, 0.5, 0.5, function()
		arg_19_0:DestroyCharAction(9073)
		arg_19_0:DestroyCharAction(9510)
		arg_19_0:EnableCameraByTagAction("", 1, 0)
		arg_19_0:HideAllDynamicAction(false, false, 4095, {})
		arg_19_0:WalkingPeopleGlobleCull(false)
		arg_19_0:ContinueBlackFade()
		arg_19_0:OnNext(function()
			arg_19_0:ClearOnNext()
			arg_19_0:CloseStoryEventNode_4()
		end)
	end, function()
		arg_19_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_4(arg_23_0)
	arg_23_0:EnableCameraCutAction(false)
	arg_23_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_24_0)
	arg_24_0:RegisterTalkFunction("End", arg_24_0.CloseStoryEventNode_4)
end

return var_0_0
