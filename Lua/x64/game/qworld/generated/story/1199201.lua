BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("1199201", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "1199201"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/1199201"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:DialogueNode_1()
end

function var_0_0.DialogueNode_1(arg_5_0)
	arg_5_0:PlaySoundsAction(1, "vo_sandplay", "vo_sandplay_female_elder_excited", "vo_sandplay.awb", "vo_sandplay.acb")
	arg_5_0:ShowTalkView()
	arg_5_0:SetTalkContent(119920101, "", 9522)
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
	arg_9_0:SetTalkContent(119920102, "", 9522)
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
		arg_9_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_13_0)
	arg_13_0:ShowTalkView()
	arg_13_0:SetTalkContent(119920103, "", 9522)
	arg_13_0:SetNeedSkip(true, {
		Invoke = function()
			arg_13_0:Skip("End")
		end
	})
	arg_13_0:SetNeedClick(true, {
		Invoke = function()
			arg_13_0:Next()
		end
	})
	arg_13_0:OnNext(function(arg_16_0)
		arg_13_0:ClearOnNext()
		arg_13_0:CloseStoryEventNode_4()
	end)
end

function var_0_0.CloseStoryEventNode_4(arg_17_0)
	arg_17_0:EnableCameraCutAction(false)
	arg_17_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_18_0)
	arg_18_0:RegisterTalkFunction("End", arg_18_0.CloseStoryEventNode_4)
end

return var_0_0
