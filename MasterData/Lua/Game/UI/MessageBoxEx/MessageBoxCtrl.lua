local MessageBoxCtrl = class("MessageBoxCtrl", BaseCtrl)
MessageBoxCtrl._mapNodeConfig = {
  aniBlur = {sComponentName = "Animator"},
  aniBlur2 = {sComponentName = "Animator"},
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnBlur2 = {
    sNodeName = "snapshot2",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  MessageBox = {
    sNodeName = "--MessageBox--"
  },
  ctrlBox = {
    sNodeName = "--MessageBox--",
    sCtrlName = "Game.UI.MessageBoxEx.MessageBoxCommonCtrl"
  },
  DescBox = {
    sNodeName = "--DescBox--"
  },
  ctrlDesc = {
    sNodeName = "--DescBox--",
    sCtrlName = "Game.UI.MessageBoxEx.MessageBoxDescCtrl"
  },
  ItemBox = {
    sNodeName = "--ItemBox--"
  },
  ctrlItem = {
    sNodeName = "--ItemBox--",
    sCtrlName = "Game.UI.MessageBoxEx.MessageBoxItemCtrl"
  },
  ItemList = {
    sNodeName = "--ItemList--"
  },
  ctrlItemList = {
    sNodeName = "--ItemList--",
    sCtrlName = "Game.UI.MessageBoxEx.MessageBoxItemListCtrl"
  },
  PlainText = {
    sNodeName = "--PlainText--"
  },
  ctrlPlainText = {
    sNodeName = "--PlainText--",
    sCtrlName = "Game.UI.MessageBoxEx.MessageBoxPlainTextCtrl"
  },
  CharBox = {
    sNodeName = "--CharBox--"
  },
  ctrlCharBox = {
    sNodeName = "--CharBox--",
    sCtrlName = "Game.UI.MessageBoxEx.MessageBoxCharBoxCtrl"
  }
}
MessageBoxCtrl._mapEventConfig = {
  ContinueMessageBox = "ProcessParam"
}

function MessageBoxCtrl:ProcessParam(mapMsg)
  table.insert(self.tbQueue, mapMsg)
  self:OpenQueue()
end

function MessageBoxCtrl:OpenQueue()
  if self.bOpening == false then
    self.bOpening = true
    local bChangeType = false
    self.nCurType = self.tbQueue[1].nType
    if not self.nBeforeType or self.nBeforeType ~= self.nCurType then
      bChangeType = true
    end
    if bChangeType then
      self._mapNode.MessageBox:SetActive(self.nCurType == AllEnum.MessageBox.Alert or self.nCurType == AllEnum.MessageBox.Confirm)
      self._mapNode.DescBox:SetActive(self.nCurType == AllEnum.MessageBox.Desc)
      self._mapNode.ItemBox:SetActive(self.nCurType == AllEnum.MessageBox.Item)
      self._mapNode.ItemList:SetActive(self.nCurType == AllEnum.MessageBox.ItemList)
      self._mapNode.PlainText:SetActive(self.nCurType == AllEnum.MessageBox.PlainText)
      self._mapNode.CharBox:SetActive(self.nCurType == AllEnum.MessageBox.Char)
    end
    if self.nCurType == AllEnum.MessageBox.Alert or self.nCurType == AllEnum.MessageBox.Confirm then
      self._mapNode.ctrlBox:OpenBox(self.tbQueue[1], self)
    elseif self.nCurType == AllEnum.MessageBox.Desc then
      self._mapNode.ctrlDesc:OpenBox(self.tbQueue[1], self)
    elseif self.nCurType == AllEnum.MessageBox.Item then
      self._mapNode.ctrlItem:OpenBox(self.tbQueue[1], self)
    elseif self.nCurType == AllEnum.MessageBox.ItemList then
      self._mapNode.ctrlItemList:OpenBox(self.tbQueue[1], self)
    elseif self.nCurType == AllEnum.MessageBox.PlainText then
      self._mapNode.ctrlPlainText:OpenBox(self.tbQueue[1], self)
    elseif self.nCurType == AllEnum.MessageBox.Char then
      self._mapNode.ctrlCharBox:OpenBox(self.tbQueue[1], self)
    end
    self.nBeforeType = self.nCurType
  end
end

function MessageBoxCtrl:CloseMessageBox(callback, callbackAfterClose)
  if callback then
    callback()
  end
  if #self.tbQueue == 0 then
    if self._panel.bBlur then
      self._mapNode.aniBlur:SetTrigger("tOut")
      self:AddTimer(1, 0.1, function()
        EventManager.Hit(EventId.CloseMessageBox)
        if callbackAfterClose then
          callbackAfterClose()
        end
      end, true, true, true)
    else
      self._mapNode.aniBlur2.gameObject:SetActive(false)
      EventManager.Hit(EventId.CloseMessageBox)
      if callbackAfterClose then
        callbackAfterClose()
      end
    end
  else
    self:ReOpenQueue()
  end
end

function MessageBoxCtrl:ReOpenQueue(_, callback)
  if callback then
    callback()
  end
  self.bOpening = false
  self:OpenQueue()
end

function MessageBoxCtrl:DefaultClick(callback, callbackAfterClose)
  table.remove(self.tbQueue, 1)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  if #self.tbQueue == 0 then
    if self._panel.bBlur then
      self:AddTimer(1, 0.2, function()
        self:CloseMessageBox(callback, callbackAfterClose)
      end, true, true, true)
    else
      self:CloseMessageBox(callback, callbackAfterClose)
    end
  else
    self:AddTimer(1, 0.2, "ReOpenQueue", true, true, true, callback)
  end
end

function MessageBoxCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
end

function MessageBoxCtrl:OnEnable()
  self._panel:SetTop(self.canvas)
  self.tbQueue = {}
  self.bOpening = false
  self.nBeforeType = nil
  local mapMsg = self:GetPanelParam()
  if mapMsg.bBlur ~= nil then
    self._panel.bBlur = mapMsg.bBlur
  end
  self._mapNode.aniBlur.gameObject:SetActive(self._panel.bBlur == true)
  self._mapNode.aniBlur2.gameObject:SetActive(self._panel.bBlur == false)
  self:ProcessParam(mapMsg)
end

function MessageBoxCtrl:OnDisable()
  self.tbQueue = nil
  self.bOpening = false
  self.nBeforeType = nil
end

function MessageBoxCtrl:OnDestroy()
end

function MessageBoxCtrl:OnBtnClick_Close()
  if self.nCurType == AllEnum.MessageBox.Alert or self.nCurType == AllEnum.MessageBox.Confirm then
    self._mapNode.ctrlBox:Close()
  elseif self.nCurType == AllEnum.MessageBox.Desc then
    self._mapNode.ctrlDesc:Close()
  elseif self.nCurType == AllEnum.MessageBox.Item then
    self._mapNode.ctrlItem:Close()
  elseif self.nCurType == AllEnum.MessageBox.ItemList then
    self._mapNode.ctrlItemList:Close()
  elseif self.nCurType == AllEnum.MessageBox.PlainText then
    self._mapNode.ctrlPlainText:Close()
  elseif self.nCurType == AllEnum.MessageBox.Char then
    self._mapNode.ctrlCharBox:Close()
  end
end

return MessageBoxCtrl
