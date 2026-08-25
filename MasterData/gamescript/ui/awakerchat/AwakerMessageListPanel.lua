local AwakerMessageListPanel, Super = System.NewClass("AwakerMessageListPanel", UIBasePanel)
AwakerMessageListPanel.uiResCls = UI_Address_Panel_NewMessageResource

function AwakerMessageListPanel:ctor(storyId, chatId)
  Super.ctor(self)
end

function AwakerMessageListPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Dialogs, System.fn(self, self.OnBtnConfirm))
  binder:BindToVisible(self.ui.Btn_Dialogs, function()
    do return end
    return AwakerChatDataUtils.IsHaveCompletedDialogs, nil
  end)
  self:CreateMessageTable()
  self:RefreshMessage()
  binder:BindEvent(EventMgr.Instance.OnFinishAwakerChat, System.fn(self, self.RefreshMessage))
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.L,
    maskClickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_L, commonPopupConfirmTipsData))
end

function AwakerMessageListPanel:OnBtnConfirm()
  AwakerChatDataUtils.OpenMainChatPanel()
end

function AwakerMessageListPanel:OnOpenChat(chatId)
  UIManager.Instance:Reopen(Urls.AwakerChatPanel, chatId)
end

function AwakerMessageListPanel:RefreshMessage()
  self.messageList = AwakerChatDataUtils.GetRecentMessageList()
  table.sort(self.messageList, function(chatIdA, chatIdB)
    local pushedTimeA = AwakerChatDataUtils.GetPushedTime(chatIdA)
    local pushedTimeB = AwakerChatDataUtils.GetPushedTime(chatIdB)
    if pushedTimeA ~= pushedTimeB then
      return pushedTimeA > pushedTimeB
    end
    return chatIdA < chatIdB
  end)
  self.ui.Group_Null_Black:SetActive(#self.messageList <= 0)
  self.messageTableView:ReloadData()
end

function AwakerMessageListPanel:CreateMessageTable()
  local baseGameObj = self.ui.UI_Address_Item_NewMessage
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.messageTableView = self:CreateTableview(self.ui.Scroll_Message, function()
    return #(self.messageList or {})
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local chatId = self.messageList[idx]
    
    local function clickCb()
      self:OnOpenChat(chatId)
    end
    
    itemComps[gameObj] = self.binder:BindComponent(AwakerMessageItem(gameObj, chatId, clickCb))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

return AwakerMessageListPanel
