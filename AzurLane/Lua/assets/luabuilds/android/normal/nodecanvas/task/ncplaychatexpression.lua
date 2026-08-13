class = var_0_10000

local var_0_0 = "NcPlayChatExpression"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetStringArg("emojiId")
	local var_1_1 = arg_1_0:GetStringArg("id")
	local var_1_2 = arg_1_0:GetStringArg("type")
	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.DoAction
	local var_1_5 = var_1_0

	tonumber = var_1_10007

	local var_1_6 = var_1_10007(var_1_1)

	tonumber = var_8

	var_1_4(var_1_3, var_1_5, var_1_6, var_8(var_1_2), function()
		return
	end)
	arg_1_0:EndAction()

	return
end

function var_0_1.DoAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_1 == "0" then
		return
	end

	_IslandCore = var_1_10005

	if not var_1_10005 then
		return
	end

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.WarpStory(var_3_0, arg_3_1, arg_3_2, arg_3_3)

	_IslandCore = var_3_0

	local var_3_2 = var_3_0:GetController()
	local var_3_3 = var_6.NotifiyCore

	ISLAND_EVT = var_8

	var_3_3(var_3_2, var_8.RAW_PLAY_BUBBLE, {
		info = var_3_1,
		callback = arg_3_4
	})

	return
end

function var_0_1.WarpStory(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
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

return var_0_1
