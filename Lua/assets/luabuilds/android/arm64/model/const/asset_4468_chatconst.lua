local ChatConst = class("ChatConst")

ChatConst.CODE_BANED = 100
ChatConst.CODE_ACTOBSS_MSG_WORD = 1000
ChatConst.ChannelAll = 1
ChatConst.ChannelWorld = 2
ChatConst.ChannelPublic = 3
ChatConst.ChannelFriend = 4
ChatConst.ChannelGuild = 5
ChatConst.ChannelWorldBoss = 6
ChatConst.ChannelIsland = 7
ChatConst.ChannelPlayRoom = 8
ChatConst.SendChannels = {
	ChatConst.ChannelWorld,
	ChatConst.ChannelGuild
}
ChatConst.RecvChannels = {
	ChatConst.ChannelAll,
	ChatConst.ChannelWorld,
	ChatConst.ChannelPublic,
	ChatConst.ChannelFriend,
	ChatConst.ChannelGuild,
	ChatConst.ChannelWorldBoss
}

function ChatConst:GetChannelName()
	return i18n("channel_name_" .. self)
end

function ChatConst:GetChannelSprite()
	return switch(self, {
		[ChatConst.ChannelWorld] = function()
			return "world"
		end,
		[ChatConst.ChannelPublic] = function()
			return "public"
		end,
		[ChatConst.ChannelFriend] = function()
			return "friend"
		end,
		[ChatConst.ChannelGuild] = function()
			return "guild"
		end,
		[ChatConst.ChannelAll] = function()
			return "total"
		end,
		[ChatConst.ChannelWorldBoss] = function()
			return "worldboss"
		end,
		[ChatConst.ChannelIsland] = function()
			return "island"
		end,
		[ChatConst.ChannelPlayRoom] = function()
			return "room"
		end
	}, function()
		assert(false)

		return
	end)
end

ChatConst.EmojiCommon = 0
ChatConst.EmojiDefault = 1
ChatConst.EmojiAnimate = 2
ChatConst.EmojiPixel = 3
ChatConst.EmojiIcon = 4
ChatConst.EmojiTypes = {
	ChatConst.EmojiCommon,
	ChatConst.EmojiDefault,
	ChatConst.EmojiAnimate,
	ChatConst.EmojiPixel,
	ChatConst.EmojiIcon
}

function ChatConst:GetEmojiSprite()
	if self == ChatConst.EmojiCommon then
		return "tab_casual"
	elseif self == ChatConst.EmojiDefault then
		return "tab_default"
	elseif self == ChatConst.EmojiAnimate then
		return "tab_motive"
	elseif self == ChatConst.EmojiPixel then
		return "tab_pixel"
	end

	assert(false)

	return
end

ChatConst.EmojiCode = "{777#code#777}"
ChatConst.EmojiCodeMatch = "{777#(%d+)#777}"
ChatConst.EmojiIconCode = "#code#"
ChatConst.EmojiIconCodeMatch = "#(%d+)#"
ChatConst.EMOJI_SAVE_TAG = "emoji_regular_used_"
ChatConst.EMOJI_ICON_SAVE_TAG = "emoji_icon_regular_used_"

return ChatConst
