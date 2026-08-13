class = var_0_10000

local var_0_0 = "BubbleStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseStep"))

var_0_1.HIDE_TYPE_IMMEDIATELY = 0
var_0_1.HIDE_TYPE_NEVER = 1
var_0_1.HIDE_TYPE_TIME = 2
var_0_1.EMOJI_TYPE_CHAT = 1
var_0_1.EMOJI_TYPE_EXPRESSION = 2

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.emoji = arg_1_1.emoji
	defaultValue = var_3
	arg_1_0.emojiType = var_3(arg_1_1.emojiType, var_0_1.EMOJI_TYPE_CHAT)

	local var_1_0

	if not arg_1_1.time then
		var_1_0 = 3
	end

	arg_1_0.time = var_1_0

	local var_1_1

	if not arg_1_1.hideType then
		var_1_1 = var_0_1.HIDE_TYPE_IMMEDIATELY
	end

	arg_1_0.hideType = var_1_1

	local var_1_2

	if not arg_1_1.hideTime then
		var_1_2 = 0
	end

	arg_1_0.hideTime = var_1_2

	return
end

function var_0_1.ExistEmoji(arg_2_0)
	return arg_2_0.emoji ~= nil
end

function var_0_1.GetEmojiType(arg_3_0)
	return arg_3_0.emojiType
end

function var_0_1.GetEmoji(arg_4_0)
	return arg_4_0.emoji, arg_4_0.emojiType
end

function var_0_1.GetHideType(arg_5_0)
	return arg_5_0.hideType, arg_5_0.hideTime
end

function var_0_1.GetTime(arg_6_0)
	return arg_6_0.time
end

return var_0_1
