_class("ChatData", Object)
ChatData = ChatData

function ChatData:Constructor(id, messageType, message, emojiId, isSelf, date)
  self._id = id
  self._messageType = messageType
  self._message = message
  self._emojiId = emojiId
  self._isSelf = isSelf
  self._date = date
  self._isShowTime = false
  self:DecodeMessage()
end

function ChatData:GetId()
  return self._id
end

function ChatData:GetMessageType()
  return self._messageType
end

function ChatData:GetMessage()
  return self._message
end

function ChatData:GetEmojiId()
  return self._emojiId
end

function ChatData:GetDate()
  return self._date
end

function ChatData:GetDateStr()
  return TimeToDate(self._date, "min")
end

function ChatData:IsSelf()
  return self._isSelf
end

function ChatData:IsShowTime()
  return self._isShowTime
end

function ChatData:SetShowTimeStatus(status)
  self._isShowTime = status
end

function ChatData:EncodeMessage()
  self._message = string.gsub(self._message, "]", "CUSTOM_RIGHT_BIG_BRACKET_BAIYEJIGUANG")
end

function ChatData:DecodeMessage()
  self._message = string.gsub(self._message, "CUSTOM_RIGHT_BIG_BRACKET_BAIYEJIGUANG", "]")
end
