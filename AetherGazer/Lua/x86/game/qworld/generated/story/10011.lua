BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10011", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10011"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10011"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9071, "9071", function()
			arg_5_0:PlayActorEmoteAction(9071, "emote@9071_face", 0.2, 4, function()
				return
			end, true, true)
		end)
		arg_5_0:SetCharToTagAction(9070, "9070", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true)
		arg_5_0:EnableCameraCutAction(true)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:ActorSeekerAction(9070, {
			"9070_1",
			"9070_2",
			"9070_3"
		}, 0.5, function()
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

function var_0_0.DialogueNode_2(arg_13_0)
	arg_13_0:DelayTimeAction(2, function()
		arg_13_0:SetNeedClick(true, {
			Invoke = function()
				arg_13_0:Next()
			end
		})
		arg_13_0:SetNeedSkip(false, nil)
	end)
	arg_13_0:ShowTalkView()
	arg_13_0:SetTalkContent(10011001, "", 9070)
	arg_13_0:SetNeedSkip(false, {
		Invoke = function()
			arg_13_0:Skip("End")
		end
	})
	arg_13_0:SetNeedClick(false, {
		Invoke = function()
			arg_13_0:Next()
		end
	})
	arg_13_0:OnNext(function(arg_18_0)
		arg_13_0:ClearOnNext()
		arg_13_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_19_0)
	arg_19_0:PlayActorAnimationAction(9071, "action2_1", 0.2, 1.666667, function()
		return
	end)
	arg_19_0:EnableCameraByTagAction("2", 1, 0)
	arg_19_0:ShowTalkView()
	arg_19_0:SetTalkContent(10011002, "", 9071)
	arg_19_0:SetNeedSkip(false, {
		Invoke = function()
			arg_19_0:Skip("End")
		end
	})
	arg_19_0:SetNeedClick(true, {
		Invoke = function()
			arg_19_0:Next()
		end
	})
	arg_19_0:OnNext(function(arg_23_0)
		arg_19_0:ClearOnNext()
		arg_19_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_24_0)
	arg_24_0:EnableCameraByTagAction("3", 1, 0)
	arg_24_0:PlayActorAnimationAction(9070, "action3_1", 0.2, 2.266667, function()
		return
	end)
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(10011003, "", 9070)
	arg_24_0:SetNeedSkip(false, {
		Invoke = function()
			arg_24_0:Skip("End")
		end
	})
	arg_24_0:SetNeedClick(true, {
		Invoke = function()
			arg_24_0:Next()
		end
	})
	arg_24_0:OnNext(function(arg_28_0)
		arg_24_0:ClearOnNext()
		arg_24_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_29_0)
	arg_29_0:PlayActorAnimationAction(9071, "action2_3", 0.2, 1.333333, function()
		return
	end)
	arg_29_0:EnableCameraByTagAction("2", 1, 0)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(10011004, "", 9071)
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
	arg_29_0:OnNext(function(arg_33_0)
		arg_29_0:ClearOnNext()
		arg_29_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_34_0)
	arg_34_0:PlayActorAnimationAction(9070, "action3_3", 0.1, 2.566667, function()
		arg_34_0:DelayTimeAction(0.01, function()
			arg_34_0:PlayActorAnimationAction(9070, "summer_doubt", 0.1, 2, function()
				return
			end)
		end)
	end)
	arg_34_0:EnableCameraByTagAction("4", 1, 0)
	arg_34_0:ShowTalkView()
	arg_34_0:SetTalkContent(10011005, "", 9070)
	arg_34_0:SetNeedSkip(false, {
		Invoke = function()
			arg_34_0:Skip("End")
		end
	})
	arg_34_0:SetNeedClick(true, {
		Invoke = function()
			arg_34_0:Next()
		end
	})
	arg_34_0:OnNext(function(arg_40_0)
		arg_34_0:ClearOnNext()
		arg_34_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_41_0)
	arg_41_0:PlayActorAnimationAction(9071, "stroke02", 0.2, 5.166667, function()
		return
	end)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(10011006, "", 9071)
	arg_41_0:SetNeedSkip(false, {
		Invoke = function()
			arg_41_0:Skip("End")
		end
	})
	arg_41_0:SetNeedClick(true, {
		Invoke = function()
			arg_41_0:Next()
		end
	})
	arg_41_0:OnNext(function(arg_45_0)
		arg_41_0:ClearOnNext()
		arg_41_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_46_0)
	arg_46_0:EnableCameraByTagAction("5", 1, 0)
	arg_46_0:PlayActorEmoteAction(9070, "fear01", 0.2, 3.166667, function()
		return
	end, true, true)
	arg_46_0:ShowTalkView()
	arg_46_0:SetTalkContent(10011007, "", 9070)
	arg_46_0:SetNeedSkip(false, {
		Invoke = function()
			arg_46_0:Skip("End")
		end
	})
	arg_46_0:SetNeedClick(true, {
		Invoke = function()
			arg_46_0:Next()
		end
	})
	arg_46_0:OnNext(function(arg_50_0)
		arg_46_0:ClearOnNext()
		arg_46_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_51_0)
	arg_51_0:PlayActorAnimationAction(9070, "dorm_female_idle01", 0.2, 4.166667, function()
		return
	end)
	arg_51_0:PlayActorEmoteAction(9070, "happy01_start", 0.2, 0.1333333, function()
		return
	end, true, true)
	arg_51_0:ShowTalkView()
	arg_51_0:SetTalkContent(10011008, "", 9070)
	arg_51_0:SetNeedSkip(false, {
		Invoke = function()
			arg_51_0:Skip("End")
		end
	})
	arg_51_0:SetNeedClick(true, {
		Invoke = function()
			arg_51_0:Next()
		end
	})
	arg_51_0:OnNext(function(arg_56_0)
		arg_51_0:ClearOnNext()
		arg_51_0:BlackFadeDialogueNode_10()
	end)
end

function var_0_0.BlackFadeDialogueNode_10(arg_57_0)
	arg_57_0:HideTalkView()
	arg_57_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_57_0:EnableCameraCutAction(true)
		arg_57_0:EnableCameraByTagAction("", 1, 0)
		arg_57_0:HideAllDynamicAction(false, false)
		arg_57_0:DestroyCharAction(9070)
		arg_57_0:DestroyCharAction(9071)
		arg_57_0:ContinueBlackFade()
		arg_57_0:OnNext(function()
			arg_57_0:ClearOnNext()
			arg_57_0:CloseStoryEventNode_11()
		end)
	end, function()
		arg_57_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_11(arg_61_0)
	arg_61_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_62_0)
	arg_62_0:RegisterTalkFunction("End", arg_62_0.CloseStoryEventNode_11)
end

return var_0_0
