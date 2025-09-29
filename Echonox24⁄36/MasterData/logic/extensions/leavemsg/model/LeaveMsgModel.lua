-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/model/LeaveMsgModel.lua

module("logic.extensions.leavemsg.model.LeaveMsgModel", package.seeall)

local M = class("LeaveMsgModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	return
end

function M:getCfgListChatEmoji()
	if not self._lstCfgEmoji then
		local cgfList = ChatConfig.instance:getAllEmojiCfgs()

		self._lstCfgEmoji = TableUtil.deepCopy(cgfList)

		table.insert(self._lstCfgEmoji, 1, {
			id = -1,
			name = "",
			icon = "chat_emoji_1001"
		})
	end

	return self._lstCfgEmoji
end

M.instance = M.New()

return M
