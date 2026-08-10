BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11126", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11126"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11126"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9516, "9516", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "9073", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {
			380001
		})
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
	arg_11_0:PlayActorAnimationAction(9516, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11126001, "", 9516)
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
	arg_11_0:OnNext(function(arg_15_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_16_0)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11126002, "", 9073)
	arg_16_0:SetNeedSkip(true, {
		Invoke = function()
			arg_16_0:Skip("End")
		end
	})
	arg_16_0:SetNeedClick(true, {
		Invoke = function()
			arg_16_0:Next()
		end
	})
	arg_16_0:OnNext(function(arg_19_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_20_0)
	arg_20_0:PlayActorAnimationAction(9516, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_20_0:ShowTalkView()
	arg_20_0:SetTalkContent(11126003, "", 9516)
	arg_20_0:SetNeedSkip(true, {
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
		arg_20_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_25_0)
	arg_25_0:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_25_0:ShowTalkView()
	arg_25_0:SetTalkContent(11126004, "", 9073)
	arg_25_0:SetNeedSkip(true, {
		Invoke = function()
			arg_25_0:Skip("End")
		end
	})
	arg_25_0:SetNeedClick(true, {
		Invoke = function()
			arg_25_0:Next()
		end
	})
	arg_25_0:OnNext(function(arg_29_0)
		arg_25_0:ClearOnNext()
		arg_25_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_30_0)
	arg_30_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_30_0:LookAtAction(true, 9073, "1")
	arg_30_0:SetLookAtParamsAction(9516, 0.8, 1, 1)
	arg_30_0:LookAtAction(true, 9516, "1")
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11126005, "", 0)
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
	arg_30_0:OnNext(function(arg_33_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_34_0)
	arg_34_0:PlayActorAnimationAction(9516, "summer_shock_start", 0.05, 0.3333333, function()
		return
	end)
	arg_34_0:ShowTalkView()
	arg_34_0:SetTalkContent(11126006, "", 9516)
	arg_34_0:SetNeedSkip(true, {
		Invoke = function()
			arg_34_0:Skip("End")
		end
	})
	arg_34_0:SetNeedClick(true, {
		Invoke = function()
			arg_34_0:Next()
		end
	})
	arg_34_0:OnNext(function(arg_38_0)
		arg_34_0:ClearOnNext()
		arg_34_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_39_0)
	arg_39_0:ShowTalkView()
	arg_39_0:SetTalkContent(11126007, "", 0)
	arg_39_0:SetNeedSkip(true, {
		Invoke = function()
			arg_39_0:Skip("End")
		end
	})
	arg_39_0:SetNeedClick(true, {
		Invoke = function()
			arg_39_0:Next()
		end
	})
	arg_39_0:OnNext(function(arg_42_0)
		arg_39_0:ClearOnNext()
		arg_39_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_43_0)
	arg_43_0:ShowTalkView()
	arg_43_0:SetTalkContent(11126008, "", 0)
	arg_43_0:SetNeedSkip(true, {
		Invoke = function()
			arg_43_0:Skip("End")
		end
	})
	arg_43_0:SetNeedClick(true, {
		Invoke = function()
			arg_43_0:Next()
		end
	})
	arg_43_0:OnNext(function(arg_46_0)
		arg_43_0:ClearOnNext()
		arg_43_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_47_0)
	arg_47_0:HideAllDynamicAction(true, true, 3, {
		380002,
		380016,
		380017,
		380018
	})
	arg_47_0:InstEffectAction({
		pointTag = "1",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	arg_47_0:InstEffectAction({
		pointTag = "2",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	arg_47_0:InstEffectAction({
		pointTag = "3",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	arg_47_0:InstEffectAction({
		pointTag = "4",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	arg_47_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_action_sgd_disappear_act", "", "")
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11126009, "", 0)
	arg_47_0:SetNeedSkip(true, {
		Invoke = function()
			arg_47_0:Skip("End")
		end
	})
	arg_47_0:SetNeedClick(true, {
		Invoke = function()
			arg_47_0:Next()
		end
	})
	arg_47_0:OnNext(function(arg_50_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_51_0)
	arg_51_0:PlayActorAnimationAction(9516, "summer_shock_end", 0.05, 0.8000001, function()
		return
	end)
	arg_51_0:SetLookAtParamsAction(9516, 0.8, 1, 1)
	arg_51_0:LookAtRoleAction(true, 9516, "9073")
	arg_51_0:ShowTalkView()
	arg_51_0:SetTalkContent(11126010, "", 9516)
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
		arg_51_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_56_0)
	arg_56_0:PlayActorAnimationAction(9073, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_56_0:ShowTalkView()
	arg_56_0:SetTalkContent(11126011, "", 9073)
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
		arg_56_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_61_0)
	arg_61_0:ShowTalkView()
	arg_61_0:SetTalkContent(11126012, "", 0)
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
	arg_61_0:OnNext(function(arg_64_0)
		arg_61_0:ClearOnNext()
		arg_61_0:BlackFadeDialogueNode_14()
	end)
end

function var_0_0.BlackFadeDialogueNode_14(arg_65_0)
	arg_65_0:HideTalkView()
	arg_65_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_65_0:EnableCameraByTagAction("", 1, 0)
		arg_65_0:HideAllDynamicAction(false, false, 4083, {})
		arg_65_0:DestroyCharAction(9073)
		arg_65_0:DestroyCharAction(9516)
		arg_65_0:ContinueBlackFade()
		arg_65_0:OnNext(function()
			arg_65_0:ClearOnNext()
			arg_65_0:CloseStoryEventNode_15()
		end)
	end, function()
		arg_65_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_15(arg_69_0)
	arg_69_0:EnableCameraCutAction(false)
	arg_69_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_70_0)
	arg_70_0:RegisterTalkFunction("End", arg_70_0.CloseStoryEventNode_15)
end

return var_0_0
