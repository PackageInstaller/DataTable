local var_0_0 = class("ChatMsg", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	assert(arg_1_1, "type should be clarified.")

	arg_1_0.type = arg_1_1
	arg_1_0.timestamp = arg_1_2.timestamp
	arg_1_0.content = arg_1_2.content
	arg_1_0.emojiId = arg_1_2.emojiId
	arg_1_0.player = arg_1_2.player

	if arg_1_0.player then
		arg_1_0.playerId = arg_1_0.player.id
	end

	arg_1_0.unread = arg_1_2.unread or 0
	arg_1_0.id = arg_1_2.id
	arg_1_0.args = arg_1_2.args
	arg_1_0.uniqueId = arg_1_2.uniqueId
	arg_1_0.needBanRichText = true

	if arg_1_2.richText then
		arg_1_0.needBanRichText = false
	end

	return
end

function var_0_0.IsPublic(arg_2_0)
	return arg_2_0.id ~= nil
end

function var_0_0.IsWorldBossNotify(arg_3_0)
	return arg_3_0.id == 4
end

function var_0_0.IsSame(arg_4_0, arg_4_1)
	return arg_4_0.uniqueId == arg_4_1
end

return var_0_0
