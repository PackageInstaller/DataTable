local AwakerMessageItem, Super = System.NewComponent("AwakerMessageItem")

function AwakerMessageItem:ctor(gameObj, chatId, clickCallback)
  Super.ctor(self)
  self.ui = UI_Address_Item_NewMessageResource(gameObj)
  self.chatId = chatId
  self.clickCallback = clickCallback
end

function AwakerMessageItem:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Message)
  local data = AwakerChatDataUtils.GetFirstLineData(self.chatId)
  if data.Awaker then
    local awakerId = data.Awaker
    local awakerIcon = AwakerDataUtils.GetLittleIcon(awakerId, true)
    if awakerIcon then
      self.binder:SetImage(self.ui.Image_Awaker, awakerIcon)
    end
    self:SetAwakerName(awakerId)
  elseif data.ContactRole and data.ContactRole[1] then
    local avgRoleId = data.ContactRole[1]
    local avgRoleCfg = DT.AvgRole[avgRoleId]
    if avgRoleCfg then
      self.binder:SetText(self.ui.Text_AwakerName, avgRoleCfg.RoleName)
      local icon = PortraitUtils.GetMiniHead(avgRoleCfg.AwakerResource)
      self.binder:SetImage(self.ui.Image_Awaker, icon)
    end
  end
  self:SetMessageContent(data.Content, data.Emoji)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
  binder:BindToVisible(self.ui.Image_RedDot, function()
    local history = AwakerChatDataUtils.GetSavedChatList(self.chatId)
    return 0 == #history
  end)
  binder:BindToVisible(self.ui.Image_Dialog, function()
    local history = AwakerChatDataUtils.GetSavedChatList(self.chatId)
    return #history > 0
  end)
end

function AwakerMessageItem:SetAwakerName(roleId)
  local cfg = AwakerDataUtils.GetAwakerConfig(roleId)
  self.binder:SetText(self.ui.Text_AwakerName, cfg.Name)
end

function AwakerMessageItem:SetMessageContent(content, emoji)
  local displayContent = AwakerChatDataUtils.TranslateContent(content)
  if string.isempty(displayContent) and emoji then
    local itemCfg = DT.Item[emoji]
    displayContent = "[" .. LT.Text(itemCfg.EmojiName) .. "]"
  end
  self.binder:SetText(self.ui.Text_Message, displayContent)
end

function AwakerMessageItem:OnBtnClick()
  if self.clickCallback then
    self.clickCallback()
  end
end

return AwakerMessageItem
