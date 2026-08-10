BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("907201", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "907201"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/907201"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:DialogueNode_1()
end

function var_0_0.DialogueNode_1(arg_5_0)
	arg_5_0:ShowTalkView()
	arg_5_0:SetTalkContent(907201001, "", 0)

	local var_5_0 = {
		[0] = {
			id = 907201002,
			icon = "",
			Invoke = function()
				arg_5_0:Next(907201002)
			end
		},
		{
			id = 907201003,
			icon = "",
			Invoke = function()
				arg_5_0:Next(907201003)
			end
		},
		Length = 2
	}

	arg_5_0:SetChoice(var_5_0, true)
	arg_5_0:SetNeedSkip(false, nil)
	arg_5_0:SetNeedClick(false, nil)
	arg_5_0:OnNext(function(arg_8_0)
		arg_5_0:ClearOnNext()
		arg_5_0:CloseChoice()

		if arg_8_0 == 907201002 then
			arg_5_0:DialogueBranchNode_2()
		elseif arg_8_0 == 907201003 then
			arg_5_0:DialogueBranchNode_3()
		end
	end)
end

function var_0_0.DialogueBranchNode_2(arg_9_0)
	arg_9_0:OnNext(function()
		arg_9_0:ClearOnNext()
		arg_9_0:DialogueNode_4()
	end)
	arg_9_0:Next()
end

function var_0_0.DialogueNode_4(arg_11_0)
	arg_11_0:ShowTalkView()
	arg_11_0:SetTalkContent(907201004, "", 0)
	arg_11_0:SetNeedSkip(false, {
		Invoke = function()
			arg_11_0:Skip("End")
		end
	})
	arg_11_0:SetNeedClick(true, {
		Invoke = function()
			arg_11_0:Next()
		end
	})
	arg_11_0:OnNext(function(arg_14_0)
		arg_11_0:ClearOnNext()
		arg_11_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_15_0)
	arg_15_0:ShowTalkView()
	arg_15_0:SetTalkContent(907201005, "", 0)
	arg_15_0:SetNeedSkip(false, {
		Invoke = function()
			arg_15_0:Skip("End")
		end
	})
	arg_15_0:SetNeedClick(true, {
		Invoke = function()
			arg_15_0:Next()
		end
	})
	arg_15_0:OnNext(function(arg_18_0)
		arg_15_0:ClearOnNext()
		arg_15_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_19_0)
	arg_19_0:ShowTalkView()
	arg_19_0:SetTalkContent(907201006, "", 0)
	arg_19_0:SetNeedSkip(false, {
		Invoke = function()
			arg_19_0:Skip("End")
		end
	})
	arg_19_0:SetNeedClick(true, {
		Invoke = function()
			arg_19_0:Next()
		end
	})
	arg_19_0:OnNext(function(arg_22_0)
		arg_19_0:ClearOnNext()
		arg_19_0:CloseStoryEventNode_7()
	end)
end

function var_0_0.CloseStoryEventNode_7(arg_23_0)
	arg_23_0:EnableCameraCutAction(false)
	arg_23_0:EndStory()
end

function var_0_0.DialogueBranchNode_3(arg_24_0)
	arg_24_0:OnNext(function()
		arg_24_0:ClearOnNext()
		arg_24_0:CloseStoryEventNode_8()
	end)
	arg_24_0:Next()
end

function var_0_0.CloseStoryEventNode_8(arg_26_0)
	arg_26_0:EnableCameraCutAction(false)
	arg_26_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_27_0)
	arg_27_0:RegisterTalkFunction("End", arg_27_0.CloseStoryEventNode_7)
	arg_27_0:RegisterTalkFunction("End", arg_27_0.CloseStoryEventNode_8)
end

return var_0_0
