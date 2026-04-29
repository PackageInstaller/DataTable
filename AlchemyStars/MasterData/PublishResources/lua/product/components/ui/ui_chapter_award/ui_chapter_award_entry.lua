_class("UIChapterAwardEntry", UICustomWidget)
UIChapterAwardEntry = UIChapterAwardEntry

function UIChapterAwardEntry:Constructor()
end

function UIChapterAwardEntry:OnShow()
  self._trans = self:GetGameObject()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self.uiItem:SetClickCallBack(function()
    self:bgOnClick()
  end)
end

function UIChapterAwardEntry:OnHide()
end

function UIChapterAwardEntry:Flush(v)
  if not v then
    return
  end
  self._v = v
  local icon = v.icon
  local text2 = v.name
  local text1 = v.count
  local quality = v.color
  local itemId = v.id
  self.uiItem:SetData({
    icon = icon,
    text1 = text1,
    text2 = text2,
    quality = quality,
    itemId = itemId
  })
end

function UIChapterAwardEntry:bgOnClick(go)
  if self._v then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self._v.id, self._trans.transform.position)
  end
end
