local AwakerChatMainPanel, Super = System.NewClass("AwakerChatMainPanel", UIBasePanel)
AwakerChatMainPanel.uiResCls = UI_Address_Panel_MainResource

function AwakerChatMainPanel:ctor(storyId, chatId)
  Super.ctor(self)
  self.selectedAwaker = Vue.ref(nil)
end

function AwakerChatMainPanel:OnBind(binder)
  self.binder = binder
  self:InitCloseBtn()
  self:CreateChatAwakerTableView()
  self:CreateMessageTableView()
  self:SetShowMessage(false)
  self:RefreshAwakerList()
end

function AwakerChatMainPanel:SetShowMessage(isShow)
  self.ui.Message_Info:SetActive(isShow)
  self.ui.Group_Null:SetActive(not isShow)
end

function AwakerChatMainPanel:RefreshAwakerList()
  self.avgRoleList = AwakerChatDataUtils.GetChatAwakerList()
  self.awakerTableView:ReloadData()
end

function AwakerChatMainPanel:ShowAwakerMessage(avgRoleId)
  self:SetShowMessage(true)
  self.selectedAwaker.value = avgRoleId
  self:SetAwakerInfo(avgRoleId)
  self:RefreshMessageList(avgRoleId)
end

function AwakerChatMainPanel:SetAwakerInfo(roleId)
  local name = AwakerChatDataUtils.GetChatName(roleId)
  self.binder:SetText(self.ui.Text_AwakerName, name)
  local sign = AwakerChatDataUtils.GetChatSign(roleId)
  self.binder:SetText(self.ui.Text_Slogan, sign)
  if not self.awakerPortraitComp then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Root_Awaker, roleId, nil, nil, portraitAlign, nil))
  else
    self.awakerPortraitComp:ChangeAwakerTid(roleId)
  end
end

function AwakerChatMainPanel:RefreshMessageList(roleId)
  self.messageList = AwakerChatDataUtils.GetAwakerCompleteDialogs(roleId)
  self.messageTableView:ReloadData()
end

function AwakerChatMainPanel:CreateChatAwakerTableView()
  local baseGameObj = self.ui.UI_Address_Item_Awaker
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.awakerTableView = self:CreateTableview(self.ui.ScrollView_Awaker, function()
    return #(self.avgRoleList or {})
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local avgRoleId = self.avgRoleList[idx]
    
    local function clickCb()
      self:ShowAwakerMessage(avgRoleId)
    end
    
    itemComps[gameObj] = self.binder:BindComponent(AwakerToggleItem(gameObj, avgRoleId, self.selectedAwaker, clickCb))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function AwakerChatMainPanel:CreateMessageTableView()
  local baseGameObj = self.ui.UI_Address_Item_Message
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.messageTableView = self:CreateTableview(self.ui.ScrollView_Message, function()
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
      UIManager.Instance:Reopen(Urls.AwakerChatPanel, chatId)
    end
    
    itemComps[gameObj] = self.binder:BindComponent(AwakerMessageTittleItem(gameObj, chatId, clickCb))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function AwakerChatMainPanel:InitCloseBtn()
  self.closeBtn = self.binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
end

return AwakerChatMainPanel
