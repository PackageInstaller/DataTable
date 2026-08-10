BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11031", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11031"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11031"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9514, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:WalkingPeopleGlobleCull(true)
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
	arg_11_0:PlayActorAnimationAction(9514, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_11_0:PlayActorEmoteAction(9514, "happy01", 0, 1, function()
		return
	end, true, false)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11031001, "", 9514)
	arg_11_0:SetNeedSkip(true, {
		Invoke = function()
			arg_11_0:Skip("LastWord")
		end
	})
	arg_11_0:SetNeedClick(true, {
		Invoke = function()
			arg_11_0:Next()
		end
	})
	arg_11_0:OnNext(function(arg_16_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_17_0)
	arg_17_0:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_17_0:ShowTalkView()
	arg_17_0:SetTalkContent(11031002, "", 9073)
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
	arg_22_0:PlayActorAnimationAction(9514, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11031003, "", 9514)
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
	arg_22_0:OnNext(function(arg_26_0)
		arg_22_0:ClearOnNext()
		arg_22_0:BlackFadeDialogueNode_5()
	end)
end

function var_0_0.BlackFadeDialogueNode_5(arg_27_0)
	arg_27_0:HideTalkView()
	arg_27_0:OnBlackFade(false, 0, 0.5, 0.5, 0.5, function()
		arg_27_0:HideAllDynamicAction(false, false, 4095, {})
		arg_27_0:DestroyCharAction(9073)
		arg_27_0:DestroyCharAction(9514)
		arg_27_0:Agent_PlayerPosControl("chuansong", function()
			arg_27_0:EnableCameraByTagAction("", 1, 0)
		end)
		arg_27_0:WalkingPeopleGlobleCull(false)
		arg_27_0:ContinueBlackFade()
		arg_27_0:OnNext(function()
			arg_27_0:ClearOnNext()
			arg_27_0:CloseStoryEventNode_6()
		end)
	end, function()
		arg_27_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_6(arg_32_0)
	arg_32_0:EnableCameraCutAction(false)
	arg_32_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_33_0)
	arg_33_0:RegisterTalkFunction("LastWord", arg_33_0.BlackFadeDialogueNode_5)
	arg_33_0:RegisterTalkFunction("End", arg_33_0.CloseStoryEventNode_6)
end

return var_0_0
