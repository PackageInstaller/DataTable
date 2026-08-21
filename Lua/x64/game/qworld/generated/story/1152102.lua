BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("1152102", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "1152102"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/1152102"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:DialogueNode_1()
end

function var_0_0.DialogueNode_1(arg_5_0)
	arg_5_0:ShowTalkView()
	arg_5_0:SetTalkContent(115210201, "", 9521)
	arg_5_0:SetNeedSkip(true, {
		Invoke = function()
			arg_5_0:Skip("End")
		end
	})
	arg_5_0:SetNeedClick(true, {
		Invoke = function()
			arg_5_0:Next()
		end
	})
	arg_5_0:OnNext(function(arg_8_0)
		arg_5_0:ClearOnNext()
		arg_5_0:DialogueNode_2()
	end)
end

function var_0_0.DialogueNode_2(arg_9_0)
	arg_9_0:ShowTalkView()
	arg_9_0:SetTalkContent(115210202, "", 9521)
	arg_9_0:SetNeedSkip(true, {
		Invoke = function()
			arg_9_0:Skip("End")
		end
	})
	arg_9_0:SetNeedClick(true, {
		Invoke = function()
			arg_9_0:Next()
		end
	})
	arg_9_0:OnNext(function(arg_12_0)
		arg_9_0:ClearOnNext()
		arg_9_0:CloseStoryEventNode_3()
	end)
end

function var_0_0.CloseStoryEventNode_3(arg_13_0)
	arg_13_0:EnableCameraCutAction(false)
	arg_13_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_14_0)
	arg_14_0:RegisterTalkFunction("End", arg_14_0.CloseStoryEventNode_3)
end

return var_0_0
