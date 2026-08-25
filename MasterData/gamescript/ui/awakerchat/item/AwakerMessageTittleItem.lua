local AwakerMessageTittleItem, Super = System.NewComponent("AwakerMessageTittleItem")

function AwakerMessageTittleItem:ctor(gameObj, chatId, clickCallback)
  Super.ctor(self)
  self.ui = UI_Address_Item_MessageResource(gameObj)
  self.chatId = chatId
  self.clickCallback = clickCallback
end

function AwakerMessageTittleItem:OnBind(binder)
  self.binder = binder
  local lineInfo = AwakerChatDataUtils.GetEndLineData(self.chatId)
  local content = AwakerChatDataUtils.TranslateContent(lineInfo.Content)
  if string.isempty(content) and lineInfo.Emoji then
    local itemCfg = DT.Item[lineInfo.Emoji]
    content = "[" .. LT.Text(itemCfg.EmojiName) .. "]"
  end
  binder:SetText(self.ui.Text_Message, content)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
end

function AwakerMessageTittleItem:OnBtnClick()
  if self.clickCallback then
    self.clickCallback(self.awakerId)
  end
end

return AwakerMessageTittleItem
