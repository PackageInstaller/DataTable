class = var_0_10000

local var_0_0 = "NcPlayStory"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetStringArg("storyName")

	arg_1_0:DoAction(var_1_0, true, function()
		local var_2_0 = arg_1_0

		var_0.EndAction(var_2_0)

		return
	end)

	return
end

function var_0_1.DoAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	_IslandCore = var_1_10004

	if not var_1_10004 then
		return
	end

	_IslandCore = var_1_10004

	local var_3_0 = var_1_10004:GetController()
	local var_3_1 = var_4.NotifiyIsland

	ISLAND_EX_EVT = var_1_10006

	var_3_1(var_3_0, var_1_10006.PLAY_STORY, {
		name = arg_3_1,
		refreshNpc = arg_3_2,
		callback = arg_3_3
	})

	return
end

return var_0_1
