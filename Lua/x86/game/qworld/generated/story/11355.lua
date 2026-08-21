BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11355", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11355"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11355"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4081, {})
		arg_5_0:SetCharToTagAction(907301, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("2", 1, 0)
		arg_5_0:PlayActorAnimationAction(907301, "angry02", 0.05, 6.966667, function()
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

function var_0_0.DialogueNode_2(arg_11_0)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11305001, "", 9073)
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
	arg_15_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		arg_15_0:SetCharToTagAction(907301, "1", function()
			return
		end)
		arg_15_0:EnableCameraByTagAction("1", 1, 0)
	end)
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(11305002, "", 9073)
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
	arg_15_0:OnNext(function(arg_21_0)
		arg_15_0:ClearOnNext()
		arg_15_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11305003, "", 0)
	arg_22_0:SetNeedSkip(true, {
		Invoke = function()
			arg_22_0:Skip("End")
		end
	})
	arg_22_0:SetNeedClick(true, {
		Invoke = function()
			arg_22_0:Next()
		end
	})
	arg_22_0:OnNext(function(arg_25_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_26_0)
	arg_26_0:ShowTalkView()
	arg_26_0:SetTalkContent(11305004, "", 9073)
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
	arg_26_0:OnNext(function(arg_29_0)
		arg_26_0:ClearOnNext()
		arg_26_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_30_0)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11305005, "", 0)
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
	arg_34_0:BlackFadeAction(0.2, 0.2, 0.2, function()
		return
	end, function()
		arg_34_0:PlayActorAnimationAction(907301, "summer_shock", 0.05, 1.166667, function()
			return
		end)
		arg_34_0:SetCharToTagAction(907301, "2", function()
			return
		end)
		arg_34_0:EnableCameraByTagAction("2", 1, 0)
	end)
	arg_34_0:ShowTalkView()
	arg_34_0:SetTalkContent(11305006, "", 9073)
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
	arg_34_0:OnNext(function(arg_41_0)
		arg_34_0:ClearOnNext()
		arg_34_0:BlackFadeDialogueNode_8()
	end)
end

function var_0_0.BlackFadeDialogueNode_8(arg_42_0)
	arg_42_0:HideTalkView()
	arg_42_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_42_0:HideAllDynamicAction(false, false, 4095, {})
		arg_42_0:DestroyCharAction(907301)
		arg_42_0:EnableCameraByTagAction("", 1, 0)
		arg_42_0:ContinueBlackFade()
		arg_42_0:OnNext(function()
			arg_42_0:ClearOnNext()
			arg_42_0:CloseStoryEventNode_9()
		end)
	end, function()
		arg_42_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_9(arg_46_0)
	arg_46_0:EnableCameraCutAction(false)
	arg_46_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_47_0)
	arg_47_0:RegisterTalkFunction("End", arg_47_0.CloseStoryEventNode_9)
end

return var_0_0
