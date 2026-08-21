BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("1001", BaseStoryGraph)

function var_0_0.Identify(arg_1_0)
	return "1001"
end

function var_0_0.ConfigPath(arg_2_0)
	return "QWWorld/StoryGraph/1001"
end

function var_0_0.StartStory(arg_3_0)
	arg_3_0:DialogueNode_1()
end

function var_0_0.DialogueNode_1(arg_4_0)
	arg_4_0:EnableCameraCutAction(true)
	arg_4_0:ShowTalkView()
	arg_4_0:SetTalkContent(101, "", 0)
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
	arg_8_0:SetTalkContent(102, "", 0)
	arg_8_0:SetNeedSkip(false, {
		Invoke = function()
			arg_8_0:Skip()
		end
	})
	arg_8_0:SetNeedClick(true, {
		Invoke = function()
			arg_8_0:Next()
		end
	})
	arg_8_0:OnNext(function(arg_11_0)
		arg_8_0:ClearOnNext()
		arg_8_0:DialogueNode_3()
	end)
end

function var_0_0.DialogueNode_3(arg_12_0)
	arg_12_0:ShowTalkView()
	arg_12_0:SetTalkContent(103, "", 0)

	local var_12_0 = {
		[0] = {
			id = 104,
			icon = "",
			Invoke = function()
				arg_12_0:Next(104)
			end
		},
		{
			id = 105,
			icon = "",
			Invoke = function()
				arg_12_0:Next(105)
			end
		},
		{
			id = 106,
			icon = "",
			Invoke = function()
				arg_12_0:Next(106)
			end
		},
		Length = 3
	}

	arg_12_0:SetChoice(var_12_0, true)
	arg_12_0:SetNeedSkip(false, nil)
	arg_12_0:SetNeedClick(false, nil)
	arg_12_0:OnNext(function(arg_16_0)
		arg_12_0:ClearOnNext()
		arg_12_0:CloseChoice()

		if arg_16_0 == 104 then
			arg_12_0:DialogueBranchNode_4()
		elseif arg_16_0 == 105 then
			arg_12_0:DialogueBranchNode_5()
		elseif arg_16_0 == 106 then
			arg_12_0:DialogueBranchNode_6()
		end
	end)
end

function var_0_0.DialogueBranchNode_4(arg_17_0)
	arg_17_0:OnNext(function()
		arg_17_0:ClearOnNext()
		arg_17_0:DialogueNode_7()
	end)
	arg_17_0:Next()
end

function var_0_0.DialogueNode_7(arg_19_0)
	arg_19_0:ShowTalkView()
	arg_19_0:SetTalkContent(107, "", 0)
	arg_19_0:SetNeedSkip(false, {
		Invoke = function()
			arg_19_0:Skip()
		end
	})
	arg_19_0:SetNeedClick(true, {
		Invoke = function()
			arg_19_0:Next()
		end
	})
	arg_19_0:OnNext(function(arg_22_0)
		arg_19_0:ClearOnNext()
		arg_19_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueNode_8(arg_23_0)
	arg_23_0:ShowTalkView()
	arg_23_0:SetTalkContent(110, "", 0)
	arg_23_0:SetNeedSkip(false, {
		Invoke = function()
			arg_23_0:Skip()
		end
	})
	arg_23_0:SetNeedClick(true, {
		Invoke = function()
			arg_23_0:Next()
		end
	})
	arg_23_0:OnNext(function(arg_26_0)
		arg_23_0:ClearOnNext()
		arg_23_0:CloseStoryEventNode_9()
	end)
end

function var_0_0.CloseStoryEventNode_9(arg_27_0)
	arg_27_0:EnableCameraCutAction(false)
	arg_27_0:EndStory()
end

function var_0_0.DialogueBranchNode_5(arg_28_0)
	arg_28_0:OnNext(function()
		arg_28_0:ClearOnNext()
		arg_28_0:DialogueNode_10()
	end)
	arg_28_0:Next()
end

function var_0_0.DialogueNode_10(arg_30_0)
	arg_30_0:ShowTalkView()
	arg_30_0:SetTalkContent(108, "", 0)
	arg_30_0:SetNeedSkip(false, {
		Invoke = function()
			arg_30_0:Skip()
		end
	})
	arg_30_0:SetNeedClick(true, {
		Invoke = function()
			arg_30_0:Next()
		end
	})
	arg_30_0:OnNext(function(arg_33_0)
		arg_30_0:ClearOnNext()
		arg_30_0:DialogueNode_8()
	end)
end

function var_0_0.DialogueBranchNode_6(arg_34_0)
	arg_34_0:OnNext(function()
		arg_34_0:ClearOnNext()
		arg_34_0:DialogueNode_11()
	end)
	arg_34_0:Next()
end

function var_0_0.DialogueNode_11(arg_36_0)
	arg_36_0:ShowTalkView()
	arg_36_0:SetTalkContent(109, "", 0)
	arg_36_0:SetNeedSkip(false, {
		Invoke = function()
			arg_36_0:Skip()
		end
	})
	arg_36_0:SetNeedClick(true, {
		Invoke = function()
			arg_36_0:Next()
		end
	})
	arg_36_0:OnNext(function(arg_39_0)
		arg_36_0:ClearOnNext()
		arg_36_0:DialogueNode_8()
	end)
end

return var_0_0
