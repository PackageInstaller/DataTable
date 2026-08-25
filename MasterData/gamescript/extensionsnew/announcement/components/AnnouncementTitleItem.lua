local AnnouncementTitleItem, Super = NewViewComponent("AnnouncementTitleItem")

function AnnouncementTitleItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Login_Btn_NoticeResource(uiNode)
  self._data = data
end

function AnnouncementTitleItem:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnAnnouncementCurUidChanged, self._OnCurUidChanged, self)
end

function AnnouncementTitleItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Notice, System.fn(self, self._OnClick))
end

function AnnouncementTitleItem:OnEnterComponent()
  self:SetText(self.ui.Text_Introduce, LT.Text(self._data.title))
  local isImportant = self._data.important == AnnouncementDataUtils.VALUE_IMPORTANT
  self.ui.Prompt:SetActive(isImportant)
  self:_RefreshSelectedState()
  if self.ui.Red_Notice then
    self.view:AddRedPoint(self.ui.Red_Notice, RedDotDefine.DynamicRedDotID.AnnouncementNoticeItem, {
      uid = self._data.uid
    })
  end
end

function AnnouncementTitleItem:OnExitComponent()
  if self.view and self.ui.Red_Notice then
    self.view:RemoveRedPoint(self.ui.Red_Notice)
  end
  Super.OnExitComponent(self)
end

function AnnouncementTitleItem:_OnCurUidChanged()
  self:_RefreshSelectedState()
end

function AnnouncementTitleItem:_RefreshSelectedState()
  local currUid = AnnouncementModel.Instance:GetCurrUid()
  local isSelected = currUid == self._data.uid
  self.ui.Selected:SetActive(isSelected)
end

function AnnouncementTitleItem:_OnClick()
  AnnouncementModel.Instance:SetCurUid(self._data.uid)
  AnnouncementController.Instance:MarkAnnRead(self._data)
end

return AnnouncementTitleItem
