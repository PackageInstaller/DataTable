local NcPlayStory = class("NcPlayStory", import("..base.NodeCanvasBaseTask"))

function NcPlayStory:OnExecute()
	self:DoAction(self:GetStringArg("storyName"), true, function()
		self:EndAction()

		return
	end)

	return
end

function NcPlayStory:DoAction(arg_3_1, arg_3_2, arg_3_3)
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

return NcPlayStory
