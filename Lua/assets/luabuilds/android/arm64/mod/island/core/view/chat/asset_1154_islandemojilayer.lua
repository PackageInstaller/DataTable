local IslandEmojiLayer = class("IslandEmojiLayer", import("view.common.EmojiLayer"))

function IslandEmojiLayer:getUIName()
	return "IslandEmojiUI"
end

function IslandEmojiLayer:SetTagText(arg_2_1, arg_2_2)
	IslandEmojiLayer.super.SetTagText(self, arg_2_1, arg_2_2)
	setText(arg_2_1:Find("Text_1"), i18n("emoji_type_" .. arg_2_2))

	return
end

return IslandEmojiLayer
