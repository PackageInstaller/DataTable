BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11194", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11194"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11194"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:EnableCameraByTagAction("1", 1, 0)
	arg_5_0:LoadThingToTag(1, "Yahaha_shigandang", "1", function()
		return
	end)
	arg_5_0:InstEffectAction({
		pointTag = "1",
		destroyMode = "DontDestroy",
		createMode = "Point",
		path = "QWWorld/Effect/fx_yahaha_smoke.prefab"
	})
	arg_5_0:HideAllDynamicAction(false, true, 1, {})
	arg_5_0:PlayThingAnimationAction(1, "shake", 0, 0, function()
		return
	end)
	arg_5_0:DelayTimeAction(3, function()
		arg_5_0:EnableCameraByTagAction("", 2, 1)
		arg_5_0:DelayTimeAction(1, function()
			arg_5_0:EventAction(function()
				arg_5_0:ImmediateNextFlag(-1)
			end)
		end)
		arg_5_0:HideAllDynamicAction(false, false, 1, {})
	end)
	arg_5_0:HideTalkView()
	arg_5_0:OnNext(function()
		arg_5_0:ClearOnNext()
		arg_5_0:CloseStoryEventNode_2()
	end)
end

function var_0_0.CloseStoryEventNode_2(arg_12_0)
	arg_12_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_13_0)
	arg_13_0:RegisterTalkFunction("End", arg_13_0.CloseStoryEventNode_2)
end

return var_0_0
