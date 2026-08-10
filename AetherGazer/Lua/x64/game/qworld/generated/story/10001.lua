BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10001", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10001"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10001"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:DelayTimeAction(1.15, function()
		arg_5_0:EnableCameraByTagAction("2", 1, 0)
		arg_5_0:CameraMoveAction("2", 4, 1, 1.2, 0.6)
	end)
	arg_5_0:DelayTimeAction(2.5, function()
		arg_5_0:EnableCameraByTagAction("5", 1, 0)
		arg_5_0:CameraMoveAction("5", 4, 1, 6, 0.3)
	end)
	arg_5_0:DelayTimeAction(5.5, function()
		arg_5_0:EventAction(function()
			arg_5_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_5_0:SetCharToTagAction(9070, "9070", function()
		return
	end)
	arg_5_0:DelayTimeAction(1.45, function()
		arg_5_0:EnableCameraShakeAction(true, "Camera/Noise/6D_Shake.asset", 1, 1, 0.4)
		arg_5_0:EnableNoneEyeFace(9070, true)
		arg_5_0:DelayTimeAction(3.2, function()
			arg_5_0:EnableNoneEyeFace(9070, false)
		end)
		arg_5_0:InstEffectAction({
			attachFollow = true,
			delayTime = 3.2,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9070,
			path = "QWWorld/Effect/FaceEffect/faint01"
		})
		arg_5_0:InstEffectAction({
			pointTag = "9070",
			destroyMode = "DontDestroy",
			createMode = "Point",
			path = "QWWorld/Effect/fx_juqing_dissipation.prefab"
		})
		arg_5_0:InstEffectAction({
			attachFollow = false,
			delayTime = 3.2,
			createMode = "RoleAttach",
			destroyMode = "DelayTime",
			attachType = 10,
			roleId = 9070,
			path = "QWWorld/Effect/EmotionBubble/fx_xingxing_0601"
		})
	end)
	arg_5_0:EnableCameraByTagAction("1", 1, 0)
	arg_5_0:HideAllDynamicAction(false, true)
	arg_5_0:PlayActorAnimationAction(9070, "juqing01", 0, 10, function()
		return
	end)
	arg_5_0:HideTalkView()
	arg_5_0:OnNext(function()
		arg_5_0:ClearOnNext()
		arg_5_0:DialogueNode_2()
	end)
end

function var_0_0.DialogueNode_2(arg_15_0)
	arg_15_0:CameraMoveAction("4", 4, 6, 5, 0.3)
	arg_15_0:SetCharToTagAction(9070, "9070_1", function()
		arg_15_0:EnableCameraByTagAction("4", 1, 0)
		arg_15_0:DelayTimeAction(3, function()
			arg_15_0:InstEffectAction({
				attachFollow = false,
				delayTime = 5,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 10,
				roleId = 9070,
				path = "QWWorld/Effect/EmotionBubble/fx_wuyu_1101_behind"
			})
		end)
	end)
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(10001001, "", 9070)
	arg_15_0:SetNeedSkip(false, {
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
		arg_15_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_21_0)
	arg_21_0:BlackFadeAction(0.3, 0.3, 0.3, function()
		arg_21_0:DelayTimeAction(1, function()
			arg_21_0:SetNeedClick(true, {
				Invoke = function()
					arg_21_0:Next()
				end
			})
			arg_21_0:SetNeedSkip(false, nil)
		end)
	end, function()
		arg_21_0:EnableCameraByTagAction("3", 1, 0)
	end)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(10001002, "", 9070)
	arg_21_0:SetNeedSkip(false, {
		Invoke = function()
			arg_21_0:Skip("End")
		end
	})
	arg_21_0:SetNeedClick(false, {
		Invoke = function()
			arg_21_0:Next()
		end
	})
	arg_21_0:OnNext(function(arg_28_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_29_0)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(10001003, "", 9070)
	arg_29_0:SetNeedSkip(false, {
		Invoke = function()
			arg_29_0:Skip("End")
		end
	})
	arg_29_0:SetNeedClick(true, {
		Invoke = function()
			arg_29_0:Next()
		end
	})
	arg_29_0:OnNext(function(arg_32_0)
		arg_29_0:ClearOnNext()
		arg_29_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_33_0)
	arg_33_0:BlackFadeAction(0.3, 0.3, 0.3, function()
		return
	end, function()
		arg_33_0:EnableCameraByTagAction("7", 1, 0)
		arg_33_0:Agent_CameraControl("6", function()
			return
		end)
		arg_33_0:HideAllDynamicAction(false, false)
		arg_33_0:CameraMoveAction("4", 4, 6, 6, 0.3)
	end)
	arg_33_0:DestroyCharAction(9070)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(10001004, "", 9070)
	arg_33_0:SetNeedSkip(false, {
		Invoke = function()
			arg_33_0:Skip("End")
		end
	})
	arg_33_0:SetNeedClick(true, {
		Invoke = function()
			arg_33_0:Next()
		end
	})
	arg_33_0:OnNext(function(arg_39_0)
		arg_33_0:ClearOnNext()
		arg_33_0:PureActorDialogueNode_6()
	end)
end

function var_0_0.PureActorDialogueNode_6(arg_40_0)
	arg_40_0:EnableCameraByTagAction("", 2, 2)
	arg_40_0:DelayTimeAction(2.2, function()
		arg_40_0:EventAction(function()
			arg_40_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_40_0:HideTalkView()
	arg_40_0:OnNext(function()
		arg_40_0:ClearOnNext()
		arg_40_0:CloseStoryEventNode_7()
	end)
end

function var_0_0.CloseStoryEventNode_7(arg_44_0)
	arg_44_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_45_0)
	arg_45_0:RegisterTalkFunction("End", arg_45_0.CloseStoryEventNode_7)
end

return var_0_0
