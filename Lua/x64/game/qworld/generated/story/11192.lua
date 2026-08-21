BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11192", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11192"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11192"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(907301, "9073", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9535, "9535", function()
			return
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

function var_0_0.DialogueNode_2(arg_11_0)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11192001, "", 0)
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
	arg_11_0:OnNext(function(arg_14_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_15_0)
	arg_15_0:PlayActorAnimationAction(9535, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(11192002, "", 0)
	arg_15_0:SetNeedSkip(true, {
		Invoke = function()
			arg_15_0:Skip("End")
		end
	})
	arg_15_0:SetNeedClick(true, {
		Invoke = function()
			arg_15_0:Next()
		end
	})
	arg_15_0:OnNext(function(arg_19_0)
		arg_15_0:ClearOnNext()
		arg_15_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_20_0)
	arg_20_0:ShowTalkView()
	arg_20_0:SetTalkContent(11192003, "", 0)
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
	arg_20_0:OnNext(function(arg_23_0)
		arg_20_0:ClearOnNext()
		arg_20_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_24_0)
	arg_24_0:PlayActorAnimationAction(9535, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(11192004, "", 0)
	arg_24_0:SetNeedSkip(true, {
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
		arg_24_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_29_0)
	arg_29_0:ShowTalkView()
	arg_29_0:SetTalkContent(11192005, "", 0)
	arg_29_0:SetNeedSkip(true, {
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
		arg_29_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_33_0)
	arg_33_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(11192006, "", 0)
	arg_33_0:SetNeedSkip(true, {
		Invoke = function()
			arg_33_0:Skip("End")
		end
	})
	arg_33_0:SetNeedClick(true, {
		Invoke = function()
			arg_33_0:Next()
		end
	})
	arg_33_0:OnNext(function(arg_37_0)
		arg_33_0:ClearOnNext()
		arg_33_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_38_0)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(11192007, "", 0)
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
	arg_38_0:OnNext(function(arg_41_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_42_0)
	arg_42_0:PlayActorAnimationAction(9535, "think_end", 0.05, 1.666667, function()
		return
	end)
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11192008, "", 0)
	arg_42_0:SetNeedSkip(true, {
		Invoke = function()
			arg_42_0:Skip("End")
		end
	})
	arg_42_0:SetNeedClick(true, {
		Invoke = function()
			arg_42_0:Next()
		end
	})
	arg_42_0:OnNext(function(arg_46_0)
		arg_42_0:ClearOnNext()
		arg_42_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_47_0)
	arg_47_0:PlayActorAnimationAction(907301, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11192009, "", 0)
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
	arg_47_0:OnNext(function(arg_51_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_52_0)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11192010, "", 0)
	arg_52_0:SetNeedSkip(true, {
		Invoke = function()
			arg_52_0:Skip("End")
		end
	})
	arg_52_0:SetNeedClick(true, {
		Invoke = function()
			arg_52_0:Next()
		end
	})
	arg_52_0:OnNext(function(arg_55_0)
		arg_52_0:ClearOnNext()
		arg_52_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_56_0)
	arg_56_0:PlayActorAnimationAction(9535, "embarrassed", 0.05, 2.6, function()
		return
	end)
	arg_56_0:ShowTalkView()
	arg_56_0:SetTalkContent(11192011, "", 0)
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
	arg_61_0:SetTalkContent(11192012, "", 0)
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
		arg_65_0:HideAllDynamicAction(false, false, 4081, {
			440008
		})
		arg_65_0:EnableCameraByTagAction("", 1, 0)
		arg_65_0:DestroyCharAction(9535)
		arg_65_0:DestroyCharAction(907301)
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
