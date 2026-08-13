class = var_0_10000

local var_0_0 = "ChatMsg"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	assert = var_1_10003

	var_1_10003(arg_1_1, "type should be clarified.")

	arg_1_0.type = arg_1_1
	arg_1_0.timestamp = arg_1_2.timestamp
	arg_1_0.content = arg_1_2.content
	arg_1_0.emojiId = arg_1_2.emojiId
	arg_1_0.player = arg_1_2.player

	if arg_1_0.player then
		arg_1_0.playerId = arg_1_0.player.id
	end

	local var_1_0

	if not arg_1_2.unread then
		var_1_0 = 0
	end

	arg_1_0.unread = var_1_0
	arg_1_0.id = arg_1_2.id
	arg_1_0.args = arg_1_2.args
	arg_1_0.uniqueId = arg_1_2.uniqueId
	arg_1_0.needBanRichText = true

	if arg_1_2.richText then
		arg_1_0.needBanRichText = false
	end

	return
end

function var_0_1.IsPublic(arg_2_0)
	return arg_2_0.id ~= nil
end

function var_0_1.IsWorldBossNotify(arg_3_0)
	return arg_3_0.id == 4
end

function var_0_1.IsSame(arg_4_0, arg_4_1)
	return arg_4_0.uniqueId == arg_4_1
end

return var_0_1
