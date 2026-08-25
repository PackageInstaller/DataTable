local AwakerToggleItem, Super = System.NewComponent("AwakerToggleItem")

function AwakerToggleItem:ctor(gameObj, avgRoleId, selectedAwaker, clickCallback)
  Super.ctor(self)
  self.ui = UI_Address_Item_AwakerResource(gameObj)
  self.avgRoleId = avgRoleId
  self.selectedAwaker = Vue.ref(selectedAwaker)
  self.clickCallback = clickCallback
end

function AwakerToggleItem:OnBind(binder)
  self.binder = binder
  self:SetAwakerIcon(self.avgRoleId)
  self:SetAwakerName(self.avgRoleId)
  self.binder:BindToVisible(self.ui.Image_Select, function()
    return self.selectedAwaker.value == self.avgRoleId
  end)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
end

function AwakerToggleItem:SetAwakerIcon(roleId, expression)
  local icon = AwakerChatDataUtils.GetChatRoleIcon(roleId, expression)
  self.binder:SetActive(self.ui.Image_Awaker, nil ~= icon)
  if icon then
    self.binder:SetImage(self.ui.Image_Awaker, icon)
  end
end

function AwakerToggleItem:SetAwakerName(roleId)
  local name = DT.AvgRole[roleId].RoleName
  self.binder:SetText(self.ui.Text_AwakerName, name)
end

function AwakerToggleItem:SetMessageContent(content)
  local content = AwakerChatDataUtils.TranslateContent(content)
  self.binder:SetText(self.ui.Text_Message, content)
end

function AwakerToggleItem:OnBtnClick()
  if self.clickCallback then
    self.clickCallback(self.avgRoleId)
  end
end

return AwakerToggleItem
