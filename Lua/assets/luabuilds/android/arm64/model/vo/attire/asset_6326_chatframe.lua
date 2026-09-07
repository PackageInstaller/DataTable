local ChatFrame = class("ChatFrame", import(".AttireFrame"))

function ChatFrame:GetIcon()
	return "ChatFrame/" .. self
end

function ChatFrame:getType()
	return AttireConst.TYPE_CHAT_FRAME
end

function ChatFrame:bindConfigTable()
	return pg.item_data_chat
end

function ChatFrame:getPrefabName()
	if self:getConfig("id") == 0 then
		return self:getConfig("id") .. "_self"
	else
		return self:getConfig("id") .. "_self"
	end

	return
end

function ChatFrame:getDropType()
	return DROP_TYPE_CHAT_FRAME
end

function ChatFrame:getIcon()
	return ChatFrame.GetIcon(self:getPrefabName())
end

return ChatFrame
