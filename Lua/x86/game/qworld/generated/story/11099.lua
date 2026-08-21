BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11099", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11099"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11099"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:BlackFadeAction(0.2, 0.5, 0.5, function()
		return
	end, function()
		arg_5_0:EnableCameraByTagAction("1", 1, 0)
		arg_5_0:SetCharToTagAction(9073, "9073_1", function()
			arg_5_0:PlayActorAnimationAction(9073, "present_bag_moving_1", 0.1, 8.033334, function()
				return
			end)
			arg_5_0:DelayTimeAction(8, function()
				arg_5_0:PlayActorAnimationAction(9073, "present_bag_moving_2", 0.1, 2.566667, function()
					return
				end)
				arg_5_0:BlackFadeAction(0, 0.2, 0.2, function()
					return
				end, function()
					arg_5_0:SetThingToTag(1, "item_2", function()
						return
					end)
					arg_5_0:SetCharToTagAction(9073, "9073_2", function()
						arg_5_0:DelayTimeAction(2, function()
							arg_5_0:BlackFadeAction(0, 0.2, 0.2, function()
								return
							end, function()
								arg_5_0:SetThingToTag(1, "item_3", function()
									return
								end)
								arg_5_0:CameraMoveAction("3", 1, 2, 10, 0.8)
								arg_5_0:SetCharToTagAction(9073, "9073_3", function()
									return
								end)
								arg_5_0:PlayActorAnimationAction(9073, "present_bag_moving_3", 0.1, 6.466667, function()
									return
								end)
								arg_5_0:DelayTimeAction(5.5, function()
									arg_5_0:BlackFadeAction(0, 0.2, 0.2, function()
										return
									end, function()
										arg_5_0:SetThingToTag(1, "item_4", function()
											return
										end)
										arg_5_0:SetCharToTagAction(9073, "9073_4", function()
											return
										end)
										arg_5_0:CameraMoveAction("3", 1, 2, 10, 0.8)
										arg_5_0:PlayActorAnimationAction(9073, "present_bag_moving_4", 0, 4.733334, function()
											return
										end)
										arg_5_0:EnableCameraByTagAction("4", 1, 0)
										arg_5_0:DelayTimeAction(3, function()
											arg_5_0:EventAction(function()
												arg_5_0:ImmediateNextFlag(-1)
											end)
										end)
										arg_5_0:InstEffectAction({
											attachFollow = false,
											delayTime = 5,
											createMode = "RoleAttach",
											destroyMode = "DelayTime",
											attachType = 10,
											roleId = 9073,
											path = "QWWorld/Effect/EmotionBubble/fx_piaosan_1401"
										})
										arg_5_0:SetCharToTagAction(9074, "9074_1", function()
											return
										end)
										arg_5_0:WalkingPeopleGlobleCull(false)
									end)
								end)
								arg_5_0:EnableCameraByTagAction("3", 1, 0)
							end)
						end)
					end)
					arg_5_0:EnableCameraByTagAction("2", 1, 0)
					arg_5_0:CameraMoveAction("2", 1, 2, 10, 0.8)
					arg_5_0:InstEffectAction({
						attachFollow = false,
						delayTime = 5,
						createMode = "RoleAttach",
						destroyMode = "DelayTime",
						attachType = 10,
						roleId = 9073,
						path = "QWWorld/Effect/EmotionBubble/fx_maohan_0302"
					})
				end)
			end)
		end)
		arg_5_0:LoadThingToTag(1, "Main_vat_original_2", "item_1", function()
			return
		end)
		arg_5_0:HideAllDynamicAction(true, true, 4083, {
			30002,
			30003
		})
		arg_5_0:CameraMoveAction("1", 1, 2, 10, 0.8)
		arg_5_0:WalkingPeopleGlobleCull(true)
		arg_5_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_story_02_bangang", "", "")
	end)
	arg_5_0:HideTalkView()
	arg_5_0:OnNext(function()
		arg_5_0:ClearOnNext()
		arg_5_0:DialogueNode_2()
	end)
end

function var_0_0.DialogueNode_2(arg_33_0)
	arg_33_0:SetLookAtParamsAction(9074, 0.8, 1, 1)
	arg_33_0:LookAtRoleAction(true, 9074, "9073")
	arg_33_0:DelayTimeAction(2, function()
		arg_33_0:SetLookAtParamsAction(9073, 0.8, 1, 1)
		arg_33_0:LookAtRoleAction(true, 9073, "9074")
		arg_33_0:DelayTimeAction(0.5, function()
			arg_33_0:SetNeedClick(true, {
				Invoke = function()
					arg_33_0:Next()
				end
			})
			arg_33_0:SetNeedSkip(true, {
				Invoke = function()
					arg_33_0:Skip("End")
				end
			})
		end)
	end)
	arg_33_0:ShowTalkView()
	arg_33_0:SetTalkContent(11013011, "", 9073)
	arg_33_0:SetNeedSkip(true, {
		Invoke = function()
			arg_33_0:Skip("End")
		end
	})
	arg_33_0:SetNeedClick(false, {
		Invoke = function()
			arg_33_0:Next()
		end
	})
	arg_33_0:OnNext(function(arg_40_0)
		arg_33_0:ClearOnNext()
		arg_33_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_41_0)
	arg_41_0:PlayActorAnimationAction(9074, "conversation_1", 0.1, 3, function()
		return
	end)
	arg_41_0:ShowTalkView()
	arg_41_0:SetTalkContent(11013012, "", 9074)
	arg_41_0:SetNeedSkip(true, {
		Invoke = function()
			arg_41_0:Skip("End")
		end
	})
	arg_41_0:SetNeedClick(true, {
		Invoke = function()
			arg_41_0:Next()
		end
	})
	arg_41_0:OnNext(function(arg_45_0)
		arg_41_0:ClearOnNext()
		arg_41_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_46_0)
	arg_46_0:PlayActorAnimationAction(9073, "embarrassed", 0.1, 2.6, function()
		return
	end)
	arg_46_0:ShowTalkView()
	arg_46_0:SetTalkContent(11013013, "", 9073)
	arg_46_0:SetNeedSkip(true, {
		Invoke = function()
			arg_46_0:Skip("End")
		end
	})
	arg_46_0:SetNeedClick(true, {
		Invoke = function()
			arg_46_0:Next()
		end
	})
	arg_46_0:OnNext(function(arg_50_0)
		arg_46_0:ClearOnNext()
		arg_46_0:BlackFadeDialogueNode_5()
	end)
end

function var_0_0.BlackFadeDialogueNode_5(arg_51_0)
	arg_51_0:HideTalkView()
	arg_51_0:OnBlackFade(false, 0, 0.2, 0.5, 0.5, function()
		arg_51_0:DestroyCharAction(9073)
		arg_51_0:UnloadThing(1)
		arg_51_0:EnableCameraByTagAction("", 1, 0)
		arg_51_0:HideAllDynamicAction(false, false, 4095, {})
		arg_51_0:ContinueBlackFade()
		arg_51_0:OnNext(function()
			arg_51_0:ClearOnNext()
			arg_51_0:CloseStoryEventNode_6()
		end)
	end, function()
		arg_51_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_6(arg_55_0)
	arg_55_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_56_0)
	arg_56_0:RegisterTalkFunction("End", arg_56_0.CloseStoryEventNode_6)
end

return var_0_0
