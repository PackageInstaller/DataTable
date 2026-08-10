BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11095", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11095"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11095"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:SetCharToTagAction(907301, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9060, "2", function()
			return
		end)
		arg_5_0:CameraMoveAction("1", 4, 6, 3, 0.3)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {})
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
	arg_11_0:SetTalkContent(11036001, "", 0)
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
	arg_15_0:PlayActorAnimationAction(9060, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_15_0:SetLookAtParamsAction(9060, 0.8, 1, 1)
	arg_15_0:LookAtRoleAction(true, 9060, "907301")
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(11036002, "", 0)
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
	arg_20_0:PlayActorAnimationAction(907301, "think_start", 0.05, 1.333333, function()
		return
	end)
	arg_20_0:ShowTalkView()
	arg_20_0:SetTalkContent(11036003, "", 0)
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
		arg_20_0:BlackFadeDialogueNode_5()
	end)
end

function var_0_0.BlackFadeDialogueNode_5(arg_25_0)
	arg_25_0:HideTalkView()
	arg_25_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_25_0:EnableCameraByTagAction("", 1, 0)
		arg_25_0:HideAllDynamicAction(false, false, 4091, {})
		arg_25_0:DestroyCharAction(907301)
		arg_25_0:DestroyCharAction(9060)
		arg_25_0:ContinueBlackFade()
		arg_25_0:OnNext(function()
			arg_25_0:ClearOnNext()
			arg_25_0:CloseStoryEventNode_6()
		end)
	end, function()
		arg_25_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_6(arg_29_0)
	arg_29_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_30_0)
	arg_30_0:RegisterTalkFunction("End", arg_30_0.BlackFadeDialogueNode_5)
	arg_30_0:RegisterTalkFunction("End", arg_30_0.CloseStoryEventNode_6)
end

return var_0_0
