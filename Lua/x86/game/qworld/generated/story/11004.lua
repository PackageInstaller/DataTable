BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11004", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11004"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11004"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.1, 0.2, 0.2, function()
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9510, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true)
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
	arg_11_0:PlayActorAnimationAction(9073, "dorm_female_idle01", 0, 4.166667, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11004001, "", 0)
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
	arg_16_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_16_0:PlayActorAnimationAction(9510, "happy02", 0, 3, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11004002, "", 0)
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
	arg_16_0:OnNext(function(arg_20_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_21_0)
	arg_21_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_21_0:PlayActorAnimationAction(9073, "speechless", 0, 3.333333, function()
		return
	end)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11004003, "", 0)
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
	arg_21_0:OnNext(function(arg_25_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_26_0)
	arg_26_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_26_0:PlayActorEmoteAction(9510, "fear01", 0, 3.166667, function()
		return
	end, true, false)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(11004004, "", 0)

	local var_26_0 = {
		[0] = {
			id = 11004005,
			icon = "",
			Invoke = function()
				arg_26_0:Next(11004005)
			end
		},
		{
			id = 11004006,
			icon = "",
			Invoke = function()
				arg_26_0:Next(11004006)
			end
		},
		Length = 2
	}

	arg_26_0:SetChoice(var_26_0, false)
	arg_26_0:SetNeedSkip(false, nil)
	arg_26_0:SetNeedClick(false, nil)
	arg_26_0:OnNext(function(arg_30_0)
		arg_26_0:ClearOnNext()
		arg_26_0:CloseChoice()

		if arg_30_0 == 11004005 then
			arg_26_0:DialogueBranchNode_6()
		elseif arg_30_0 == 11004006 then
			arg_26_0:DialogueBranchNode_7()
		end
	end)
end

function var_0_0.DialogueBranchNode_6(arg_31_0)
	arg_31_0:OnNext(function()
		arg_31_0:ClearOnNext()
		arg_31_0:PureActorDialogueNode_8()
	end)
	arg_31_0:Next()
end

function var_0_0.PureActorDialogueNode_8(arg_33_0)
	arg_33_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_33_0:PlayActorAnimationAction(9073, "angry01", 0.2, 4.333333, function()
		return
	end)
	arg_33_0:DelayTimeAction(4, function()
		arg_33_0:EventAction(function()
			arg_33_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_33_0:EnableCameraShakeAction(true, "Camera/Noise/6D_Shake.asset", 1, 1, 2)
	arg_33_0:HideTalkView()
	arg_33_0:OnNext(function()
		arg_33_0:ClearOnNext()
		arg_33_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_38_0)
	arg_38_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_38_0:PlayActorAnimationAction(9510, "embarrassed", 0.2, 2.6, function()
		return
	end)
	arg_38_0:PlayActorEmoteAction(9510, "happy01_start", 0.2, 0.1333333, function()
		return
	end, true, true)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11004007, "", 0)
	arg_38_0:SetNeedSkip(true, {
		Invoke = function()
			arg_38_0:Skip("End")
		end
	})
	arg_38_0:SetNeedClick(true, {
		Invoke = function()
			arg_38_0:Next()
		end
	})
	arg_38_0:OnNext(function(arg_43_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_44_0)
	arg_44_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_44_0:PlayActorAnimationAction(9073, "action4_1", 0.2, 2.666667, function()
		return
	end)
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(11004008, "", 0)
	arg_44_0:SetNeedSkip(true, {
		Invoke = function()
			arg_44_0:Skip("End")
		end
	})
	arg_44_0:SetNeedClick(true, {
		Invoke = function()
			arg_44_0:Next()
		end
	})
	arg_44_0:OnNext(function(arg_48_0)
		arg_44_0:ClearOnNext()
		arg_44_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_49_0)
	arg_49_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_49_0:PlayActorAnimationAction(9073, "action4_3", 0.2, 4.3, function()
		return
	end)
	arg_49_0:PlayActorAnimationAction(9510, "conversation_1", 0.2, 3, function()
		return
	end)
	arg_49_0:ShowTalkView()
	arg_49_0:SetTalkContent(11004009, "", 0)
	arg_49_0:SetNeedSkip(true, {
		Invoke = function()
			arg_49_0:Skip("End")
		end
	})
	arg_49_0:SetNeedClick(true, {
		Invoke = function()
			arg_49_0:Next()
		end
	})
	arg_49_0:OnNext(function(arg_54_0)
		arg_49_0:ClearOnNext()
		arg_49_0:BlackFadeDialogueNode_12()
	end)
end

function var_0_0.BlackFadeDialogueNode_12(arg_55_0)
	arg_55_0:HideTalkView()
	arg_55_0:OnBlackFade(false, 0, 0.1, 0.2, 0.2, function()
		arg_55_0:DestroyCharAction(9073)
		arg_55_0:DestroyCharAction(9510)
		arg_55_0:EnableCameraByTagAction("", 1, 0)
		arg_55_0:HideAllDynamicAction(false, false)
		arg_55_0:ContinueBlackFade()
		arg_55_0:OnNext(function()
			arg_55_0:ClearOnNext()
			arg_55_0:CloseStoryEventNode_13()
		end)
	end, function()
		arg_55_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_13(arg_59_0)
	arg_59_0:EnableCameraCutAction(false)
	arg_59_0:EndStory()
end

function var_0_0.DialogueBranchNode_7(arg_60_0)
	arg_60_0:OnNext(function()
		arg_60_0:ClearOnNext()
		arg_60_0:PureActorDialogueNode_8()
	end)
	arg_60_0:Next()
end

function var_0_0.RegisterFuncMap(arg_62_0)
	arg_62_0:RegisterTalkFunction("End", arg_62_0.BlackFadeDialogueNode_12)
end

return var_0_0
