local var_0_0 = class("IslandEmojiLayer", import("view.common.EmojiLayer"))

function var_0_0.getUIName(arg_1_0)
	return "IslandEmojiUI"
end

function var_0_0.SetTagText(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.SetTagText(arg_2_0, arg_2_1, arg_2_2)
	setText(arg_2_1:Find("Text_1"), i18n("emoji_type_" .. arg_2_2))

	return
end

return var_0_0
