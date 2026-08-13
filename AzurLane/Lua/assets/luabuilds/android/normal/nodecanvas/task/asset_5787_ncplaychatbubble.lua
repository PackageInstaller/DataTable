class = var_0_10000

local var_0_0 = "NcPlayChatBubble"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetStringArg("storyName")

	arg_1_0:DoAction(var_1_0, function()
		local var_2_0 = arg_1_0

		var_0.EndAction(var_2_0)

		return
	end)

	return
end

function var_0_1.DoAction(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.SendEvent

	ISLAND_EVT = var_1_10005

	var_3_1(var_3_0, var_1_10005.PLAY_BUBBLE, {
		name = arg_3_1,
		callback = arg_3_2
	})

	return
end

return var_0_1
