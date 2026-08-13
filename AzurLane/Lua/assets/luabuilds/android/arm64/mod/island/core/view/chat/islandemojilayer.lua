class = var_0_10000

local var_0_0 = "IslandEmojiLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.common.EmojiLayer"))

function var_0_1.getUIName(arg_1_0)
	return "IslandEmojiUI"
end

function var_0_1.SetTagText(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetTagText(arg_2_0, arg_2_1, arg_2_2)

	setText = var_3

	local var_2_0 = arg_2_1:Find("Text_1")

	i18n = var_6

	var_3(var_2_0, var_6("emoji_type_" .. arg_2_2))

	return
end

return var_0_1
