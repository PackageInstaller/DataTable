-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResRoleChatBubble.lua

local RT = {}

RT[1] = {
	255,
	255,
	255
}

local Data = {
	[840000] = {
		picture_name = "ChatBubble00",
		id = 840000,
		picture_path = "ChatBubbleAtlas01",
		color = RT[1],
		desc = Lang.get(107791),
		name = Lang.get(107791)
	},
	[840001] = {
		effect_path = "System/PlayerInfor/PlayerChatBubble/ChatBubbleDec01",
		picture_name = "ChatBubble01",
		id = 840001,
		picture_path = "ChatBubbleAtlas01",
		color = RT[1],
		desc = Lang.get(117964),
		name = Lang.get(108045)
	},
	[840002] = {
		picture_name = "ChatBubble02",
		id = 840002,
		picture_path = "ChatBubbleAtlas01",
		color = RT[1],
		desc = Lang.get(117964),
		name = Lang.get(114877)
	},
	[840003] = {
		picture_name = "ChatBubble03",
		id = 840003,
		picture_path = "ChatBubbleAtlas01",
		color = RT[1],
		desc = Lang.get(117964),
		name = Lang.get(117919)
	}
}

return Data
