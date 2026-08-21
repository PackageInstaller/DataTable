_class("UINoticeDetailImgTex", UICustomWidget)
UINoticeDetailImgTex = UINoticeDetailImgTex

function UINoticeDetailImgTex:OnShow(uiParams)
  self._title = self:GetUIComponent("UIRichText", "title")
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UINoticeDetailImgTex:Constructor()
  self._first = true
end

function UINoticeDetailImgTex:SetData(noticeInfo)
  local content = self:GetUIComponent("RectTransform", "Content")
  content.anchoredPosition = Vector2(content.anchoredPosition.x, 0)
  local tab = cjson.decode(noticeInfo.Text_NoticeContent)
  if tab then
    self._title:SetText(tab.title)
    
    function self._title.onHrefClick(hrefName)
      SDKProxy:GetInstance():OpenUrl(hrefName)
    end
    
    self._notices = tab.notices
    if self._first then
      self._itemPool:SpawnObjects("UINoticeDetailImgTexItem", #self._notices)
      self._items = self._itemPool:GetAllSpawnList()
      for i = 1, #self._notices do
        self._items[i]:SetData(self._notices[i])
      end
      self._first = false
    else
      self._itemPool:SpawnObjects("UINoticeDetailImgTexItem", #self._notices)
      self._items = self._itemPool:GetAllSpawnList()
      for i = 1, #self._notices do
        if self._items[i] then
          self._items[i]:SetData(self._notices[i])
        end
      end
    end
  else
    Log.fatal("###notice json decode fail ! content --> ", noticeInfo.Text_NoticeContent)
  end
  Log.debug("###[UINoticeDetailImgTex] 刷新公告布局")
  self:Lock("RefreshNoticeLayout")
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.Timer():AddEvent(1, function()
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(content)
    self:UnLock("RefreshNoticeLayout")
  end)
end

function UINoticeDetailImgTex:AnimFade()
  self._anim:Play("uieff_Notice_DetailImgTex_Fade")
end

function UINoticeDetailImgTex:AnimShow()
  self._anim:Play("uieff_Notice_DetailImgTex_Show")
end

function UINoticeDetailImgTex:OnHide()
  self._title = nil
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UINoticeDetailImgTex:_InitScrollView()
  self._noticesScrollView:InitListView(#self._notices, function(scrollView, index)
    return self:InitListItem(scrollView, index)
  end)
end

function UINoticeDetailImgTex:InitListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  item.IsInitHandlerCalled = true
  local btn = rowPool:SpawnObject("UINoticeDetailImgTexItem")
  local idx = index + 1
  btn:SetData(self._notices[idx])
  return item
end
