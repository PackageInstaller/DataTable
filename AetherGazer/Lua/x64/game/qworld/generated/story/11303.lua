BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11303", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11303"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11303"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4081, {})
		arg_5_0:EnableCameraByTagAction("2", 1, 0)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:DialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_10_0)
	arg_10_0:ShowTalkView()
	arg_10_0:SetTalkContent(11303001, "", 9073)
	arg_10_0:SetNeedSkip(false, {
		Invoke = function()
			arg_10_0:Skip("End")
		end
	})
	arg_10_0:SetNeedClick(true, {
		Invoke = function()
			arg_10_0:Next()
		end
	})
	arg_10_0:OnNext(function(arg_13_0)
		arg_10_0:ClearOnNext()
		arg_10_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_14_0)
	arg_14_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_14_0:PlayActorAnimationAction(9073, "eniliyi_stand", 0.05, 2.333333, function()
			return
		end)
		arg_14_0:EnableCameraByTagAction("1", 1, 0)
		arg_14_0:SetCharToTagAction(9073, "1", function()
			return
		end)
	end)
	arg_14_0:ShowTalkView()
	arg_14_0:SetTalkContent(11303002, "", 9073)
	arg_14_0:SetNeedSkip(false, {
		Invoke = function()
			arg_14_0:Skip("End")
		end
	})
	arg_14_0:SetNeedClick(true, {
		Invoke = function()
			arg_14_0:Next()
		end
	})
	arg_14_0:OnNext(function(arg_21_0)
		arg_14_0:ClearOnNext()
		arg_14_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11303003, "", 9073)
	arg_22_0:SetNeedSkip(false, {
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
		arg_22_0:BlackFadeDialogueNode_5()
	end)
end

function var_0_0.BlackFadeDialogueNode_5(arg_26_0)
	arg_26_0:HideTalkView()
	arg_26_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_26_0:HideAllDynamicAction(false, false, 4095, {})
		arg_26_0:DestroyCharAction(9073)
		arg_26_0:EnableCameraByTagAction("", 1, 0)
		arg_26_0:ContinueBlackFade()
		arg_26_0:OnNext(function()
			arg_26_0:ClearOnNext()
			arg_26_0:CloseStoryEventNode_6()
		end)
	end, function()
		arg_26_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_6(arg_30_0)
	arg_30_0:EnableCameraCutAction(false)
	arg_30_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_31_0)
	arg_31_0:RegisterTalkFunction("End", arg_31_0.CloseStoryEventNode_6)
end

return var_0_0
