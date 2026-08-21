BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11044", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11044"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11044"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:HideAllDynamicAction(true, true, 4095, {})
		arg_5_0:SetCharToTagAction(907301, "1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "2", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9510, "3", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9072, "4", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9071, "5", function()
			arg_5_0:DelayTimeAction(0.1, function()
				arg_5_0:ActorSeekerAction(9071, {
					"5_1"
				}, 0.8, function()
					return
				end)
			end)
		end)
		arg_5_0:SetCharToTagAction(9060, "6", function()
			return
		end)
		arg_5_0:ActorSeekerAction(907301, {
			"1_1"
		}, 2.5, function()
			return
		end)
		arg_5_0:ActorSeekerAction(9510, {
			"3_1"
		}, 0.6, function()
			return
		end)
		arg_5_0:ActorSeekerAction(9072, {
			"1_1"
		}, 0.6, function()
			return
		end)
		arg_5_0:ActorSeekerAction(9060, {
			"6_1"
		}, 0.65, function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:DelayTimeAction(0.2, function()
			arg_5_0:ActorSeekerAction(9074, {
				"1_1"
			}, 0.6, function()
				return
			end)
		end)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:PureActorDialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_2(arg_23_0)
	arg_23_0:DelayTimeAction(2.6, function()
		arg_23_0:EventAction(function()
			arg_23_0:ImmediateNextFlag(-1)
		end)
	end)
	arg_23_0:HideTalkView()
	arg_23_0:OnNext(function()
		arg_23_0:ClearOnNext()
		arg_23_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_27_0)
	arg_27_0:PlayActorAnimationAction(9060, "dorm_male_idle01", 0.1, 8.166667, function()
		return
	end)
	arg_27_0:DelayTimeAction(2.5, function()
		arg_27_0:EnableCameraByTagAction("1_1", 1, 0)
		arg_27_0:CameraMoveAction("1_1", 4, 6, 6, 0.4)
		arg_27_0:DelayTimeAction(0.5, function()
			arg_27_0:SetNeedClick(true, {
				Invoke = function()
					arg_27_0:Next()
				end
			})
			arg_27_0:SetNeedSkip(true, {
				Invoke = function()
					arg_27_0:Skip("End")
				end
			})
		end)
	end)
	arg_27_0:SetLookAtParamsAction(9060, 0.8, 1, 1)
	arg_27_0:LookAtAction(true, 9060, "ta")
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11044001, "", 9060)
	arg_27_0:SetNeedSkip(true, {
		Invoke = function()
			arg_27_0:Skip("LastWord")
		end
	})
	arg_27_0:SetNeedClick(false, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_35_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_36_0)
	arg_36_0:EnableCameraByTagAction("2", 1, 0)
	arg_36_0:PlayActorAnimationAction(907301, "proud_start", 0.05, 0.6, function()
		return
	end)
	arg_36_0:DelayTimeAction(0.5, function()
		arg_36_0:PlayActorEmoteAction(907301, "happy01_start", 0, 0.1333333, function()
			return
		end, true, true)
	end)
	arg_36_0:SetCharToTagAction(907301, "1_2", function()
		return
	end)
	arg_36_0:DelayTimeAction(2, function()
		arg_36_0:SetNeedClick(true, {
			Invoke = function()
				arg_36_0:Next()
			end
		})
		arg_36_0:SetNeedSkip(true, {
			Invoke = function()
				arg_36_0:Skip("End")
			end
		})
	end)
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(11044002, "", 907301)
	arg_36_0:SetNeedSkip(true, {
		Invoke = function()
			arg_36_0:Skip("LastWord")
		end
	})
	arg_36_0:SetNeedClick(false, {
		Invoke = function()
			arg_36_0:Next()
		end
	})
	arg_36_0:OnNext(function(arg_46_0)
		arg_36_0:ClearOnNext()
		arg_36_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_47_0)
	arg_47_0:PlayActorEmoteAction(907301, "happy01_end", 0, 0.2666667, function()
		return
	end, true, false)
	arg_47_0:SetLookAtParamsAction(907301, 0.8, 1, 1)
	arg_47_0:LookAtAction(true, 907301, "kan")
	arg_47_0:InstEffectAction({
		attachFollow = false,
		delayTime = 5,
		createMode = "RoleAttach",
		destroyMode = "DelayTime",
		attachType = 10,
		roleId = 907301,
		path = "QWWorld/Effect/EmotionBubble/fx_daxiao_0802_QW"
	})
	arg_47_0:ShowTalkView()
	arg_47_0:SetTalkContent(11044003, "", 907301)
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
	arg_47_0:OnNext(function(arg_51_0)
		arg_47_0:ClearOnNext()
		arg_47_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_52_0)
	arg_52_0:EnableCameraByTagAction("4", 1, 0)
	arg_52_0:PlayActorAnimationAction(9071, "conversation_1", 0.05, 3, function()
		return
	end)
	arg_52_0:DestroyCharAction(9072)
	arg_52_0:DestroyCharAction(9074)
	arg_52_0:ShowTalkView()
	arg_52_0:SetTalkContent(11044004, "", 9071)
	arg_52_0:SetNeedSkip(true, {
		Invoke = function()
			arg_52_0:Skip("LastWord")
		end
	})
	arg_52_0:SetNeedClick(true, {
		Invoke = function()
			arg_52_0:Next()
		end
	})
	arg_52_0:OnNext(function(arg_56_0)
		arg_52_0:ClearOnNext()
		arg_52_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_57_0)
	arg_57_0:PlayActorAnimationAction(9510, "stroke01", 0.05, 9.066668, function()
		return
	end)
	arg_57_0:ShowTalkView()
	arg_57_0:SetTalkContent(11044005, "", 9510)
	arg_57_0:SetNeedSkip(true, {
		Invoke = function()
			arg_57_0:Skip("LastWord")
		end
	})
	arg_57_0:SetNeedClick(true, {
		Invoke = function()
			arg_57_0:Next()
		end
	})
	arg_57_0:OnNext(function(arg_61_0)
		arg_57_0:ClearOnNext()
		arg_57_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_62_0)
	arg_62_0:ShowTalkView()
	arg_62_0:SetTalkContent(11044006, "", 907301)
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
	arg_62_0:OnNext(function(arg_65_0)
		arg_62_0:ClearOnNext()
		arg_62_0:BlackFadeDialogueNode_9()
	end)
end

function var_0_0.BlackFadeDialogueNode_9(arg_66_0)
	arg_66_0:HideTalkView()
	arg_66_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_66_0:HideAllDynamicAction(false, false, 4095, {})
		arg_66_0:DestroyCharAction(907301)
		arg_66_0:EnableCameraByTagAction("", 1, 0)
		arg_66_0:DestroyCharAction(9071)
		arg_66_0:DestroyCharAction(9060)
		arg_66_0:DestroyCharAction(9510)
		arg_66_0:ContinueBlackFade()
		arg_66_0:OnNext(function()
			arg_66_0:ClearOnNext()
			arg_66_0:CloseStoryEventNode_10()
		end)
	end, function()
		arg_66_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_10(arg_70_0)
	arg_70_0:EnableCameraCutAction(false)
	arg_70_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_71_0)
	arg_71_0:RegisterTalkFunction("LastWord", arg_71_0.BlackFadeDialogueNode_9)
	arg_71_0:RegisterTalkFunction("End", arg_71_0.CloseStoryEventNode_10)
end

return var_0_0
