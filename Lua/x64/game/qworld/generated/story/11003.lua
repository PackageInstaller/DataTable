BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11003", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11003"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11003"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.1, 0.3, 0.3, function()
		arg_5_0:SetCharToTagAction(9510, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9511, "3", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("3", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
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
	arg_12_0:PlayActorEmoteAction(9510, "glory01", 0, 1.566667, function()
		return
	end, true, false)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(11003001, "", 9510)
	arg_12_0:SetNeedSkip(true, {
		Invoke = function()
			arg_12_0:Skip("LastWord")
		end
	})
	arg_12_0:SetNeedClick(true, {
		Invoke = function()
			arg_12_0:Next()
		end
	})
	arg_12_0:OnNext(function(arg_16_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_17_0:PlayActorAnimationAction(9073, "happy02", 0.2, 3, function()
		return
	end)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11003002, "", 9073)
	arg_17_0:SetNeedSkip(true, {
		Invoke = function()
			arg_17_0:Skip("LastWord")
		end
	})
	arg_17_0:SetNeedClick(true, {
		Invoke = function()
			arg_17_0:Next()
		end
	})
	arg_17_0:OnNext(function(arg_21_0)
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_22_0:PlayActorAnimationAction(9510, "summer_doubt", 0.2, 2, function()
		return
	end)
	arg_22_0:PlayActorEmoteAction(9510, "shocked01", 0, 1.4, function()
		return
	end, true, false)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11003003, "", 9510)
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
	arg_22_0:OnNext(function(arg_27_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_28_0)
	arg_28_0:PlayActorAnimationAction(9073, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_28_0:BlackFadeAction(0.1, 0.2, 0.2, function()
		return
	end, function()
		arg_28_0:EnableCameraByTagAction("4", 1, 0)
		arg_28_0:CameraMoveAction("4", 4, 3, 3, 0.4)
	end)
	arg_28_0:DelayTimeAction(3, function()
		arg_28_0:BlackFadeAction(0.1, 0.2, 0.2, function()
			arg_28_0:SetNeedClick(true, {
				Invoke = function()
					arg_28_0:Next()
				end
			})
			arg_28_0:SetNeedSkip(true, {
				Invoke = function()
					arg_28_0:Skip("LastWord")
				end
			})
		end, function()
			arg_28_0:EnableCameraByTagAction("5", 1, 0)
			arg_28_0:CameraMoveAction("5", 4, 4, 7, 0.3)
		end)
	end)
	arg_28_0:ShowTalkView()
	arg_28_0:SetTalkContent(11003004, "", 9073)
	arg_28_0:SetNeedSkip(true, {
		Invoke = function()
			arg_28_0:Skip("LastWord")
		end
	})
	arg_28_0:SetNeedClick(false, {
		Invoke = function()
			arg_28_0:Next()
		end
	})
	arg_28_0:OnNext(function(arg_39_0)
		arg_28_0:ClearOnNext()
		arg_28_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_40_0)
	arg_40_0:EnableCameraByTagAction("6", 1, 0)
	arg_40_0:CameraMoveAction("6", 4, 6, 7, 0.3)
	arg_40_0:ActorSeekerAction(9510, {
		"4"
	}, 0.8, function()
		arg_40_0:PlayActorAnimationAction(9510, "action2_1", 0.2, 1.666667, function()
			return
		end)
	end)
	arg_40_0:DelayTimeAction(2, function()
		arg_40_0:SetNeedClick(true, {
			Invoke = function()
				arg_40_0:Next()
			end
		})
		arg_40_0:SetNeedSkip(true, {
			Invoke = function()
				arg_40_0:Skip("End")
			end
		})
	end)
	arg_40_0:SetLookAtParamsAction(9073, 0.6, 0.8, 1)
	arg_40_0:LookAtRoleAction(true, 9073, "9510")
	arg_40_0:ShowTalkView()
	arg_40_0:SetTalkContent(11003005, "", 9510)
	arg_40_0:SetNeedSkip(true, {
		Invoke = function()
			arg_40_0:Skip("LastWord")
		end
	})
	arg_40_0:SetNeedClick(false, {
		Invoke = function()
			arg_40_0:Next()
		end
	})
	arg_40_0:OnNext(function(arg_48_0)
		arg_40_0:ClearOnNext()
		arg_40_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_49_0)
	arg_49_0:PlayActorAnimationAction(9511, "proud", 0, 2.333333, function()
		return
	end)
	arg_49_0:EnableCameraByTagAction("7", 1, 0)
	arg_49_0:ShowTalkView()
	arg_49_0:SetTalkContent(11003006, "", 9511)
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
	arg_49_0:OnNext(function(arg_53_0)
		arg_49_0:ClearOnNext()
		arg_49_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_54_0)
	arg_54_0:SetCharToTagAction(9073, "5", function()
		return
	end)
	arg_54_0:PlayActorAnimationAction(9510, "happy02", 0, 3, function()
		arg_54_0:ActorSeekerAction(9511, {
			"10"
		}, 0.8, function()
			return
		end)
	end)
	arg_54_0:EnableCameraByTagAction("8", 1, 0)
	arg_54_0:DelayTimeAction(6, function()
		arg_54_0:BlackFadeAction(0.1, 0.2, 0.2, function()
			return
		end, function()
			arg_54_0:EnableCameraByTagAction("9", 1, 0)
			arg_54_0:CameraMoveAction("9", 4, 5, 5, 0.4)
		end)
		arg_54_0:ActorSeekerAction(9510, {
			"6"
		}, 0.8, function()
			return
		end)
	end)
	arg_54_0:SetCharToTagAction(9510, "4", function()
		return
	end)
	arg_54_0:ShowTalkView()
	arg_54_0:SetTalkContent(11003007, "", 9510)

	local var_54_0 = {
		Length = 0
	}

	arg_54_0:SetChoice(var_54_0, true)
	arg_54_0:SetNeedSkip(false, nil)
	arg_54_0:SetNeedClick(false, nil)
	arg_54_0:OnNext(function(arg_63_0)
		arg_54_0:ClearOnNext()
		arg_54_0:CloseChoice()
	end)
end

function var_0_0.RegisterFuncMap(arg_64_0)
	arg_64_0:RegisterTalkFunction("LastWord", arg_64_0.DialogueNode_8)
end

return var_0_0
