local NcPlayChatExpression = class("NcPlayChatExpression", import("..base.NodeCanvasBaseTask"))

function NcPlayChatExpression:OnExecute()
	self:DoAction(self:GetStringArg("emojiId"), tonumber((self:GetStringArg("id"))), tonumber((self:GetStringArg("type"))), function()
		return
	end)
	self:EndAction()

	return
end

function NcPlayChatExpression:DoAction(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_1 == "0" then
		return
	end

	local var_3_0

	if not _IslandCore then
		do return end

		var_3_0 = {}
	end

	var_3_0.info = self:WarpStory(arg_3_1, arg_3_2, arg_3_3)
	var_3_0.callback = arg_3_4

	_IslandCore:GetController():NotifiyCore(ISLAND_EVT.RAW_PLAY_BUBBLE, var_3_0)

	return
end

function NcPlayChatExpression:WarpStory(arg_4_1, arg_4_2, arg_4_3)
	return {
		id = "NPC_WARP_STORY",
		mode = 9,
		map = {
			{
				9999,
				arg_4_2,
				arg_4_3
			}
		},
		scripts = {
			{
				emojiType = 2,
				characterId = 9999,
				emoji = arg_4_1
			}
		}
	}
end

return NcPlayChatExpression
