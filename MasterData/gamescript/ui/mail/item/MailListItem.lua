local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local CHAR_TRUNCATE_LANGS
local MailListItem, Super = System.NewComponent("MailListItem")

function MailListItem:ctor(obj, res, data, model, onClick, isSelectFunc)
  Super.ctor(self)
  self.ui = res(obj)
  self.data = data
  self.model = model
  self.onClick = onClick
  self.isSelectFunc = isSelectFunc
end

function MailListItem:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Mail, System.fn(self, self.OnClick))
  if not CHAR_TRUNCATE_LANGS then
    CHAR_TRUNCATE_LANGS = StrUtils.CHAR_TRUNCATE_LANGS
  end
  local langCode = DataCenter.gameData.CurrTextLanguage
  if CHAR_TRUNCATE_LANGS[langCode] then
    local textComp = self.ui.Text_Introduce:GetComponent(TYPEOF_TMP_Text)
    if textComp then
      textComp.overflowMode = CS.TMPro.TextOverflowModes.Ellipsis
    end
  end
  binder:BindToText(self.ui.Text_Introduce, function()
    do return self.model.GetMailListTitle, self.model end
    return self.model.GetMailListTitle, self.model, self.data.mailUid
  end)
  binder:BindToTextColor(self.ui.Text_Introduce, function()
    local hasRead = self.model:IsMailRead(self.data.mailUid)
    if hasRead then
      return CommonDefine.ColorType.Dark
    end
    return CommonDefine.ColorType.Light
  end)
  binder:BindToText(self.ui.Text_Detail, function()
    do return self.model.GetPublisher, self.model end
    return self.model.GetPublisher, self.model, self.data.mailUid
  end)
  binder:BindToTextColor(self.ui.Text_Detail, function()
    local hasRead = self.model:IsMailRead(self.data.mailUid)
    if hasRead then
      return CommonDefine.ColorType.Dark
    end
    return CommonDefine.ColorType.Light
  end)
  binder:BindToText(self.ui.Text_Date, function()
    do return self.model.GetLeftTime, self.model end
    return self.model.GetLeftTime, self.model, self.data.mailUid
  end)
  binder:BindToTextColor(self.ui.Text_Date, function()
    local hasRead = self.model:IsMailRead(self.data.mailUid)
    if hasRead then
      return CommonDefine.ColorType.Dark
    end
    return CommonDefine.ColorType.Light
  end)
  self.icon = self.ui.Image_Icon or self.ui.Prompt
  binder:BindToImage(self.icon, function()
    local cfg = self.model:GetMailConfig(self.data.cfgTid)
    local isMailRead = self.model:IsMailRead(self.data.mailUid)
    local promptImg
    if cfg and cfg.ListIcon then
      promptImg = cfg.ListIcon
    else
      promptImg = isMailRead and "UIResources/AtlasSource/UI_Mail_Image/icon_unread.png" or "UIResources/AtlasSource/UI_Mail_Image/icon_read.png"
    end
    return promptImg
  end)
  binder:BindToVisible(self.ui.Icon_Gift, function()
    do return self.model.CanReceiveAttachment, self.model end
    return self.model.CanReceiveAttachment, self.model, self.data.mailUid
  end)
  binder:BindToVisible(self.ui.Group_Mail_Bg_Nor, function()
    if self.data.collection then
      return true
    end
    return not self.model:IsMailRead(self.data.mailUid)
  end)
  binder:BindToVisible(self.ui.Group_Mail_Bg_Dis, function()
    if self.data.collection then
      return false
    end
    do return self.model.IsMailRead, self.model end
    return self.model.IsMailRead, self.model, self.data.mailUid
  end)
  binder:BindToVisible(self.ui.Selected, self.isSelectFunc)
  binder:BindToVisible(self.ui.Image_Unchecked, function()
    local isRead = self.model:IsMailRead(self.data.mailUid)
    return isRead
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, function()
    local isRead = self.model:IsMailRead(self.data.mailUid)
    return not isRead
  end))
end

function MailListItem:OnClick()
  print("[t] On Click ========= mailUid, onclick, data:", self.data and self.data.mailUid, self.onClick, table.tostring(self.data))
  if not (self.data and self.data.mailUid) or not self.onClick then
    return
  end
  self.onClick(self.data.mailUid)
end

return MailListItem
