local var_0_0 = class("NcPlayChatBubble", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	arg_1_0:DoAction(arg_1_0:GetStringArg("storyName"), function()
		arg_1_0:EndAction()

		return
	end)

	return
end

function var_0_0.DoAction(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:SendEvent(ISLAND_EVT.PLAY_BUBBLE, {
		name = arg_3_1,
		callback = arg_3_2
	})

	return
end

return var_0_0
