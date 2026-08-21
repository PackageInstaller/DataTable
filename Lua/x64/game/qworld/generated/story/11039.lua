BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11039", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11039"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11039"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9510, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "2_0", function()
			arg_5_0:ActorSeekerAction(9074, {
				"2"
			}, 0.5, function()
				return
			end)
		end)
		arg_5_0:SetCharToTagAction(9060, "4_0", function()
			arg_5_0:DelayTimeAction(0.1, function()
				arg_5_0:ActorSeekerAction(9060, {
					"4"
				}, 0.5, function()
					return
				end)
			end)
		end)
		arg_5_0:SetCharToTagAction(907301, "3_0", function()
			arg_5_0:DelayTimeAction(0.2, function()
				arg_5_0:ActorSeekerAction(907301, {
					"3"
				}, 0.5, function()
					return
				end)
			end)
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_18_0)
	arg_18_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_18_0:DelayTimeAction(2.5, function()
		arg_18_0:SetNeedClick(true, {
			Invoke = function()
				arg_18_0:Next()
			end
		})
		arg_18_0:SetNeedSkip(true, {
			Invoke = function()
				arg_18_0:Skip("End")
			end
		})
	end)
	arg_18_0:ShowTalkView()
	arg_18_0:SetTalkContent(11039001, "", 0)
	arg_18_0:SetNeedSkip(true, {
		Invoke = function()
			arg_18_0:Skip("End")
		end
	})
	arg_18_0:SetNeedClick(false, {
		Invoke = function()
			arg_18_0:Next()
		end
	})
	arg_18_0:OnNext(function(arg_25_0)
		arg_18_0:ClearOnNext()
		arg_18_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_26_0)
	arg_26_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_26_0:EnableCameraByTagAction("2", 1, 0)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(11039002, "", 0)
	arg_26_0:SetNeedSkip(true, {
		Invoke = function()
			arg_26_0:Skip("End")
		end
	})
	arg_26_0:SetNeedClick(true, {
		Invoke = function()
			arg_26_0:Next()
		end
	})
	arg_26_0:OnNext(function(arg_30_0)
		arg_26_0:ClearOnNext()
		arg_26_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_31_0)
	arg_31_0:EnableCameraByTagAction("3", 1, 0)
	arg_31_0:CameraMoveAction("3", 4, 3, 5, 0.4)
	arg_31_0:PlayActorAnimationAction(9510, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_31_0:DelayTimeAction(2, function()
		arg_31_0:EnableCameraByTagAction("3_1", 1, 0)
		arg_31_0:SetNeedClick(true, {
			Invoke = function()
				arg_31_0:Next()
			end
		})
		arg_31_0:SetNeedSkip(true, {
			Invoke = function()
				arg_31_0:Skip("End")
			end
		})
		arg_31_0:CameraMoveAction("3_1", 4, 4, 5, 0.4)
	end)
	arg_31_0:ShowTalkView()
	arg_31_0:SetTalkContent(11039003, "", 0)
	arg_31_0:SetNeedSkip(true, {
		Invoke = function()
			arg_31_0:Skip("End")
		end
	})
	arg_31_0:SetNeedClick(true, {
		Invoke = function()
			arg_31_0:Next()
		end
	})
	arg_31_0:OnNext(function(arg_38_0)
		arg_31_0:ClearOnNext()
		arg_31_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_39_0)
	arg_39_0:PlayActorAnimationAction(907301, "excited_start", 0.05, 0.6666667, function()
		return
	end)
	arg_39_0:EnableCameraByTagAction("2", 1, 0)
	arg_39_0:PlayActorEmoteAction(907301, "anger02", 0, 1.933333, function()
		return
	end, true, false)
	arg_39_0:ShowTalkView()
	arg_39_0:SetTalkContent(11039004, "", 0)
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
	arg_39_0:OnNext(function(arg_44_0)
		arg_39_0:ClearOnNext()
		arg_39_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_45_0)
	arg_45_0:EnableCameraByTagAction("5", 1, 0)
	arg_45_0:CameraMoveAction("5", 4, 5, 5, 0.2)
	arg_45_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(11039005, "", 0)
	arg_45_0:SetNeedSkip(true, {
		Invoke = function()
			arg_45_0:Skip("End")
		end
	})
	arg_45_0:SetNeedClick(true, {
		Invoke = function()
			arg_45_0:Next()
		end
	})
	arg_45_0:OnNext(function(arg_49_0)
		arg_45_0:ClearOnNext()
		arg_45_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_50_0)
	arg_50_0:EnableCameraByTagAction("1", 1, 0)
	arg_50_0:PlayActorAnimationAction(907301, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	arg_50_0:PlayActorAnimationAction(9060, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_50_0:ShowTalkView()
	arg_50_0:SetTalkContent(11039006, "", 0)
	arg_50_0:SetNeedSkip(true, {
		Invoke = function()
			arg_50_0:Skip("End")
		end
	})
	arg_50_0:SetNeedClick(true, {
		Invoke = function()
			arg_50_0:Next()
		end
	})
	arg_50_0:OnNext(function(arg_55_0)
		arg_50_0:ClearOnNext()
		arg_50_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_56_0)
	arg_56_0:PlayActorAnimationAction(9510, "action2_1", 0.05, 1.666667, function()
		return
	end)
	arg_56_0:ShowTalkView()
	arg_56_0:SetTalkContent(11039007, "", 0)
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
		arg_56_0:BlackFadeDialogueNode_9()
	end)
end

function var_0_0.BlackFadeDialogueNode_9(arg_61_0)
	arg_61_0:HideTalkView()
	arg_61_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_61_0:EnableCameraByTagAction("", 1, 0)
		arg_61_0:DestroyCharAction(907301)
		arg_61_0:DestroyCharAction(9074)
		arg_61_0:DestroyCharAction(9060)
		arg_61_0:HideAllDynamicAction(false, false, 4083, {})
		arg_61_0:ContinueBlackFade()
		arg_61_0:OnNext(function()
			arg_61_0:ClearOnNext()
			arg_61_0:CloseStoryEventNode_10()
		end)
	end, function()
		arg_61_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_10(arg_65_0)
	arg_65_0:EnableCameraCutAction(false)
	arg_65_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_66_0)
	arg_66_0:RegisterTalkFunction("End", arg_66_0.CloseStoryEventNode_10)
end

return var_0_0
