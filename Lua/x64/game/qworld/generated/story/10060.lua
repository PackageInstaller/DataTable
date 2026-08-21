BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10060", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "10060"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/10060"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:BlackFadeDialogueNode_1()
end

function var_0_0.BlackFadeDialogueNode_1(arg_5_0)
	arg_5_0:HideTalkView()
	arg_5_0:OnBlackFade(false, 0, 0, 0, 0.5, function()
		arg_5_0:EnableCameraByTagAction("4", 1, 0)
		arg_5_0:CameraMoveAction("4", 1, 5, 6, 0.4)
		arg_5_0:HideAllDynamicAction(false, true)
		arg_5_0:ContinueBlackFade()
		arg_5_0:OnNext(function()
			arg_5_0:ClearOnNext()
			arg_5_0:PureActorDialogueNode_2()
		end)
	end, function()
		arg_5_0:Next()
	end)
end

function var_0_0.PureActorDialogueNode_2(arg_9_0)
	arg_9_0:DelayTimeAction(5, function()
		arg_9_0:BlackFadeAction(0.1, 0.5, 0.5, function()
			return
		end, function()
			arg_9_0:EnableCameraByTagAction("2", 1, 0)
			arg_9_0:DelayTimeAction(6, function()
				arg_9_0:BlackFadeAction(0.1, 0.5, 0.5, function()
					return
				end, function()
					arg_9_0:EnableCameraByTagAction("1", 1, 0)
					arg_9_0:CameraMoveAction("1", 1, 3, 6, 0.4)
					arg_9_0:DelayTimeAction(5, function()
						arg_9_0:BlackFadeAction(0.1, 0.5, 0.5, function()
							return
						end, function()
							arg_9_0:EnableCameraByTagAction("3", 1, 0)
							arg_9_0:CameraMoveAction("3", 1, 4, 6, 0.4)
							arg_9_0:DelayTimeAction(5, function()
								arg_9_0:EventAction(function()
									arg_9_0:ImmediateNextFlag(-1)
								end)
							end)
						end)
					end)
				end)
			end)
		end)
	end)
	arg_9_0:HideTalkView()
	arg_9_0:OnNext(function()
		arg_9_0:ClearOnNext()
		arg_9_0:BlackFadeDialogueNode_3()
	end)
end

function var_0_0.BlackFadeDialogueNode_3(arg_22_0)
	arg_22_0:HideTalkView()
	arg_22_0:OnBlackFade(false, 0, 0.1, 0.5, 0.5, function()
		arg_22_0:EnableCameraByTagAction("", 1, 0)
		arg_22_0:HideAllDynamicAction(false, false)
		arg_22_0:ContinueBlackFade()
		arg_22_0:OnNext(function()
			arg_22_0:ClearOnNext()
			arg_22_0:CloseStoryEventNode_4()
		end)
	end, function()
		arg_22_0:Next()
	end)
end

function var_0_0.CloseStoryEventNode_4(arg_26_0)
	arg_26_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_27_0)
	arg_27_0:RegisterTalkFunction("End", arg_27_0.CloseStoryEventNode_4)
end

return var_0_0
