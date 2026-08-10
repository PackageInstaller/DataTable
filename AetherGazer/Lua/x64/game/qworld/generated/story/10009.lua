BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10009", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10009"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10009"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9070, "9070_1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9072, "9072_1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true)
		arg_5_0:SetCharToTagAction(9074, "9074", function()
			return
		end)
		arg_5_0:ActorSeekerAction(9070, {
			"9070_2"
		}, 0.6, function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:SetLookAtParamsAction(9072, 0.8, 1, 0.1)
		arg_5_0:LookAtRoleAction(true, 9072, "9070")
		arg_5_0:SetLookAtParamsAction(9074, 0.8, 1, 0.1)
		arg_5_0:LookAtRoleAction(true, 9074, "9070")
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
	arg_13_0:CameraMoveAction("1", 1, 1, 3, 1)
	arg_13_0:DelayTimeAction(2.2, function()
		arg_13_0:SetNeedClick(true, {
			Invoke = function()
				arg_13_0:Next()
			end
		})
		arg_13_0:SetNeedSkip(false, nil)
	end)
	arg_13_0:ShowTalkView()
	arg_13_0:SetTalkContent(10009001, "", 0)
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
	arg_13_0:OnNext(function(arg_20_0)
		arg_13_0:ClearOnNext()
		arg_13_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_21_0)
	arg_21_0:PlayActorAnimationAction(9072, "action4_1", 0.2, 2.666667, function()
		return
	end)
	arg_21_0:EnableCameraByTagAction("2", 1, 0)
	arg_21_0:DelayTimeAction(1, function()
		arg_21_0:SetNeedClick(true, {
			Invoke = function()
				arg_21_0:Next()
			end
		})
		arg_21_0:SetNeedSkip(false, nil)
	end)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(10009002, "", 0)
	arg_21_0:SetNeedSkip(false, {
		Invoke = function()
			arg_21_0:Skip("End")
		end
	})
	arg_21_0:SetNeedClick(false, {
		Invoke = function()
			arg_21_0:Next()
		end
	})
	arg_21_0:OnNext(function(arg_27_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_28_0)
	arg_28_0:PlayActorAnimationAction(9070, "stroke01", 0.2, 9.066668, function()
		return
	end)
	arg_28_0:EnableCameraByTagAction("3", 1, 0)
	arg_28_0:SetLookAtParamsAction(9070, 0.8, 1, 0.8)
	arg_28_0:LookAtRoleAction(true, 9070, "9072")
	arg_28_0:ShowTalkView()
	arg_28_0:SetTalkContent(10009003, "", 0)
	arg_28_0:SetNeedSkip(false, {
		Invoke = function()
			arg_28_0:Skip("End")
		end
	})
	arg_28_0:SetNeedClick(true, {
		Invoke = function()
			arg_28_0:Next()
		end
	})
	arg_28_0:OnNext(function(arg_32_0)
		arg_28_0:ClearOnNext()
		arg_28_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_33_0)
	arg_33_0:PlayActorAnimationAction(9072, "action4_3", 0.2, 4.3, function()
		return
	end)
	arg_33_0:EnableCameraByTagAction("4", 1, 0)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(10009004, "", 0)
	arg_33_0:SetNeedSkip(false, {
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
		arg_33_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_38_0)
	arg_38_0:PlayActorAnimationAction(9074, "conversation_2", 0.2, 3.166667, function()
		return
	end)
	arg_38_0:ActorSeekerAction(9070, {
		"9070_3"
	}, 0.5, function()
		return
	end)
	arg_38_0:EnableCameraByTagAction("5", 1, 0)
	arg_38_0:ShowTalkView()
	arg_38_0:SetTalkContent(10009005, "", 0)
	arg_38_0:SetNeedSkip(false, {
		Invoke = function()
			arg_38_0:Skip("End")
		end
	})
	arg_38_0:SetNeedClick(true, {
		Invoke = function()
			arg_38_0:Next()
		end
	})
	arg_38_0:OnNext(function(arg_43_0)
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_44_0)
	arg_44_0:EnableCameraByTagAction("6", 1, 0)
	arg_44_0:SetLookAtParamsAction(9070, 0.8, 1, 0.5)
	arg_44_0:LookAtRoleAction(true, 9070, "9074")
	arg_44_0:ShowTalkView()
	arg_44_0:SetTalkContent(10009006, "", 0)
	arg_44_0:SetNeedSkip(false, {
		Invoke = function()
			arg_44_0:Skip("End")
		end
	})
	arg_44_0:SetNeedClick(true, {
		Invoke = function()
			arg_44_0:Next()
		end
	})
	arg_44_0:OnNext(function(arg_47_0)
		arg_44_0:ClearOnNext()
		arg_44_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_48_0)
	arg_48_0:BlackFadeAction(0.3, 0.3, 0.3, function()
		arg_48_0:DelayTimeAction(2, function()
			arg_48_0:SetNeedClick(true, {
				Invoke = function()
					arg_48_0:Next()
				end
			})
			arg_48_0:SetNeedSkip(false, nil)
		end)
	end, function()
		arg_48_0:EnableCameraByTagAction("7_1", 1, 0)
		arg_48_0:HideAllDynamicAction(false, true)
		arg_48_0:CameraMoveAction("7_1", 4, 6, 6, 0.3)
	end)
	arg_48_0:ShowTalkView()
	arg_48_0:SetTalkContent(10009007, "", 0)
	arg_48_0:SetNeedSkip(false, {
		Invoke = function()
			arg_48_0:Skip("End")
		end
	})
	arg_48_0:SetNeedClick(false, {
		Invoke = function()
			arg_48_0:Next()
		end
	})
	arg_48_0:OnNext(function(arg_55_0)
		arg_48_0:ClearOnNext()
		arg_48_0:DialogueNode_9()
	end)
end

function var_0_0.DialogueNode_9(arg_56_0)
	arg_56_0:CameraMoveAction("6", 1, 1, 3, 0.4)
	arg_56_0:BlackFadeAction(0.3, 0.3, 0.3, function()
		arg_56_0:DelayTimeAction(2, function()
			arg_56_0:SetNeedClick(true, {
				Invoke = function()
					arg_56_0:Next()
				end
			})
			arg_56_0:SetNeedSkip(false, nil)
		end)
	end, function()
		arg_56_0:PlayActorAnimationAction(9070, "happy03", 0.2, 6, function()
			return
		end)
		arg_56_0:HideAllDynamicAction(true, true)
		arg_56_0:EnableCameraByTagAction("6", 1, 0)
	end)
	arg_56_0:ShowTalkView()
	arg_56_0:SetTalkContent(10009008, "", 0)
	arg_56_0:SetNeedSkip(false, {
		Invoke = function()
			arg_56_0:Skip("End")
		end
	})
	arg_56_0:SetNeedClick(true, {
		Invoke = function()
			arg_56_0:Next()
		end
	})
	arg_56_0:OnNext(function(arg_64_0)
		arg_56_0:ClearOnNext()
		arg_56_0:DialogueNode_10()
	end)
end

function var_0_0.DialogueNode_10(arg_65_0)
	arg_65_0:PlayActorAnimationAction(9072, "happy02", 0.2, 3, function()
		return
	end)
	arg_65_0:EnableCameraByTagAction("7", 1, 0)
	arg_65_0:CameraMoveAction("7", 3, 6, 4, 0.2)
	arg_65_0:SetLookAtParamsAction(9070, 0.8, 1, 0.6)
	arg_65_0:LookAtRoleAction(true, 9070, "9072")
	arg_65_0:SetLookAtParamsAction(9074, 0.8, 1, 0.6)
	arg_65_0:LookAtRoleAction(true, 9074, "9072")
	arg_65_0:ShowTalkView()
	arg_65_0:SetTalkContent(10009009, "", 0)
	arg_65_0:SetNeedSkip(false, {
		Invoke = function()
			arg_65_0:Skip("End")
		end
	})
	arg_65_0:SetNeedClick(true, {
		Invoke = function()
			arg_65_0:Next()
		end
	})
	arg_65_0:OnNext(function(arg_69_0)
		arg_65_0:ClearOnNext()
		arg_65_0:DialogueNode_11()
	end)
end

function var_0_0.DialogueNode_11(arg_70_0)
	arg_70_0:ShowTalkView()
	arg_70_0:SetTalkContent(10009010, "", 0)
	arg_70_0:SetNeedSkip(false, {
		Invoke = function()
			arg_70_0:Skip("End")
		end
	})
	arg_70_0:SetNeedClick(true, {
		Invoke = function()
			arg_70_0:Next()
		end
	})
	arg_70_0:OnNext(function(arg_73_0)
		arg_70_0:ClearOnNext()
		arg_70_0:DialogueNode_12()
	end)
end

function var_0_0.DialogueNode_12(arg_74_0)
	arg_74_0:PlayActorEmoteAction(9072, "disdain01_start", 0.2, 0.4, function()
		return
	end, true, true)
	arg_74_0:ActorSeekerAction(9070, {
		"9070_2"
	}, 0.5, function()
		return
	end)
	arg_74_0:EnableCameraByTagAction("7-2", 1, 0)
	arg_74_0:PlayActorAnimationAction(9072, "dorm_female_idle01", 0.2, 4.166667, function()
		return
	end)
	arg_74_0:ShowTalkView()
	arg_74_0:SetTalkContent(10009011, "", 0)
	arg_74_0:SetNeedSkip(false, {
		Invoke = function()
			arg_74_0:Skip("End")
		end
	})
	arg_74_0:SetNeedClick(true, {
		Invoke = function()
			arg_74_0:Next()
		end
	})
	arg_74_0:OnNext(function(arg_80_0)
		arg_74_0:ClearOnNext()
		arg_74_0:DialogueNode_13()
	end)
end

function var_0_0.DialogueNode_13(arg_81_0)
	arg_81_0:PlayActorAnimationAction(9070, "win", 0.2, 1.933333, function()
		return
	end)
	arg_81_0:EnableCameraByTagAction("8", 1, 0)
	arg_81_0:SetLookAtParamsAction(9070, 0.6, 0.8, 1)
	arg_81_0:LookAtRoleAction(true, 9070, "9072")
	arg_81_0:PlayActorEmoteAction(9070, "laugh01_start", 0, 0.3333333, function()
		return
	end, true, true)
	arg_81_0:CameraMoveAction("8", 4, 1, 0.6, 0.3)
	arg_81_0:ShowTalkView()
	arg_81_0:SetTalkContent(10009012, "", 0)
	arg_81_0:SetNeedSkip(false, {
		Invoke = function()
			arg_81_0:Skip("End")
		end
	})
	arg_81_0:SetNeedClick(true, {
		Invoke = function()
			arg_81_0:Next()
		end
	})
	arg_81_0:OnNext(function(arg_86_0)
		arg_81_0:ClearOnNext()
		arg_81_0:BlackFadeDialogueNode_14()
	end)
end

function var_0_0.BlackFadeDialogueNode_14(arg_87_0)
	arg_87_0:HideTalkView()
	arg_87_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_87_0:EnableCameraByTagAction("", 1, 0)
		arg_87_0:HideAllDynamicAction(false, false)
		arg_87_0:DestroyCharAction(9070)
		arg_87_0:DestroyCharAction(9072)
		arg_87_0:DestroyCharAction(9074)
		arg_87_0:ContinueBlackFade()
		arg_87_0:OnNext(function()
			arg_87_0:ClearOnNext()
			arg_87_0:CloseStoryEventNode_15()
		end)
	end, function()
		arg_87_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_15(arg_91_0)
	arg_91_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_92_0)
	arg_92_0:RegisterTalkFunction("End", arg_92_0.CloseStoryEventNode_15)
end

return var_0_0
