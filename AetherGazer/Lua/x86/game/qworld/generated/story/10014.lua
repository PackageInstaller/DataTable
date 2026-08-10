BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("10014", BaseStoryGraph)

function var_0_0.Identify(arg_1_0)
	return "10014"
end

function var_0_0.ConfigPath(arg_2_0)
	return "QWWorld/StoryGraph/10014"
end

function var_0_0.StartStory(arg_3_0)
	arg_3_0:DialogueNode_1()
end

function var_0_0.DialogueNode_1(arg_4_0)
	arg_4_0:EnableCameraCutAction(true)
	arg_4_0:ShowTalkView()
	arg_4_0:SetTalkContent(10014001, "", 0)
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
	arg_8_0:SetTalkContent(10014002, "", 0)
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
	arg_12_0:SetTalkContent(10014003, "", 0)
	arg_12_0:SetNeedSkip(false, {
		Invoke = function()
			arg_12_0:Skip()
		end
	})
	arg_12_0:SetNeedClick(true, {
		Invoke = function()
			arg_12_0:Next()
		end
	})
	arg_12_0:OnNext(function(arg_15_0)
		arg_12_0:ClearOnNext()
		arg_12_0:DialogueNode_4()
	end)
end

function var_0_0.DialogueNode_4(arg_16_0)
	arg_16_0:ShowTalkView()
	arg_16_0:SetTalkContent(10014004, "", 0)
	arg_16_0:SetNeedSkip(false, {
		Invoke = function()
			arg_16_0:Skip()
		end
	})
	arg_16_0:SetNeedClick(true, {
		Invoke = function()
			arg_16_0:Next()
		end
	})
	arg_16_0:OnNext(function(arg_19_0)
		arg_16_0:ClearOnNext()
		arg_16_0:DialogueNode_5()
	end)
end

function var_0_0.DialogueNode_5(arg_20_0)
	arg_20_0:ShowTalkView()
	arg_20_0:SetTalkContent(10014005, "", 0)
	arg_20_0:SetNeedSkip(false, {
		Invoke = function()
			arg_20_0:Skip()
		end
	})
	arg_20_0:SetNeedClick(true, {
		Invoke = function()
			arg_20_0:Next()
		end
	})
	arg_20_0:OnNext(function(arg_23_0)
		arg_20_0:ClearOnNext()
		arg_20_0:DialogueNode_6()
	end)
end

function var_0_0.DialogueNode_6(arg_24_0)
	arg_24_0:ShowTalkView()
	arg_24_0:SetTalkContent(10014006, "", 0)
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
		arg_24_0:DialogueNode_7()
	end)
end

function var_0_0.DialogueNode_7(arg_28_0)
	arg_28_0:ShowTalkView()
	arg_28_0:SetTalkContent(10014007, "", 0)
	arg_28_0:SetNeedSkip(false, {
		Invoke = function()
			arg_28_0:Skip()
		end
	})
	arg_28_0:SetNeedClick(true, {
		Invoke = function()
			arg_28_0:Next()
		end
	})
	arg_28_0:OnNext(function(arg_31_0)
		arg_28_0:ClearOnNext()
		arg_28_0:CloseStoryEventNode_8()
	end)
end

function var_0_0.CloseStoryEventNode_8(arg_32_0)
	arg_32_0:EnableCameraCutAction(false)
	arg_32_0:EndStory()
end

return var_0_0
