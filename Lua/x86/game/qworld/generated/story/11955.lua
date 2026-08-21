BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("11955", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "11955"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/11955"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:PureActorDialogueNode_1()
end

function var_0_0.PureActorDialogueNode_1(arg_5_0)
	arg_5_0:EnableCameraByTagAction("1", 1, 0)
	arg_5_0:EventAction(function()
		arg_5_0:ImmediateNextFlag(-1)
	end)
	arg_5_0:CameraMoveAction("1", 2, 2, 8, 3)
	arg_5_0:HideTalkView()
	arg_5_0:OnNext(function()
		arg_5_0:ClearOnNext()
		arg_5_0:DialogueNode_2()
	end)
end

function var_0_0.DialogueNode_2(arg_8_0)
	arg_8_0:ShowTalkView()
	arg_8_0:SetTalkContent(11955001, "", 0)
	arg_8_0:SetNeedSkip(false, {
		Invoke = function()
			arg_8_0:Skip("End")
		end
	})
	arg_8_0:SetNeedClick(true, {
		Invoke = function()
			arg_8_0:Next()
		end
	})
	arg_8_0:OnNext(function(arg_11_0)
		arg_8_0:ClearOnNext()
		arg_8_0:CloseStoryEventNode_3()
	end)
end

function var_0_0.CloseStoryEventNode_3(arg_12_0)
	arg_12_0:EnableCameraByTagAction("", 2, 1)
	arg_12_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_13_0)
	arg_13_0:RegisterTalkFunction("End", arg_13_0.CloseStoryEventNode_3)
end

return var_0_0
