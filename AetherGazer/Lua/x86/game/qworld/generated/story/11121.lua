BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11121", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11121"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11121"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9516, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "2", function()
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
	arg_11_0:PlayActorEmoteAction(9516, "shocked01_start", 0, 0.3666667, function()
		return
	end, true, true)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11121001, "", 0)
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
	arg_16_0:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11121002, "", 0)
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
	arg_21_0:PlayActorEmoteAction(9516, "shocked01_end", 0, 0.4000001, function()
		return
	end, true, false)
	arg_21_0:PlayActorAnimationAction(9516, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(11121003, "", 0)
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
	arg_21_0:OnNext(function(arg_26_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_27_0)
	arg_27_0:PlayActorAnimationAction(9073, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11121004, "", 0)
	arg_27_0:SetNeedSkip(true, {
		Invoke = function()
			arg_27_0:Skip("End")
		end
	})
	arg_27_0:SetNeedClick(true, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_31_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_32_0)
	arg_32_0:PlayActorAnimationAction(9516, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11121005, "", 0)
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
		arg_32_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_37_0)
	arg_37_0:ShowTalkView()
	arg_37_0:SetTalkContent(11121006, "", 0)
	arg_37_0:SetNeedSkip(true, {
		Invoke = function()
			arg_37_0:Skip("End")
		end
	})
	arg_37_0:SetNeedClick(true, {
		Invoke = function()
			arg_37_0:Next()
		end
	})
	arg_37_0:OnNext(function(arg_40_0)
		arg_37_0:ClearOnNext()
		arg_37_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_41_0)
	arg_41_0:PlayActorAnimationAction(9516, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(11121007, "", 0)
	arg_41_0:SetNeedSkip(true, {
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
		arg_41_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_46_0)
	arg_46_0:PlayActorAnimationAction(9073, "think_end", 0.05, 1.666667, function()
		return
	end)
	arg_46_0:ShowTalkView()
	arg_46_0:SetTalkContent(11121008, "", 0)
	arg_46_0:SetNeedSkip(true, {
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
		arg_46_0:BlackFadeDialogueNode_10()
	end)
end

function var_0_0.BlackFadeDialogueNode_10(arg_51_0)
	arg_51_0:HideTalkView()
	arg_51_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_51_0:EnableCameraByTagAction("", 1, 0)
		arg_51_0:DestroyCharAction(9073)
		arg_51_0:DestroyCharAction(9516)
		arg_51_0:HideAllDynamicAction(false, false, 4083, {})
		arg_51_0:ContinueBlackFade()
		arg_51_0:OnNext(function()
			arg_51_0:ClearOnNext()
			arg_51_0:CloseStoryEventNode_11()
		end)
	end, function()
		arg_51_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_11(arg_55_0)
	arg_55_0:EnableCameraCutAction(false)
	arg_55_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_56_0)
	arg_56_0:RegisterTalkFunction("End", arg_56_0.CloseStoryEventNode_11)
end

return var_0_0
