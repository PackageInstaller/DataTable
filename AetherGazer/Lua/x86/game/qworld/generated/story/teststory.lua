BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("TestStory", BaseStoryGraph)

function var_0_0.Identify(arg_1_0)
	return "TestStory"
end

function var_0_0.ConfigPath(arg_2_0)
	return "QWWorld/StoryGraph/TestStory"
end

function var_0_0.StartStory(arg_3_0)
	arg_3_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_4_0)
	arg_4_0:HideTalkView()
	arg_4_0:OnBlackFade(true, 5, 3, 2, 2, function()
		arg_4_0:EnableCameraCutAction(true)
		arg_4_0:EnableCameraByTagAction("A1")
		arg_4_0:ContinueBlackFade()
		arg_4_0:OnNext(function()
			arg_4_0:ClearOnNext()
			arg_4_0:DialogueNode_2()
		end)
	end, function()
		arg_4_0:Next()
	end)
end

function var_0_0.DialogueNode_2(arg_8_0)
	arg_8_0:ShowTalkView()
	arg_8_0:SetTalkContent(10, "Assets/ABResources/Textures/Dorm/Customer/1.png", 9070)

	local var_8_0 = {
		[0] = {
			id = 7,
			icon = "",
			Invoke = function()
				arg_8_0:Next(7)
			end
		},
		{
			id = 8,
			icon = "",
			Invoke = function()
				arg_8_0:Next(8)
			end
		},
		Length = 2
	}

	arg_8_0:SetChoice(var_8_0, false)
	arg_8_0:SetNeedSkip(false, nil)
	arg_8_0:SetNeedClick(false, nil)
	arg_8_0:OnNext(function(arg_11_0)
		arg_8_0:ClearOnNext()
		arg_8_0:CloseChoice()

		if arg_11_0 == 7 then
			arg_8_0:DialogueBranchNode_3()
		elseif arg_11_0 == 8 then
			arg_8_0:DialogueBranchNode_4()
		end
	end)
end

function var_0_0.DialogueBranchNode_3(arg_12_0)
	arg_12_0:OnNext(function()
		arg_12_0:ClearOnNext()
		arg_12_0:BlackFadeDialogueNode_5()
	end)
	arg_12_0:Next()
end

function var_0_0.BlackFadeDialogueNode_5(arg_14_0)
	arg_14_0:HideTalkView()
	arg_14_0:OnBlackFade(true, 2, 2, 3, 3, function()
		arg_14_0:SetCharToTagAction(9024, "PATH_A1", function()
			arg_14_0:ContinueBlackFade()
		end)
		arg_14_0:OnNext(function()
			arg_14_0:ClearOnNext()
			arg_14_0:PureActorDialogueNode_6()
		end)
	end, function()
		arg_14_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_6(arg_19_0)
	arg_19_0:ActorSeekerAction(9024, {
		"PATH_A1",
		"PATH_A2",
		"PATH_A3"
	}, 3, function()
		arg_19_0:DelayTimeAction(0.5, function()
			arg_19_0:PlayActorAnimationAction(9024, "cheer", 0, 2.333333, function()
				arg_19_0:ActorSeekerAction(9024, {
					"PATH_A4",
					"PATH_A5",
					"PATH_A6"
				}, 3, function()
					arg_19_0:PlayActorAnimationAction(9024, "conversation_1", 0, 3, function()
						arg_19_0:EventAction(function()
							arg_19_0:ImmediateNextFlag(-1)
							arg_19_0:DispatchEvent("Destroy_A")
						end)
					end)
					arg_19_0:EnableCameraByTagAction("A2")
				end)
			end)
		end)
	end)
	arg_19_0:InstEffectAction({
		attachFollow = false,
		event = "Destroy_A",
		createMode = "RoleAttach",
		destroyMode = "Event",
		attachType = 3,
		roleId = 9024,
		path = "QWWorld/Effect/fx_pickup.prefab"
	})
	arg_19_0:EnableCameraShakeAction(true, "Camera/Noise/Handheld_normal_strong.asset", 2, 2, 2)
	arg_19_0:HideTalkView()
	arg_19_0:OnNext(function()
		arg_19_0:ClearOnNext()
		arg_19_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_27_0)
	arg_27_0:ShowTalkView()
	arg_27_0:SetTalkContent(4, "Assets/UIResources/UI_AB/TextureConfig/Story/Character/1060_split_1_1.png", 9072)
	arg_27_0:SetNeedSkip(true, {
		Invoke = function()
			arg_27_0:Skip()
		end
	})
	arg_27_0:SetNeedClick(true, {
		Invoke = function()
			arg_27_0:Next()
		end
	})
	arg_27_0:OnNext(function(arg_30_0)
		arg_27_0:ClearOnNext()
		arg_27_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_31_0)
	arg_31_0:EnableCameraCutAction(false)
	arg_31_0:DelayTimeAction(3, function()
		arg_31_0:SetNeedClick(true, {
			Invoke = function()
				arg_31_0:Next()
			end
		})
		arg_31_0:SetNeedSkip(false, nil)
	end)
	arg_31_0:EnableCameraByTagAction("A1")
	arg_31_0:ShowTalkView()
	arg_31_0:SetTalkContent(9, "", 9072)
	arg_31_0:SetNeedSkip(false, {
		Invoke = function()
			arg_31_0:Skip()
		end
	})
	arg_31_0:SetNeedClick(false, {
		Invoke = function()
			arg_31_0:Next()
		end
	})
	arg_31_0:OnNext(function(arg_36_0)
		arg_31_0:ClearOnNext()
		arg_31_0:CloseStoryEventNode_9()
	end)
end

function var_0_0.CloseStoryEventNode_9(arg_37_0)
	arg_37_0:EnableCameraCutAction(false)
	arg_37_0:EnableCameraByTagAction("")
	arg_37_0:EndStory()
end

function var_0_0.DialogueBranchNode_4(arg_38_0)
	arg_38_0:OnNext(function()
		arg_38_0:ClearOnNext()
		arg_38_0:DialogueNode_8()
	end)
	arg_38_0:Next()
end

return var_0_0
