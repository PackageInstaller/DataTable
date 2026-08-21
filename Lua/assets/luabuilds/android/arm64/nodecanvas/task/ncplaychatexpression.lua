local var_0_0 = class("NcPlayChatExpression", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	arg_1_0:DoAction(arg_1_0:GetStringArg("emojiId"), tonumber((arg_1_0:GetStringArg("id"))), tonumber((arg_1_0:GetStringArg("type"))), function()
		return
	end)
	arg_1_0:EndAction()

	return
end

function var_0_0.DoAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_1 == "0" then
		return
	end

	if not _IslandCore then
		return
	end

	;({}).info = arg_3_0:WarpStory(arg_3_1, arg_3_2, arg_3_3)
	;({}).callback = arg_3_4

	_IslandCore:GetController():NotifiyCore(ISLAND_EVT.RAW_PLAY_BUBBLE, {})

	return
end

function var_0_0.WarpStory(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
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

return var_0_0
