local AwakerChatOptionComp, Super = System.NewComponent("AwakerChatOptionComp")

function AwakerChatOptionComp:ctor(gameObj, chatId, options, clickCallback)
  Super.ctor(self)
  self.ui = UI_Address_Panel_DialogResource(gameObj)
  self.chatId = chatId
  self.options = Vue.ref(options)
  self.clickCallback = clickCallback
end

function AwakerChatOptionComp:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Toggle_Option_Message, function()
    local isText = self:IsTextOption(1)
    return isText
  end)
  binder:BindToVisible(self.ui.Toggle_Option_Emoji, function()
    local isEmoji = self:IsEmojOption(1)
    return isEmoji
  end)
  for i = 1, 3 do
    binder:BindToRaw(function(cbinder, optionIndex)
      self:BindTextOption(cbinder, self.ui["UI_Address_Option_Message" .. i], i, optionIndex)
      self:BindEmojOption(cbinder, self.ui["UI_Address_Option_Emoji" .. i], i, optionIndex)
    end, function()
      return self.options.value[i]
    end)
  end
end

function AwakerChatOptionComp:BindTextOption(cbinder, gameObj, index, optionIndex)
  if not self:IsTextOption(index) then
    gameObj:SetActive(false)
    return
  end
  gameObj:SetActive(true)
  local res = UI_Address_Option_MessageResource(gameObj)
  res.Image_Select:SetActive(false)
  cbinder:BindButtonClick(gameObj, function()
    res.Image_Select:SetActive(true)
    self.clickCallback(optionIndex)
  end)
  local data = AwakerChatDataUtils.GetLineData(self.chatId, optionIndex)
  cbinder:SetText(res.Text_Option, AwakerChatDataUtils.TranslateContent(data.Option))
end

function AwakerChatOptionComp:BindEmojOption(cbinder, gameObj, index, optionIndex)
  if not self:IsEmojOption(index) then
    gameObj:SetActive(false)
    return
  end
  gameObj:SetActive(true)
  local res = UI_Address_Option_EmojiResource(gameObj)
  res.Image_Select:SetActive(false)
  cbinder:BindButtonClick(gameObj, function()
    res.Image_Select:SetActive(true)
    self.clickCallback(optionIndex)
  end)
  local data = AwakerChatDataUtils.GetLineData(self.chatId, optionIndex)
  local emoj = data.Emoji
  if emoj then
    cbinder:SetImage(res.Option_Emoji, ItemDataUtils.GetIcon(emoj))
  end
end

function AwakerChatOptionComp:IsTextOption(index)
  local optionIndex = self.options.value[index or 1]
  if optionIndex then
    local lineInfo = AwakerChatDataUtils.GetLineData(self.chatId, optionIndex)
    return lineInfo.Emoji == nil
  end
end

function AwakerChatOptionComp:IsEmojOption(index)
  local optionIndex = self.options.value[index or 1]
  if optionIndex then
    local lineInfo = AwakerChatDataUtils.GetLineData(self.chatId, optionIndex)
    return lineInfo.Emoji ~= nil
  end
end

return AwakerChatOptionComp
