local var_0_0 = class("NcPlayStory", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	arg_1_0:DoAction(arg_1_0:GetStringArg("storyName"), true, function()
		arg_1_0:EndAction()

		return
	end)

	return
end

function var_0_0.DoAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not _IslandCore then
		return
	end

	_IslandCore:GetController():NotifiyIsland(ISLAND_EX_EVT.PLAY_STORY, {
		name = arg_3_1,
		refreshNpc = arg_3_2,
		callback = arg_3_3
	})

	return
end

return var_0_0
