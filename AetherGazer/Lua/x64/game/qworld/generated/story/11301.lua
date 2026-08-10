BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11301", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11301"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11301"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(true, 11301001, 2.5, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9073, "1", function()
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
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:PureActorDialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_2(arg_12_0)
	arg_12_0:DelayTimeAction(3.5, function()
		arg_12_0:EventAction(function()
			arg_12_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_12_0:HideTalkView()
	arg_12_0:OnNext(function()
		arg_12_0:ClearOnNext()
		arg_12_0:BlackFadeDialogueNode_3()
	end)
end

function var_0_0.BlackFadeDialogueNode_3(arg_16_0)
	arg_16_0:HideTalkView()
	arg_16_0:OnBlackFade(true, 11301002, 3, 0.5, 0.5, function()
		arg_16_0:ContinueBlackFade()
		arg_16_0:OnNext(function()
			arg_16_0:ClearOnNext()
			arg_16_0:DialogueNode_4()
		end)
	end, function()
		arg_16_0:Next()
	end)
end

function var_0_0.DialogueNode_4(arg_20_0)
	arg_20_0:PlayActorAnimationAction(9073, "action5_2", 0.05, 4, function()
		return
	end)
	arg_20_0:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 9073,
		path = "QWWorld/Effect/EmotionBubble/fx_jusang_1001"
	})
	arg_20_0:ShowTalkView()
	arg_20_0:SetTalkContent(11301003, "", 0)
	arg_20_0:SetNeedSkip(false, {
		Invoke = function()
			arg_20_0:Skip("End")
		end
	})
	arg_20_0:SetNeedClick(true, {
		Invoke = function()
			arg_20_0:Next()
		end
	})
	arg_20_0:OnNext(function(arg_24_0)
		arg_20_0:ClearOnNext()
		arg_20_0:BlackFadeDialogueNode_5()
	end)
end

function var_0_0.BlackFadeDialogueNode_5(arg_25_0)
	arg_25_0:HideTalkView()
	arg_25_0:OnBlackFade(true, 11301004, 3, 0.5, 0.5, function()
		arg_25_0:DestroyCharAction(9073)
		arg_25_0:EnableCameraByTagAction("", 1, 0)
		arg_25_0:HideAllDynamicAction(false, false, 4095, {})
		arg_25_0:ContinueBlackFade()
		arg_25_0:OnNext(function()
			arg_25_0:ClearOnNext()
			arg_25_0:CloseStoryEventNode_6()
		end)
	end, function()
		arg_25_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_6(arg_29_0)
	arg_29_0:EnableCameraCutAction(false)
	arg_29_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_30_0)
	arg_30_0:RegisterTalkFunction("End", arg_30_0.CloseStoryEventNode_6)
end

return var_0_0
