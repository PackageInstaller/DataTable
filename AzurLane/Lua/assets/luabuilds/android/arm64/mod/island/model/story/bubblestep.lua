local var_0_0 = class("BubbleStep", import(".IslandBaseStep"))

var_0_0.HIDE_TYPE_IMMEDIATELY = 0
var_0_0.HIDE_TYPE_NEVER = 1
var_0_0.HIDE_TYPE_TIME = 2
var_0_0.EMOJI_TYPE_CHAT = 1
var_0_0.EMOJI_TYPE_EXPRESSION = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.emoji = arg_1_1.emoji
	arg_1_0.emojiType = defaultValue(arg_1_1.emojiType, var_0_0.EMOJI_TYPE_CHAT)
	arg_1_0.time = arg_1_1.time or 3
	arg_1_0.hideType = arg_1_1.hideType or var_0_0.HIDE_TYPE_IMMEDIATELY
	arg_1_0.hideTime = arg_1_1.hideTime or 0

	return
end

function var_0_0.ExistEmoji(arg_2_0)
	return arg_2_0.emoji ~= nil
end

function var_0_0.GetEmojiType(arg_3_0)
	return arg_3_0.emojiType
end

function var_0_0.GetEmoji(arg_4_0)
	return arg_4_0.emoji, arg_4_0.emojiType
end

function var_0_0.GetHideType(arg_5_0)
	return arg_5_0.hideType, arg_5_0.hideTime
end

function var_0_0.GetTime(arg_6_0)
	return arg_6_0.time
end

return var_0_0
