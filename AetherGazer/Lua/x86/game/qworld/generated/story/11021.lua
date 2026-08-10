BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11021", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11021"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11021"
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
		arg_5_0:SetCharToTagAction(9073, "2", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
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
	arg_11_0:PlayActorAnimationAction(9510, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(11021001, "", 0)
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
	arg_16_0:PlayActorAnimationAction(9073, "dorm_female_idle01", 0.05, 4.166667, function()
		return
	end)
	arg_16_0:PlayActorEmoteAction(9073, "happy01_start", 0, 0.1333333, function()
		return
	end, true, true)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11021002, "", 0)
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
	arg_16_0:OnNext(function(arg_21_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_22_0)
	arg_22_0:EnableCameraByTagAction("LookAtCamera_1_1_R", 1, 0)
	arg_22_0:PlayActorEmoteAction(9510, "happy01", 0, 1, function()
		return
	end, true, true)
	arg_22_0:ShowTalkView()
	arg_22_0:SetTalkContent(11021003, "", 0)
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
	arg_22_0:OnNext(function(arg_26_0)
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_27_0)
	arg_27_0:EnableCameraByTagAction("LookAtCamera_2_2_R", 1, 0)
	arg_27_0:PlayActorAnimationAction(9073, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_27_0:PlayActorEmoteAction(9073, "laugh01_start", 0.1, 0.3333333, function()
		return
	end, true, true)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11021004, "", 0)
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
	arg_27_0:OnNext(function(arg_32_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_33_0)
	arg_33_0:EnableCameraByTagAction("5", 1, 0)
	arg_33_0:PlayActorAnimationAction(9510, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_33_0:PlayActorEmoteAction(9510, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	arg_33_0:CameraMoveAction("5", 4, 5, 6, 0.3)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(11021005, "", 0)
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
	arg_33_0:OnNext(function(arg_38_0)
		arg_33_0:ClearOnNext()
		arg_33_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_39_0)
	arg_39_0:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_39_0:PlayActorEmoteAction(9073, "", 0, 0, function()
		return
	end, false, false)
	arg_39_0:ShowTalkView()
	arg_39_0:SetTalkContent(11021006, "", 0)
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
		arg_39_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_45_0)
	arg_45_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		arg_45_0:SetNeedClick(true, {
			Invoke = function()
				arg_45_0:Next()
			end
		})
		arg_45_0:SetNeedSkip(false, nil)
	end, function()
		arg_45_0:EnableCameraByTagAction("7", 1, 0)
		arg_45_0:CameraMoveAction("7", 4, 6, 5, 0.5)
	end)
	arg_45_0:ShowTalkView()
	arg_45_0:SetTalkContent(11021007, "", 0)
	arg_45_0:SetNeedSkip(true, {
		Invoke = function()
			arg_45_0:Skip("End")
		end
	})
	arg_45_0:SetNeedClick(false, {
		Invoke = function()
			arg_45_0:Next()
		end
	})
	arg_45_0:OnNext(function(arg_51_0)
		arg_45_0:ClearOnNext()
		arg_45_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_52_0)
	arg_52_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_52_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
		arg_52_0:PlayActorAnimationAction(9073, "conversation_1", 0.05, 3, function()
			return
		end)
	end)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11021008, "", 0)
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
	arg_52_0:OnNext(function(arg_58_0)
		arg_52_0:ClearOnNext()
		arg_52_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_59_0)
	arg_59_0:ShowTalkView()
	arg_59_0:SetTalkContent(11021009, "", 0)
	arg_59_0:SetNeedSkip(true, {
		Invoke = function()
			arg_59_0:Skip("End")
		end
	})
	arg_59_0:SetNeedClick(true, {
		Invoke = function()
			arg_59_0:Next()
		end
	})
	arg_59_0:OnNext(function(arg_62_0)
		arg_59_0:ClearOnNext()
		arg_59_0:BlackFadeDialogueNode_11()
	end)
end

function var_0_0.BlackFadeDialogueNode_11(arg_63_0)
	arg_63_0:HideTalkView()
	arg_63_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_63_0:HideAllDynamicAction(false, false, 4095, {})
		arg_63_0:DestroyCharAction(9073)
		arg_63_0:DestroyCharAction(9510)
		arg_63_0:EnableCameraByTagAction("", 1, 0)
		arg_63_0:Agent_PlayerPosControl("chuansong", function()
			return
		end)
		arg_63_0:ContinueBlackFade()
		arg_63_0:OnNext(function()
			arg_63_0:ClearOnNext()
			arg_63_0:CloseStoryEventNode_12()
		end)
	end, function()
		arg_63_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_12(arg_68_0)
	arg_68_0:EnableCameraCutAction(false)
	arg_68_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_69_0)
	arg_69_0:RegisterTalkFunction("End", arg_69_0.BlackFadeDialogueNode_11)
end

return var_0_0
