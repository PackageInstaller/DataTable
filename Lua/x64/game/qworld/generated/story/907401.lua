BaseStoryGraph = import("game.qworld.story.Graph.BaseStoryGraph")

local var_0_0 = class("907401", BaseStoryGraph)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	arg_1_0:RegisterFuncMap()
end

function var_0_0.Identify(arg_2_0)
	return "907401"
end

function var_0_0.ConfigPath(arg_3_0)
	return "QWWorld/StoryGraph/907401"
end

function var_0_0.StartStory(arg_4_0)
	arg_4_0:DialogueNode_1()
end

function var_0_0.DialogueNode_1(arg_5_0)
	arg_5_0:ShowTalkView()
	arg_5_0:SetTalkContent(907401001, "", 0)

	local var_5_0 = {
		Length = 1,
		[0] = {
			id = 907401002,
			icon = "",
			Invoke = function()
				arg_5_0:Next(907401002)
			end
		}
	}

	arg_5_0:SetChoice(var_5_0, true)
	arg_5_0:SetNeedSkip(false, nil)
	arg_5_0:SetNeedClick(false, nil)
	arg_5_0:OnNext(function(arg_7_0)
		arg_5_0:ClearOnNext()
		arg_5_0:CloseChoice()

		if arg_7_0 == 907401002 then
			arg_5_0:DialogueBranchNode_2()
		end
	end)
end

function var_0_0.DialogueBranchNode_2(arg_8_0)
	arg_8_0:OnNext(function()
		arg_8_0:ClearOnNext()
		arg_8_0:CloseStoryEventNode_3()
	end)
	arg_8_0:Next()
end

function var_0_0.CloseStoryEventNode_3(arg_10_0)
	arg_10_0:EnableCameraCutAction(false)
	arg_10_0:EndStory()
end

function var_0_0.RegisterFuncMap(arg_11_0)
	arg_11_0:RegisterTalkFunction("End", arg_11_0.CloseStoryEventNode_3)
end

return var_0_0
