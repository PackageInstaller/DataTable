local AnnouncementTitleComponent, Super = System.NewComponent("AnnouncementTitleComponent")

function AnnouncementTitleComponent:ctor(uiNode, data, model)
  Super.ctor(self)
  self.ui = UI_Login_Btn_NoticeResource(uiNode)
  self.data = data
  self.model = model
end

function AnnouncementTitleComponent:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Introduce, LT.Text(self.data.title))
  binder:BindButtonClick(self.ui.Btn_Notice, System.fn(self, self.OnClick))
  binder:BindToVisible(self.ui.Selected, function()
    if not self.model then
      return false
    end
    return self.model.currUid == self.data.uid
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, function()
    local data = AnnouncementRedUtils.GetNoticeRedData(self.data.uid)
    local state = RedPointDataUtils.ShowRedPointState(data)
    return state
  end))
  binder:BindToVisible(self.ui.Prompt, System.fn(self, self._IsImportant))
end

function AnnouncementTitleComponent:_IsImportant()
  return self.data.important == AnnouncementDataUtils.VALUE_IMPORTANT
end

function AnnouncementTitleComponent:SetText(content)
  for _, item in ipairs({
    "Text_High_CN",
    "Text_Normal_CN",
    "Text_Disabled_CN"
  }) do
    local textGameObj = self.ui[item]
    if textGameObj then
      self.binder:SetText(textGameObj, LT.Text(content, true))
    end
  end
end

function AnnouncementTitleComponent:OnClick()
  if not self.model then
    return
  end
  self.model:SetCurUid(self.data.uid)
  if not self.data.new then
    return
  end
  SdkMgr.Instance:RemoveNoticeRed(self.data.annType, self.data.uid, function()
    AnnouncementRedUtils.RemoveRedData(self.data)
  end)
end

return AnnouncementTitleComponent
