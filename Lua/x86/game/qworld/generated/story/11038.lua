BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11038", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11038"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11038"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4093, {
			60015
		})
		arg_5_0:SetCharToTagAction(9074, "1_0", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9060, "2_0", function()
			arg_5_0:ActorSeekerAction(9060, {
				"2"
			}, 0.5, function()
				return
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
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:CameraMoveAction("1", 4, 4, 3, 0.4)
		arg_5_0:PlayActorAnimationAction(9074, "think_loop", 0, 2, function()
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

function var_0_0.DialogueNode_2(arg_16_0)
	arg_16_0:DelayTimeAction(2, function()
		arg_16_0:SetNeedClick(true, {
			Invoke = function()
				arg_16_0:Next()
			end
		})
		arg_16_0:SetNeedSkip(true, {
			Invoke = function()
				arg_16_0:Skip("LastWord")
			end
		})
	end)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(11038001, "", 0)
	arg_16_0:SetNeedSkip(true, {
		Invoke = function()
			arg_16_0:Skip("LastWord")
		end
	})
	arg_16_0:SetNeedClick(false, {
		Invoke = function()
			arg_16_0:Next()
		end
	})
	arg_16_0:OnNext(function(arg_22_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_23_0)
	arg_23_0:EnableCameraByTagAction("2", 1, 0)
	arg_23_0:CameraMoveAction("2", 4, 5, 4, 0.4)
	arg_23_0:DelayTimeAction(1.5, function()
		arg_23_0:SetNeedClick(true, {
			Invoke = function()
				arg_23_0:Next()
			end
		})
		arg_23_0:SetNeedSkip(true, {
			Invoke = function()
				arg_23_0:Skip("LastWord")
			end
		})
	end)
	arg_23_0:ShowTalkView()
	arg_23_0:SetTalkContent(11038002, "", 0)
	arg_23_0:SetNeedSkip(true, {
		Invoke = function()
			arg_23_0:Skip("LastWord")
		end
	})
	arg_23_0:SetNeedClick(false, {
		Invoke = function()
			arg_23_0:Next()
		end
	})
	arg_23_0:OnNext(function(arg_29_0)
		arg_23_0:ClearOnNext()
		arg_23_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_30_0)
	arg_30_0:PlayActorAnimationAction(9060, "summer_doubt", 0.05, 2, function()
		return
	end)
	arg_30_0:PlayActorEmoteAction(9060, "sad03", 0, 1.933333, function()
		return
	end, true, false)
	arg_30_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(11038003, "", 0)
	arg_30_0:SetNeedSkip(true, {
		Invoke = function()
			arg_30_0:Skip("LastWord")
		end
	})
	arg_30_0:SetNeedClick(true, {
		Invoke = function()
			arg_30_0:Next()
		end
	})
	arg_30_0:OnNext(function(arg_35_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_36_0)
	arg_36_0:EnableCameraByTagAction("LookAtCamera_1_2_R", 1, 0)
	arg_36_0:ActorSeekerAction(9074, {
		"1"
	}, 0.5, function()
		arg_36_0:PlayActorAnimationAction(9074, "conversation_2", 0.05, 3.166667, function()
			return
		end)
	end)
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(11038004, "", 0)
	arg_36_0:SetNeedSkip(true, {
		Invoke = function()
			arg_36_0:Skip("LastWord")
		end
	})
	arg_36_0:SetNeedClick(true, {
		Invoke = function()
			arg_36_0:Next()
		end
	})
	arg_36_0:OnNext(function(arg_41_0)
		arg_36_0:ClearOnNext()
		arg_36_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_42_0)
	arg_42_0:PlayActorAnimationAction(907301, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_42_0:EnableCameraByTagAction("LookAtCamera_3_1_R", 1, 0)
	arg_42_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_42_0:LookAtRoleAction(true, 907301, "9074")
	arg_42_0:ShowTalkView()
	arg_42_0:SetTalkContent(11038005, "", 0)
	arg_42_0:SetNeedSkip(true, {
		Invoke = function()
			arg_42_0:Skip("LastWord")
		end
	})
	arg_42_0:SetNeedClick(true, {
		Invoke = function()
			arg_42_0:Next()
		end
	})
	arg_42_0:OnNext(function(arg_46_0)
		arg_42_0:ClearOnNext()
		arg_42_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_47_0)
	arg_47_0:EnableCameraByTagAction("3", 1, 0)
	arg_47_0:SetLookAtParamsAction(9060, 0.8, 1, 1)
	arg_47_0:LookAtRoleAction(true, 9060, "907301")
	arg_47_0:DelayTimeAction(1.2, function()
		arg_47_0:PlayActorAnimationAction(9060, "summer_shock", 0.05, 1.166667, function()
			return
		end)
	end)
	arg_47_0:CameraMoveAction("3", 4, 3, 5, 0.4)
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11038006, "", 0)
	arg_47_0:SetNeedSkip(true, {
		Invoke = function()
			arg_47_0:Skip("LastWord")
		end
	})
	arg_47_0:SetNeedClick(true, {
		Invoke = function()
			arg_47_0:Next()
		end
	})
	arg_47_0:OnNext(function(arg_52_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_53_0)
	arg_53_0:PlayActorAnimationAction(907301, "firm_start", 0.05, 0.5666667, function()
		return
	end)
	arg_53_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_53_0:LookAtRoleAction(true, 907301, "9060")
	arg_53_0:ShowTalkView()
	arg_53_0:SetTalkContent(11038007, "", 0)
	arg_53_0:SetNeedSkip(true, {
		Invoke = function()
			arg_53_0:Skip("LastWord")
		end
	})
	arg_53_0:SetNeedClick(true, {
		Invoke = function()
			arg_53_0:Next()
		end
	})
	arg_53_0:OnNext(function(arg_57_0)
		arg_53_0:ClearOnNext()
		arg_53_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_58_0)
	arg_58_0:ShowTalkView()
	arg_58_0:SetTalkContent(11038008, "", 0)
	arg_58_0:SetNeedSkip(true, {
		Invoke = function()
			arg_58_0:Skip("LastWord")
		end
	})
	arg_58_0:SetNeedClick(true, {
		Invoke = function()
			arg_58_0:Next()
		end
	})
	arg_58_0:OnNext(function(arg_61_0)
		arg_58_0:ClearOnNext()
		arg_58_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_62_0)
	arg_62_0:PlayActorAnimationAction(9074, "speechless", 0.05, 3.333333, function()
		return
	end)
	arg_62_0:EnableCameraByTagAction("4", 1, 0)
	arg_62_0:PlayActorAnimationAction(907301, "firm_end", 0.05, 0.5000001, function()
		return
	end)
	arg_62_0:ShowTalkView()
	arg_62_0:SetTalkContent(11038009, "", 0)
	arg_62_0:SetNeedSkip(true, {
		Invoke = function()
			arg_62_0:Skip("LastWord")
		end
	})
	arg_62_0:SetNeedClick(true, {
		Invoke = function()
			arg_62_0:Next()
		end
	})
	arg_62_0:OnNext(function(arg_67_0)
		arg_62_0:ClearOnNext()
		arg_62_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_68_0)
	arg_68_0:ShowTalkView()
	arg_68_0:SetTalkContent(11038010, "", 0)
	arg_68_0:SetNeedSkip(true, {
		Invoke = function()
			arg_68_0:Skip("LastWord")
		end
	})
	arg_68_0:SetNeedClick(true, {
		Invoke = function()
			arg_68_0:Next()
		end
	})
	arg_68_0:OnNext(function(arg_71_0)
		arg_68_0:ClearOnNext()
		arg_68_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_72_0)
	arg_72_0:PlayActorAnimationAction(9060, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_72_0:PlayActorEmoteAction(9060, "complaint01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_72_0:EnableCameraByTagAction("LookAtCamera_2_1_R", 1, 0)
	arg_72_0:SetLookAtParamsAction(9060, 0.8, 1, 1)
	arg_72_0:LookAtRoleAction(true, 9060, "9074")
	arg_72_0:ShowTalkView()
	arg_72_0:SetTalkContent(11038011, "", 0)
	arg_72_0:SetNeedSkip(true, {
		Invoke = function()
			arg_72_0:Skip("LastWord")
		end
	})
	arg_72_0:SetNeedClick(true, {
		Invoke = function()
			arg_72_0:Next()
		end
	})
	arg_72_0:OnNext(function(arg_77_0)
		arg_72_0:ClearOnNext()
		arg_72_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_78_0)
	arg_78_0:ShowTalkView()
	arg_78_0:SetTalkContent(11038012, "", 0)
	arg_78_0:SetNeedSkip(true, {
		Invoke = function()
			arg_78_0:Skip("LastWord")
		end
	})
	arg_78_0:SetNeedClick(true, {
		Invoke = function()
			arg_78_0:Next()
		end
	})
	arg_78_0:OnNext(function(arg_81_0)
		arg_78_0:ClearOnNext()
		arg_78_0:DialogueNode_14()
	end)
end

function var_0_0.DialogueNode_14(arg_82_0)
	arg_82_0:PlayActorAnimationAction(907301, "conversation_2", 0.05, 3.166667, function()
		return
	end)
	arg_82_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_82_0:LookAtRoleAction(true, 907301, "9060")
	arg_82_0:ShowTalkView()
	arg_82_0:SetTalkContent(11038013, "", 0)
	arg_82_0:SetNeedSkip(true, {
		Invoke = function()
			arg_82_0:Skip("LastWord")
		end
	})
	arg_82_0:SetNeedClick(true, {
		Invoke = function()
			arg_82_0:Next()
		end
	})
	arg_82_0:OnNext(function(arg_86_0)
		arg_82_0:ClearOnNext()
		arg_82_0:DialogueNode_15()
	end)
end

function var_0_0.DialogueNode_15(arg_87_0)
	arg_87_0:ShowTalkView()
	arg_87_0:SetTalkContent(11038014, "", 0)

	local var_87_0 = {
		Length = 0
	}

	arg_87_0:SetChoice(var_87_0, true)
	arg_87_0:SetNeedSkip(false, nil)
	arg_87_0:SetNeedClick(false, nil)
	arg_87_0:OnNext(function(arg_88_0)
		arg_87_0:ClearOnNext()
		arg_87_0:CloseChoice()
	end)
end

function var_0_0.RegisterFuncMap(arg_89_0)
	arg_89_0:RegisterTalkFunction("LastWord", arg_89_0.DialogueNode_15)
end

return var_0_0
