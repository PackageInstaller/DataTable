BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("601", BaseStoryGraph)

function var_0_0.Identify(arg_1_0)
	return "601"
end

function var_0_0.ConfigPath(arg_2_0)
	return "QWWorld/StoryGraph/601"
end

function var_0_0.StartStory(arg_3_0)
	arg_3_0:DialogueNode_1()
end

function var_0_0.DialogueNode_1(arg_4_0)
	arg_4_0:EnableCameraCutAction(true)
	arg_4_0:ShowTalkView()
	arg_4_0:SetTalkContent(601, "", 0)
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
	arg_8_0:SetTalkContent(602, "", 0)

	local var_8_0 = {
		[0] = {
			id = 603,
			icon = "",
			Invoke = function()
				arg_8_0:Next(603)
			end
		},
		{
			id = 606,
			icon = "",
			Invoke = function()
				arg_8_0:Next(606)
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

		if arg_11_0 == 603 then
			arg_8_0:DialogueBranchNode_3()
		elseif arg_11_0 == 606 then
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
	arg_14_0:SetTalkContent(604, "", 0)
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
		arg_14_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_18_0)
	arg_18_0:ShowTalkView()
	arg_18_0:SetTalkContent(605, "", 0)
	arg_18_0:SetNeedSkip(false, {
		Invoke = function()
			arg_18_0:Skip()
		end
	})
	arg_18_0:SetNeedClick(true, {
		Invoke = function()
			arg_18_0:Next()
		end
	})
	arg_18_0:OnNext(function(arg_21_0)
		arg_18_0:ClearOnNext()
		arg_18_0:DialogueNode_2()
	end)
end

function var_0_0.DialogueBranchNode_4(arg_22_0)
	arg_22_0:OnNext(function()
		arg_22_0:ClearOnNext()
		arg_22_0:DialogueNode_7()
	end)
	arg_22_0:Next()
end

function var_0_0.DialogueNode_7(arg_24_0)
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(607, "", 0)
	arg_24_0:SetNeedSkip(false, {
		Invoke = function()
			arg_24_0:Skip()
		end
	})
	arg_24_0:SetNeedClick(true, {
		Invoke = function()
			arg_24_0:Next()
		end
	})
	arg_24_0:OnNext(function(arg_27_0)
		arg_24_0:ClearOnNext()
		arg_24_0:CloseStoryEventNode_8()
	end)
end

function var_0_0.CloseStoryEventNode_8(arg_28_0)
	arg_28_0:EnableCameraCutAction(false)
	arg_28_0:EndStory()
end

return var_0_0
