local HomeChatData = class("HomeChatData")

function HomeChatData:ctor()
  self.isSelf = false
  self.senderInfo = nil
  self.isSinglePicture = false
  self.content = nil
  self.singlePicResName = nil
  self.__uiLayoutHeight = 0
end

function HomeChatData.CreateChatData(isSelf, isSinglePicture, content, singlePicResName)
  local data = HomeChatData.New()
  data.isSelf = isSelf
  data.isSinglePicture = isSinglePicture
  data.content = content
  data.singlePicResName = singlePicResName
  return data
end

function HomeChatData:GetIsSinglePicture()
  return self.isSinglePicture
end

function HomeChatData:GetContent()
  return self.content
end

function HomeChatData:GetContent4Home()
  if self:GetIsSinglePicture() then
    return ConfigData:GetTipContent(TipContent.ChatemojiReplace)
  end
  return self.content
end

function HomeChatData:GetSinglePicResName()
  return self.singlePicResName
end

return HomeChatData
