-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/util/ChatUtil.lua

module("logic.extensions.chat.util.ChatUtil", package.seeall)

local ChatUtil = class("ChatUtil")

local function utf8CharSize(char)
	if not char then
		return 0
	elseif char > 240 then
		return 4
	elseif char > 225 then
		return 3
	elseif char > 192 then
		return 2
	else
		return 1
	end
end

local function utf8str(str, start_index, end_index)
	local startByte = 1

	while start_index > 1 do
		local char = string.byte(str, startByte)

		startByte = startByte + utf8CharSize(char)
		start_index = start_index - 1
	end

	local endByte = 1

	while end_index > 0 do
		local char = string.byte(str, endByte)

		endByte = endByte + utf8CharSize(char)
		end_index = end_index - 1
	end

	endByte = endByte - 1

	return str:sub(startByte, endByte)
end

function ChatUtil.adaptForFixedWidth(txtComp, content, maxWidth, cutCount)
	cutCount = cutCount or 1
	maxWidth = maxWidth or goutil.getWidth(txtComp.gameObject.transform)
	content = string.gsub(content, "%s+", "")

	local str_length = string.utf8len(content)

	for index = 1, str_length do
		local substring = utf8str(content, 1, index)

		if index < str_length then
			substring = substring .. "..."
		end

		txtComp.text = substring

		if maxWidth < txtComp.preferredWidth then
			txtComp.text = utf8str(content, 1, index - cutCount) .. "..."

			break
		end
	end
end

local function _getLastMsgTime(friendMo)
	local channelType = GameEnum.ChannelTypeEnum.Friend
	local msgMo = ChatModel.instance:getLastMsg(channelType, friendMo:getUserId())

	if not msgMo then
		return 0
	else
		return msgMo:getTime()
	end
end

function ChatUtil.chatFriendSortFunc(friendMo1, friendMo2)
	local lastLoginTime1 = friendMo1:getLastLoginTime()
	local lastLoginTime2 = friendMo2:getLastLoginTime()

	if _getLastMsgTime(friendMo1) ~= _getLastMsgTime(friendMo2) then
		return _getLastMsgTime(friendMo1) > _getLastMsgTime(friendMo2)
	elseif lastLoginTime1 * lastLoginTime2 == 0 and lastLoginTime1 + lastLoginTime2 > 0 then
		return lastLoginTime1 < lastLoginTime2
	else
		return lastLoginTime2 < lastLoginTime1
	end
end

ChatUtil.instance = ChatUtil.New()

return ChatUtil
