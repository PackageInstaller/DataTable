local MailListItemComp, Super = NewViewComponent("MailListItemComp")

function MailListItemComp:ctor(uiNode, view, mailData, isSelected, clickCb)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Btn_MailResource(uiNode)
  self._mailData = mailData
  self._isSelected = isSelected or false
  self._clickCb = clickCb
end

function MailListItemComp:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnChangeMailData, self._RefreshAll, self)
end

function MailListItemComp:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mail, System.fn(self, self._OnClick))
end

function MailListItemComp:OnEnterComponent()
  self:_RefreshAll()
end

function MailListItemComp:_RefreshAll()
  if not self.view then
    return
  end
  local mailUid = self._mailData:GetMailUid()
  local model = MailModel.Instance
  self:SetText(self.ui.Text_Introduce, model:GetMailTitle(mailUid))
  self:SetText(self.ui.Text_Detail, model:GetPublisher(mailUid))
  self:SetText(self.ui.Text_Date, model:GetLeftTime(mailUid))
  local hasRead = model:IsMailRead(mailUid)
  local colorType = hasRead and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
  self:SetTextColorType(self.ui.Text_Introduce, colorType)
  self:SetTextColorType(self.ui.Text_Detail, colorType)
  self:SetTextColorType(self.ui.Text_Date, colorType)
  local iconNode = self.ui.Image_Icon or self.ui.Prompt
  local cfg = model:GetMailConfig(self._mailData:GetCfgTid())
  local promptImg
  if cfg and cfg.ListIcon then
    promptImg = cfg.ListIcon
  else
    promptImg = hasRead and CommonRes.MailReadIcon or CommonRes.MailUnreadIcon
  end
  self:SetImage(iconNode, promptImg)
  self.ui.Icon_Gift:SetActive(model:CanReceiveAttachment(mailUid))
  local isCollection = self._mailData:IsCollection()
  self.ui.Group_Mail_Bg_Nor:SetActive(isCollection or not hasRead)
  self.ui.Group_Mail_Bg_Dis:SetActive(not isCollection and hasRead)
  self.ui.Selected:SetActive(self._isSelected)
  self.ui.Image_Unchecked:SetActive(hasRead)
  self:_RefreshRedDot()
end

function MailListItemComp:_RefreshRedDot()
  self.view:AddRedPoint(self.ui.Com_RedDot, RedDotDefine.DynamicRedDotID.MailItemUnread, {
    mailUid = self._mailData:GetMailUid()
  })
end

function MailListItemComp:_OnClick()
  if not self._mailData or not self._clickCb then
    return
  end
  self._clickCb(self._mailData:GetMailUid())
end

function MailListItemComp:Refresh(mailData, isSelected)
  self._mailData = mailData
  self._isSelected = isSelected or false
  self:_RefreshAll()
end

function MailListItemComp:SetSelected(isSelected)
  self._isSelected = isSelected
  self.ui.Selected:SetActive(isSelected)
end

return MailListItemComp
