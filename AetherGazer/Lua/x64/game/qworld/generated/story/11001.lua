BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11001", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11001"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11001"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:BlackFadeAction(0.2, 0, 0.5, function()
		return
	end, function()
		arg_5_0:DelayTimeAction(3.5, function()
			arg_5_0:BlackFadeAction(0.2, 0.5, 0.5, function()
				return
			end, function()
				arg_5_0:DelayTimeAction(4.5, function()
					arg_5_0:BlackFadeAction(0.2, 0.5, 0.5, function()
						return
					end, function()
						arg_5_0:EnableCameraByTagAction("2", 1, 2)
						arg_5_0:DelayTimeAction(4.5, function()
							arg_5_0:BlackFadeAction(0.2, 0.5, 0.5, function()
								return
							end, function()
								arg_5_0:EventAction(function()
									arg_5_0:ImmediateNextFlag(-1)
								end)
								arg_5_0:HideAllDynamicAction(false, false, 4095, {})
							end)
						end)
					end)
				end)
				arg_5_0:EnableCameraByTagAction("3", 1, 2)
				arg_5_0:CameraMoveAction("3", 4, 5, 6, 1)
			end)
		end)
	end)
	arg_5_0:HideAllDynamicAction(true, true, 4095, {})
	arg_5_0:EnableCameraByTagAction("1", 1, 2)
	arg_5_0:CameraMoveAction("1", 4, 4, 6, 1)
	arg_5_0:PlaySoundsAction(2, "ui_sandplay", "ui_sandplay_x511_bgm_start", "", "")
	arg_5_0:HideTalkView()
	arg_5_0:OnNext(function()
		arg_5_0:ClearOnNext()
		arg_5_0:CloseStoryEventNode_2()
	end)
end

function var_0_0.CloseStoryEventNode_2(arg_19_0)
	arg_19_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_20_0)
	arg_20_0:RegisterTalkFunction("End", arg_20_0.CloseStoryEventNode_2)
end

return var_0_0
