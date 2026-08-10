BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11098", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11098"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11098"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_5_0:SetCharToTagAction(9073, "9073_1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {
			30004,
			30005
		})
		arg_5_0:PlayActorAnimationAction(9073, "dorm_female_idle01", 0.05, 4.166667, function()
			return
		end)
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:LoadThingToTag(1, "jing_original", "item_1", function()
			return
		end)
		arg_5_0:SetCharToTagAction(9074, "9074_1", function()
			return
		end)
		arg_5_0:PlayActorAnimationAction(9074, "dorm_female_idle01", 0.05, 4.166667, function()
			return
		end)
		arg_5_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_01_xiujin", "", "")
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:PureActorDialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_2(arg_14_0)
	arg_14_0:DelayTimeAction(2.5, function()
		arg_14_0:BlackFadeAction(0.2, 0.3, 0.3, function()
			arg_14_0:InstEffectAction({
				attachFollow = false,
				delayTime = 5,
				createMode = "RoleAttach",
				destroyMode = "DelayTime",
				attachType = 3,
				roleId = 9073,
				path = "QWWorld/Effect/EmotionBubble/fx_canlan_0401"
			})
		end, function()
			arg_14_0:LoadThingToTag(2, "jing_done", "item_1", function()
				return
			end)
			arg_14_0:PlayActorAnimationAction(9073, "proud_start", 0, 0.6, function()
				arg_14_0:DelayTimeAction(2, function()
					arg_14_0:EventAction(function()
						arg_14_0:ImmediateNextFlag(-1)
					end)
				end)
			end)
			arg_14_0:UnloadThing(1)
		end)
	end)
	arg_14_0:HideTalkView()
	arg_14_0:OnNext(function()
		arg_14_0:ClearOnNext()
		arg_14_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_23_0)
	arg_23_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
	arg_23_0:LookAtRoleAction(true, 9073, "9074")
	arg_23_0:ShowTalkView()
	arg_23_0:SetTalkContent(11013001, "", 0)
	arg_23_0:SetNeedSkip(true, {
		Invoke = function()
			arg_23_0:Skip("End")
		end
	})
	arg_23_0:SetNeedClick(true, {
		Invoke = function()
			arg_23_0:Next()
		end
	})
	arg_23_0:OnNext(function(arg_26_0)
		arg_23_0:ClearOnNext()
		arg_23_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_27_0)
	arg_27_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_27_0:LookAtRoleAction(true, 9074, "9073")
	arg_27_0:PlayActorAnimationAction(9074, "dorm_male_idle01", 0.05, 8.166667, function()
		return
	end)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(11013002, "", 0)
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
		arg_27_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_32_0)
	arg_32_0:PlayActorAnimationAction(9073, "action3_1", 0.05, 2.266667, function()
		return
	end)
	arg_32_0:ShowTalkView()
	arg_32_0:SetTalkContent(11013003, "", 0)
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
		arg_32_0:BlackFadeDialogueNode_6()
	end)
end

function var_0_0.BlackFadeDialogueNode_6(arg_37_0)
	arg_37_0:HideTalkView()
	arg_37_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_37_0:HideAllDynamicAction(false, false, 4083, {
			30004
		})
		arg_37_0:EnableCameraByTagAction("", 1, 0)
		arg_37_0:UnloadThing(2)
		arg_37_0:DestroyCharAction(9073)
		arg_37_0:DestroyCharAction(9074)
		arg_37_0:ContinueBlackFade()
		arg_37_0:OnNext(function()
			arg_37_0:ClearOnNext()
			arg_37_0:CloseStoryEventNode_7()
		end)
	end, function()
		arg_37_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_7(arg_41_0)
	arg_41_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_42_0)
	arg_42_0:RegisterTalkFunction("End", arg_42_0.BlackFadeDialogueNode_6)
	arg_42_0:RegisterTalkFunction("End", arg_42_0.CloseStoryEventNode_7)
end

return var_0_0
