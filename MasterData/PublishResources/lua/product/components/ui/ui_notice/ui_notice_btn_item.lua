_class("UINoticeBtnItem", UICustomWidget)
UINoticeBtnItem = UINoticeBtnItem

function UINoticeBtnItem:OnShow(uiParams)
  self:AttachEvent(GameEventType.UINoticeItemClick, self.UINoticeItemClick)
  local loginModule = GameGlobal.GetModule(LoginModule)
  self._noticeData = loginModule:GetNoticeData()
  if self._noticeData == nil then
    Log.fatal("###noticedata -- notice data is nil !")
    return
  end
  self._isNew = false
end

function UINoticeBtnItem:SetData(idx, notice, callback)
  self:_GetComponents()
  self._idx = idx
  self._notice = notice
  self._callback = callback
  self._isCurrent = false
  self:_OnValue()
end

function UINoticeBtnItem:_GetComponents()
  self._select = self:GetGameObject("select")
  self._title = self:GetUIComponent("UILocalizationText", "name")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._newGo = self:GetGameObject("new")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UINoticeBtnItem:_OnValue()
  self._title:SetText(self._notice.Text_NoticeTitle)
  Log.debug("notice.TextInfo.NoticeTitle : ", self._notice.Text_NoticeTitle)
  self._isNew = self._noticeData:CheckNoticeNew(self._notice.NoticeId, self._notice.NoticeType)
  self._newGo:SetActive(self._isNew)
  local content = self._notice.Text_NoticeContent
  if not content then
    Log.error("###[UINoticeBtnItem] notice content is nil !")
    return
  else
    Log.debug("###[UINoticeBtnItem] notice content : ", content)
  end
  local str1 = string.sub(content, 1, 1)
  str1 = string.trim(str1)
  local str2 = string.sub(content, -1)
  str2 = string.trim(str2)
  local icon = ""
  if str1 == "{" and str2 == "}" then
    local tab = cjson.decode(content)
    if tab then
      icon = tab.icon
    else
      Log.fatal("###notice json decode fail ! content --> ", content)
    end
  else
    icon = "notice_20200602_icon4"
  end
  if string.isnullorempty(icon) == false then
    self._icon:LoadImage(icon)
  end
end

function UINoticeBtnItem:bgOnClick()
  if self._isCurrent then
    return
  end
  self._anim:Play("uieff_Notice_BtnItem_OnClick")
  if self._callback then
    self._callback(self._idx)
  end
end

function UINoticeBtnItem:UINoticeItemClick(currIdx, type)
  self._isCurrent = self._notice.NoticeType == type and self._idx == currIdx
  if type == self._notice.NoticeType and self._idx == currIdx and self._isNew then
    self._noticeData:CancelNoticeNew(self._notice.NoticeId, self._notice.NoticeType)
    self._isNew = false
    self._newGo:SetActive(self._isNew)
  end
end

function UINoticeBtnItem:OnHide()
  self:DetachEvent(GameEventType.UINoticeItemClick, self.UINoticeItemClick)
end
