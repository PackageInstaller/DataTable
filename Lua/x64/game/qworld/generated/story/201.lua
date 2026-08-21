BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("201", BaseStoryGraph)

function var_0_0.Identify(arg_1_0)
	return "201"
end

function var_0_0.ConfigPath(arg_2_0)
	return "QWWorld/StoryGraph/201"
end

function var_0_0.StartStory(arg_3_0)
	arg_3_0:DialogueNode_1()
end

function var_0_0.DialogueNode_1(arg_4_0)
	arg_4_0:EnableCameraCutAction(true)
	arg_4_0:ShowTalkView()
	arg_4_0:SetTalkContent(201, "", 0)
	arg_4_0:SetNeedSkip(false, {
		Invoke = function()
			arg_4_0:Skip()
		end
	})
	arg_4_0:SetNeedClick(true, {
		Invoke = function()
			arg_4_0:Next()
		end
	})
	arg_4_0:OnNext(function(arg_7_0)
		arg_4_0:ClearOnNext()
		arg_4_0:DialogueNode_2()
	end)
end

function var_0_0.DialogueNode_2(arg_8_0)
	arg_8_0:ShowTalkView()
	arg_8_0:SetTalkContent(202, "", 0)

	local var_8_0 = {
		[0] = {
			id = 203,
			icon = "",
			Invoke = function()
				arg_8_0:Next(203)
			end
		},
		{
			id = 205,
			icon = "",
			Invoke = function()
				arg_8_0:Next(205)
			end
		},
		Length = 2
	}

	arg_8_0:SetChoice(var_8_0, true)
	arg_8_0:SetNeedSkip(false, nil)
	arg_8_0:SetNeedClick(false, nil)
	arg_8_0:OnNext(function(arg_11_0)
		arg_8_0:ClearOnNext()
		arg_8_0:CloseChoice()

		if arg_11_0 == 203 then
			arg_8_0:DialogueBranchNode_3()
		elseif arg_11_0 == 205 then
			arg_8_0:DialogueBranchNode_4()
		end
	end)
end

function var_0_0.DialogueBranchNode_3(arg_12_0)
	arg_12_0:OnNext(function()
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_5()
	end)
	arg_12_0:Next()
end

function var_0_0.DialogueNode_5(arg_14_0)
	arg_14_0:ShowTalkView()
	arg_14_0:SetTalkContent(204, "", 0)
	arg_14_0:SetNeedSkip(false, {
		Invoke = function()
			arg_14_0:Skip()
		end
	})
	arg_14_0:SetNeedClick(true, {
		Invoke = function()
			arg_14_0:Next()
		end
	})
	arg_14_0:OnNext(function(arg_17_0)
		arg_14_0:ClearOnNext()
		arg_14_0:CloseStoryEventNode_6()
	end)
end

function var_0_0.CloseStoryEventNode_6(arg_18_0)
	arg_18_0:EnableCameraCutAction(false)
	arg_18_0:EndStory()
end

function var_0_0.DialogueBranchNode_4(arg_19_0)
	arg_19_0:OnNext(function()
		arg_19_0:ClearOnNext()
		arg_19_0:DialogueNode_7()
	end)
	arg_19_0:Next()
end

function var_0_0.DialogueNode_7(arg_21_0)
	arg_21_0:ShowTalkView()
	arg_21_0:SetTalkContent(206, "", 0)
	arg_21_0:SetNeedSkip(false, {
		Invoke = function()
			arg_21_0:Skip()
		end
	})
	arg_21_0:SetNeedClick(true, {
		Invoke = function()
			arg_21_0:Next()
		end
	})
	arg_21_0:OnNext(function(arg_24_0)
		arg_21_0:ClearOnNext()
		arg_21_0:DialogueNode_2()
	end)
end

return var_0_0
